From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [patch -v3 17/22] aty: use
	memory_read_from_buffer
Date: Wed, 04 Jun 2008 20:56:50 +0900
Message-ID: <20080604115828.992854080@gmail.com>
References: <20080604115633.116832712@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3rpM-0001TH-6M for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 05:10:52 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3rpL-0005qB-RN
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 05:10:52 -0700
Received: by py-out-1112.google.com with SMTP id n24so31639pyh.20
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 04 Jun 2008 05:10:51 -0700 (PDT)
Content-Disposition: inline; filename=aty-use-memory-read-from-buffer.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/aty/radeon_base.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

Index: 2.6-git/drivers/video/aty/radeon_base.c
===================================================================
--- 2.6-git.orig/drivers/video/aty/radeon_base.c
+++ 2.6-git/drivers/video/aty/radeon_base.c
@@ -70,6 +70,7 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
+#include <linux/fs.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -2098,15 +2099,7 @@ static void radeon_identify_vram(struct 
 
 static ssize_t radeon_show_one_edid(char *buf, loff_t off, size_t count, const u8 *edid)
 {
-	if (off > EDID_LENGTH)
-		return 0;
-
-	if (off + count > EDID_LENGTH)
-		count = EDID_LENGTH - off;
-
-	memcpy(buf, edid + off, count);
-
-	return count;
+	return memory_read_from_buffer(buf, count, &off, edid, EDID_LENGTH);
 }
 
 

-- 

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
