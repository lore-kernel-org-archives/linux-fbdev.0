From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:03 +0000
Subject: [PATCH v2 08/12] USB: EHCI: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-9-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alan Stern <stern@rowland.harvard.edu>, Alexandre Courbot <gnurou@gmail.com>

So others can find out whether a firmware node depends on a phy as
specified in bindings/usb/nvidia,tegra20-ehci.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/usb/host/ehci-tegra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 4031b37..3665eaa 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -589,6 +589,18 @@ static const struct ehci_driver_overrides tegra_overrides __initconst = {
 	.reset			= tegra_ehci_reset,
 };
 
+static void tegra_ehci_get_dependencies(struct fwnode_handle *fwnode,
+					struct list_head *deps)
+{
+	struct device_node *np;
+
+	np = of_parse_phandle(to_of_node(fwnode), "nvidia,phy", 0);
+	if (!np)
+		return;
+
+	fwnode_add_dependency(&np->fwnode, deps);
+}
+
 static int __init ehci_tegra_init(void)
 {
 	if (usb_disabled())
@@ -611,6 +623,8 @@ static int __init ehci_tegra_init(void)
 	tegra_ehci_hc_driver.unmap_urb_for_dma = tegra_ehci_unmap_urb_for_dma;
 	tegra_ehci_hc_driver.hub_control = tegra_ehci_hub_control;
 
+	fwnode_add_dependency_parser(tegra_ehci_get_dependencies);
+
 	return platform_driver_register(&tegra_ehci_driver);
 }
 module_init(ehci_tegra_init);
@@ -618,6 +632,8 @@ module_init(ehci_tegra_init);
 static void __exit ehci_tegra_cleanup(void)
 {
 	platform_driver_unregister(&tegra_ehci_driver);
+
+	fwnode_remove_dependency_parser(tegra_ehci_get_dependencies);
 }
 module_exit(ehci_tegra_cleanup);
 
-- 
2.4.1

