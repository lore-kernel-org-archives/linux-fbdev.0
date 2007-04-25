From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 39/41] pm2fb: Permedia 2V memory clock
	setting
Date: Wed, 25 Apr 2007 15:23:19 +0800
Message-ID: <462F01E7.5090305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcE3-0001mX-2b for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:43 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcE2-0007z9-MC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:43 -0700
Received: by py-out-1112.google.com with SMTP id a29so117820pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:47:42 -0700 (PDT)
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

Permedia 2V uses its own registers to set a memory clock. The
patch adds these registers and uses them in the set_memclock()
function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c     |   52 ++++++++++++++++++++++++++++++++-------------
 include/video/permedia2.h |    4 +++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 2c7dccb..6f634e3 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -462,21 +462,43 @@ static void set_memclock(struct pm2fb_pa
 	int i;
 	unsigned char m, n, p;
 
-	pm2_mnp(clk, &m, &n, &p);
-	WAIT_FIFO(par, 10);
-	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 6);
-	wmb();
-	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_1, m);
-	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_2, n);
-	wmb();
-	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 8|p);
-	wmb();
-	pm2_RDAC_RD(par, PM2I_RD_MEMORY_CLOCK_STATUS);
-	rmb();
-	for (i = 256;
-	     i && !(pm2_RD(par, PM2R_RD_INDEXED_DATA) & PM2F_PLL_LOCKED);
-	     i--)
-		;
+	switch (par->type) {
+	case PM2_TYPE_PERMEDIA2V:
+		pm2v_mnp(clk/2, &m, &n, &p);
+		WAIT_FIFO(par, 8);
+		pm2_WR(par, PM2VR_RD_INDEX_HIGH, PM2VI_RD_MCLK_CONTROL >> 8);
+		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 0);
+		wmb();
+		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_PRESCALE, m);
+		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_FEEDBACK, n);
+		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_POSTSCALE, p);
+		wmb();
+		pm2v_RDAC_WR(par, PM2VI_RD_MCLK_CONTROL, 1);
+		rmb();
+		for (i = 256;
+		     i && !(pm2_RDAC_RD(par, PM2VI_RD_MCLK_CONTROL) & 2);
+		     i--)
+			;
+		pm2_WR(par, PM2VR_RD_INDEX_HIGH, 0);
+		break;
+	case PM2_TYPE_PERMEDIA2:
+		pm2_mnp(clk, &m, &n, &p);
+		WAIT_FIFO(par, 10);
+		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 6);
+		wmb();
+		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_1, m);
+		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_2, n);
+		wmb();
+		pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 8|p);
+		wmb();
+		pm2_RDAC_RD(par, PM2I_RD_MEMORY_CLOCK_STATUS);
+		rmb();
+		for (i = 256;
+		     i && !(pm2_RD(par, PM2R_RD_INDEXED_DATA) & PM2F_PLL_LOCKED);
+		     i--)
+			;
+		break;
+	}
 }
 
 static void set_pixclock(struct pm2fb_par* par, u32 clk)
diff --git a/include/video/permedia2.h b/include/video/permedia2.h
index b95d362..9e49c95 100644
--- a/include/video/permedia2.h
+++ b/include/video/permedia2.h
@@ -154,6 +154,10 @@ #define PM2VI_RD_CLK0_POSTSCALE				0x203
 #define PM2VI_RD_CLK1_PRESCALE				0x204
 #define PM2VI_RD_CLK1_FEEDBACK				0x205
 #define PM2VI_RD_CLK1_POSTSCALE				0x206
+#define PM2VI_RD_MCLK_CONTROL				0x20D
+#define PM2VI_RD_MCLK_PRESCALE				0x20E
+#define PM2VI_RD_MCLK_FEEDBACK				0x20F
+#define PM2VI_RD_MCLK_POSTSCALE				0x210
 #define PM2VI_RD_CURSOR_PALETTE				0x303
 #define PM2VI_RD_CURSOR_PATTERN				0x400
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
