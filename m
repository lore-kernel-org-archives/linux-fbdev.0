From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Aug 2017 13:08:59 +0000
Subject: [PATCH v4 7/8] video: goldfishfb: Add support for device tree bindings
Message-Id: <1503061833-26563-8-git-send-email-aleksandar.markovic@rt-rk.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mips@linux-mips.org
Cc: Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Miodrag Dinic <miodrag.dinic@imgtec.com>, Goran Ferenc <goran.ferenc@imgtec.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bo Hu <bohu@google.com>, Douglas Leung <douglas.leung@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jin Qian <jinqian@google.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>, Petar Jovanovic <petar.jovanovic@imgtec.com>, Raghu Gandham <raghu.gandham@imgtec.com>

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add ability to the Goldfish FB driver to be recognized by OS via DT.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 drivers/video/fbdev/goldfishfb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 7f6c9e6..3b70044 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -304,12 +304,18 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id goldfish_fb_of_match[] = {
+	{ .compatible = "google,goldfish-fb", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
 
 static struct platform_driver goldfish_fb_driver = {
 	.probe		= goldfish_fb_probe,
 	.remove		= goldfish_fb_remove,
 	.driver = {
-		.name = "goldfish_fb"
+		.name = "goldfish_fb",
+		.of_match_table = goldfish_fb_of_match,
 	}
 };
 
-- 
2.7.4

