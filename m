From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH atyfb] Fix typo
Date: Wed, 10 Nov 2004 19:27:00 +0100
Message-ID: <200411101927.01121.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_11lkBbpv51OpLxW"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRxBU-0007nc-6D
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:27:08 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRxBT-0004Vh-Am
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:27:08 -0800
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_11lkBbpv51OpLxW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix typo, and decrease amount of output


Signed-off-by: Alexander Kern <alex.kern@gmx.de>



--Boundary-00=_11lkBbpv51OpLxW
Content-Type: text/x-diff;
  charset="us-ascii";
  name="atyfb_fix_typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_fix_typo.patch"

--- linux-2.6.head/drivers/video/aty/atyfb_base.c.orig	2004-11-07 17:14:57.000000000 +0100
+++ linux-2.6.head/drivers/video/aty/atyfb_base.c	2004-11-07 19:22:58.973917552 +0100
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
 

--Boundary-00=_11lkBbpv51OpLxW--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
