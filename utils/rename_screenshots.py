import os
import shutil
import re
from pathlib import Path


def rename_images_with_prefix(directory_path, new_prefix):
    """
    Rename all images in a directory to 'new_prefix {n}.png' format while maintaining
    numerical order based on existing numbers in filenames.

    Args:
        directory_path (str): Path to the directory containing images
        new_prefix (str): New prefix to use for renamed files
    """

    # Convert to Path object for easier handling
    directory = Path(directory_path)

    # Check if directory exists
    if not directory.exists():
        print(f"Error: Directory '{directory_path}' does not exist.")
        return

    if not directory.is_dir():
        print(f"Error: '{directory_path}' is not a directory.")
        return

    # Pattern to match files with format "prefix {n}.png"
    pattern = re.compile(r"^(.+?)\s+(\d+)\.png$", re.IGNORECASE)

    # Get all matching image files
    image_files = []
    for file_path in directory.iterdir():
        if file_path.is_file():
            match = pattern.match(file_path.name)
            if match:
                prefix = match.group(1)
                number = int(match.group(2))
                image_files.append((file_path, prefix, number))

    if not image_files:
        print(
            f"No image files with format 'prefix {{n}}.png' found in '{directory_path}'."
        )
        return

    # Sort files by the integer 'n' to maintain numerical order
    image_files.sort(key=lambda x: x[2])  # Sort by the number (index 2)

    print(f"Found {len(image_files)} image files to rename.")
    print("Current order based on numbers:")
    for file_info in image_files:
        print(f"  {file_info[0].name} (number: {file_info[2]})")

    # Create temporary directory to avoid naming conflicts
    temp_dir = directory / "temp_rename"
    temp_dir.mkdir(exist_ok=True)

    try:
        # First, move all files to temp directory with new names
        for i, (old_file, old_prefix, old_number) in enumerate(image_files, 1):
            new_name = f"{new_prefix} {i}.png"
            temp_file = temp_dir / new_name

            print(f"Renaming: {old_file.name} -> {new_name}")
            shutil.move(str(old_file), str(temp_file))

        # Then move all files back to original directory
        for temp_file in temp_dir.iterdir():
            final_file = directory / temp_file.name
            shutil.move(str(temp_file), str(final_file))

        # Remove temporary directory
        temp_dir.rmdir()

        print(
            f"\nSuccessfully renamed {len(image_files)} images with new prefix '{new_prefix}'."
        )
        print("Files are now numbered sequentially starting from 1.")

    except Exception as e:
        print(f"Error during renaming: {e}")
        # Try to restore files if something went wrong
        try:
            for temp_file in temp_dir.iterdir():
                shutil.move(str(temp_file), str(directory))
            temp_dir.rmdir()
            print("Files restored to original location.")
        except:
            print("Warning: Some files may still be in temp directory.")


def preview_changes(directory_path, new_prefix):
    """
    Preview what changes will be made without actually renaming files.
    """
    directory = Path(directory_path)

    if not directory.exists():
        print(f"Error: Directory '{directory_path}' does not exist.")
        return

    pattern = re.compile(r"^(.+?)\s+(\d+)\.png$", re.IGNORECASE)
    image_files = []

    for file_path in directory.iterdir():
        if file_path.is_file():
            match = pattern.match(file_path.name)
            if match:
                prefix = match.group(1)
                number = int(match.group(2))
                image_files.append((file_path, prefix, number))

    if not image_files:
        print(f"No image files with format 'prefix {{n}}.png' found.")
        return

    image_files.sort(key=lambda x: x[2])

    print(f"\nPreview of changes for {len(image_files)} files:")
    print("-" * 60)
    for i, (old_file, old_prefix, old_number) in enumerate(image_files, 1):
        new_name = f"{new_prefix} {i}.png"
        print(f"{old_file.name:30} -> {new_name}")


def main():
    # Get user input
    directory_path = input("Enter the directory path: ").strip()
    new_prefix = input("Enter the new prefix for renamed files: ").strip()
    # directory_path = "/Users/am/Desktop/ss2"
    # new_prefix = "screenshot"

    # Remove quotes if user added them
    directory_path = directory_path.strip("\"'")

    # Validate inputs
    if not directory_path:
        print("Error: Directory path cannot be empty.")
        return

    if not new_prefix:
        print("Error: New prefix cannot be empty.")
        return

    # Show preview first
    preview_changes(directory_path, new_prefix)

    # Confirm before proceeding
    print(
        f"\nThis will rename all images to use the new prefix '{new_prefix}' while maintaining numerical order."
    )
    confirm = input("Do you want to proceed? (y/N): ").strip().lower()

    if confirm in ["y", "yes"]:
        rename_images_with_prefix(directory_path, new_prefix)
    else:
        print("Operation cancelled.")


if __name__ == "__main__":
    main()
