From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 07 Aug 2015 16:10:17 +0000
Subject: [PATCH] drm: Remove two-level menu in Kconfig
Message-Id: <1438963817-9695-1-git-send-email-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Thierry Reding <treding@nvidia.com>

The Direct Rendering Manager Kconfig option is already a separate menu,
so remove the extra level to make it easier to navigate.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8bf495ffb020..e0606c01e8ac 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -22,9 +22,7 @@ source "drivers/gpu/vga/Kconfig"
 source "drivers/gpu/host1x/Kconfig"
 source "drivers/gpu/ipu-v3/Kconfig"
 
-menu "Direct Rendering Manager"
 source "drivers/gpu/drm/Kconfig"
-endmenu
 
 menu "Frame buffer Devices"
 source "drivers/video/fbdev/Kconfig"
-- 
2.4.5

