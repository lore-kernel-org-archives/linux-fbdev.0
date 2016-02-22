From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 22 Feb 2016 20:54:47 +0000
Subject: [PATCH 9/9] simplefb: Remove impossible check for of_clk_get_parent_count() < 0
Message-Id: <1456174487-28397-10-git-send-email-sboyd@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456174487-28397-1-git-send-email-sboyd@codeaurora.org>
In-Reply-To: <1456174487-28397-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

The check for < 0 is impossible now that
of_clk_get_parent_count() returns an unsigned int. Simplify the
code and update the types.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Please ack so this can go through clk tree along with patch 1.

 drivers/video/fbdev/simplefb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 48ccf6db62a2..e9cf19977285 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -174,7 +174,7 @@ static int simplefb_parse_pd(struct platform_device *pdev,
 struct simplefb_par {
 	u32 palette[PSEUDO_PALETTE_SIZE];
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
-	int clk_count;
+	unsigned int clk_count;
 	struct clk **clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
@@ -213,7 +213,7 @@ static int simplefb_clocks_init(struct simplefb_par *par,
 		return 0;
 
 	par->clk_count = of_clk_get_parent_count(np);
-	if (par->clk_count <= 0)
+	if (!par->clk_count)
 		return 0;
 
 	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

