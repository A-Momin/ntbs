import boto3
from botocore.exceptions import ClientError

ec2_client = boto3.client('ec2')


# Example usage
inbound_rules = [
    {
        'IpProtocol': 'tcp',
        'FromPort': 22,
        'ToPort': 22,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "SSH_Port"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 80,
        'ToPort': 80,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "HTTP_Port"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 443,
        'ToPort': 443,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "HTTPs_Port"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 8000,
        'ToPort': 8000,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "Django_Port1"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 8010,
        'ToPort': 8010,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "Django_Port2"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 8080,
        'ToPort': 8080,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "Jenkins_Port"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 8888,
        'ToPort': 8888,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "JupyterNotebook_Port"}]
    },
    {
        'IpProtocol': 'tcp',
        'FromPort': 3306,
        'ToPort': 3306,
        'IpRanges': [{'CidrIp': '0.0.0.0/0', "Description": "AWS_RDS_Port"}]
    },
]

tags = [
    {
        'Key': 'Name',
        'Value': 'httx-sg'
    }
]

outbound_rules = [
    {
        'IpProtocol': '-1', # '-1' means all protocols
        'FromPort': -1,
        'ToPort': -1,
        'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
    }
]



def replace_next_of_prefixed_line(file_path, prefix, replacing_string):
    """
    Replace following line of the matching line by replacing_string.
    
    This function reads a text file line by line, checks if each line starts with the specified
    prefix, and if so, replaces the following line with the given replacement string. The updated
    content is then written back to the file.
    
    Parameters:
    ===========
        -   file_path (str): The path to the text file.
        -   prefix (str): The prefix string to match at the beginning of each line.
        -   replacing_string (str): The string to replace lines that start with the prefix.
    
    Example:
    ========
        replace_line_with_prefix("example.txt", "prefix_string", "new replacement text")
        
    Note:
    =====
    This function overwrites the original file with the modified content.
    """
    
    # Read the file and replace matching lines
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    idx = 0

    while idx < len(lines):
        if lines[idx].startswith(prefix):
            if idx+1 < len(lines) and lines[idx+1].split(' ')[0] == replacing_string.split(' ')[0]:
                lines[idx+1] = f"{replacing_string}\n"
        idx += 1

    # Write the modified lines back to the file
    with open(file_path, 'w') as file:
        file.writelines(lines)
