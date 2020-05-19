From: Sasha Levin <sashal@kernel.org>
Date: Tue, 19 May 2020 16:32:32 +0000
Subject: [RFC PATCH 2/4] gpu: dxgkrnl: hook up dxgkrnl
Message-Id: <20200519163234.226513-3-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alexander.deucher@amd.com, chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, spronovo@microsoft.com, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, kys@microsoft.com

Connect the dxgkrnl module to the drivers/gpu/ makefile and Kconfig.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/Makefile  | 2 +-
 drivers/video/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..28c22c814494 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -3,6 +3,6 @@
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-y			+= drm/ vga/ dxgkrnl/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 427a993c7f57..362c08778a54 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -19,6 +19,8 @@ source "drivers/gpu/ipu-v3/Kconfig"
 
 source "drivers/gpu/drm/Kconfig"
 
+source "drivers/gpu/dxgkrnl/Kconfig"
+
 menu "Frame buffer Devices"
 source "drivers/video/fbdev/Kconfig"
 endmenu
-- 
2.25.1
