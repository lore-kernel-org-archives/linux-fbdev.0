From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] au1100: fix io_remap_page_range() arg. list
Date: Mon, 21 Feb 2005 15:28:22 -0800
Message-ID: <20050221152822.5221487b.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3MyP-0002Wa-EB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 15:28:17 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D3MyN-0004f7-RF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 15:28:17 -0800
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
To: ralf@linux-mips.org, akpm <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net


Fix io_remap_page_range() call to pass a missing arg.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/au1100fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/video/au1100fb.c~au1100_ioremap ./drivers/video/au1100fb.c
--- ./drivers/video/au1100fb.c~au1100_ioremap	2005-02-18 13:39:05.000000000 -0800
+++ ./drivers/video/au1100fb.c	2005-02-21 15:21:17.447431120 -0800
@@ -408,7 +408,7 @@ au1100fb_mmap(struct fb_info *_fb,
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO;
 
-	if (io_remap_page_range(vma->vm_start, off,
+	if (io_remap_page_range(vma, vma->vm_start, off,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;


---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
