From: akinobu.mita@gmail.com
Subject: [patch -v2 18/23] aty: use
	memory_read_from_buffer
Date: Mon, 02 Jun 2008 08:13:47 +0900
Message-ID: <20080601231628.820854976@gmail.com>
References: <20080601231329.223608711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2wyk-0002eM-Qd for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 16:28:47 -0700
Received: from rv-out-0708.google.com ([209.85.198.248])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2wyh-00066d-V4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 16:28:45 -0700
Received: by rv-out-0708.google.com with SMTP id f25so578917rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Jun 2008 16:28:43 -0700 (PDT)
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
To: linux-kernel@vger.kernel.org
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
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
