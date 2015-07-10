From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 10 Jul 2015 06:37:30 +0000
Subject: [PATCH 2/2] video: fbdev: Drop owner assignment from platform_driver
Message-Id: <1436510250-5633-3-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/video/fbdev/omap2/displays-new/encoder-opa362.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c b/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
index a14d993f719d..8c246c213e06 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
@@ -266,7 +266,6 @@ static struct platform_driver opa362_driver = {
 	.remove	= __exit_p(opa362_remove),
 	.driver	= {
 		.name	= "amplifier-opa362",
-		.owner	= THIS_MODULE,
 		.of_match_table = opa362_of_match,
 		.suppress_bind_attrs = true,
 	},
-- 
1.9.1

