#!/usr/bin/python
#
# Source : https://github.com/MichaelAquilina/ubuntu-ansible/blob/abafbeb78a524e002a178921dd9b6c0b16d949e2/library/apm
# See also : https://github.com/hnakamur/ansible-role-atom-packages/blob/master/library/apm
#

import subprocess

from ansible.module_utils.basic import *


def get_installed(links=False):
    packages = {}
    output = subprocess.check_output([
        'apm', 'list', '--links={}'.format(links), '-i', '-b',
    ]).strip().split('\n')
    for line in output:
        if '@' in line:
            name, version = line.split('@')
            packages[name] = version
    return packages


def install_package(name, version):
    if version is not None:
        install_name = '{}@{}'.format(name, version)
    else:
        install_name = name

    subprocess.check_output([
        'apm', 'install', install_name,
    ])


def main():
    module = AnsibleModule(
        argument_spec={
            'name': {'required': True},
            'version': {'default': None},
        },
    )

    name = module.params['name']
    version = module.params['version']

    changed = False
    try:
        packages = get_installed()

        if name not in packages or (version is not None and version != packages[name]):
            changed = True
            install_package(name, version)
    except subprocess.CalledProcessError as e:
        module.fail_json(msg=e.msg)
    else:
        module.exit_json(changed=changed)


if __name__ == '__main__':
    main()
