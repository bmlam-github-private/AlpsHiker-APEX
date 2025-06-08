#!/usr/bin/python3 

import argparse

def parse_args():
    parser = argparse.ArgumentParser(description="Sample script with flags and values")

    # Value arguments
    parser.add_argument('--input', '-i', type=str, help='Input file path', required=True)
    parser.add_argument('--output', '-o', type=str, help='Output file path', required=False)

    # Flag arguments (store_true makes them act like switches)
    parser.add_argument('--verbose', '-v', action='store_true', help='Enable verbose mode')
    parser.add_argument('--debug', action='store_true', help='Enable debug mode')

    args = parser.parse_args()
    return args 

def main():
    prog_args = parse_args()
    # Example usage
    if prog_args.verbose:
        print("Verbose mode is on")

    if prog_args.debug:
        print("Debug mode is on")

    print(f"Input file: {prog_args.input}")
    if prog_args.output:
        print(f"Output file: {prog_args.output}")
    else:
        print("No output file specified")

if __name__ == '__main__':
    main()
