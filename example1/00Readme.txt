README for Hard Disk Drive Benchmark Problem (example1: following)
Authour(s): H.Uchida, T.Hara
Ver.1.0 2006-12-06
Copyright (c) 2004-2005, MSS benchmark working group
Copyright (c) 2006-, HDD benchmark working group

�t�H���C���O�n������ݒ肨��ѐ݌v��f��

�� ���ݒ�

* ���̖��ݒ��2005�N9���ɊJ�Â��ꂽ�d�C�w��Y�ƌv�����䌤����̃x��
  �`�}�[�N�Z�b�V�����ŗp����ꂽ���̂ł��B

  ����ΏہFHDD�̃t�H���C���O�n���f�� (Ver.1)
  ���ݒ�F�t�H���C���O�n�̐݌v

�E�^����炽�v�����g����ъO�����f���ɂ��ăt�H���C���O����n��݌v���C 
  1000���i8.4�b�j�̎��Ԏ��V�~�����[�V���������s����

�E���\�]���F���I�Ȉʒu�덷�i�ŏ���10ms�̃f�[�^�͖����j

    �ERPEp-p �l
    �ENRPE3�Вl
  ���j
  RPE  (Repeatable Position Error)
  NRPE (None Repeatable Position Error)

�E���ׂĂ̕ϓ����f���i�S30�ʂ�j�ɂ��Čv�Z���C���ς���эň��l��]��

    �E�A�N�`���G�[�^���U�̂΂���E�ϓ����f��10���
    �E�Q�C���ϓ�3��ށi�m�~�i���C�}10%�j

�E�T���v�����O���g���͌Œ肾��2�{�܂ł̓��̓}���`���[�g�͉�

�E�����̎����C���͒l�̐�������

�E���萫�F�^����ꂽ���ׂĂ̕ϓ����f���ɂ��Ĉ���ł���Ηǂ�


�� �݌v��

���U����PID�R���g���[�������2�{�}���`���[�g���i�m�b�`�t�B���^��p����
�݌v�B


�� ���s���@

���炩���� HDDBench.m �����s���� Ver.1 �̃p�����[�^�t�@�C�����琶����
���ȉ��̃t�@�C����example1 �̃t�H���_���ɃR�s�[���Ă����܂��i�R�s�[
���Ȃ��ꍇ�́C�p�X��ʂ��Ă����j�B

  mainPlantDataV1.mat
  mainDistDataV1.mat

�����āCfollowdemo.m �����s����ƁCPID+2�{�}���`���[�g�m�b�`�t�B���^��
���݌v��ɂ��f��������܂��B


�� �X�N���v�g�t�@�C��

  followdemo.m - PID+2�{�}���`���[�g�m�b�`�t�B���^�ɂ��݌v��
  evperf.m     - ���䐫�\�]���p�X�N���v�g�ifollowdemo.m�Ŏg�p�j


�� simulink model

  SimTrackFollowing.mdl  - PID Controller + 2x Multi-rate Notch Filter
  SimTrackFollowing5.mdl - �� (MATLAB5.x�p)

���̃T���v�����f���́C����n�̍\�����V���O�����[�g�܂���ZOH�A�b�v�T��
�v���ɂ��2�{�̃}���`���[�g�ł���ꍇ�ɂ� sys_C1, sys_C2 ��K�؂ɐݒ�
���邾���ł��̂܂܎g�p�ł��܂��B


�� MATLAB�̃o�[�W�����ɂ���

�{�x���`�}�[�N����MATLAB6.5.1�ō쐬�E����m�F���Ă��܂��B
���̃o�[�W�����Ŏ��s����ꍇ�ɂ͈ȉ��̒��ӂ��K�v�ł��B

Ver.5.3.1
�ELTI���f����݊��F6.5.1�ō쐬�������f���͓ǂݍ��߂Ȃ��B
  ��5.3.1���HDDBench�𑖂点��Ζ�薳���B
�Erandn �̔�݊��F5.3.1�ŊO�����f���𐶐������6.5.1�ƌ��ʂ��قȂ�B
  ��6.5.1�ō쐬�����O�����f����ǂݍ��܂���Ηǂ��B
�ESimulink���f���̔�݊��F6.5.1�ō쐬�������f���͎��s�s��
  ��5.3.1��Simulink���f�����쐬 (SimTrackFollowing5.mdl)
