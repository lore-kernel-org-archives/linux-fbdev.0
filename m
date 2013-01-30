From: Tomasz Figa <t.figa@samsung.com>
Date: Wed, 30 Jan 2013 15:39:01 +0000
Subject: [RFC PATCH 2/4] video: add makefile & kconfig
Message-Id: <1359560343-31636-3-git-send-email-t.figa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
In-Reply-To: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com, Daniel Vetter <daniel@ffwll.ch>, Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, rob@ti.com, tomi.valkeinen@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, inki.dae@samsung.com, dh09.lee@samsung.com, ville.syrjala@intel.com, s.nawrocki@samsung.com

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/Kconfig          |  1 +
 drivers/video/Makefile         |  1 +
 drivers/video/display/Kconfig  | 10 ++++++++++
 drivers/video/display/Makefile |  1 +
 4 files changed, 13 insertions(+)
 create mode 100644 drivers/video/display/Kconfig
 create mode 100644 drivers/video/display/Makefile

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 68f17ee..800e98c 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2444,6 +2444,7 @@ source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 source "drivers/video/exynos/Kconfig"
 source "drivers/video/backlight/Kconfig"
+source "drivers/video/display/Kconfig"
 
 if VT
 	source "drivers/video/console/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f592f3b..4a091d4 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -14,6 +14,7 @@ fb-objs                           := $(fb-y)
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-y				  += backlight/
+obj-y				  += display/
 
 obj-$(CONFIG_EXYNOS_VIDEO)     += exynos/
 
diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
new file mode 100644
index 0000000..477192d
--- /dev/null
+++ b/drivers/video/display/Kconfig
@@ -0,0 +1,10 @@
+menuconfig DISPLAY_CORE
+	tristate "Display Core"
+	---help---
+	  Support common display framework for graphics devices.
+
+if DISPLAY_CORE
+
+
+
+endif # DISPLAY_CORE
diff --git a/drivers/video/display/Makefile b/drivers/video/display/Makefile
new file mode 100644
index 0000000..bd93496
--- /dev/null
+++ b/drivers/video/display/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DISPLAY_CORE) += display-core.o
-- 
1.8.1

