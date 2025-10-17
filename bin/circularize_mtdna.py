import sys

mtdna_fas = sys.argv[1]
n_bp = int(sys.argv[2])
out_f = sys.argv[3]

seq = ""

with open(out_f,"w") as dest:
    with open(mtdna_fas) as source:
        for line in source:
            if line.startswith(">"):
                dest.write(line)
            else:
                seq += line.rstrip()
    seq = seq + seq[:n_bp]
    wrapped = "\n".join([seq[i : i + 80] for i in range(0, len(seq), 80)])
    dest.write(f"{wrapped}\n")

