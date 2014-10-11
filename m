From: Vinod Koul <vinod.koul@intel.com>
Date: Sat, 11 Oct 2014 15:52:40 +0000
Subject: [PATCH 12/12] video: mx3fb: use dmaengine_terminate_all() API
Message-Id: <1413042040-28222-12-git-send-email-vinod.koul@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
In-Reply-To: <1413041973-28146-1-git-send-email-vinod.koul@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Denis Carikli <denis@eukrea.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The drivers should use dmaengine_terminate_all() API instead of
accessing the device_control which will be deprecated soon

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/video/fbdev/mx3fb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index c645a0a..cdbc93a 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -461,8 +461,7 @@ static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 
 	spin_unlock_irqrestore(&mx3fb->lock, flags);
 
-	mx3_fbi->txd->chan->device->device_control(mx3_fbi->txd->chan,
-						   DMA_TERMINATE_ALL, 0);
+	dmaengine_terminate_all(mx3_fbi->txd->chan);
 	mx3_fbi->txd = NULL;
 	mx3_fbi->cookie = -EINVAL;
 }
-- 
1.7.0.4

