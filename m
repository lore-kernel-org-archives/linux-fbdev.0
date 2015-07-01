From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:40:56 +0000
Subject: [PATCH v2 01/12] device: property: delay device-driver matches
Message-Id: <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org

Delay matches of platform devices until late_initcall, when we are sure
that all built-in drivers have been registered already. This is needed
to prevent deferred probes because of some dependencies' drivers not
having registered yet.

This reduces the total amount of work that the kernel does during boot
because it won't try to match devices to drivers when built-in drivers
are still registering but also reduces some parallelism, so total boot
time might slightly increase or decrease depending on the platform and
kernel configuration.

This change will make make possible to prevent any deferred probes once
devices are probed in dependency order.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Instead of delaying all probes until late_initcall, only delay matches
  of platform devices that have a firmware node attached.

 drivers/base/property.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8528eb9..8ead1ba 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -16,8 +16,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 
+static bool fwnode_match_enable = false;
+
 /**
  * device_add_property_set - Add a collection of properties to a device object.
  * @dev: Device to add properties to.
@@ -604,6 +607,15 @@ EXPORT_SYMBOL_GPL(fwnode_is_compatible);
 bool fwnode_driver_match_device(struct device *dev,
 				const struct device_driver *drv)
 {
+	/*
+	 * Delay matches of platform devices until late_initcall, when we are
+	 * sure that all built-in drivers have been registered already. This
+	 * is needed to prevent deferred probes because of some drivers
+	 * not having registered yet.
+	 */
+	if(dev->bus = &platform_bus_type && !fwnode_match_enable)
+		return false;
+
 	if (is_of_node(dev->fwnode))
 		return of_driver_match_device(dev, drv);
 	else if (is_acpi_node(dev->fwnode))
@@ -612,3 +624,20 @@ bool fwnode_driver_match_device(struct device *dev,
 	return false;
 }
 EXPORT_SYMBOL_GPL(fwnode_driver_match_device);
+
+static int __device_attach(struct device *dev, void *data)
+{
+	device_initial_probe(dev);
+
+	return 0;
+}
+
+static int fwnode_match_initcall(void)
+{
+	fwnode_match_enable = true;
+
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, __device_attach);
+
+	return 0;
+}
+late_initcall(fwnode_match_initcall);
-- 
2.4.1

