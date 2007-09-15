From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/12] pm2fb: replace busy waiting with
	cpu_relax
Date: Sat, 15 Sep 2007 08:07:09 +0800
Message-ID: <46EB222D.5000201@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLF0-0007mm-BR for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:30 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEz-0003jU-0P
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:30 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3286302rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:28 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces busy waiting with the cpu_relax() call.
This makes scrolling faster.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 9db1f2e..5591dfb 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -193,8 +193,8 @@ #define WAIT_FIFO(p, a)
 #else
 static inline void WAIT_FIFO(struct pm2fb_par *p, u32 a)
 {
-	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a);
-	mb();
+	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a)
+		cpu_relax();
 }
 #endif
 
@@ -328,7 +328,7 @@ static void reset_card(struct pm2fb_par 
 	pm2_WR(p, PM2R_RESET_STATUS, 0);
 	mb();
 	while (pm2_RD(p, PM2R_RESET_STATUS) & PM2F_BEING_RESET)
-		;
+		cpu_relax();
 	mb();
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
 	DPRINTK("FIFO disconnect enabled\n");
@@ -1041,8 +1041,7 @@ static int pm2fb_sync(struct fb_info *in
 	mb();
 	do {
 		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
-			udelay(10);
-		rmb();
+			cpu_relax();
 	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
 
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
