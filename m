From: Tommi Rantala <tt.rantala@gmail.com>
Subject: [PATCH] omapfb: Blizzard: constify register address tables
Date: Mon, 21 Sep 2009 15:48:10 +0300
Message-ID: <1253537290-5362-1-git-send-email-tt.rantala@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>, Siarhei Siamashka <siarhei.siamashka@nokia.com>, Rodrigo Vivi <rodrigo.vivi@openbossa.org>, Tommi Rantala <tt.rantala@gmail.com>

Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>
---
 drivers/video/omap/blizzard.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index ce28be6..70dadf9 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -93,7 +93,7 @@ struct blizzard_reg_list {
 };
 
 /* These need to be saved / restored separately from the rest. */
-static struct blizzard_reg_list blizzard_pll_regs[] = {
+static const struct blizzard_reg_list blizzard_pll_regs[] = {
 	{
 		.start	= 0x04,		/* Don't save PLL ctrl (0x0C) */
 		.end	= 0x0a,
@@ -104,7 +104,7 @@ static struct blizzard_reg_list blizzard_pll_regs[] = {
 	},
 };
 
-static struct blizzard_reg_list blizzard_gen_regs[] = {
+static const struct blizzard_reg_list blizzard_gen_regs[] = {
 	{
 		.start	= 0x18,		/* SDRAM control */
 		.end	= 0x20,
@@ -1372,7 +1372,7 @@ static void blizzard_get_caps(int plane, struct omapfb_caps *caps)
 			   (1 << OMAPFB_COLOR_YUV420);
 }
 
-static void _save_regs(struct blizzard_reg_list *list, int cnt)
+static void _save_regs(const struct blizzard_reg_list *list, int cnt)
 {
 	int i;
 
@@ -1383,7 +1383,7 @@ static void _save_regs(struct blizzard_reg_list *list, int cnt)
 	}
 }
 
-static void _restore_regs(struct blizzard_reg_list *list, int cnt)
+static void _restore_regs(const struct blizzard_reg_list *list, int cnt)
 {
 	int i;
 
-- 
1.5.6.5

