From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Fri, 19 Dec 2014 02:00:26 +0000
Subject: [PATCH v2 7/7] gpu: ipu-di: Switch to DIV_ROUND_CLOSEST for DI clock divider calc
Message-Id: <1418954426-21909-8-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Denis Carikli <denis@eukrea.com>, Jiada Wang <jiada_wang@mentor.com>, Steve Longerbeam <steve_longerbeam@mentor.com>

We can use the DIV_ROUND_CLOSEST() macro when calculating the DI
clock divider, rounded to nearest int.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-di.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index d95fbd0..b61d6be 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -440,8 +440,7 @@ static void ipu_di_config_clock(struct ipu_di *di,
 			clk_set_rate(clk, sig->mode.pixelclock);
 
 			in_rate = clk_get_rate(clk);
-			div = (in_rate + sig->mode.pixelclock / 2) /
-				sig->mode.pixelclock;
+			div = DIV_ROUND_CLOSEST(in_rate, sig->mode.pixelclock);
 			if (div = 0)
 				div = 1;
 
@@ -459,8 +458,7 @@ static void ipu_di_config_clock(struct ipu_di *di,
 		unsigned div, error;
 
 		clkrate = clk_get_rate(di->clk_ipu);
-		div = (clkrate + sig->mode.pixelclock / 2) /
-			sig->mode.pixelclock;
+		div = DIV_ROUND_CLOSEST(clkrate, sig->mode.pixelclock);
 		rate = clkrate / div;
 
 		error = rate / (sig->mode.pixelclock / 1000);
@@ -482,8 +480,7 @@ static void ipu_di_config_clock(struct ipu_di *di,
 			clk_set_rate(clk, sig->mode.pixelclock);
 
 			in_rate = clk_get_rate(clk);
-			div = (in_rate + sig->mode.pixelclock / 2) /
-				sig->mode.pixelclock;
+			div = DIV_ROUND_CLOSEST(in_rate, sig->mode.pixelclock);
 			if (div = 0)
 				div = 1;
 
-- 
1.7.9.5

