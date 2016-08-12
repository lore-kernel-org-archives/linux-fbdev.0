From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 12 Aug 2016 14:14:55 +0000
Subject: [PATCH RFC 1/5] video: add HDMI state notifier support
Message-Id: <E1bYDEd-0004rZ-3i@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
In-Reply-To: <20160812141421.GB1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

Add support for HDMI hotplug and EDID notifiers, which is used to convey
information from HDMI drivers to their CEC and audio counterparts.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/Kconfig         |  3 +++
 drivers/video/Makefile        |  1 +
 drivers/video/hdmi-notifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi-notifier.h | 44 +++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af999893..1ee7b9f9bb25 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -36,6 +36,9 @@ config VIDEOMODE_HELPERS
 config HDMI
 	bool
 
+config HDMI_NOTIFIERS
+	bool
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17d6456..65f564906fb4 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_HDMI)                += hdmi.o
+obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
new file mode 100644
index 000000000000..f3b16552b0fe
--- /dev/null
+++ b/drivers/video/hdmi-notifier.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/hdmi-notifier.h>
+#include <linux/notifier.h>
+#include <linux/string.h>
+
+static BLOCKING_NOTIFIER_HEAD(hdmi_notifier);
+
+int hdmi_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_register_notifier);
+
+int hdmi_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_unregister_notifier);
+
+void hdmi_event_connect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_CONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_connect);
+
+void hdmi_event_disconnect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_DISCONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_disconnect);
+
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
+{
+	struct hdmi_event_new_edid new_edid;
+
+	new_edid.base.source = dev;
+	new_edid.edid = edid;
+	new_edid.size = size;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_EDID, &new_edid);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_edid);
+
+void hdmi_event_new_eld(struct device *dev, const u8 eld[128])
+{
+	struct hdmi_event_new_eld new_eld;
+
+	new_eld.base.source = dev;
+	memcpy(new_eld.eld, eld, sizeof(new_eld.eld));
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_ELD, &new_eld);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_eld);
diff --git a/include/linux/hdmi-notifier.h b/include/linux/hdmi-notifier.h
new file mode 100644
index 000000000000..5fb710e5d68a
--- /dev/null
+++ b/include/linux/hdmi-notifier.h
@@ -0,0 +1,44 @@
+#ifndef LINUX_HDMI_NOTIFIER_H
+#define LINUX_HDMI_NOTIFIER_H
+
+#include <linux/types.h>
+
+enum {
+	HDMI_CONNECTED,
+	HDMI_DISCONNECTED,
+	HDMI_NEW_EDID,
+	HDMI_NEW_ELD,
+};
+
+struct hdmi_event_base {
+	struct device *source;
+};
+
+struct hdmi_event_new_edid {
+	struct hdmi_event_base base;
+	const void *edid;
+	size_t size;
+};
+
+struct hdmi_event_new_eld {
+	struct hdmi_event_base base;
+	unsigned char eld[128];
+};
+
+union hdmi_event {
+	struct hdmi_event_base base;
+	struct hdmi_event_new_edid edid;
+	struct hdmi_event_new_eld eld;
+};
+
+struct notifier_block;
+
+int hdmi_register_notifier(struct notifier_block *nb);
+int hdmi_unregister_notifier(struct notifier_block *nb);
+
+void hdmi_event_connect(struct device *dev);
+void hdmi_event_disconnect(struct device *dev);
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size);
+void hdmi_event_new_eld(struct device *dev, const u8 eld[128]);
+
+#endif
-- 
2.1.0

