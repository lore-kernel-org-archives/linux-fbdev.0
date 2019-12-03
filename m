From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:49 +0000
Subject: [PATCH v3 07/12] video: fbdev: intelfb: use const pointer for fb_ops
Message-Id: <171c573bc2977a6ec374753ac7bb03a3523ca2b7.1575390740.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Use const for fb_ops to let us make the fbops struct const in the
future.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/intelfb/intelfb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfb.h b/drivers/video/fbdev/intelfb/intelfb.h
index b54db05f028d..5de703902a21 100644
--- a/drivers/video/fbdev/intelfb/intelfb.h
+++ b/drivers/video/fbdev/intelfb/intelfb.h
@@ -273,7 +273,7 @@ struct intelfb_vsync {
 
 struct intelfb_info {
 	struct fb_info *info;
-	struct fb_ops  *fbops;
+	const struct fb_ops *fbops;
 	struct pci_dev *pdev;
 
 	struct intelfb_hwstate save_state;
-- 
2.20.1
