#!/usr/local/ruby/bin/ruby
require 'readline'
require 'net/telnet'

host,user,psw = ARGV

host ||= 'mecerp3x0111'
user ||= 'root'

if psw.blank? then
  psw = STDIN.noecho(&:gets)
end

# �����[�g�z�X�g
# �^�C���A�E�g�� 10 �b
telnet = Net::Telnet.new(
  "Host"       => host,
  "Prompt"     => /[$%#>]\z/n,
  "Output_log" => nil
  "Timeout"    => 3
)

# ���O�C�����A�v�����v�g���o��܂ő҂����킹��
telnet.login(
  root, 
  psw
) { |c| print c }






# ls �R�}���h�����s���A���s��A�v�����v�g���o��܂ő҂����킹��
telnet.cmd("ls") {|c|
  print c
}

# sleep �� 5 �b
telnet.cmd("sleep 5 && echo foobar &") {|c| print c}

STDOUT.flush # <- ���ꂪ�Ȃ��Ƃ����܂ŏ��������Ă邱�Ƃ��킩��ɂ���

# �O�̃R�}���h�̏o�͂�҂����킹��
telnet.waitfor(/foobar\Z/) {|c| print c}

# ���O�C���Z�b�V�����̏I��
telnet.cmd("exit") {|c| print c}
telnet.close
