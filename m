From: Jan Engelhardt <jengelh@inai.de>
Date: Wed, 31 Oct 2012 13:47:30 +0000
Subject: fbdev: on-screen character cell corruption
Message-Id: <alpine.LNX.2.01.1210311423100.29232@nerf07.vanv.qr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,


I have here a 9x16 font (for use with e.g. videor0x400 on KMS to get 
80x25 tty size) that fbcon seems to have a problem correctly rendering. 
When backspacing, the pixels from the character under the cursor not 
only gets moved to one character cell to the left (as it should), but 
the leftmost pixel column of the char also leaks to the rightmost pixel 
column previous glyph.

LKML being a text/plain medium, I have taken pictures of the screen for 
better understanding on how to reproduce, and have placed them at 
http://inai.de/keyb/ . The font file is also provided there.

The kernel I run is 3.4.11 on x86_64. There is no known good version to 
me (IOW, it is not a regression), as I just started using a 9x16 font 
on fbcon.
