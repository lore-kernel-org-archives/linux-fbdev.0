From: Joe Perches <joe@perches.com>
Date: Mon, 13 Dec 2010 21:42:21 +0000
Subject: [PATCH 4/5] video: mx3fb: Use vsprintf extension %pR for struct resource
Message-Id: <b3c183f21ed73116f4c158249836ac5ab68862cb.1292276119.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1292276119.git.joe@perches.com>
In-Reply-To: <cover.1292276119.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-fbdev@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/mx3fb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index ca0f6be..cb01391 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1474,8 +1474,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 		goto eremap;
 	}
 
-	pr_debug("Remapped %x to %x at %p\n", sdc_reg->start, sdc_reg->end,
-		 mx3fb->reg_base);
+	pr_debug("Remapped %pR at %p\n", sdc_reg, mx3fb->reg_base);
 
 	/* IDMAC interface */
 	dmaengine_get();
-- 
1.7.3.3.398.g0b0cd.dirty

