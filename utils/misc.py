import os, sys, json, yaml, time
import pytz
import random
from datetime import datetime, timedelta
import yaml

def convert_datetime(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError("Type %s not serializable" % type(obj))

def rename_images(directory, old_prefix="screenshot ", new_prefix="screenshot "):
    # Get all files in the directory
    files = sorted(
        [
            f
            for f in os.listdir(directory)
            if f.startswith(old_prefix)
            and f.lower().endswith((".jpg", ".jpeg", ".png", ".gif", ".bmp"))
        ]
    )

    # Rename files sequentially
    for index, filename in enumerate(files, start=0):
        old_path = os.path.join(directory, filename)
        extension = os.path.splitext(filename)[1]  # Get file extension
        new_filename = f"{new_prefix}{index}{extension}"
        new_path = os.path.join(directory, new_filename)

        os.rename(old_path, new_path)
        print(f"Renamed: {filename} → {new_filename}")


def save_output_in_file(content, file_path=os.environ["DATA"]+"/rough/output.txt"):

    # Open the file in write mode
    with open(file_path, 'w') as file:
        # Redirect stdout to the file
        sys.stdout = file

        # Call the function whose output you want to append
        print(content)

        # Restore stdout to the original value
        sys.stdout = sys.__stdout__

def json_dump(data, file_path=os.environ["DATA"]+"/rough/json_dump.json"):
    # Serialize list into a json file
    with open(file_path, 'w') as f:
        json.dump(data, f, indent=4)

def redirect_print_to_file(file_path=os.environ["DATA"]+"/rough/output.txt"):
    def decorator(f):
        def wrapper(*args, **kwargs):
            pass

        return wrapper


## NOT WORKING AS EXPECTED !!!
def my_logger(logfilepath=os.environ['DATA']+'/rough/python_logging.log'):
    import logging
    from functools import wraps
    
    logging.basicConfig(
        filename=logfilepath, 
        level=logging.INFO, 
        format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s'),
        filemode='w'
    )

    def decorator(orig_func):
        logger = logging.getLogger(__name__)
        filename = "/".join(logfilepath.split('/')[:-1]) + '/{}.log'.format(orig_func.__name__)
        # Create and configure second handler
        handler2 = logging.FileHandler(filename)
        handler2.setLevel(logging.INFO) # error and above is logged to a file
        file_format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler2.setFormatter(file_format)
        logger.addHandler(handler2)
        
        logger.info(f"invoking {decorator.__name__}")
        # print(f"Started Executing: {decorator.__name__}")
        # logger.warning('This is a warning')
        
        # @wraps(orig_func)
        def wrapper(*args, **kwargs):
            print(f"Started Executing: {wrapper.__name__}")
            logger.info('Ran with args: {}, and kwargs: {}'.format(args, kwargs))
            return orig_func(*args, **kwargs)

        return wrapper
    
    return decorator


def random_datetime(timezone="cst"):
    tzs = {"cst": "America/Chicago"}
    # Define the CST timezone
    zn_timezone = pytz.timezone(tzs[timezone])

    # Function to generate a random naive datetime
    def generate_random_naive_datetime():
        start_date = datetime(2020, 1, 1)
        end_date = datetime.now()
        random_delta = random.randint(0, int((end_date - start_date).total_seconds()))
        return start_date + timedelta(seconds=random_delta)

    # Generate a random naive datetime
    random_naive_datetime = generate_random_naive_datetime()

    # Convert the naive datetime to a zone aware datetime
    zn_aware_datetime = zn_timezone.localize(random_naive_datetime)
    return zn_aware_datetime


def load_from_yaml(file_path: str):
    """
    Load a YAML configuration file and convert it into a Python object.

    :param file_path: Path to the YAML configuration file.
    :return: Python object representing the YAML file content.
    :raises FileNotFoundError: If the file does not exist.
    :raises yaml.YAMLError: If there is an error in parsing the YAML file.
    """
    try:
        with open(file_path, 'r') as file:
            config = yaml.safe_load(file)
            return config
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
        raise
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
        raise

def save_to_yaml(file_path, python_object):
    """
    Saves a Python object as a YAML file, with checks for serializability.

    Args:
        file_path (str): The path where the YAML file will be saved.
        python_object (object): The Python object to save.
    """
    try:
        try:
            yaml.dump(python_object, None, default_flow_style=False)  # Try dumping to None first
            with open(file_path, 'w') as yaml_file:
                yaml.dump(python_object, yaml_file, default_flow_style=False)
            print(f"The Object above successfully saved to {file_path}\n")
        except yaml.YAMLError as e:
            print(f"Error: Object cannot be serialized to YAML: {e}")
    except Exception as e:
        print(f"Unexpected Error saving object to {file_path}: {e}")
