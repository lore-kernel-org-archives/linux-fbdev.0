From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/8] fbdev: Fix typo in atyfb
Date: Thu, 11 Nov 2004 10:15:39 +0800
Message-ID: <20041111022458.AFCCF1A022E@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4eE-00053I-NC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:18 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4eD-0004U5-N9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E0CC29D84B2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:25:09 +0000 (UTC)
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
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix typo, and decrease amount of output

Signed-off-by: Alexander Kern <alex.kern@gmx.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 atyfb_base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-11-10 06:15:06 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-11-11 09:56:16 +08:00
@@ -659,7 +659,7 @@
 	aty_st_le32(CRTC_GEN_CNTL, crtc->gen_cntl & ~CRTC_EN, par);
 
 	DPRINTK("setting up CRTC\n");
-	PRINTKI("set primary CRT to %ix%i %c%c composite %c\n",
+	DPRINTK("set primary CRT to %ix%i %c%c composite %c\n",
 	    ((((crtc->h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->v_tot_disp>>16) & 0x7ff) + 1),
 	    (crtc->h_sync_strt_wid & 0x200000)?'N':'P', (crtc->v_sync_strt_wid & 0x200000)?'N':'P',
 	    (crtc->gen_cntl & CRTC_CSYNC_EN)?'P':'N');
@@ -692,7 +692,7 @@
 		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
 			(SHADOW_EN | SHADOW_RW_EN), par);
 
-		PRINTKI("set secondary CRT to %ix%i %c%c\n",
+		DPRINTK("set secondary CRT to %ix%i %c%c\n",
 		    ((((crtc->shadow_h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->shadow_v_tot_disp>>16) & 0x7ff) + 1),
 		    (crtc->shadow_h_sync_strt_wid & 0x200000)?'N':'P', (crtc->shadow_v_sync_strt_wid & 0x200000)?'N':'P');
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
