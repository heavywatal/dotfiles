#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import io
import threading

import mercurial

cmdtable = dict()
command = mercurial.cmdutil.command(cmdtable)


home = os.path.expanduser('~')
lock = threading.RLock()
semaphore = threading.BoundedSemaphore(4)
full_sequence = ('parents', 'status', 'diff', 'incoming', 'outgoing')


def find_repos(topdir=None):
    if not topdir:
        topdir = home
    subdirs = [os.path.join(topdir, x) for x in sorted(os.listdir(topdir))]
    repos = [mercurial.cmdutil.findrepo(x) for x in subdirs]
    return [x for x in repos if x]


def list_repos(ui, topdir=None):
    if not topdir:
        topdir = home
    repos = []
    for item in sorted(os.listdir(topdir)):
        try:
            repo = mercurial.hg.repository(ui, os.path.join(topdir, item))
            repos.append(repo)
        except:
            pass
    return repos


def print_hg(command, repo, **opts):
    try:
        getattr(mercurial.commands, command)(repo.ui, repo,
                                             bundle=None, force=None, **opts)
    except mercurial.error.RepoError as err:
        repo.ui.fout.write(str(err))
    return


def make_header(repo):
    default_path = repo.ui.expandpath('default')
    return '\033[1m{:32} | {}\033[0m'.format(repo.root, default_path)


def hg_(command, repo, prefix=None, **opts):
    if prefix:
        remote = prefix + os.path.basename(repo.root)
        if command in ('incoming', 'pull'):
            opts['source'] = remote
        elif command in ('outgoing', 'push'):
            opts['dest'] = remote
    fout = repo.ui.fout
    with io.BytesIO() as strio:
        repo.ui.fout = strio
        print_hg(command, repo, **opts)
        value = strio.getvalue()
    repo.ui.fout = fout
    if 'no changes found' in value:
        value = ''
    return value


def hg_summary(repo, remote):
    print('\n'.join([make_header(repo), hg_('summary', repo, remote=remote)]))


@command('home', [
    ('r', 'remote', False, ''),
    ('d', 'dir', home, '')],
    'hg homesum [options]', norepo=True)
def home_summary(ui, *commands, **kwargs):
    threads = []
    for repo in list_repos(ui, kwargs.get('dir')):
        th = threading.Thread(target=hg_summary,
                              args=[repo, kwargs.get('remote')],
                              name=repo.root)
        th.start()
        threads.append(th)
    for th in threads:
        th.join()


if __name__ == '__main__':
    from mercurial import ui as mercurial_ui
    ui = mercurial_ui.ui()
    print('% hg home')
    home_summary(ui)
