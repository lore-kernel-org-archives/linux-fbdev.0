From: "Randy.Dunlap" <randy.dunlap@verizon.net>
Subject: [PATCH] 2.5.69 drm/radeon_cp.c
Date: Sun, 4 May 2003 20:49:01 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030504204901.20761942.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from out006pub.verizon.net ([206.46.170.106] helo=out006.verizon.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19CWyt-0001gt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 May 2003 20:49:35 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: torvalds@transmeta.com, linux-fbdev-devel@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>, ajoshi@shell.unixbox.com, gareth.hughes@acm.org, faith@redhat.com, jsimmons@infradead.org

Hi,

This patch to 2.5.69 fixes this warning (gcc 3.2):
drivers/char/drm/radeon_cp.c: In function `radeon_cp_init_ring_buffer':
drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)
drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)


Is this obvious enough?  Want it to go thru someone?

--
~Randy



patch_name:	drm_radeon_dma.patch
patch_version:	2003-05-04.20:32:09
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix printk of dma_addr_t
product:	Linux
product_versions: linux-2569
changelog:	print dma_addr_t as unsigned long
maintainer:	dunno: Ani Joshi (ajoshi@shell.unixbox.com),
		James Simmons (jsimmons@infradead.org),
		Gareth Hughes (gareth.hughes@acm.org),
		Rik Faith (faith@redhat.com)
diffstat:	=
 drivers/char/drm/radeon_cp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./drivers/char/drm/radeon_cp.c%VID ./drivers/char/drm/radeon_cp.c
--- ./drivers/char/drm/radeon_cp.c%VID	2003-05-04 16:53:06.000000000 -0700
+++ ./drivers/char/drm/radeon_cp.c	2003-05-04 20:30:30.000000000 -0700
@@ -903,8 +903,8 @@
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
 			     entry->busaddr[page_ofs]);
-		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
-			   entry->busaddr[page_ofs],
+		DRM_DEBUG( "ring rptr: offset=0x%08lx handle=0x%08lx\n",
+			   (unsigned long) entry->busaddr[page_ofs],
 			   entry->handle + tmp_ofs );
 	}
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
