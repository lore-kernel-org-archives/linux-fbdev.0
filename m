From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/6] radeonfb: Set accelerator id
Date: Tue, 18 Jan 2005 05:40:58 +0800
Message-ID: <200501180540.58285.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqece-00036c-1S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:16 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqecc-0006yR-Cb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C4A2613502E1
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:40:56 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Set accelerator id for radeonfb. This id is checked by some user apps such
as DirectFB.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 radeon_base.c |    1 +
 1 files changed, 1 insertion(+)

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2005-01-15 04:25:57 +08:00
+++ b/drivers/video/aty/radeon_base.c	2005-01-15 08:08:53 +08:00
@@ -1748,6 +1748,7 @@
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
+	info->fix.accel = FB_ACCEL_ATI_RADEON;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
