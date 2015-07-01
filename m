From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:07 +0000
Subject: [PATCH v2 12/12] driver-core: probe dependencies before probing
Message-Id: <1435743667-11987-13-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org

Before actually probing a device, find out what dependencies it has and
do our best to ensure that they are available at this point.

This is accomplished by finding out what platform devices need to be
probed and probing them. Non-platform devices will be probed when the
closest ancestor that is a platform device is probed.

If any dependencies are still unavailable after that (most probably a
missing driver or an error in the HW description from the firmware), we
print a nice error message so that people don't have to add a zillion of
printks to find out why a device asked for its probe to be deferred.

Dependencies are discovered with the help of the code that is already
implementing the specification of the firmware bindings, via the
callbacks registered with fwnode_add_dependency_parser().

Currently the dependencies list is discarded but it could be stored for
later usage.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
tegra, kernel, usb
---

Changes in v2:
- Allocate the list of dependencies and pass it to the function that
  fills it.

 drivers/base/dd.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a638bbb..c8a1aff 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,9 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -54,6 +57,140 @@ static LIST_HEAD(deferred_probe_active_list);
 static struct workqueue_struct *deferred_wq;
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 
+static bool device_is_bound(struct device *dev)
+{
+	return klist_node_attached(&dev->p->knode_driver);
+}
+
+static int fwnode_match(struct device *dev, void *data)
+{
+	return dev->fwnode = data;
+}
+
+static bool fwnode_is_bound(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&platform_bus_type, NULL, fwnode, fwnode_match);
+
+	/* Check whether device is bound or is being probed right now */
+	return dev ? dev->driver : false;
+}
+
+static bool fwnode_is_platform(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+	const char *compatible;
+	int count;
+
+	count = fwnode_property_read_string_array(fwnode, "compatible", NULL,
+						  0);
+
+	/* The node has to have a compatible string */
+	if (!count)
+		return false;
+
+	/* But it cannot be only simple-bus */
+	if ((count = 1) &&
+	    !fwnode_property_read_string(fwnode, "compatible", &compatible) &&
+	    !strcmp(compatible, "simple-bus"))
+		return false;
+
+	parent = fwnode_get_parent(fwnode);
+
+	/* Node is immediately below root */
+	if (!fwnode_get_parent(parent))
+		return true;
+
+	/* If its parent is a simple-bus */
+	if (fwnode_is_compatible(parent, "simple-bus"))
+		return true;
+
+	return false;
+}
+
+static struct fwnode_handle *get_enclosing_platform_dev(
+						struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *iter, *node = NULL;
+
+	for (iter = fwnode;
+	     iter && fwnode_get_parent(iter);
+	     iter = fwnode_get_parent(iter)) {
+
+		/*
+		 * If we already have a platform device and an ancestor is
+		 * already bound, the first is the one we want to probe.
+		 */
+		if (node && fwnode_is_bound(iter))
+			break;
+
+		if (fwnode_is_platform(iter))
+			node = iter;
+	}
+
+	return node;
+}
+
+static bool check_dependency(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *target;
+	struct device *dev;
+
+	if (!fwnode)
+		return true;
+
+	target = get_enclosing_platform_dev(fwnode);
+	if (!target)
+		return true;
+
+	dev = bus_find_device(&platform_bus_type, NULL, target, fwnode_match);
+	if (!dev) {
+		pr_debug("Couldn't find device for %s\n",
+			 fwnode_get_name(fwnode));
+		return false;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (dev->driver)
+		return true;
+
+	bus_probe_device(dev);
+
+	/* If the dependency hasn't finished probing, we'll want a warning */
+	return device_is_bound(dev);
+}
+
+static void check_dependencies(struct device *dev)
+{
+	struct fwnode_dependency *dep, *tmp;
+	LIST_HEAD(deps);
+
+	if (dev->parent && !check_dependency(dev->parent->fwnode))
+		pr_debug("Parent '%s' of device '%s' not available\n",
+			 dev_name(dev->parent), dev_name(dev));
+
+	if (!dev->fwnode) {
+		pr_debug("Device '%s' doesn't have a fwnode\n", dev_name(dev));
+		return;
+	}
+
+	fwnode_get_dependencies(dev->fwnode, &deps);
+
+	list_for_each_entry_safe(dep, tmp, &deps, dependency) {
+		if (!check_dependency(dep->fwnode))
+			pr_debug("Dependency '%s' not available\n",
+				 fwnode_get_name(dep->fwnode));
+
+		list_del(&dep->dependency);
+		kfree(dep);
+	}
+}
+
 /*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
@@ -287,6 +424,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	dev->driver = drv;
 
+	check_dependencies(dev);
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
-- 
2.4.1

