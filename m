From: James Simmons <jsimmons@infradead.org>
Subject: fbdev sysfs support.
Date: Sat, 7 Feb 2004 00:34:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0402070032030.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Linus, please do a

	bk pull http://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/Makefile  |    2 
 drivers/video/fbmem.c   |    6 ++
 drivers/video/fbsysfs.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h      |   40 ++++++++++-------
 4 files changed, 141 insertions(+), 17 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/06 1.1549)
   [FBDEV] Add syfs support.
