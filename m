From: James Simmons <jsimmons@infradead.org>
Subject: FBDEV patch for testing.
Date: Sat, 3 May 2003 17:35:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0305031726360.4509-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

  I needed this patch to be tested. The patch has two parts. The first is 
updates to the g346fb driver to use the cursor api. The second part is 
a code optimization of the pixmap code. The purpose of the pixmap code is
to take image data and byte or word padd it according to the needs of the 
hardware. The problem was it was only copy on byte at a time. This was a 
performace killer. Soon now it copies a whole scanline at a time. Please 
test.

The diff is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/console/fbcon.c |  219 +++++++++++++++---------------------------
 drivers/video/fbmem.c         |    5 
 drivers/video/g364fb.c        |   78 ++++++++------
 drivers/video/logo/logo.c     |    3 
 include/linux/fb.h            |   63 ++++++------
 include/linux/linux_logo.h    |    4 
 6 files changed, 163 insertions(+), 209 deletions(-)
