From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/41] fbdev: Kill sparse warning in
	deferred IO
Date: Wed, 25 Apr 2007 14:26:27 +0800
Message-ID: <462EF493.9050106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc5h-0000tT-58 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:05 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc5g-0002pB-M0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:05 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:39:04 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Kill the following in fb_defio.c:

drivers/video/fb_defio.c:40:43: warning: incorrect type in argument 1 (different address spaces)
drivers/video/fb_defio.c:40:43:    expected void *addr
drivers/video/fb_defio.c:40:43:    got char [noderef] *screen_base<asn:2>

The framebuffer memory of these types of devices are allocated from system
RAM.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fb_defio.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index f963f5f..1a8643f 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -32,12 +32,14 @@ static struct page* fb_deferred_io_nopag
 	unsigned long offset;
 	struct page *page;
 	struct fb_info *info = vma->vm_private_data;
+	/* info->screen_base is in System RAM */
+	void *screen_base = (void __force *) info->screen_base;
 
 	offset = (vaddr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
 	if (offset >= info->fix.smem_len)
 		return NOPAGE_SIGBUS;
 
-	page = vmalloc_to_page(info->screen_base + offset);
+	page = vmalloc_to_page(screen_base + offset);
 	if (!page)
 		return NOPAGE_OOM;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
