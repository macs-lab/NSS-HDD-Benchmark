README for Hard Disk Drive Benchmark Problem (example2: short seeking)
Authour(s): M.Hirata, T.Hara
Ver.1.0 2006-12-06
Ver.1.1 2007-08-31
Copyright (c) 2004-2005, MSS benchmark working group
Copyright (c) 2006-, HDD benchmark working group

�V���[�g�V�[�N�n������ݒ肨��ѐ݌v��f��

�� ���ݒ�

* ���̖��ݒ��2006�N9���ɊJ�Â��ꂽ�d�C�w��Y�ƌv�����䌤����̃x��
  �`�}�[�N�Z�b�V�����ŗp����ꂽ���̂ł��B

�E�V�[�N������1track�y��10track�Ƃ���

�E�V�[�N���Ԃ͖ڕW�g���b�N�́}0.1track�ȓ��Ɏ��܂������ԂƂ���

�E������͂�Limit�݂͐��Ȃ�

�E18�ʂ�̃��J���f���ɑ΂��āC3�ʂ�̃V�~�����[�V�������s���B
    �E���[�v�Q�C���ϓ� 0%, +5%, -5%
     �i�t�B�[�h�t�H���[�h���͂̐݌v�݂̂��c�_����ꍇ�́C���[�v�Q�C��
       �ϓ�0%�̏ꍇ�݂̂ł悢�j

�E18�ʂ�̃��J���f���ɑ΂��鎟�̉��������[�v�Q�C���ʂɃv���b�g����
    �E�������
    �E�w�b�h�̎��ԉ���
    �E�w�b�h�̎c���U���̃X�y�N�g�����i18�ʂ�̃��J���f���̃V�[�N������
      �}0.1track�ȓ��Ɏ��܂�����������C10ms��܂ł̎c���U���̃X�y�N�g
      �����j

�E�V�[�N���\�̕]���|�C���g
    �E�V�[�N���Ԃ̕]��
    �E�w�b�h�̉����̍s���߂��ʁi0.5�g���b�N�ȏ�̃I�[�o�[�V���[�g�͖]
      �܂����Ȃ��j
    �E������͂̑傫���ƂȂ߂炩���i�����I�Ȑ�����͂��ǂ����j


�� �݌v��

�I�[��Ԑ���C�y�сC���g�����`�^�I�[��Ԑ���ɂ��݌v���ꂽ�t�B�[�h�t�H
���[�h���͂ɂ��V�[�N�V�~�����[�V�����B�������C�O���͂Ȃ����̂Ƃ��āC
�t�B�[�h�o�b�N�͍s���Ă��Ȃ��B

 �E�݌v����
   �t�B�[�h�t�H���[�h���͈͂ȉ��̏����̂��Ƃɐ݌v����Ă���B

   �V�[�N���� 10track
   �V�[�N���� 20step (��0.76ms�j


�����s���@

���炩���� HDDBench.m �����s���� Ver.2 �̃p�����[�^�t�@�C�����琶����
���ȉ��̃t�@�C����example1 �̃t�H���_���ɃR�s�[���Ă����܂��i�R�s�[
���Ȃ��ꍇ�́C�p�X��ʂ��Ă����j�B

  mainPlantDataV2.mat
  mainDistDataV2.mat

�����āCseekdemo.m �����s���܂��B

>> seekdemo.m
Please select feedforward input [0-2] : <-- 0,1,2�����

���ׂĂ̐���Ώۂɑ΂��C�V�[�N�������v�Z��

figure 1  �t�B�[�h�t�H���[�h���͂̎��ԉ���
figure 2  �ڕW�g���b�N�t�߂ł̎��ԉ���
figure 3  �c���U���̃X�y�N�g����

��\������B�܂��C�}0.1�g���b�N�ȓ��Ɏ��܂������Ԃ���C�V�[�N���Ԃ��v
�Z���� figure 2 �ɕ\���B


���⑫

�t�������t�B�[�h�t�H���[�h�f�[�^��

  ffdata0.mat              - �I�[��Ԑ���@
  ffdata1.mat, ffdata2.mat - ���g�����`�^�I�[��Ԑ���

�ƂȂ��Ă���B�������C�f�����ړI�̂��߁C���\��ǋ������݌v�ɂ͂Ȃ��Ă�
�Ȃ��B

