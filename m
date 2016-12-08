From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 08 Dec 2016 00:57:52 +0000
Subject: [PATCH 11/12] gpu: ipu-v3: lookup ipu client nodes by name
Message-Id: <1481158673-15937-12-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1481158673-15937-1-git-send-email-steve_longerbeam-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Steve Longerbeam <steve_longerbeam-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

To allow for IPU clients containing multiple ports, they are no longer
a single port node name, but have a name of the format
"ipu<id>_<unit>". So we can no longer use of_graph_get_port_by_id()
to lookup the client node.

Create the function of_get_ipu_client_node() that looks up the client
node by node name and unit id. The ipu_unit_type enumeration is added
to the client_reg[] entries to compose the node names.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 55 +++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 97218af..b6ca36b 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1159,6 +1159,7 @@ struct ipu_platform_reg {
 static struct ipu_platform_reg client_reg[] = {
 	{
 		.pdata = {
+			.type = IPU_CSI,
 			.csi = 0,
 			.dma[0] = IPUV3_CHANNEL_CSI0,
 			.dma[1] = -EINVAL,
@@ -1166,6 +1167,7 @@ static struct ipu_platform_reg client_reg[] = {
 		.name = "imx-ipuv3-csi",
 	}, {
 		.pdata = {
+			.type = IPU_CSI,
 			.csi = 1,
 			.dma[0] = IPUV3_CHANNEL_CSI1,
 			.dma[1] = -EINVAL,
@@ -1173,6 +1175,7 @@ static struct ipu_platform_reg client_reg[] = {
 		.name = "imx-ipuv3-csi",
 	}, {
 		.pdata = {
+			.type = IPU_DI,
 			.di = 0,
 			.dc = 5,
 			.dp = IPU_DP_FLOW_SYNC_BG,
@@ -1182,6 +1185,7 @@ static struct ipu_platform_reg client_reg[] = {
 		.name = "imx-ipuv3-crtc",
 	}, {
 		.pdata = {
+			.type = IPU_DI,
 			.di = 1,
 			.dc = 1,
 			.dp = -EINVAL,
@@ -1195,6 +1199,46 @@ static struct ipu_platform_reg client_reg[] = {
 static DEFINE_MUTEX(ipu_client_id_mutex);
 static int ipu_client_id;
 
+static struct device_node *
+of_get_ipu_client_node(struct ipu_soc *ipu, struct ipu_platform_reg *reg)
+{
+	struct device *dev = ipu->dev;
+	struct device_node *client;
+	char node_name[32];
+	u32 id, client_id = 0;
+
+	switch (reg->pdata.type) {
+	case IPU_CSI:
+		snprintf(node_name, sizeof(node_name),
+			 "ipu%d_csi", ipu->id + 1);
+		client_id = reg->pdata.csi;
+		break;
+	case IPU_DI:
+		snprintf(node_name, sizeof(node_name),
+			 "ipu%d_di", ipu->id + 1);
+		client_id = reg->pdata.di;
+		break;
+	default:
+		client = NULL;
+		goto out;
+	}
+
+	for_each_child_of_node(dev->of_node, client) {
+		if (client->name &&
+		    (of_node_cmp(client->name, node_name) = 0)) {
+			of_property_read_u32(client, "reg", &id);
+			if (id = client_id)
+				break;
+		}
+	}
+out:
+	if (!client)
+		dev_info(dev, "no %s%d node in %s, not using %s%d\n",
+			 node_name, client_id, dev->of_node->full_name,
+			 node_name, client_id);
+	return client;
+}
+
 static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 {
 	struct device *dev = ipu->dev;
@@ -1211,15 +1255,10 @@ static int ipu_add_client_devices(struct ipu_soc *ipu, unsigned long ipu_base)
 		struct platform_device *pdev;
 		struct device_node *of_node;
 
-		/* Associate subdevice with the corresponding port node */
-		of_node = of_graph_get_port_by_id(dev->of_node, i);
-		if (!of_node) {
-			dev_info(dev,
-				 "no port@%d node in %s, not using %s%d\n",
-				 i, dev->of_node->full_name,
-				 (i / 2) ? "DI" : "CSI", i % 2);
+		/* Associate subdevice with the corresponding client node */
+		of_node = of_get_ipu_client_node(ipu, reg);
+		if (!of_node)
 			continue;
-		}
 
 		pdev = platform_device_alloc(reg->name, id++);
 		if (!pdev) {
-- 
2.7.4

