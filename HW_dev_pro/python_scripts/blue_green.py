#!/usr/bin/env python3

import subprocess
import argparse
import json

import requests


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-br', '--deployment_branch', help='Set deployment branch: Green or Blue', required=True)
    parser.add_argument('-z_id', '--zone_id', help='Set zone_id for cloudflare', required=True)
    parser.add_argument('-e', '--email', help='Set email for cloudflare', required=True)
    parser.add_argument('-a_key', '--auth_key', help='Set auth_key for cloudflare', required=True)

    return parser.parse_args()


def get_alb_buffer():
    """ Get all balancers """
    output = subprocess.run(["aws", "elbv2", "describe-load-balancers"], capture_output=True, text=True,)
    return output.stdout


def get_alb_dns_names(buffer):
    my_dictionary = json.loads(buffer)
    balancers = []
    for balancer in my_dictionary['LoadBalancers']:
        if balancer:
            new_dict = {}
            new_dict['{}'.format(balancer.get("LoadBalancerName"))] = "{}".format(balancer.get("DNSName"))
            balancers.append(new_dict)
    return balancers


def check_deployment_branch(balancers, deployment_branch):
    if balancers:
        for balancer in balancers:
            branches = balancer.keys()
            for branch in branches:
                if deployment_branch in branch:
                    return balancer[branch]


def check_dns_name(url, data, headers):
    response = requests.get(url=url, json=data, headers=headers).json()
    buffer = response.get("result")
    if buffer:
        for records in buffer:
            return records.get("id")
    return False


def set_cname_to_cloudflare(zone_id, email, auth_key, dns_name):
    if dns_name:
        headers = {
            "Content-type": "application/json",
            "X-Auth-Email": email,
            "X-Auth-Key": auth_key
        }
        data = {
            "type": "CNAME",
            "content": dns_name,
            "proxied": True,
        }
        url = f"https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records"

        # Check DNS record
        record_id = check_dns_name(url, data, headers)
        if record_id:
            requests.delete(url=f"{url + '/' + record_id}", json=data, headers=headers).json()
        response = requests.post(url=url, json=data, headers=headers).json()
        print(response)



def main():
    args = parse_arguments()
    buffer = get_alb_buffer()
    balancers = get_alb_dns_names(buffer)
    dns_name = check_deployment_branch(balancers, deployment_branch=args.deployment_branch)
    set_cname_to_cloudflare(zone_id=args.zone_id, email=args.email, auth_key=args.auth_key, dns_name=dns_name)


if __name__ == '__main__':
    main()