From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 8/8] fbdev: Set correct mclk/xclk values for aty in ibook
Date: Tue, 2 Nov 2004 20:20:35 +0800
Message-ID: <200411022020.35889.adaplas@hotpop.com>
References: <200411021946.29343.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COxf5-0000Cr-Or
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 04:21:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COxf4-0003t2-W3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 04:21:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B04238EC01C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 12:21:11 +0000 (UTC)
In-Reply-To: <200411021946.29343.adaplas@hotpop.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Olaf Hering <olh@suse.de>

The patch has extraneous characters introduced. Take this one instead

Tony

The first iBook needs special mclk/xclk values, or the screen will show
only garbage. A patch like this went into 2.4.23. It stopped working
after 2.6.10-rc1.

http://linux.bkbits.net:8080/linux-2.4/cset@3f966ca7mqKxZorh7Uw2SBAuVbv3mA

It was discussed here:
http://marc.theaimsgroup.com/?t=106345749200001&r=1&w=4

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 atyfb_base.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-11-02 20:14:48 +08:00
@@ -2191,6 +2191,14 @@
 	par->aty_cmap_regs =
 	    (struct aty_cmap_regs __iomem *) (par->ati_regbase + 0xc0);
 
+#ifdef CONFIG_PPC_PMAC
+	/* The Apple iBook1 uses non-standard memory frequencies. We detect it
+	 * and set the frequency manually. */
+	if (machine_is_compatible("PowerBook2,1")) {
+		par->pll_limits.mclk = 70;
+		par->pll_limits.xclk = 53;
+	}
+#endif
 	if (pll)
 		par->pll_limits.pll_max = pll;
 	if (mclk)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
