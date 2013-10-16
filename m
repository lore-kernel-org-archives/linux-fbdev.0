From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Oct 2013 18:25:11 +0000
Subject: [RFR 1/2] drm: Add panel support
Message-Id: <1381947912-11741-2-git-send-email-treding@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1381947912-11741-1-git-send-email-treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add a very simple framework to register and lookup panels. Panel drivers
can initialize a DRM panel and register it with the framework, allowing
them to be retrieved and used by display drivers. Currently only support
for DPMS and obtaining panel modes is provided. However it should be
sufficient to enable a large number of panels. The framework should also
be easily extensible to support more sophisticated kinds of panels such
as DSI.

The framework hasn't been tied into the DRM core, even though it should
be easily possible to do so if that's what we want. In the current
implementation, display drivers can simple make use of it to retrieve a
panel, obtain its modes and control its DPMS mode.

Note that this is currently only tested on systems that boot from a
device tree. No glue code has been written yet for systems that use
platform data, but it should be easy to add.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/Kconfig       |  2 +
 drivers/gpu/drm/Makefile      |  1 +
 drivers/gpu/drm/drm_panel.c   | 96 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig |  4 ++
 include/drm/drm_panel.h       | 78 +++++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_panel.c
 create mode 100644 drivers/gpu/drm/panel/Kconfig
 create mode 100644 include/drm/drm_panel.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 290e2ac..a1d4f8e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -238,3 +238,5 @@ source "drivers/gpu/drm/qxl/Kconfig"
 source "drivers/gpu/drm/msm/Kconfig"
 
 source "drivers/gpu/drm/tegra/Kconfig"
+
+source "drivers/gpu/drm/panel/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e39cd03..81363a9 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -18,6 +18,7 @@ drm-y       :=	drm_auth.o drm_buffer.o drm_bufs.o drm_cache.o \
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
 drm-$(CONFIG_PCI) += ati_pcigart.o
+drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 
 drm-usb-y   := drm_usb.o
 
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
new file mode 100644
index 0000000..ff6e459
--- /dev/null
+++ b/drivers/gpu/drm/drm_panel.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_panel.h>
+
+static DEFINE_MUTEX(panel_lock);
+static LIST_HEAD(panel_list);
+
+void drm_panel_init(struct drm_panel *panel)
+{
+	INIT_LIST_HEAD(&panel->list);
+}
+EXPORT_SYMBOL(drm_panel_init);
+
+int drm_panel_add(struct drm_panel *panel)
+{
+	mutex_lock(&panel_lock);
+	list_add_tail(&panel->list, &panel_list);
+	mutex_unlock(&panel_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_panel_add);
+
+void drm_panel_remove(struct drm_panel *panel)
+{
+	mutex_lock(&panel_lock);
+	list_del_init(&panel->list);
+	mutex_unlock(&panel_lock);
+}
+EXPORT_SYMBOL(drm_panel_remove);
+
+int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
+{
+	if (panel->connector)
+		return -EBUSY;
+
+	panel->connector = connector;
+	panel->drm = connector->dev;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_panel_attach);
+
+int drm_panel_detach(struct drm_panel *panel)
+{
+	panel->connector = NULL;
+	panel->drm = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_panel_detach);
+
+#ifdef CONFIG_OF
+struct drm_panel *of_drm_find_panel(struct device_node *np)
+{
+	struct drm_panel *panel;
+
+	mutex_lock(&panel_lock);
+
+	list_for_each_entry(panel, &panel_list, list) {
+		if (panel->dev->of_node = np) {
+			mutex_unlock(&panel_lock);
+			return panel;
+		}
+	}
+
+	mutex_unlock(&panel_lock);
+	return NULL;
+}
+EXPORT_SYMBOL(of_drm_find_panel);
+#endif
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
new file mode 100644
index 0000000..2ddd5bd
--- /dev/null
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -0,0 +1,4 @@
+menuconfig DRM_PANEL
+	bool "DRM panel support"
+	help
+	  Panel registration and lookup framework.
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
new file mode 100644
index 0000000..4c8760b
--- /dev/null
+++ b/include/drm/drm_panel.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __DRM_PANEL_H__
+#define __DRM_PANEL_H__
+
+#include <linux/list.h>
+
+struct drm_connector;
+struct drm_device;
+struct drm_panel;
+
+struct drm_panel_funcs {
+	void (*disable)(struct drm_panel *panel);
+	void (*enable)(struct drm_panel *panel);
+	int (*get_modes)(struct drm_panel *panel);
+};
+
+struct drm_panel {
+	struct drm_device *drm;
+	struct drm_connector *connector;
+	struct device *dev;
+
+	const struct drm_panel_funcs *funcs;
+
+	struct list_head list;
+};
+
+static inline void drm_panel_disable(struct drm_panel *panel)
+{
+	if (panel && panel->funcs && panel->funcs->disable)
+		panel->funcs->disable(panel);
+}
+
+static inline void drm_panel_enable(struct drm_panel *panel)
+{
+	if (panel && panel->funcs && panel->funcs->enable)
+		panel->funcs->enable(panel);
+}
+
+void drm_panel_init(struct drm_panel *panel);
+
+int drm_panel_add(struct drm_panel *panel);
+void drm_panel_remove(struct drm_panel *panel);
+
+int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector);
+int drm_panel_detach(struct drm_panel *panel);
+
+#ifdef CONFIG_OF
+struct drm_panel *of_drm_find_panel(struct device_node *np);
+#else
+static inline struct drm_panel *of_drm_find_panel(struct device_node *np)
+{
+	return NULL;
+}
+#endif
+
+#endif
-- 
1.8.4

