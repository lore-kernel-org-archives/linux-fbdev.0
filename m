From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] MAINTAINERS: mark framebuffer as Orphan
Date: Thu, 15 Feb 2007 13:25:49 -0800
Message-ID: <20070215132549.c182f7bf.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161383AbXBOVa3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

From: Randy Dunlap <randy.dunlap@oracle.com>

Are we ready to do this?
I'd love for Tony to return, but he's been missing for awhile now.

So this give us the following major areas that are marked as Orphan:

Firmware loader
Framebuffer
Serial (8250/16x50)

and PCMCIA has a Team.  It doesn't seem to be hurting.  :)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 MAINTAINERS |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.20-git9.orig/MAINTAINERS
+++ linux-2.6.20-git9/MAINTAINERS
@@ -1321,11 +1321,9 @@ W:	http://www.farsite.co.uk/
 S:	Supported
 
 FRAMEBUFFER LAYER
-P:	Antonino Daplas
-M:	adaplas@pol.net
 L:	linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
 W:	http://linux-fbdev.sourceforge.net/
-S:	Maintained
+S:	Orphan
 
 FREESCALE SOC FS_ENET DRIVER
 P:	Pantelis Antoniou
