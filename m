From: James Simmons <jsimmons@infradead.org>
Subject: fbdev documentation patch
Date: Mon, 26 Jan 2004 22:05:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0401262202280.5445-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

  The below patch updates the framebuffer docs to reflect the requirement 
that all driver names must end in fb. Please apply.

--- linus-2.6/Documentation/fb/modedb.txt	2004-01-26 13:31:19.000000000 -0800
+++ fbdev-2.6/Documentation/fb/modedb.txt	2004-01-26 16:32:23.000000000 -0800
@@ -51,10 +51,10 @@
     Drivers that support modedb boot options
     Boot Name	  Cards Supported
 
-    ami		- Amiga chipset frame buffer
+    amifb	- Amiga chipset frame buffer
     aty128fb	- ATI Rage128 / Pro frame buffer
     atyfb	- ATI Mach64 frame buffer
-    tdfx	- 3D Fx frame buffer
+    tdfxfb	- 3D Fx frame buffer
     tridentfb	- Trident (Cyber)blade chipset frame buffer
 
 BTW, only a few drivers use this at the moment. Others are to follow
