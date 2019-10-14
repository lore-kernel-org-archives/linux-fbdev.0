From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:05 +0000
Subject: [PATCH v2 04/15] drm: Add fbconv helper module
Message-Id: <20191014140416.28517-5-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

This adds fbconv helpers for DRM to the build infrastructure. The
configuration symbol is DRM_FBCONV_HELPERS. Drivers should select
it if they wish to use fbconv.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig             | 10 ++++++++++
 drivers/gpu/drm/Makefile            |  1 +
 drivers/gpu/drm/drm_fbconv_helper.c |  1 +
 3 files changed, 12 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_fbconv_helper.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 9591bd720e56..ed689201ec81 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -157,6 +157,16 @@ config DRM_DP_CEC
 	  Note: not all adapters support this feature, and even for those
 	  that do support this they often do not hook up the CEC pin.
 
+config DRM_FBCONV_HELPER
+	tristate "Enable fbdev conversion helpers"
+	depends on DRM
+	help
+	  Provides helpers for running DRM on top of fbdev drivers. Choose
+	  this option if you're converting an fbdev driver to DRM. The
+	  helpers provide conversion functions for fbdev data structures
+	  and allow to build a basic DRM driver on top of the fbdev
+	  interfaces.
+
 config DRM_TTM
 	tristate
 	depends on DRM && MMU
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 9f1c7c486f88..a7178245d938 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -52,6 +52,7 @@ drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 drm_kms_helper-$(CONFIG_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
 drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
 drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
+drm_kms_helper-$(CONFIG_DRM_FBCONV_HELPER) += drm_fbconv_helper.o
 
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
new file mode 100644
index 000000000000..0cb46d2c98c3
--- /dev/null
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
-- 
2.23.0
