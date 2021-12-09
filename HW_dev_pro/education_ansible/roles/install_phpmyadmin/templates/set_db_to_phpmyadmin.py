#!/usr/bin/env python3

import argparse
import re


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-ip', '--privat_ip', help='Set privat ip address', required=True)
    parser.add_argument('-sample', '--sample', help='Path to sample config for phpMyAdmin', required=True)
    parser.add_argument('-config', '--config', help='Path to config file for phpMyAdmin', required=True)

    return parser.parse_args()


def clear_ip(privat_ip):
    ip = re.findall(r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}", privat_ip)
    return ip[0]


def make_config_file(path_to_sample_conf, private_ip, path_for_save_config):
    with open(path_to_sample_conf) as r:
        text = r.read().replace("localhost", private_ip)
    with open(path_for_save_config, "w") as w:
        w.write(text)


def main():
    args = parse_arguments()
    ip = clear_ip(args.privat_ip)
    make_config_file(path_to_sample_conf=args.sample, path_for_save_config=args.config, private_ip=ip)
    print(ip)


if __name__ == "__main__":
    main()

