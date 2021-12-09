#!/usr/bin/env python3

# import subprocess
import argparse
# import json


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-ip', '--privat_ip', help='Set privat ip address', required=True)
    parser.add_argument('-sample', '--sample', help='Path to sample config for phpMyAdmin', required=True)
    parser.add_argument('-config', '--config', help='Path to config file for phpMyAdmin', required=True)

    return parser.parse_args()


# def get_aws_ec2_buffer(path_to_aws_ec2):
#     """ Get all balancers """
#     output = subprocess.run(["ansible-inventory", "-i", f"{path_to_aws_ec2}", "--list"], capture_output=True, text=True,)
#     return output.stdout


# def parse_buffer(buffer):
#     with open("test_error.txt", "w") as w:
#         w.write(buffer)

#     my_dictionary = json.loads(buffer)
#     if my_dictionary:
#         for tag in my_dictionary:
#             if "db" in tag:
#                 return my_dictionary[tag].get("hosts"), my_dictionary


# def get_db_ip(tag, buffer_dict):
#     if tag and buffer_dict:
#         if isinstance(tag, list):
#             db_host = tag[0]
#             for _ in buffer_dict:
#                 for var in buffer_dict.get("_meta").get("hostvars"):
#                     if db_host == var:
#                         return buffer_dict.get("_meta").get("hostvars").get(var).get("private_ip_address")


def make_config_file(path_to_sample_conf, private_ip, path_for_save_config):
    with open(path_to_sample_conf) as r:
        text = r.read().replace("localhost", private_ip)
    with open(path_for_save_config, "w") as w:
        w.write(text)


def main():
    args = parse_arguments()

    # buffer = get_aws_ec2_buffer(args.aws_ec2)
    # tag, buffer_dict = parse_buffer(buffer)
    # private_ip = get_db_ip(tag=tag, buffer_dict=buffer_dict)
    make_config_file(path_to_sample_conf=args.sample, path_for_save_config=args.config, private_ip=args.private_ip)
    # print(args.private_ip)


if __name__ == "__main__":
    main()

