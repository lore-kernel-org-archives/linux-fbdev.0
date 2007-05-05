From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/20] pm2fb: memclock setting
	corrections
Date: Sat, 05 May 2007 23:09:30 +0800
Message-ID: <463C9E2A.4060402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkNPS-0006zp-I3 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 09:47:02 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEt-0008EN-G9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:32:04 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:32:03 -0700 (PDT)
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

This patch disables a memory clock setting if a board has been
initialized by BIOS. This allows using the memory clock set by
manufacturer of the board.
This patch also sets default clock for 3dlabs Permedia 2V
reference board's clock to 75MHz (BIOS setting for EONtronic
Permedia 2Vboard), because the default 83MHz can be too high.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 33f17a9..5395419 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1141,10 +1141,10 @@ #endif
 		default_par->mem_control, default_par->boot_address,
 		default_par->mem_config);
 
-	default_par->memclock = CVPPC_MEMCLOCK;
 	if(default_par->mem_control == 0 &&
 		default_par->boot_address == 0x31 &&
 		default_par->mem_config == 0x259fffff) {
+		default_par->memclock = CVPPC_MEMCLOCK;
 		default_par->mem_control=0;
 		default_par->boot_address=0x20;
 		default_par->mem_config=0xe6002021;
@@ -1164,7 +1164,7 @@ #endif
 			DPRINTK("We have not been initialized by VGA BIOS "
 				"and are running on an 3dlabs reference board\n");
 			DPRINTK("Initializing card timings manually...\n");
-			default_par->memclock=70000;
+			default_par->memclock=74894;
 		}
 	}
 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
