#!/usr/bin/env python3

import argparse
import re


def parse_arguments():
    """
    This function pars arguments from command line
    :return: all arguments in string format
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('-ip', '--private_ip', help='Set privat ip address', required=True)
    parser.add_argument('-sample', '--sample', help='Path to sample config for phpMyAdmin', required=True)
    parser.add_argument('-config', '--config', help='Path to config file for phpMyAdmin', required=True)
    return parser.parse_args()


def clear_ip(private_ip):
    """
    This step finds IP addresses in buffer
    The function return list of IP addresses,
    or list of only one ip address
    """
    # pattern of ip address
    pattern = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
    return re.findall(pattern, private_ip)


def make_config_file(path_to_sample_conf, private_ip, path_for_save_config):
    """
    This function checks if exist ip address in list,
    after that the function parses sample config file for PhpMyAdmin
    and replaces localhost to ip address of DB, in config file for PhpMyAdmin.
    At least this function makes new config file with current DB's ip address.
    ###############
    :param path_to_sample_conf: Absolute path to the config's sample
    :param private_ip: Got it in the "clear_ip" function
    :param path_for_save_config: Absolute path to the config file which will be make this function
    """
    if private_ip:
        first_ip_address = private_ip[0]
        with open(path_to_sample_conf) as r:
            text = r.read().replace("localhost", first_ip_address)
        with open(path_for_save_config, "w") as w:
            w.write(text)


def main():
    args = parse_arguments()
    ip = clear_ip(args.private_ip)
    make_config_file(path_to_sample_conf=args.sample, path_for_save_config=args.config, private_ip=ip)


if __name__ == "__main__":
    main()

