#!/bin/bash

# Check if two XML files are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <xml_file1> <xml_file2>"
    exit 1
fi

xml_file1="$1"
xml_file2="$2"

# Function to extract keys (element names) from an XML file
extract_keys() {
    xml_file="$1"
    grep -o '<string name="[^"]*">' "$xml_file" | sed -E -e 's/<string name="([^"]+)">/\1/g' | sort -u
}

# Extract keys from each XML file
keys_xml1=$(extract_keys "$xml_file1")
keys_xml2=$(extract_keys "$xml_file2")

# Find keys present in the first file but not in the second file
diff_keys=$(comm -23 <(echo "$keys_xml1") <(echo "$keys_xml2"))

# Create the output XML with the different keys
output_xml="<resources>\n"
while IFS= read -r key; do
    value=$(grep -o "<string name=\"$key\">[^<]*</string>" "$xml_file1" | sed -E -e "s/<string name=\"$key\">([^<]+)<\/string>/\1/g")
    output_xml+="  <string name=\"$key\">$value</string>\n"
done <<< "$diff_keys"

# Find keys present in the second file but not in the first file
diff_keys2=$(comm -13 <(echo "$keys_xml1") <(echo "$keys_xml2"))

# Add the keys from the second file that are not in the first file to the output XML
while IFS= read -r key; do
    value=$(grep -o "<string name=\"$key\">[^<]*</string>" "$xml_file2" | sed -E -e "s/<string name=\"$key\">([^<]+)<\/string>/\1/g")
    output_xml+="  <string name=\"$key\">$value</string>\n"
done <<< "$diff_keys2"

output_xml+="</resources>"

echo -e "$output_xml" > "output.xml"

echo "Output has been saved to output.xml"

# Convert XML to CSV using xmlstarlet
echo -e "$output_xml" | xmlstarlet sel -t -m "/resources/string" -v "@name" -o "," -v "." -n > "output.csv"

echo "Output CSV has been saved to output.csv"



##!/bin/bash
#
## Check if two XML files are provided as arguments
#if [ $# -ne 2 ]; then
#    echo "Usage: $0 <xml_file1> <xml_file2>"
#    exit 1
#fi
#
#xml_file1="$1"
#xml_file2="$2"
#
## Function to extract keys (element names) from an XML file
#extract_keys() {
#    xml_file="$1"
#    grep -o '<string name="[^"]*">' "$xml_file" | sed -E -e 's/<string name="([^"]+)">/\1/g' | sort -u
#}
#
## Extract keys from each XML file
#keys_xml1=$(extract_keys "$xml_file1")
#keys_xml2=$(extract_keys "$xml_file2")
#
## Find keys present in the first file but not in the second file
#diff_keys=$(comm -23 <(echo "$keys_xml1") <(echo "$keys_xml2"))
#
## Create the output XML with the different keys
#output_xml="<resources>\n"
#while IFS= read -r key; do
#    value=$(grep -o "<string name=\"$key\">[^<]*</string>" "$xml_file1" | sed -E -e "s/<string name=\"$key\">([^<]+)<\/string>/\1/g")
#    output_xml+="  <string name=\"$key\">$value</string>\n"
#done <<< "$diff_keys"
#output_xml+="</resources>"
#
#echo -e "$output_xml" > "output.xml"
#
#echo "Output has been saved to output.xml"