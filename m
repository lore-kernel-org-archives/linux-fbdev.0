From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/10] pm2fb: RDAC_WR barriers clean up
Date: Thu, 17 May 2007 05:18:49 +0800
Message-ID: <464B7539.60704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9O-0005vU-85 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:14 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9N-0003Q1-UI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:14 -0700
Received: by py-out-1112.google.com with SMTP id a29so647770pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:13 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes a possible barriers problem in RDAC_WR
functions, then remove redudant ones.

It also removes one unneeded register load from blitter function().

Signed-off-by: Krzysztof.Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index ab5e668..0a04483 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -183,15 +183,17 @@ static inline void pm2_RDAC_WR(struct pm
 		index = PM2VR_RD_INDEXED_DATA;
 		break;
 	}	
-	mb();
+	wmb();
 	pm2_WR(p, index, v);
+	wmb();
 }
 
 static inline void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
-	mb();
+	wmb();
 	pm2_WR(p, PM2VR_RD_INDEXED_DATA, v);
+	wmb();
 }
 
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
@@ -466,11 +468,9 @@ static void set_memclock(struct pm2fb_pa
 		WAIT_FIFO(par, 8);
 		pm2_WR(par, PM2VR_RD_INDEX_HIGH, PM2VI_RD_MCLK_CONTROL >> 8);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 0);
-		wmb();
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_PRESCALE, m);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_FEEDBACK, n);
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_POSTSCALE, p);
-		wmb();
 		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 1);
 		rmb();
 		for (i = 256;
@@ -483,12 +483,9 @@ static void set_memclock(struct pm2fb_pa
 		pm2_mnp(clk, &m, &n, &p);
 		WAIT_FIFO(par, 10);
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 6);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_1, m);
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_2, n);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 8|p);
-		wmb();
 		pm2_RDAC_RD(par, PM2I_RD_MEMORY_CLOCK_STATUS);
 		rmb();
 		for (i = 256;
@@ -509,12 +506,9 @@ static void set_pixclock(struct pm2fb_pa
 		pm2_mnp(clk, &m, &n, &p);
 		WAIT_FIFO(par, 8);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 0);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A1, m);
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A2, n);
-		wmb();
 		pm2_RDAC_WR(par, PM2I_RD_PIXEL_CLOCK_A3, 8|p);
-		wmb();
 		pm2_RDAC_RD(par, PM2I_RD_PIXEL_CLOCK_STATUS);
 		rmb();
 		for (i = 256;
@@ -1066,10 +1060,9 @@ static void pm2fb_block_op(struct fb_inf
 
 	if (!w || !h)
 		return;
-	WAIT_FIFO(par, 6);
+	WAIT_FIFO(par, 5);
 	pm2_WR(par, PM2R_CONFIG, PM2F_CONFIG_FB_WRITE_ENABLE |
 		PM2F_CONFIG_FB_READ_SOURCE_ENABLE);
-	pm2_WR(par, PM2R_FB_PIXEL_OFFSET, 0);
 	if (copy)
 		pm2_WR(par, PM2R_FB_SOURCE_DELTA,
 			((ysrc-y) & 0xfff) << 16 | ((xsrc-x) & 0xfff));


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
