From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/12] pm3fb: replace busy waiting with
	cpu_relax
Date: Sat, 15 Sep 2007 08:07:45 +0800
Message-ID: <46EB2251.2060702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLF3-0007n0-4f for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:33 -0700
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLF2-0003qG-RU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:33 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1238382waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:32 -0700 (PDT)
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

 drivers/video/pm3fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 6a64b93..0706599 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -110,7 +110,8 @@ static inline void PM3_WRITE_REG(struct 
 
 static inline void PM3_WAIT(struct pm3_par *par, u32 n)
 {
-	while (PM3_READ_REG(par, PM3InFIFOSpace) < n);
+	while (PM3_READ_REG(par, PM3InFIFOSpace) < n)
+		cpu_relax();
 }
 
 static inline void PM3_WRITE_DAC_REG(struct pm3_par *par, unsigned r, u8 v)
@@ -209,8 +210,8 @@ static int pm3fb_sync(struct fb_info *in
 	PM3_WRITE_REG(par, PM3Sync, 0);
 	mb();
 	do {
-		while ((PM3_READ_REG(par, PM3OutFIFOWords)) == 0);
-		rmb();
+		while ((PM3_READ_REG(par, PM3OutFIFOWords)) == 0)
+			cpu_relax();
 	} while ((PM3_READ_REG(par, PM3OutputFifo)) != PM3Sync_Tag);
 
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
