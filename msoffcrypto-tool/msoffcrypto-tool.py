import msoffcrypto
import os
import sys

def main(argv):
   if len(sys.argv) < 3:
      print 'MSOFFCRYPTO_PW=<password> msoffcrypto-tool.py <inputfile> <outputfile>'
      sys.exit()
   inputfile = sys.argv[1]
   outputfile = sys.argv[2]
   password = os.environ['MSOFFCRYPTO_PW']

   file = msoffcrypto.OfficeFile(open(inputfile, "rb"))
   file.load_key(password=password)
   file.decrypt(open(outputfile, "wb"))

main(sys.argv[1:])
