#!/bin/bash
if [ "$#" -lt 3 ]
then

    echo "Usage: $0 <ASHS_ROOT> <in_bids> <out_ASHS>"
    exit 1
fi

export ASHS_ROOT=$1
bids=$2
out=$3

echo $ASHS_ROOT

for nii in `ls -d $bids/sub-*`
do

 subj=${nii##*/}
 if [[ $subj = *"pilot"* ]]; then
  echo "Pilot subject detected, skipping preprocessing."
  continue
 fi

 out_dir=${out}/${subj}/

mkdir -p $out_dir
echo $out_dir

 T1=${bids}/${subj}/ses-001/anat/*T1w.nii.gz
echo $T1


 T2=${bids}/${subj}/ses-001/anat/*SPACE_run-01_T2w.nii.gz
echo $T2

 cmd="$ASHS_ROOT/bin/ashs_main.sh -a ~$ASHS_ROOT/atlases/ashs_atlas_upennpmc_20161128/ -g $T1 -f $T2 -w $out_dir -T"

 regularSubmit $cmd

done
