From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH] radeonfb: more initializer fixes
Date: Fri, 29 Oct 2004 23:11:01 +0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1099080661.9569.0.camel@localhost>
References: <200410281712.i9SHCxDe025312@hera.kernel.org>
	 <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263477AbUJ2URy@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Use 8-bit palette entries for radeonfb and avoid zero-initialization
as suggested by Geert Uytterhoeven.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 radeon_monitor.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/video/aty/radeon_monitor.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/video/aty/radeon_monitor.c	2004-10-29 11:07:54.000000000 +0300
+++ 2.6.10-rc1-mm1/drivers/video/aty/radeon_monitor.c	2004-10-29 23:02:58.854952680 +0300
@@ -12,9 +12,9 @@
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
 	.bits_per_pixel = 8,
-	.red		= { 0, 6, 0 },
-	.green		= { 0, 6, 0 },
-	.blue		= { 0, 6, 0 },
+	.red		= { .length = 8 },
+	.green		= { .length = 8 },
+	.blue		= { .length = 8 },
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,
