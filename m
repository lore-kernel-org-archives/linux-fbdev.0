From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jan 2018 16:14:05 +0000
Subject: [PATCH 2/2] drm/msm/adreno: fix nvmem related link error
Message-Id: <20180115161431.803248-2-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180115161431.803248-1-arnd@arndb.de>
In-Reply-To: <20180115161431.803248-1-arnd-r2nGTMty4D4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When NVMEM is configured as a loadable module, and adreno
is built-in, we get a link failure:

drivers/gpu/drm/msm/adreno/a5xx_gpu.o: In function `a5xx_gpu_init':
a5xx_gpu.c:(.text+0x15cc): undefined reference to `nvmem_cell_get'
a5xx_gpu.c:(.text+0x15da): undefined reference to `nvmem_cell_read'
a5xx_gpu.c:(.text+0x15e4): undefined reference to `nvmem_cell_put'

This adds a Kconfig dependency to enforce valid configurations,
when NVMEM is a loadable module, adreno now has to also be one.
The code seems to deal fine with nvmem being completely disabled,
it will just not set the right speed bin then, so we don't need
a hard dependency.

Fixes: f56d9df656c4 ("drm/msm/adreno: Read the speed bins for a5xx targets")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 99d39b2aefa6..74fb1c816da9 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -4,6 +4,7 @@ config DRM_MSM
 	depends on DRM
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
+	depends on NVMEM || !NVMEM
 	depends on MMU
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
-- 
2.9.0

