From: James Simmons <jsimmons@infradead.org>
Subject: New permedia fbdev driver.
Date: Tue, 2 Mar 2004 20:02:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0403021959150.18264-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jim.hague@acm.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This is the new permedia written to the new api. Please test it. You can 
grab a traditional diff from

http://phoenix.infradead.org/~jsimmons/pm2fb.diff

or grab it from the BK tree below. 

bk pull bk://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/cvisionppc.h |   51 
 include/video/pm2fb.h      |  222 ---
 drivers/video/Kconfig      |   18 
 drivers/video/Makefile     |    2 
 drivers/video/pm2fb.c      | 3014 +++++++++++++--------------------------------
 include/video/cvisionppc.h |   51 
 include/video/permedia2.h  |  222 +++
 7 files changed, 1210 insertions(+), 2370 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/17 1.1557.1.5)
   [PERMEDIA2 FBDEV] Updated to the new api.
