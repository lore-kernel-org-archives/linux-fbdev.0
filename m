From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/5] au1100fb: replaced io_remap_page_range() with io_remap_pfn_range()
Date: Thu, 23 Feb 2006 19:59:06 +0800
Message-ID: <43FDA38A.9090409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCSIG-0001ya-Lx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 18:02:52 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCSIF-0004cx-BC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 18:02:52 -0800
Received: by pproxy.gmail.com with SMTP id s49so239226pyc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 18:02:50 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Freddy Spierenburg <freddy@dusktilldawn.nl>

From: Freddy Spierenburg <freddy@dusktilldawn.nl>

Replaced the no longer existing io_remap_page_range() routine
with the io_remap_pfn_range() routine. Did not have a chance yet
to test the functionality of the driver, but at least the kernel
compiles cleanly again.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/au1100fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 2406899..3d04b2d 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
@@ -406,7 +407,7 @@ int au1100fb_fb_mmap(struct fb_info *fbi
 
 	vma->vm_flags |= VM_IO;
 
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
