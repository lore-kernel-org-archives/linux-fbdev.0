From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: deferred io cleanup fix for sh_mobile_lcdcfb
Date: Tue, 10 Mar 2009 15:08:49 +0900
Message-ID: <20090310060849.22278.94445.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix deferred io cleanup patch in the sh_mobile_lcdcfb driver.

If probe() fails early the sh_mobile_lcdc_stop() function will
be called to clean up deferred io. This patch modifies the
code to only call fb_deferred_io_cleanup() after deferred io
has been initialized. 

With this patch applied we no longer hit BUG_ON() inside
fb_deferred_io_cleanup(). Triggers on a Migo-R with the
SYS QVGA panel board unmounted.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/sh_mobile_lcdcfb.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-03-03 18:31:37.000000000 +0900
@@ -446,7 +446,6 @@ static void sh_mobile_lcdc_stop(struct s
 {
 	struct sh_mobile_lcdc_chan *ch;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
-	unsigned long tmp;
 	int k;
 
 	/* tell the board code to disable the panel */
@@ -456,9 +455,8 @@ static void sh_mobile_lcdc_stop(struct s
 		if (board_cfg->display_off)
 			board_cfg->display_off(board_cfg->board_data);
 
-		/* cleanup deferred io if SYS bus */
-		tmp = ch->cfg.sys_bus_cfg.deferred_io_msec;
-		if (ch->ldmt1r_value & (1 << 12) && tmp) {
+		/* cleanup deferred io if enabled */
+		if (ch->info.fbdefio) {
 			fb_deferred_io_cleanup(&ch->info);
 			ch->info.fbdefio = NULL;
 		}
