From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:31 +0000
Subject: [RFC 5/6] video: add taal panel
Message-Id: <1355495252-26364-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/display/panel-taal.c   |  383 ++++++++++++++++++++++++++++++++++
 include/video/omap-panel-nokia-dsi.h |    4 +-
 2 files changed, 385 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/display/panel-taal.c

diff --git a/drivers/video/display/panel-taal.c b/drivers/video/display/panel-taal.c
new file mode 100644
index 0000000..f1c2196
--- /dev/null
+++ b/drivers/video/display/panel-taal.c
@@ -0,0 +1,383 @@
+/*
+ * Taal DSI command mode panel
+ *
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DEBUG
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/gpio.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/videomode.h>
+
+#include <video/omapdss.h>
+#include <video/display.h>
+#include <video/omap-panel-nokia-dsi.h>
+#include <video/mipi_display.h>
+
+/* DSI Virtual channel. Hardcoded for now. */
+#define TCH 0
+
+#define DCS_READ_NUM_ERRORS	0x05
+#define DCS_BRIGHTNESS		0x51
+#define DCS_CTRL_DISPLAY	0x53
+#define DCS_WRITE_CABC		0x55
+#define DCS_READ_CABC		0x56
+#define DCS_GET_ID1		0xda
+#define DCS_GET_ID2		0xdb
+#define DCS_GET_ID3		0xdc
+
+struct taal_data {
+	struct platform_device *pdev;
+	struct video_source *src;
+	struct display_entity entity;
+
+	struct mutex lock;
+
+	unsigned long	hw_guard_end;	/* next value of jiffies when we can
+					 * issue the next sleep in/out command
+					 */
+	unsigned long	hw_guard_wait;	/* max guard time in jiffies */
+
+	/* panel HW configuration from DT or platform data */
+	int reset_gpio;
+
+	/* runtime variables */
+	bool enabled;
+
+	bool te_enabled;
+
+	int channel;
+
+	bool cabc_broken;
+	unsigned cabc_mode;
+
+	bool intro_printed;
+};
+
+static void hw_guard_start(struct taal_data *td, int guard_msec)
+{
+	td->hw_guard_wait = msecs_to_jiffies(guard_msec);
+	td->hw_guard_end = jiffies + td->hw_guard_wait;
+}
+
+static void hw_guard_wait(struct taal_data *td)
+{
+	unsigned long wait = td->hw_guard_end - jiffies;
+
+	if ((long)wait > 0 && wait <= td->hw_guard_wait) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(wait);
+	}
+}
+
+static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
+{
+	int r;
+	u8 buf[1];
+	struct video_source *src = td->src;
+
+	r = src->ops.dsi->dcs_read(src, td->channel, dcs_cmd, buf, 1);
+	if (r < 0)
+		return r;
+
+	*data = buf[0];
+
+	return 0;
+}
+
+static int taal_dcs_write_0(struct taal_data *td, u8 dcs_cmd)
+{
+	struct video_source *src = td->src;
+
+	return src->ops.dsi->dcs_write(src, td->channel, &dcs_cmd, 1);
+}
+
+static int taal_sleep_out(struct taal_data *td)
+{
+	int r;
+
+	hw_guard_wait(td);
+
+	r = taal_dcs_write_0(td, MIPI_DCS_EXIT_SLEEP_MODE);
+	if (r)
+		return r;
+
+	hw_guard_start(td, 120);
+
+	msleep(5);
+
+	return 0;
+}
+
+static int taal_get_id(struct taal_data *td, u8 *id1, u8 *id2, u8 *id3)
+{
+	int r;
+
+	r = taal_dcs_read_1(td, DCS_GET_ID1, id1);
+	if (r)
+		return r;
+	r = taal_dcs_read_1(td, DCS_GET_ID2, id2);
+	if (r)
+		return r;
+	r = taal_dcs_read_1(td, DCS_GET_ID3, id3);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static void taal_hw_reset(struct taal_data *td)
+{
+	if (!gpio_is_valid(td->reset_gpio))
+		return;
+
+	gpio_set_value(td->reset_gpio, 1);
+	udelay(10);
+	/* reset the panel */
+	gpio_set_value(td->reset_gpio, 0);
+	/* assert reset */
+	udelay(10);
+	gpio_set_value(td->reset_gpio, 1);
+	/* wait after releasing reset */
+	msleep(5);
+}
+
+#define to_panel(p) container_of(p, struct taal_data, entity)
+
+static int taal_set_state(struct display_entity *entity,
+			       enum display_entity_state state)
+{
+	struct taal_data *td = to_panel(entity);
+	struct video_source *src = td->src;
+	int r;
+
+	switch (state) {
+	case DISPLAY_ENTITY_STATE_OFF:
+	case DISPLAY_ENTITY_STATE_STANDBY:
+		r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_OFF);
+		if (r)
+			printk("display off failed\n");
+
+		src->ops.dsi->disable(src);
+
+		break;
+
+	case DISPLAY_ENTITY_STATE_ON:
+		r = src->ops.dsi->enable(src);
+		if (r)
+			printk("failed to enable bus\n");
+
+		taal_hw_reset(td);
+
+		r = taal_sleep_out(td);
+		if (r)
+			printk("sleep out failed\n");
+
+		src->ops.dsi->enable_hs(src, true);
+
+
+		r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_ON);
+		if (r)
+			printk("display on failed\n");
+		break;
+	}
+
+	return 0;
+}
+
+static const struct videomode taal_mode = {
+	.hactive = 864,
+	.vactive = 480,
+};
+
+static int taal_get_modes(struct display_entity *entity,
+			       const struct videomode **modes)
+{
+	//struct panel_data *data = to_panel(entity);
+
+	*modes = &taal_mode;
+	return 1;
+}
+
+static int taal_get_size(struct display_entity *entity,
+			      unsigned int *width, unsigned int *height)
+{
+	//struct panel_data *data = to_panel(entity);
+
+	*width = 10;
+	*height = 10;
+	return 0;
+}
+
+static int taal_update(struct display_entity *entity,
+		void (*callback)(int, void *), void *data)
+{
+	struct taal_data *td = to_panel(entity);
+	struct video_source *src = td->src;
+
+	return src->ops.dsi->update(src, td->channel, callback, data);
+}
+
+static const struct display_entity_control_ops taal_control_ops = {
+	.set_state = taal_set_state,
+	.get_modes = taal_get_modes,
+	.get_size = taal_get_size,
+	.update = taal_update,
+};
+
+static void panel_taal_release(struct display_entity *entity)
+{
+	printk("panel taal release\n");
+}
+
+static int taal_probe(struct platform_device *pdev)
+{
+	const struct nokia_dsi_panel_data *pdata = pdev->dev.platform_data;
+	struct taal_data *td;
+	int r;
+	u8 id1, id2, id3;
+	struct video_source *src;
+
+	dev_dbg(&pdev->dev, "probe\n");
+
+	td = devm_kzalloc(&pdev->dev, sizeof(*td), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	td->pdev = pdev;
+
+
+	td->reset_gpio = pdata->reset_gpio;
+
+	platform_set_drvdata(pdev, td);
+
+	mutex_init(&td->lock);
+
+	if (gpio_is_valid(td->reset_gpio)) {
+		r = devm_gpio_request_one(&pdev->dev, td->reset_gpio,
+				GPIOF_OUT_INIT_LOW, "taal rst");
+		if (r) {
+			dev_err(&pdev->dev, "failed to request reset gpio\n");
+			return r;
+		}
+	}
+
+
+	/* setup input */
+	src = video_source_find(pdata->video_source);
+	if (src = NULL) {
+		printk("failed to get video source\n");
+		return -EINVAL;
+	}
+
+	td->src = src;
+
+	r = src->ops.dsi->configure_pins(src, &pdata->pin_config);
+	if (r)
+		dev_err(&pdev->dev, "failed to configure DSI pins\n");
+
+	r = src->ops.dsi->set_clocks(src, 216000000, 10000000);
+	if (r)
+		dev_err(&pdev->dev, "failed to set HS and LP clocks\n");
+
+	src->ops.dsi->set_size(src, 864, 480);
+	src->ops.dsi->set_pixel_format(src, OMAP_DSS_DSI_FMT_RGB888);
+	src->ops.dsi->set_operation_mode(src, OMAP_DSS_DSI_CMD_MODE);
+
+	/* setup panel entity */
+
+	td->entity.dev = &pdev->dev;
+	td->entity.release = panel_taal_release;
+	td->entity.ops = &taal_control_ops;
+
+	r = display_entity_register(&td->entity);
+	if (r < 0) {
+		printk("failed to register display entity\n");
+		return r;
+	}
+
+	/* show version */
+
+	r = src->ops.dsi->enable(src);
+	if (r)
+		dev_err(&pdev->dev, "failed to enable bus\n");
+
+	taal_hw_reset(td);
+
+	r = taal_get_id(td, &id1, &id2, &id3);
+	if (r)
+		return r;
+
+	dev_info(&pdev->dev, "panel revision %02x.%02x.%02x\n", id1, id2, id3);
+
+	src->ops.dsi->disable(src);
+
+
+	return 0;
+#if 0
+	r = omap_dsi_request_vc(dssdev, &td->channel);
+	if (r) {
+		dev_err(&pdev->dev, "failed to get virtual channel\n");
+		goto err_req_vc;
+	}
+
+	r = omap_dsi_set_vc_id(dssdev, td->channel, TCH);
+	if (r) {
+		dev_err(&pdev->dev, "failed to set VC_ID\n");
+		goto err_vc_id;
+	}
+#endif
+}
+
+static int taal_remove(struct platform_device *pdev)
+{
+	struct taal_data *td = platform_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "remove\n");
+
+	display_entity_unregister(&td->entity);
+
+	video_source_put(td->src);
+
+	/* reset, to be sure that the panel is in a valid state */
+	taal_hw_reset(td);
+
+#if 0
+	omap_dsi_release_vc(dssdev, td->channel);
+#endif
+	return 0;
+}
+
+static struct platform_driver taal_driver = {
+	.probe	= taal_probe,
+	.remove	= taal_remove,
+	.driver	= {
+		.name	= "taal",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(taal_driver);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
+MODULE_DESCRIPTION("Taal Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
index 225a841..fe274a5 100644
--- a/include/video/omap-panel-nokia-dsi.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -14,6 +14,8 @@ struct omap_dss_device;
  * @pin_config: DSI pin configuration
  */
 struct nokia_dsi_panel_data {
+	const char *video_source;
+
 	const char *name;
 
 	int reset_gpio;
@@ -27,8 +29,6 @@ struct nokia_dsi_panel_data {
 	bool use_dsi_backlight;
 
 	struct omap_dsi_pin_config pin_config;
-
-	void *video_source;
 };
 
 #endif /* __OMAP_NOKIA_DSI_PANEL_H */
-- 
1.7.10.4

