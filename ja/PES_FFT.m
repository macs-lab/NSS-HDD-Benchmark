%PES_FFT  Position Error Signal��FFT�v���b�g
%
%   PESFFT(PES, NFFT, Fs, option, ltype) ��PES�̃p���[�X�y�N�g�������J��
%   ���g�t�B�M���A��Ƀv���b�g���܂��B
%
%   �n�j���O���֐����g�p�C�I�[�o�[���b�v50%
%
%   PES    : PES�������f�[�^
%   NFFT   : FFT����
%   Fs     : �T���v�����O���g��
%   option : ''    �p���[�X�y�N�g���� (default)
%            'psd' �p���[�X�y�N�g�������x�Ƃ��ăv���b�g
%   ltype  : ���̌`�� (default 'b')
%
%   [data,num] = PESFFT(PES, NFFT, Fs, option);
%   �� data = [f psp] ����ѕ��ω��� num ��Ԃ��܂��B
%
%   Copyright (C) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara
