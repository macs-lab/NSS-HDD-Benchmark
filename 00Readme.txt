README for Hard Disk Drive Benchmark Problem
Authors(s): M.Hirata, T.Hara
Ver.1.0, 2005-04-26
Ver.1.1, 2005-05-02
Ver.1.2, 2005-05-10
Ver.1.3, 2005-05-12
Ver.1.4, 2005-05-13
Ver.1.5, 2005-05-16, first release
Ver.1.6, 2005-08-30, add evaluation functions
Ver.3.0, 2006-12-06
Ver.3.1, 2007-08-31
Copyright (c) 2004-2005, MSS benchmark working group
Copyright (c) 2006-, HDD benchmark working group


�� �g�p���@

HDDBench.m �����s���Ă��������B

Specify the version of parameter file [1 or 2] or just hit return: 

�ɑ΂��āC1 �܂��� 2 �܂��͉������͂����� return �������Ă��������B��
�̂Ƃ��C���͂��������ɉ����āC�Y������o�[�W�����̃p�����[�^�t�@�C����
�ǂݍ��܂�C����Ώہi�v�����g�j���f���̒�`�C�O�����f���̒�`���s���
�܂��B�����āC�v�����g���f���ƊO�����f���� mat �t�@�C���ɃZ�[�u�����
���B�ڍׂ͈ȉ��̒ʂ�ł��B

* �p�����[�^�t�@�C���̃o�[�W�����i1 or 2�j���w�肵���ꍇ

�ǂݍ��܂��t�@�C���F

  hdd_plantparam_v#.m
  hdd_distparam_v#.m

�ۑ������t�@�C���F

  mainPlantDataV#.mat
  mainDistDataV#.m

���j# �̓o�[�W������\�� 1 �܂��� 2 ������B

* return �݂̂���͂����ꍇ

�ǂݍ��܂��t�@�C���F

  hdd_plantparam.m�i���݂��Ȃ��ꍇ�� hdd_plantparam_v2.m�j
  hdd_distparam.m�i���݂��Ȃ��ꍇ�� hdd_distparam_v2.m�j

�ۑ������t�@�C���F

  mainPlantData.mat
  mainDistData.m

�� �쐬����� mat �t�@�C���ɂ���

* mainPlantData.mat�i�v�����g���f���j

  PlantData     - �t�H���[�C���O����p�v�����g���f���̍\����
  PlantDataSeek - �V�[�N����p�v�����g���f���̍\����

  �e�v�����g�͍\���̂ɂȂ��Ă���C�ȉ��̕����̃��f���ƃp�����[�^���܂݂܂��B

  struct PlantData (�ꕔ)
    PlantData.Ts      - PES�i�ʒu�덷�M���j�̃T���v�����O����
    PlantData.Ty      - �o�͒[�O�����Z�_�̃T���v�����O����
    PlantData.Tu      - ���͒[�O�����Z�_�̃T���v�����O����
    PlantData.Td      - ���͂ނ�����
    PlantData.Pn      - �m�~�i�����f��
    PlantData.Pf      - �t���I�[�_�[���f��
    PlantData.Pfpert  - �ϓ����f���i�������z��j
    PlantData.DeltaKp - �Q�C���ϓ�

  ������͓͂d��[A]�C�ϑ��o�͂̓g���b�N[track]�ƂȂ��Ă��܂��B
  �e�v�����g���f���ɂ͓��͎��Ԓx�ꂪ�܂܂�Ă��܂��B

  �� �{���͉�]�n�̃A�N�`���G�[�^�ł����C�����I�ɕ��i�n�Ƃ݂Ȃ��Ē�`��
     �Ă��܂�

* mainDistData.mat�i�O�����f���j

  DistParam   - �O���p�����[�^
  ForceDist   - �͊O��
  FlutterDist - �t���b�^�O��
  SensorNoise - �Z���T�m�C�Y
  RRO         - RRO�iRepeatable Runout: �J��Ԃ��O���j

  �{�x���`�}�[�N���Ŏ�舵���O���͈ȉ���4��ނł��B

  �E�͊O����
  �E�t���b�^�O���i�T�X�y���V�����N���O�������܂ށj
  �E�Z���T�m�C�Y
  �ERRO�i���Ԉ�̂݁j

  �� �{���͉�]�n�̃A�N�`���G�[�^�Ȃ̂Ńg���N�O���ł����C�����I�ɕ��i
     �n�Ƃ݂Ȃ��ė͊O���Ƃ��Ē�`���Ă��܂�

* �e�O���͉��L�̂悤�ȍ\���̂ɂȂ��Ă��܂��B

  ��F�͊O��
  struct ForceDist
    ForceDist.Data      - �O���f�[�^
    ForceDist.Time      - ���ԃx�N�g��
    ForceDist.Ts        - �O���̃T���v�����O����
    ForceDist.DataAtPes - �o�͒[�ł̊O���f�[�^
    ForceDist.TimeAtPes - �o�͒[�ł̎��ԃx�N�g��
    ForceDist.TsAtPes   - �o�͒[�ł̊O���̃T���v�����O����
    ForceDist.Freq      - ���g���x�N�g��
    ForceDist.Spec      - �O���X�y�N�g��
    ForceDist.SpecAtPes - �o�͒[�ł̊O���X�y�N�g��

  �ʏ�V�~�����[�V�����ŗp����̂� Data, .Time, .Ts �����ł��B

  �͊O���́C����Ώۂ̓��͒[�i�P��[A]�j����яo�͒[�i�P��[track]�j�Ɋ�
  �Z�������̗̂�����p�ӂ��Ă��܂��B���͒[�̃T���v�����O���Ԃ�
  PES(Position Error Signal)�̃T���v�����O���Ԃ̐����{�ɐݒ�ł��܂��B

  ����ȊO�̊O���͂��ׂďo�͒[�i�P��[track]�j�Œ�`���Ă��܂��B�t���b
  �^�O����PES�T���v�����O���Ԃ̐����{�Œ�`�������̂ƁCPES�T���v�����O
  ���ԂɃ_�E���T���v���������̗̂������`���Ă��܂��B

  RRO�Ɋւ��ẮC�ʒu�M�����������ލۂɍ�������RRO���͋[���Ă���C����
  ���n��f�[�^��RROSequence.mat�Ƃ��ėp�ӂ��Ă��܂��B���̃t�@�C������
  mat�t�@�C�����J�����g�f�B���N�g���܂��̓T�[�`�p�X��ɑ��݂���Ƃ��C
  �����I�ɓǂݍ��݂܂��B


�� �x���`�}�[�N���ݒ�Ɛ݌v��̃f��

  �e�T�u�f�B���N�g�����Q�Ƃ����������B

  1. �t�H���[�C���O�Fexample1
  2. �V���[�g�V�[�N�Fexample2

�� �t�@�C���ꗗ

�E�X�N���v�g�t�@�C��

  HDDBench.m     - ����Ώۂ���уm�C�Y�f�[�^�̕\��
  HDDBenchPlot.m - �v���b�g�p�X�N���v�g

�E���f���p�����[�^

  hdd_plantparam_v1.m - HDD Benchmark Model Ver.1.0 �̃v�����g�p�����[�^
  hdd_distparam_v1.m  - HDD Benchmark Model Ver.1.0 �̊O���p�����[�^
  hdd_plantparam_v2.m - HDD Benchmark Model Ver.2.0 �̃v�����g�p�����[�^
  hdd_distparam_v2.m  - HDD Benchmark Model Ver.2.0 �̊O���p�����[�^

�E���f����`�p�֐�

  SetPlantModel.m   - ����Ώۂ̒�`
  SetDistParam.m    - �O�������̂��߂̃p�����[�^��`
  SetFlutterDist.m  - �t���b�^�O���f�[�^�̐���
  SetForceDist.m    - �͊O���f�[�^�̐���
  SetSensorNoise.m  - �Z���T�m�C�Y�f�[�^�̐���
  SetRRO.m          - RRO�f�[�^�̐���

�E�⏕�֐��i��L�֐�����Ăяo�����j

  make_plant.m - ����Ώۂ̌v�Z
  plot_bode.m  - �{�[�h���}�̕\��
  figsize.m    - figure�̃T�C�Y���w��
  psdcal.m     - �p���[�X�y�N�g�����x(PSD)�̌v�Z
  whitenoise.m - �P�ʃG�l���M�[�����z���C�g�m�C�Y�̐���

�E�f�[�^�t�@�C��

  RROSequence.m  -  RRO�̎����������BSTW���ɏ������܂��RRO��͋[�B

�E���ʕ]���p�֐�

  PESEval.m    - PES�]���v���b�g�i���Ԏ��C���g�����C�q�X�g�O�����j
  PES_FFT.m    - PES�̃p���[�X�y�N�g�������v�Z�i�n�j���O���C�I�[�o�[���b�v50%�j
  PES_PlotTD.m - PES�̎��ԉ���PLOT�iRPE��NRPE�𕪗����ăv���b�g�j


�� TODO LIST

* �����O�V�[�N����n�̃��f�����쐬

�� ����

���� m-file ����� Simulink �t�@�C���� MATLAB ver 6.5.1 �̏�œ���m�F���Ă��܂��B

�� MATLAB�̃o�[�W�����ɂ���

�{�x���`�}�[�N���� MATLAB6.5.1 �ō쐬�E����m�F���Ă��܂��B
���̃o�[�W�����Ŏ��s����ꍇ�ɂ͈ȉ��̒��ӂ��K�v�ł��B

Ver.5.3.1
�ELTI���f����݊��F6.5.1�ō쐬�������f���imat file�j�͓ǂݍ��߂Ȃ��B
  ��5.3.1���HDDBench�𑖂点��Ζ�薳���B
�Erandn �̔�݊��F5.3.1�ŊO�����f���𐶐������6.5.1�ƌ��ʂ��قȂ�B
  ��6.5.1�ō쐬�����O�����f����ǂݍ��܂���Ηǂ��B
�ESimulink���f���̔�݊��F6.5.1�ō쐬�������f���͎��s�s��
  ��5.3.1��Simulink���f�����쐬

Ver.7�ȍ~
�ELTI���f����݊��F6.5.1�ō쐬�������f���͓ǂݍ��ݎ���Warning
  ���������Ă��ǂ��B�܂��CVer.7x ���HDDBench�𑖂点�čč쐬����Ζ�薳���B
�ESimulink���f���̔�݊��F6.5.1�ō쐬�������f���͎��s��Warning
  ���������Ă��ǂ��B

�� �X�V����
>>Ver.3.1 - 2007-08-31
* Ver.3 ���������[�X
* �ڍׂ� Changes.txt �Q��

>>Ver.3.0RC2 - 2006-12-06
* �ڍׂ� Changes.txt �Q��

>>Ver.2.0 - 2006-06-06
* �b�胊���[�X
* ���J���f���̍X�V
  ���@��HDD���x�[�X�ɂ������J���f���Ƃ����B
* �O�����ɃT���v�����O�������ς�����l�ɂ����B
* �e�T���v�����O�����̃f�t�H���g���ȉ��Ƃ����B
  Ts = Tc = Ty = Tu
* �O�������R�}���h���C�O���ʂɂ����B�܂��C�O���̃T���v�����O�����ɂ��
  �ĊO���̃p���[���ω����Ȃ��悤�ɂ����B
* SetPlantModel�̃I�v�V�������w�肷�邱�ƂŁC���̃��[�h��2�d�ϕ���Ƃ�
  ��悤�ɂ����B�i�V�[�N���ւ̑Ή��j

>> Ver.1.5, 2005-05-16 (�ψ�������J�Łj
* �g���b�N�s�b�`��100kTPI�Ƃ���
  SetPlantModel.m
* ��L�ύX�ɔ����O������у��[�v�Q�C���̒���
  SetNoiseParam.m, example1.m
* ���U���[�h�̕ϓ����𒲐������B
  SetPlantModel.m

>> Ver.1.4
* RRO�̎��n��f�[�^��mat�t�@�C������ǂނ悤�ɂ����B
  SetNoiseParam.m, RROSequence.mat
* ���U���[�h�̕ϓ�����傫�������B
  SetPlantModel.m

>> Ver.1.3
* ����Ώۂ̃Q�C���𒲐�
  SetPlantModel.m, SetNoiseParam.m
* TDParam��p�~���C���ׂẴp�����[�^��SetNoseParam.m�̒��Œ�`���鎖�Ƃ����B
  SetNoiseParam.m,SetNoiseTimeDom.m
* example1.m �̒��Ƀm�b�`�t�B���^�[�̃f�[�^�𒼐ڏ������񂾁B

>> Ver.1.2
* �O���̑傫���𒲐�
  SetNoiseParam.m
  SetNoiseFreqDomain.m
* �}�̔w�i�F���f�t�H���g�ɖ߂�
  plot_bode.m
* PID����ɂ��݌v���ǉ�
  example1.m
* �ϓ����f���̒�`���@��ύX
  SetPlantMode.m, plot_bode.m

>> Ver.1.1
* bug fix
  fftgain.m, SetPlantModel.m, SetNoiseTimeDom.m

* SetPlantModel.m �ɂ�����ϓ��̎�舵����ύX�B
   DeltaFn   - Fn �ɑ΂����@�I�ȕϓ��l
   DeltaZeta - Zeta �V
   DeltaGain - Gain �V

* SetNoiseParam.m
   RROSequence �̒ǉ�
   -> �f�B�X�N1������RRO�̎��n��f�[�^�B
      FreqRRO, AmpRRO �Ƃ͕ʂɁCRRO�𒼐ڎ��n��f�[�^�Ƃ��ė^������B

>> Ver.1.0, �����[�X

EOF of readme.txt
