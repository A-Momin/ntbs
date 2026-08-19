import datetime
import random

##############################################################################

def generate_random_datetime(
    start: str = "1990-01-01 00:00:00",
    end: str = "2000-01-01 00:00:00",
    date_format: str = "%Y-%m-%d %H:%M:%S",
    ) -> datetime.datetime:
    """
    Generates a random datetime object between a given start and end date strings.

    Args:
        start: The starting datetime as a string (inclusive).
        end: The ending datetime as a string (inclusive).
        date_format: The format string used to parse start and end.
                     Defaults to "%Y-%m-%d %H:%M:%S" (e.g., "2023-01-01 00:00:00").

    Returns:
        A random datetime object within the specified range.

    Raises:
        ValueError: If start cannot be parsed, end cannot be parsed,
                    or if the parsed start_date is after the parsed end_date.
    """
    try:
        start_date = datetime.datetime.strptime(start, date_format)
    except ValueError as e:
        raise ValueError(
            f"Could not parse start '{start}' with format '{date_format}': {e}"
        )

    try:
        end_date = datetime.datetime.strptime(end, date_format)
    except ValueError as e:
        raise ValueError(
            f"Could not parse end '{end}' with format '{date_format}': {e}"
        )

    if start_date > end_date:
        raise ValueError("Parsed start_date cannot be after parsed end_date")

    # Calculate the total duration in seconds between the two dates
    time_difference = end_date - start_date
    total_seconds = int(time_difference.total_seconds())

    # Generate a random number of seconds within this duration
    random_seconds = random.randint(0, total_seconds)

    # Add the random seconds to the start date to get the random datetime
    random_datetime = start_date + datetime.timedelta(seconds=random_seconds)

    return random_datetime


# --- Example Usage ---
if __name__ == "__main__":
    # Define your start and end dates as strings
    start_str = "2023-01-01 00:00:00"
    end_str = "2024-12-31 23:59:59"
    my_format = "%Y-%m-%d %H:%M:%S"

    print(
        f"Generating random datetimes between '{start_str}' and '{end_str}' (format: '{my_format}'):\n"
    )

    # Generate and print a few random datetimes
    for _ in range(5):
        random_dt = generate_random_datetime(start_str, end_str, my_format)
        print(random_dt)