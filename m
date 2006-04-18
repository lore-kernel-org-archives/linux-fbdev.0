From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] fix section mismatch in pm2fb.o
Date: Wed, 19 Apr 2006 01:50:38 +0200
Message-ID: <20060418235038.GC11582@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750849AbWDRXuk@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, Darren Jenkins <darrenrjenkins@gmail.com>, linux-kernel@vger.kernel.org

From: Darren Jenkins <darrenrjenkins@gmail.com>

There are a couple of Section mismatch problems in drivers/video/pm2fb.o

WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd5d)
WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd82)

They are caused because pm2fb_set_par() uses lowhsync and lowvsync which
are marked __devinitdata.

This patch simply removes the __devinitdata annotations.

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Apr 2006

--- 2.6.16-git20/drivers/video/pm2fb.c.orig	2006-04-03 19:08:51.000000000 +1000
+++ 2.6.16-git20/drivers/video/pm2fb.c	2006-04-03 19:09:34.000000000 +1000
@@ -73,8 +73,8 @@ static char *mode __devinitdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __devinitdata = 0;
-static int lowvsync __devinitdata = 0;
+static int lowhsync = 0;
+static int lowvsync = 0;
 
 /*
  * The hardware state of the graphics card that isn't part of the
