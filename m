From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 5/7] [ARM] s3c-fb: Added missing window
	enabled state updates.
Date: Fri, 11 Sep 2009 20:05:00 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5C@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <p.osciak@samsung.com>) id 1MmAVo-0004au-EZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:20 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MmAVh-0006mf-Vj for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 18:06:20 +0000
Received: from eu_spt1 (mailout1.w1.samsung.com [210.118.77.11])
	by mailout1.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KPT00NXUJM058@mailout1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:06:01 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0KPT005RKJM15M@spt1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Sep 2009 19:06:01 +0100 (BST)
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 drivers/video/s3c-fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 307a7e8..226d225 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -401,6 +401,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 		writel(osdc_data, regs + VIDOSD_C(win_no));
 
 	data = WINCONx_ENWIN;
+	sfb->enabled |= (1 << win_no);
 
 	/* note, since we have to round up the bits-per-pixel, we end up
 	 * relying on the bitfield information for r/g/b/a to work out
@@ -633,6 +634,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 		/* disable the DMA and display 0x0 (black) */
 		writel(WINxMAP_MAP | WINxMAP_MAP_COLOUR(0x0),
 		       sfb->regs + WINxMAP(index));
+        sfb->enabled &= ~(1 << index);
 		break;
 
 	case FB_BLANK_UNBLANK:
-- 
1.6.4.2.253.g0b1fac

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
