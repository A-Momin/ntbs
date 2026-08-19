from datetime import datetime


def get_seconds_difference(input_datetime_str):
    # Define the format of the input string
    datetime_format = "%b %d, %Y, %I:%M %p"

    # Parse the input string into a datetime object
    input_datetime = datetime.strptime(input_datetime_str, datetime_format)

    # Get the current datetime
    now = datetime.now()

    # Calculate the difference in seconds
    difference = (input_datetime - now).total_seconds()

    return difference

dt_str = "Apr 20, 2025, 10:28 AM"
seconds = get_seconds_difference(dt_str)
print(f"Seconds difference: {seconds}")
