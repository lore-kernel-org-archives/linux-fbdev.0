From: cailiwei <cailiwei@hisilicon.com>
Date: Tue, 07 Feb 2017 02:35:56 +0000
Subject: [PATCH 5/8] fb: hisilicon: Add framebuffer driver for hi3660 SoC
Message-Id: <20170207023559.79455-5-cailiwei@hisilicon.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170207023559.79455-1-cailiwei@hisilicon.com>
In-Reply-To: <20170207023559.79455-1-cailiwei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, guodong.xu@linaro.org
Cc: suzhuangluan@hisilicon.com, dengqingshan@hisilicon.com, xuhongtao8@hisilicon.com, zhengwanchun@hisilicon.com, shizongxuan@huawei.com, cailiwei@hisilicon.com

From: Levy-Cai <cailiwei@hisilicon.com>

Add framebuffer driver for hi3660 SoC, this driver include lcd
driver & Hdmi adv7533/adv7535 driver, support lcd display at
1080p@60 and hdmi display at 1080p@60.

Signed-off-by: cailiwei <cailiwei@hisilicon.com>
---
 drivers/video/fbdev/hisi/dss/hisi_fb_bl.c       | 323 +++++++++
 drivers/video/fbdev/hisi/dss/hisi_fb_buf_sync.c | 507 ++++++++++++++
 drivers/video/fbdev/hisi/dss/hisi_fb_def.h      | 125 ++++
 drivers/video/fbdev/hisi/dss/hisi_fb_isr.c      | 327 +++++++++
 drivers/video/fbdev/hisi/dss/hisi_fb_panel.c    | 835 +++++++++++++++++++++++
 drivers/video/fbdev/hisi/dss/hisi_fb_panel.h    | 839 ++++++++++++++++++++++++
 6 files changed, 2956 insertions(+)
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_bl.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_buf_sync.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_def.h
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_isr.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_panel.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_panel.h

diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_bl.c b/drivers/video/fbdev/hisi/dss/hisi_fb_bl.c
new file mode 100755
index 000000000000..ee4b8c7f4abb
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_bl.c
@@ -0,0 +1,323 @@
+/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "hisi_fb.h"
+#include <linux/leds.h>
+#define K3_DSS_SBL_WORKQUEUE	"k3_dss_sbl_workqueue"
+
+static int lcd_backlight_registered;
+static unsigned int is_recovery_mode;
+static int is_no_fastboot_bl_enable;
+
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+unsigned long backlight_duration = (3 * HZ / 60);
+#endif
+
+void hisifb_set_backlight(struct hisi_fb_data_type *hisifd, uint32_t bkl_lvl)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+	uint32_t temp = bkl_lvl;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	if (!hisifd->panel_power_on || !hisifd->backlight.bl_updated) {
+		hisifd->bl_level = bkl_lvl;
+		return;
+	}
+
+	if (pdata->set_backlight) {
+		if (hisifd->backlight.bl_level_old = temp) {
+			hisifd->bl_level = bkl_lvl;
+			return;
+		}
+		if (hisifd->backlight.bl_level_old = 0) {
+			HISI_FB_INFO("backlight level = %d", bkl_lvl);
+		}
+		hisifd->bl_level = bkl_lvl;
+		if (hisifd->panel_info.bl_set_type & BL_SET_BY_MIPI) {
+			hisifb_set_vsync_activate_state(hisifd, true);
+			hisifb_activate_vsync(hisifd);
+		}
+		pdata->set_backlight(hisifd->pdev, bkl_lvl);
+		if (hisifd->panel_info.bl_set_type & BL_SET_BY_MIPI) {
+			hisifb_set_vsync_activate_state(hisifd, false);
+			hisifb_deactivate_vsync(hisifd);
+		}
+		hisifd->backlight.bl_level_old = temp;
+	}
+}
+
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+static void hisifb_bl_workqueue_handler(struct work_struct *work)
+#else
+static void hisifb_bl_workqueue_handler(struct hisi_fb_data_type *hisifd)
+#endif
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+	struct hisifb_backlight *pbacklight = NULL;
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	pbacklight +	    container_of(to_delayed_work(work), struct hisifb_backlight,
+			 bl_worker);
+	BUG_ON(pbacklight = NULL);
+
+	hisifd = container_of(pbacklight, struct hisi_fb_data_type, backlight);
+#endif
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	if (!hisifd->backlight.bl_updated) {
+		down(&hisifd->blank_sem);
+
+		if (hisifd->backlight.frame_updated = 0) {
+			up(&hisifd->blank_sem);
+			return;
+		}
+
+		hisifd->backlight.frame_updated = 0;
+		hisifd->backlight.bl_updated = 1;
+		if (is_recovery_mode) {
+			hisifd->bl_level = hisifd->panel_info.bl_default;
+		} else {
+			if (!is_no_fastboot_bl_enable) {
+				is_no_fastboot_bl_enable = 1;
+				hisifd->bl_level +				    hisifd->panel_info.bl_default;
+			}
+		}
+
+		hisifb_set_backlight(hisifd, hisifd->bl_level);
+		up(&hisifd->blank_sem);
+	}
+}
+
+void hisifb_backlight_update(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	if (!hisifd->backlight.bl_updated) {
+		hisifd->backlight.frame_updated = 1;
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+		schedule_delayed_work(&hisifd->backlight.bl_worker,
+				      backlight_duration);
+#else
+		hisifb_bl_workqueue_handler(hisifd);
+#endif
+	}
+}
+
+void hisifb_backlight_cancel(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+	cancel_delayed_work(&hisifd->backlight.bl_worker);
+#endif
+	hisifd->backlight.bl_updated = 0;
+	hisifd->backlight.bl_level_old = 0;
+	hisifd->backlight.frame_updated = 0;
+
+	if (pdata->set_backlight) {
+		hisifd->bl_level = 0;
+		if (hisifd->panel_info.bl_set_type & BL_SET_BY_MIPI)
+			hisifb_activate_vsync(hisifd);
+		pdata->set_backlight(hisifd->pdev, hisifd->bl_level);
+		if (hisifd->panel_info.bl_set_type & BL_SET_BY_MIPI)
+			hisifb_deactivate_vsync(hisifd);
+	}
+}
+
+#ifdef CONFIG_FB_BACKLIGHT
+static int hisi_fb_bl_get_brightness(struct backlight_device *pbd)
+{
+	if (NULL = pbd) {
+		HISI_FB_ERR("NULL pointer!\n");
+		return 0;
+	}
+	return pbd->props.brightness;
+}
+
+static int hisi_fb_bl_update_status(struct backlight_device *pbd)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	uint32_t bl_lvl = 0;
+
+	if (NULL = pbd) {
+		HISI_FB_ERR("NULL pointer!\n");
+		return 0;
+	}
+
+	hisifd = bl_get_data(pbd);
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL pointer!\n");
+		return 0;
+	}
+
+	bl_lvl = pbd->props.brightness;
+	bl_lvl = hisifd->fbi->bl_curve[bl_lvl];
+
+	down(&hisifd->blank_sem);
+	hisifb_set_backlight(hisifd, bl_lvl);
+	up(&hisifd->blank_sem);
+
+	return 0;
+}
+
+static struct backlight_ops hisi_fb_bl_ops = {
+	.get_brightness = hisi_fb_bl_get_brightness,
+	.update_status = hisi_fb_bl_update_status,
+};
+#else
+static void hisi_fb_set_bl_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness value)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	int bl_lvl = 0;
+
+	if (NULL = led_cdev) {
+		HISI_FB_ERR("NULL pointer!\n");
+		return;
+	}
+
+	hisifd = dev_get_drvdata(led_cdev->dev->parent);
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL pointer!\n");
+		return;
+	}
+
+	if (value < 0)
+		value = 0;
+
+	if (value > hisifd->panel_info.bl_max)
+		value = hisifd->panel_info.bl_max;
+
+	/* This maps android backlight level 0 to 255 into
+	   driver backlight level 0 to bl_max with rounding */
+	bl_lvl +	    (2 * value * hisifd->panel_info.bl_max + hisifd->panel_info.bl_max)
+	    / (2 * hisifd->panel_info.bl_max);
+	if (!bl_lvl && value)
+		bl_lvl = 1;
+	hisifb_set_backlight(hisifd, bl_lvl);
+}
+
+static struct led_classdev backlight_led = {
+	.name = DEV_NAME_LCD_BKL,
+	.brightness_set = hisi_fb_set_bl_brightness,
+};
+#endif
+
+void hisifb_backlight_register(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+#ifdef CONFIG_FB_BACKLIGHT
+	struct backlight_device *pbd = NULL;
+	struct fb_info *fbi = NULL;
+	char name[16] = { 0 };
+	struct backlight_properties props;
+#endif
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	hisifd->backlight.bl_updated = 0;
+	hisifd->backlight.frame_updated = 0;
+	hisifd->backlight.bl_level_old = 0;
+	sema_init(&hisifd->backlight.bl_sem, 1);
+#ifdef CONFIG_HISI_FB_BACKLIGHT_DELAY
+	INIT_DELAYED_WORK(&hisifd->backlight.bl_worker,
+			  hisifb_bl_workqueue_handler);
+#endif
+
+	if (lcd_backlight_registered) return;
+
+#ifdef CONFIG_FB_BACKLIGHT
+	fbi = hisifd->fbi;
+
+	snprintf(name, sizeof(name), "hisifb%d_bl", hisifd->index);
+	props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
+	props.brightness = FB_BACKLIGHT_LEVELS - 1;
+	pbd = backlight_device_register(name, fbi->dev, hisifd,
+					&hisi_fb_bl_ops, &props);
+	if (IS_ERR(pbd)) {
+		fbi->bl_dev = NULL;
+		HISI_FB_ERR("backlight_device_register failed!\n");
+	}
+
+	fbi->bl_dev = pbd;
+	fb_bl_default_curve(fbi, 0,
+			    hisifd->panel_info.bl_min,
+			    hisifd->panel_info.bl_max);
+#else
+	backlight_led.brightness = hisifd->panel_info.bl_default;
+	backlight_led.max_brightness = hisifd->panel_info.bl_max;
+	/* android supports only one lcd-backlight/lcd for now */
+#ifdef CONFIG_LEDS_CLASS
+	if (led_classdev_register(&pdev->dev, &backlight_led)) {
+		HISI_FB_ERR("led_classdev_register failed!\n");
+		return;
+	}
+#endif
+#endif
+
+	if (HISI_DSS_SUPPORT_DPP_MODULE_BIT(DPP_MODULE_SBL)) {
+		hisifd->backlight.sbl_queue +		    create_singlethread_workqueue(K3_DSS_SBL_WORKQUEUE);
+		if (!hisifd->backlight.sbl_queue) {
+			HISI_FB_ERR("failed to create sbl_queue!\n");
+			return;
+		}
+	}
+
+	lcd_backlight_registered = 1;
+}
+
+void hisifb_backlight_unregister(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	if (lcd_backlight_registered) {
+		lcd_backlight_registered = 0;
+#ifdef CONFIG_FB_BACKLIGHT
+		/* remove /sys/class/backlight */
+		backlight_device_unregister(hisifd->fbi->bl_dev);
+#else
+#ifdef CONFIG_LEDS_CLASS
+		led_classdev_unregister(&backlight_led);
+#endif
+#endif
+		if (hisifd->backlight.sbl_queue) {
+			destroy_workqueue(hisifd->backlight.sbl_queue);
+			hisifd->backlight.sbl_queue = NULL;
+		}
+	}
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_buf_sync.c b/drivers/video/fbdev/hisi/dss/hisi_fb_buf_sync.c
new file mode 100755
index 000000000000..e36a39ad4d31
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_buf_sync.c
@@ -0,0 +1,507 @@
+/* Copyright (c) 2008-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "hisi_fb.h"
+
+#define HISI_DSS_LAYERBUF_FREE	"hisi-dss-layerbuf-free"
+
+int hisifb_layerbuf_lock(struct hisi_fb_data_type *hisifd,
+			 dss_overlay_t *pov_req, struct list_head *plock_list)
+{
+	dss_overlay_block_t *pov_h_block_infos = NULL;
+	dss_overlay_block_t *pov_h_block = NULL;
+	dss_layer_t *layer = NULL;
+	int i = 0;
+	int m = 0;
+	struct hisifb_layerbuf *node = NULL;
+	struct ion_handle *ionhnd = NULL;
+	struct iommu_map_format iommu_format;
+	bool add_tail = false;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(pov_req = NULL);
+	BUG_ON(plock_list = NULL);
+
+	pov_h_block_infos +	    (dss_overlay_block_t *) (pov_req->ov_block_infos_ptr);
+	for (m = 0; m < pov_req->ov_block_nums; m++) {
+		pov_h_block = &(pov_h_block_infos[m]);
+
+		for (i = 0; i < pov_h_block->layer_nums; i++) {
+			layer = &(pov_h_block->layer_infos[i]);
+			add_tail = false;
+			ionhnd = NULL;
+
+			if (layer->dst_rect.y < pov_h_block->ov_block_rect.y)
+				continue;
+
+			if (layer->img.shared_fd < 0)
+				continue;
+
+			if ((layer->img.phy_addr = 0) &&
+			    (layer->img.vir_addr = 0) &&
+			    (layer->img.afbc_payload_addr = 0)) {
+				HISI_FB_ERR
+				    ("fb%d, layer_idx%d, chn_idx%d, no buffer!\n",
+				     hisifd->index, layer->layer_idx,
+				     layer->chn_idx);
+				continue;
+			}
+
+			if (layer->img.shared_fd >= 0) {
+				ionhnd +				    ion_import_dma_buf(hisifd->ion_client,
+						       layer->img.shared_fd);
+				if (IS_ERR(ionhnd)) {
+					ionhnd = NULL;
+					HISI_FB_ERR
+					    ("fb%d, layer_idx%d, failed to ion_import_dma_buf, "
+					     "ionclient %p, share_fd %d!\n",
+					     hisifd->index, i,
+					     hisifd->ion_client,
+					     layer->img.shared_fd);
+				} else {
+					if (layer->img.mmu_enable = 1) {
+						memset(&iommu_format, 0,
+						       sizeof(struct iommu_map_format));
+								ion_map_iommu(hisifd->ion_client,ionhnd,
+							      &iommu_format);
+					}
+					add_tail = true;
+				}
+			}
+
+			if (add_tail) {
+				node +				    kzalloc(sizeof(struct hisifb_layerbuf),
+					    GFP_KERNEL);
+				if (node = NULL) {
+					HISI_FB_ERR
+					    ("fb%d, layer_idx%d, failed to kzalloc!\n",
+					     hisifd->index, layer->layer_idx);
+
+					if (ionhnd) {
+						ion_free(hisifd->ion_client,
+							 ionhnd);
+						ionhnd = NULL;
+					}
+					continue;
+				}
+
+				node->shared_fd = layer->img.shared_fd;
+				node->frame_no = pov_req->frame_no;
+				node->ion_handle = ionhnd;
+				node->has_map_iommu = (ionhnd
+							&& (layer->img.mmu_enable = 1)) ? true : false;
+				node->timeline = 0;
+
+				node->mmbuf.addr = layer->img.mmbuf_base;
+				node->mmbuf.size = layer->img.mmbuf_size;
+
+				node->vir_addr = layer->img.vir_addr;
+				node->chn_idx = layer->chn_idx;
+
+				list_add_tail(&node->list_node, plock_list);
+				if (g_debug_layerbuf_sync) {
+					HISI_FB_INFO
+					    ("fb%d, frame_no=%d, layer_idx(%d), "
+					     "shared_fd=%d, ion_handle=%p, "
+					     "has_map_iommu=%d, timeline=%d, mmbuf(0x%x, %d).\n",
+					     hisifd->index, node->frame_no, i,
+					     node->shared_fd, node->ion_handle,
+					     node->has_map_iommu,
+					     node->timeline, node->mmbuf.addr,
+					     node->mmbuf.size);
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+void hisifb_layerbuf_flush(struct hisi_fb_data_type *hisifd,
+			   struct list_head *plock_list)
+{
+	struct hisifb_layerbuf *node, *_node_;
+	unsigned long flags = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(hisifd->ion_client = NULL);
+	BUG_ON(plock_list = NULL);
+
+	spin_lock_irqsave(&(hisifd->buf_sync_ctrl.layerbuf_spinlock), flags);
+	hisifd->buf_sync_ctrl.layerbuf_flushed = true;
+	list_for_each_entry_safe(node, _node_, plock_list, list_node) {
+		list_del(&node->list_node);
+		list_add_tail(&node->list_node,
+			      &(hisifd->buf_sync_ctrl.layerbuf_list));
+	}
+	spin_unlock_irqrestore(&(hisifd->buf_sync_ctrl.layerbuf_spinlock),
+			       flags);
+}
+
+void hisifb_layerbuf_unlock(struct hisi_fb_data_type *hisifd,
+			    struct list_head *pfree_list)
+{
+	struct hisifb_layerbuf *node, *_node_;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(hisifd->ion_client = NULL);
+	BUG_ON(hisifd->mmbuf_gen_pool = NULL);
+	BUG_ON(pfree_list = NULL);
+
+	list_for_each_entry_safe(node, _node_, pfree_list, list_node) {
+		list_del(&node->list_node);
+
+		if (g_debug_layerbuf_sync) {
+			HISI_FB_INFO
+			    ("fb%d, frame_no=%d, share_fd=%d, "
+			     "ion_handle=%p, has_map_iommu=%d, "
+			     "timeline=%d, mmbuf(0x%x, %d). "
+			     "vir_addr = 0x%llx, chn_idx = %d\n",
+			     hisifd->index, node->frame_no, node->shared_fd,
+			     node->ion_handle, node->has_map_iommu,
+			     node->timeline, node->mmbuf.addr, node->mmbuf.size,
+			     node->vir_addr, node->chn_idx);
+		}
+
+		node->timeline = 0;
+		if (node->ion_handle) {
+			if (node->has_map_iommu) {
+				ion_unmap_iommu(hisifd->ion_client,
+						node->ion_handle);
+			}
+			ion_free(hisifd->ion_client, node->ion_handle);
+		}
+		kfree(node);
+	}
+}
+
+void hisifb_layerbuf_lock_exception(struct hisi_fb_data_type *hisifd,
+				    struct list_head *plock_list)
+{
+	unsigned long flags = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(plock_list = NULL);
+
+	spin_lock_irqsave(&(hisifd->buf_sync_ctrl.layerbuf_spinlock), flags);
+	hisifd->buf_sync_ctrl.layerbuf_flushed = false;
+	spin_unlock_irqrestore(&(hisifd->buf_sync_ctrl.layerbuf_spinlock), flags);
+
+	hisifb_layerbuf_unlock(hisifd, plock_list);
+}
+
+static void hisifb_layerbuf_unlock_work(struct work_struct *work)
+{
+	struct hisifb_buf_sync *pbuf_sync = NULL;
+	struct hisi_fb_data_type *hisifd = NULL;
+	unsigned long flags;
+	struct hisifb_layerbuf *node, *_node_;
+	struct list_head free_list;
+
+	pbuf_sync +	    container_of(work, struct hisifb_buf_sync, free_layerbuf_work);
+	BUG_ON(pbuf_sync = NULL);
+	hisifd +	    container_of(pbuf_sync, struct hisi_fb_data_type, buf_sync_ctrl);
+	BUG_ON(hisifd = NULL);
+	BUG_ON(hisifd->ion_client = NULL);
+
+	INIT_LIST_HEAD(&free_list);
+	spin_lock_irqsave(&pbuf_sync->layerbuf_spinlock, flags);
+	list_for_each_entry_safe(node, _node_, &pbuf_sync->layerbuf_list,
+				 list_node) {
+		if (node->timeline >= 2) {
+			list_del(&node->list_node);
+			list_add_tail(&node->list_node, &free_list);
+		}
+	}
+	spin_unlock_irqrestore(&pbuf_sync->layerbuf_spinlock, flags);
+
+	hisifb_layerbuf_unlock(hisifd, &free_list);
+}
+
+#ifdef CONFIG_BUF_SYNC_USED
+#define BUF_SYNC_TIMEOUT_MSEC	(10 * MSEC_PER_SEC)
+#define BUF_SYNC_FENCE_NAME	"hisi-dss-fence"
+#define BUF_SYNC_TIMELINE_NAME	"hisi-dss-timeline"
+int hisifb_buf_sync_create_fence(struct hisi_fb_data_type *hisifd,
+				 unsigned value)
+{
+	int fd = -1;
+	struct sync_fence *fence = NULL;
+	struct sync_pt *pt = NULL;
+
+	BUG_ON(hisifd = NULL);
+	fd = get_unused_fd_flags(0);
+	if (fd < 0) {
+		HISI_FB_ERR("get_unused_fd failed!\n");
+		return fd;
+	}
+
+	pt = sw_sync_pt_create(hisifd->buf_sync_ctrl.timeline, value);
+	if (pt = NULL) {
+		return -ENOMEM;
+	}
+
+	fence = sync_fence_create(BUF_SYNC_FENCE_NAME, pt);
+	if (fence = NULL) {
+		sync_pt_free(pt);
+		return -ENOMEM;
+	}
+
+	sync_fence_install(fence, fd);
+
+	return fd;
+}
+
+int hisifb_buf_sync_wait(int fence_fd)
+{
+	int ret = 0;
+	struct sync_fence *fence = NULL;
+
+	fence = sync_fence_fdget(fence_fd);
+	if (fence = NULL) {
+		HISI_FB_ERR("fence_fd=%d, sync_fence_fdget failed!\n",
+			    fence_fd);
+		return -EINVAL;
+	}
+
+	ret = sync_fence_wait(fence, BUF_SYNC_TIMEOUT_MSEC);
+	if (ret < 0) {
+		HISI_FB_ERR("Waiting on fence failed, fence_fd: %d, ret: %d.\n",
+			    fence_fd, ret);
+	}
+	sync_fence_put(fence);
+
+	return ret;
+}
+
+int hisifb_buf_sync_handle(struct hisi_fb_data_type *hisifd,
+			   dss_overlay_t *pov_req)
+{
+	dss_overlay_block_t *pov_h_block_infos = NULL;
+	dss_overlay_block_t *pov_h_block = NULL;
+	dss_layer_t *layer = NULL;
+	int i = 0;
+	int m = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(pov_req = NULL);
+
+	pov_h_block_infos +	    (dss_overlay_block_t *) (pov_req->ov_block_infos_ptr);
+	for (m = 0; m < pov_req->ov_block_nums; m++) {
+		pov_h_block = &(pov_h_block_infos[m]);
+
+		for (i = 0; i < pov_h_block->layer_nums; i++) {
+			layer = &(pov_h_block->layer_infos[i]);
+
+			if (layer->dst_rect.y < pov_h_block->ov_block_rect.y)
+				continue;
+
+			if (layer->acquire_fence >= 0) {
+				hisifb_buf_sync_wait(layer->acquire_fence);
+			}
+		}
+	}
+
+	return 0;
+}
+
+void hisifb_buf_sync_signal(struct hisi_fb_data_type *hisifd)
+{
+	struct hisifb_layerbuf *node = NULL;
+	struct hisifb_layerbuf *_node_ = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	spin_lock(&hisifd->buf_sync_ctrl.refresh_lock);
+	if (hisifd->buf_sync_ctrl.refresh) {
+		sw_sync_timeline_inc(hisifd->buf_sync_ctrl.timeline,
+				     hisifd->buf_sync_ctrl.refresh);
+		hisifd->buf_sync_ctrl.refresh = 0;
+	}
+	spin_unlock(&hisifd->buf_sync_ctrl.refresh_lock);
+
+	spin_lock(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+	list_for_each_entry_safe(node, _node_,
+				 &(hisifd->buf_sync_ctrl.layerbuf_list),
+				 list_node) {
+		if (hisifd->buf_sync_ctrl.layerbuf_flushed) {
+			node->timeline++;
+		}
+	}
+	hisifd->buf_sync_ctrl.layerbuf_flushed = false;
+	spin_unlock(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+
+	queue_work(hisifd->buf_sync_ctrl.free_layerbuf_queue,
+		   &(hisifd->buf_sync_ctrl.free_layerbuf_work));
+}
+
+void hisifb_buf_sync_suspend(struct hisi_fb_data_type *hisifd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hisifd->buf_sync_ctrl.refresh_lock, flags);
+	sw_sync_timeline_inc(hisifd->buf_sync_ctrl.timeline,
+			     hisifd->buf_sync_ctrl.refresh + 1);
+	hisifd->buf_sync_ctrl.refresh = 0;
+	hisifd->buf_sync_ctrl.timeline_max++;
+	spin_unlock_irqrestore(&hisifd->buf_sync_ctrl.refresh_lock, flags);
+}
+
+void hisifb_buf_sync_register(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	spin_lock_init(&hisifd->buf_sync_ctrl.refresh_lock);
+	hisifd->buf_sync_ctrl.refresh = 0;
+	hisifd->buf_sync_ctrl.timeline_max = 1;
+	hisifd->buf_sync_ctrl.timeline +	    sw_sync_timeline_create(BUF_SYNC_TIMELINE_NAME);
+	if (hisifd->buf_sync_ctrl.timeline = NULL) {
+		HISI_FB_ERR("cannot create time line!");
+		return;		/* -ENOMEM */
+	}
+
+	spin_lock_init(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+	INIT_LIST_HEAD(&(hisifd->buf_sync_ctrl.layerbuf_list));
+	hisifd->buf_sync_ctrl.layerbuf_flushed = false;
+
+	INIT_WORK(&(hisifd->buf_sync_ctrl.free_layerbuf_work),
+		  hisifb_layerbuf_unlock_work);
+	hisifd->buf_sync_ctrl.free_layerbuf_queue +	    create_singlethread_workqueue(HISI_DSS_LAYERBUF_FREE);
+	if (!hisifd->buf_sync_ctrl.free_layerbuf_queue) {
+		HISI_FB_ERR("failed to create free_layerbuf_queue!\n");
+		return;
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+}
+
+void hisifb_buf_sync_unregister(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	if (hisifd->buf_sync_ctrl.timeline) {
+		sync_timeline_destroy((struct sync_timeline *)
+					hisifd->buf_sync_ctrl.timeline);
+		hisifd->buf_sync_ctrl.timeline = NULL;
+	}
+
+	if (hisifd->buf_sync_ctrl.free_layerbuf_queue) {
+		destroy_workqueue(hisifd->buf_sync_ctrl.free_layerbuf_queue);
+		hisifd->buf_sync_ctrl.free_layerbuf_queue = NULL;
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+}
+#else
+int hisifb_buf_sync_wait(int fence_fd)
+{
+	return 0;
+}
+
+int hisifb_buf_sync_handle(struct hisi_fb_data_type *hisifd,
+			   dss_overlay_t *pov_req)
+{
+	return 0;
+}
+
+void hisifb_buf_sync_signal(struct hisi_fb_data_type *hisifd)
+{
+	struct hisifb_layerbuf *node = NULL;
+	struct hisifb_layerbuf *_node_ = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+
+
+	spin_lock(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+	list_for_each_entry_safe(node, _node_,
+				 &(hisifd->buf_sync_ctrl.layerbuf_list),
+				 list_node) {
+		if (hisifd->buf_sync_ctrl.layerbuf_flushed) {
+			node->timeline++;
+		}
+	}
+	hisifd->buf_sync_ctrl.layerbuf_flushed = false;
+	spin_unlock(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+
+	queue_work(hisifd->buf_sync_ctrl.free_layerbuf_queue,
+		   &(hisifd->buf_sync_ctrl.free_layerbuf_work));
+}
+
+void hisifb_buf_sync_suspend(struct hisi_fb_data_type *hisifd)
+{
+}
+
+void hisifb_buf_sync_register(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+	spin_lock_init(&(hisifd->buf_sync_ctrl.layerbuf_spinlock));
+	INIT_LIST_HEAD(&(hisifd->buf_sync_ctrl.layerbuf_list));
+	hisifd->buf_sync_ctrl.layerbuf_flushed = false;
+
+	INIT_WORK(&(hisifd->buf_sync_ctrl.free_layerbuf_work),
+		  hisifb_layerbuf_unlock_work);
+	hisifd->buf_sync_ctrl.free_layerbuf_queue +	    create_singlethread_workqueue(HISI_DSS_LAYERBUF_FREE);
+	if (!hisifd->buf_sync_ctrl.free_layerbuf_queue) {
+		HISI_FB_ERR("failed to create free_layerbuf_queue!\n");
+		return;
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+}
+
+void hisifb_buf_sync_unregister(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	if (hisifd->buf_sync_ctrl.free_layerbuf_queue) {
+		destroy_workqueue(hisifd->buf_sync_ctrl.free_layerbuf_queue);
+		hisifd->buf_sync_ctrl.free_layerbuf_queue = NULL;
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+}
+#endif
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_def.h b/drivers/video/fbdev/hisi/dss/hisi_fb_def.h
new file mode 100755
index 000000000000..3496be2e1838
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_def.h
@@ -0,0 +1,125 @@
+/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef HISI_FB_DEF_H
+#define HISI_FB_DEF_H
+
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <asm/bug.h>
+
+#ifndef MAX
+#define MAX(x, y) (((x) > (y)) ? (x) : (y))
+#endif
+
+#ifndef MIN
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+#endif
+
+/* align */
+#ifndef ALIGN_DOWN
+#define ALIGN_DOWN(val, al)  ((val) & ~((al)-1))
+#endif
+#ifndef ALIGN_UP
+#define ALIGN_UP(val, al)    (((val) + ((al)-1)) & ~((al)-1))
+#endif
+
+#ifndef BIT
+#define BIT(x)  (1<<(x))
+#endif
+
+#ifndef IS_EVEN
+#define IS_EVEN(x)  ((x) % 2 = 0)
+#endif
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+#define KHZ	(1000)
+#define MHZ	(1000 * 1000)
+
+enum {
+	WAIT_TYPE_US = 0,
+	WAIT_TYPE_MS,
+};
+
+/*--------------------------------------------------------------------------*/
+extern uint32_t hisi_fb_msg_level;
+
+/*
+ * Message printing priorities:
+ * LEVEL 0 KERN_EMERG (highest priority)
+ * LEVEL 1 KERN_ALERT
+ * LEVEL 2 KERN_CRIT
+ * LEVEL 3 KERN_ERR
+ * LEVEL 4 KERN_WARNING
+ * LEVEL 5 KERN_NOTICE
+ * LEVEL 6 KERN_INFO
+ * LEVEL 7 KERN_DEBUG (Lowest priority)
+ */
+#define HISI_FB_EMERG(msg, ...)    \
+	do { if (hisi_fb_msg_level > 0)  \
+		printk(KERN_EMERG "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_ALERT(msg, ...)    \
+	do { if (hisi_fb_msg_level > 1)  \
+		printk(KERN_ALERT "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_CRIT(msg, ...)    \
+	do { if (hisi_fb_msg_level > 2)  \
+		printk(KERN_CRIT "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_ERR(msg, ...)    \
+	do { if (hisi_fb_msg_level > 3)  \
+		printk(KERN_ERR "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_WARNING(msg, ...)    \
+	do { if (hisi_fb_msg_level > 4)  \
+		printk(KERN_WARNING "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_NOTICE(msg, ...)    \
+	do { if (hisi_fb_msg_level > 5)  \
+		printk(KERN_NOTICE "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_INFO(msg, ...)    \
+	do { if (hisi_fb_msg_level > 6)  \
+		printk(KERN_INFO "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+#define HISI_FB_DEBUG(msg, ...)    \
+	do { if (hisi_fb_msg_level > 7)  \
+		printk(KERN_INFO "[hisifb]%s: "msg, __func__, ## __VA_ARGS__); } while (0)
+
+#define assert(expr) \
+	if(!(expr)) { \
+		printk(KERN_ERR "[hisifb]: assertion failed! %s,%s,%s,line=%d\n",\
+		#expr, __FILE__, __func__, __LINE__); \
+	}
+
+#define HISI_FB_ASSERT(x)   assert(x)
+
+#define outp32(addr, val) writel(val, addr)
+#define outp16(addr, val) writew(val, addr)
+#define outp8(addr, val) writeb(val, addr)
+#define outp(addr, val) outp32(addr, val)
+
+#define inp32(addr) readl(addr)
+#define inp16(addr) readw(addr)
+#define inp8(addr) readb(addr)
+#define inp(addr) inp32(addr)
+
+#define inpw(port) readw(port)
+#define outpw(port, val) writew(val, port)
+#define inpdw(port) readl(port)
+#define outpdw(port, val) writel(val, port)
+
+#endif
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_isr.c b/drivers/video/fbdev/hisi/dss/hisi_fb_isr.c
new file mode 100755
index 000000000000..ca361f8028b9
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_isr.c
@@ -0,0 +1,327 @@
+/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "hisi_fb.h"
+#include "hisi_overlay_utils.h"
+
+/*******************************************************************************
+ ** handle isr
+ */
+irqreturn_t dss_pdp_isr(int irq, void *ptr)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	uint32_t isr_s1 = 0;
+	uint32_t isr_s2 = 0;
+	uint32_t isr_s2_dpp = 0;
+	uint32_t isr_s2_smmu = 0;
+	uint32_t mask = 0;
+	uint32_t isr_te_vsync = 0;
+	uint32_t i = 0;
+	uint32_t temp = 0;
+	struct timeval tv;
+	dss_module_reg_t *dss_module = NULL;
+
+	hisifd = (struct hisi_fb_data_type *)ptr;
+	BUG_ON(hisifd = NULL);
+	dss_module = &(hisifd->dss_module);
+
+	isr_s1 = inp32(hisifd->dss_base + GLB_CPU_PDP_INTS);
+	isr_s2 = inp32(hisifd->dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INTS);
+	isr_s2_dpp = inp32(hisifd->dss_base + DSS_DPP_OFFSET + DPP_INTS);
+	isr_s2_smmu +	    inp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTSTAT_NS);
+
+	outp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTCLR_NS,
+	       isr_s2_smmu);
+	outp32(hisifd->dss_base + DSS_DPP_OFFSET + DPP_INTS, isr_s2_dpp);
+	outp32(hisifd->dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INTS, isr_s2);
+	outp32(hisifd->dss_base + GLB_CPU_PDP_INTS, isr_s1);
+
+	isr_s1 &= ~(inp32(hisifd->dss_base + GLB_CPU_PDP_INT_MSK));
+	isr_s2 &+	    ~(inp32(hisifd->dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INT_MSK));
+	isr_s2_dpp &= ~(inp32(hisifd->dss_base + DSS_DPP_OFFSET + DPP_INT_MSK));
+
+	if (is_mipi_cmd_panel(hisifd)) {
+		isr_te_vsync = BIT_LCD_TE0_PIN;
+	} else {
+		isr_te_vsync = BIT_VSYNC;
+	}
+
+	if (isr_s2 & BIT_VACTIVE0_END) {
+		hisifd->vactive0_end_flag = 1;
+		if (g_err_status & DSS_PDP_LDI_UNDERFLOW) {
+			temp +			    inp32(hisifd->dss_base + DSS_DPP_OFFSET +
+				  DPP_DBG_CNT);
+			HISI_FB_INFO
+			    ("fb%d, BIT_VACTIVE0_END: frame_no=%d, dpp_dbg =0x%x\n",
+			     hisifd->index, hisifd->ov_req.frame_no, temp);
+			g_err_status &= ~DSS_PDP_LDI_UNDERFLOW;
+		}
+	}
+
+	if (isr_s2 & BIT_VACTIVE0_START) {
+		if (hisifd->ov_vactive0_start_isr_handler) {
+			hisifd->ov_vactive0_start_isr_handler(hisifd);
+		}
+
+		if (g_err_status & DSS_PDP_LDI_UNDERFLOW) {
+			temp +			    inp32(hisifd->dss_base + DSS_DPP_OFFSET +
+				  DPP_DBG_CNT);
+			HISI_FB_INFO
+			    ("fb%d, BIT_VACTIVE0_START: frame_no=%d, dpp_dbg=0x%x\n",
+			     hisifd->index, hisifd->ov_req.frame_no, temp);
+		}
+	}
+
+	if (isr_s2 & isr_te_vsync) {
+		if (hisifd->vsync_isr_handler) {
+			hisifd->vsync_isr_handler(hisifd);
+		}
+
+		if (hisifd->buf_sync_signal) {
+			hisifd->buf_sync_signal(hisifd);
+		}
+
+		if (g_err_status &
+		    (DSS_PDP_LDI_UNDERFLOW | DSS_PDP_SMMU_ERR |
+		     DSS_SDP_SMMU_ERR)) {
+			temp +			    inp32(hisifd->dss_base + DSS_DPP_OFFSET +
+				  DPP_DBG_CNT);
+			HISI_FB_INFO
+			    ("isr_te_vsync:frame_no = %d,dpp_dbg = 0x%x\n",
+			     hisifd->ov_req.frame_no, temp);
+		}
+
+		if (g_debug_ldi_underflow) {
+			hisifb_get_timestamp(&tv);
+			HISI_FB_INFO
+			    ("isr_te_vsync:frame_no = %d,isr_s2 = 0x%x\n",
+			     hisifd->ov_req.frame_no, isr_s2);
+		}
+	}
+
+	if (isr_s2 & BIT_LDI_UNFLOW) {
+		mask = inp32(hisifd->dss_base + DSS_LDI0_OFFSET +
+			  LDI_CPU_ITF_INT_MSK);
+		mask |= BIT_LDI_UNFLOW;
+		outp32(hisifd->dss_base + DSS_LDI0_OFFSET + LDI_CPU_ITF_INT_MSK, mask);
+
+		if (g_debug_ldi_underflow_clear) {
+			if (is_mipi_cmd_panel(hisifd)) {
+				if (g_ldi_data_gate_en = 0) {
+					if (hisifd->ldi_underflow_wq) {
+						disable_ldi(hisifd);
+						queue_work(hisifd->ldi_underflow_wq,
+							   &hisifd->ldi_underflow_work);
+					}
+				}
+			} else {
+				if (hisifd->ldi_underflow_wq) {
+					disable_ldi(hisifd);
+					queue_work(hisifd->ldi_underflow_wq,
+						   &hisifd->ldi_underflow_work);
+				}
+			}
+		}
+
+		if (g_debug_ldi_underflow) {
+			if (g_debug_ovl_online_composer) {
+				if (hisifd->dss_debug_wq)
+					queue_work(hisifd->dss_debug_wq,
+						   &hisifd->dss_debug_work);
+			}
+		}
+		g_err_status |= DSS_PDP_LDI_UNDERFLOW;
+
+		if (hisifd->ldi_data_gate_en = 0) {
+			temp +			    inp32(hisifd->dss_base + DSS_DPP_OFFSET +
+				  DPP_DBG_CNT);
+			HISI_FB_INFO
+			    ("ldi underflow! frame_no = %d,dpp_dbg = 0x%x!\n",
+			     hisifd->ov_req.frame_no, temp);
+
+			for (i = 0; i < DSS_WCHN_W0; i++) {
+				if ((i != DSS_RCHN_V0) && (i != DSS_RCHN_G0)) {
+					HISI_FB_INFO
+					    ("RCH[%d], DMA_BUF_DBG0 = 0x%x,DMA_BUF_DBG1 = 0x%x!!\n",
+					     i, inp32(dss_module->dma_base[i] +
+						   DMA_BUF_DBG0),
+					     inp32(dss_module->dma_base[i] +
+						   DMA_BUF_DBG1));
+				}
+			}
+			for (i = 0; i < 18; i++) {
+				HISI_FB_INFO("MCTL_MOD%d_STATUS = 0x%x\n",
+					     i, inp32(dss_module->mctl_sys_base +
+						   MCTL_MOD0_STATUS + i * 0x4));
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t dss_sdp_isr(int irq, void *ptr)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	uint32_t isr_s1 = 0;
+	uint32_t isr_s2 = 0;
+	uint32_t isr_s2_smmu = 0;
+	uint32_t mask = 0;
+
+	hisifd = (struct hisi_fb_data_type *)ptr;
+	BUG_ON(hisifd = NULL);
+
+	isr_s1 = inp32(hisifd->dss_base + GLB_CPU_SDP_INTS);
+	isr_s2 = inp32(hisifd->dss_base + DSS_LDI1_OFFSET + LDI_CPU_ITF_INTS);
+	isr_s2_smmu +	    inp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTSTAT_NS);
+
+	outp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTCLR_NS,
+	       isr_s2_smmu);
+	outp32(hisifd->dss_base + DSS_LDI1_OFFSET + LDI_CPU_ITF_INTS, isr_s2);
+	outp32(hisifd->dss_base + GLB_CPU_SDP_INTS, isr_s1);
+
+	isr_s1 &= ~(inp32(hisifd->dss_base + GLB_CPU_SDP_INT_MSK));
+	isr_s2 &+	    ~(inp32(hisifd->dss_base + DSS_LDI1_OFFSET + LDI_CPU_ITF_INT_MSK));
+
+	if (isr_s2 & BIT_VACTIVE0_END) {
+		hisifd->vactive0_end_flag = 1;
+	}
+
+	if (isr_s2 & BIT_VACTIVE0_START) {
+		if (hisifd->ov_vactive0_start_isr_handler)
+			hisifd->ov_vactive0_start_isr_handler(hisifd);
+	}
+
+	if (isr_s2 & BIT_VSYNC) {
+		if (hisifd->vsync_isr_handler) {
+			hisifd->vsync_isr_handler(hisifd);
+		}
+
+		if (hisifd->buf_sync_signal) {
+			hisifd->buf_sync_signal(hisifd);
+		}
+	}
+
+	if (isr_s2 & BIT_LDI_UNFLOW) {
+		mask +		    inp32(hisifd->dss_base + DSS_LDI1_OFFSET +
+			  LDI_CPU_ITF_INT_MSK);
+		mask |= BIT_LDI_UNFLOW;
+		outp32(hisifd->dss_base + DSS_LDI1_OFFSET + LDI_CPU_ITF_INT_MSK,
+		       mask);
+		if (g_debug_ldi_underflow_clear) {
+			if (is_mipi_cmd_panel(hisifd)) {
+				if (g_ldi_data_gate_en = 0) {
+					if (hisifd->ldi_underflow_wq) {
+						disable_ldi(hisifd);
+						queue_work(hisifd->ldi_underflow_wq,
+							   &hisifd->ldi_underflow_work);
+					}
+				}
+			} else {
+				if (hisifd->ldi_underflow_wq) {
+					disable_ldi(hisifd);
+					queue_work(hisifd->ldi_underflow_wq,
+						   &hisifd->ldi_underflow_work);
+				}
+			}
+		}
+		if (g_debug_ldi_underflow) {
+			if (g_debug_ovl_online_composer) {
+				if (hisifd->dss_debug_wq)
+					queue_work(hisifd->dss_debug_wq,
+						   &hisifd->dss_debug_work);
+			}
+		}
+		g_err_status |= DSS_SDP_LDI_UNDERFLOW;
+		if (hisifd->ldi_data_gate_en = 0)
+			HISI_FB_ERR("ldi underflow!\n");
+	}
+	return IRQ_HANDLED;
+}
+
+irqreturn_t dss_adp_isr(int irq, void *ptr)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	uint32_t isr_s1 = 0;
+	uint32_t isr_s2_smmu = 0;
+	uint32_t isr_s3_copybit = 0;
+
+	hisifd = (struct hisi_fb_data_type *)ptr;
+	BUG_ON(hisifd = NULL);
+
+	isr_s1 = inp32(hisifd->dss_base + GLB_CPU_OFF_INTS);
+	isr_s2_smmu +	    inp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTSTAT_NS);
+
+	outp32(hisifd->dss_base + DSS_SMMU_OFFSET + SMMU_INTCLR_NS,
+	       isr_s2_smmu);
+	outp32(hisifd->dss_base + GLB_CPU_OFF_INTS, isr_s1);
+
+	isr_s1 &= ~(inp32(hisifd->dss_base + GLB_CPU_OFF_INT_MSK));
+	isr_s3_copybit = inp32(hisifd->dss_base + GLB_CPU_OFF_CAM_INTS);
+	outp32(hisifd->dss_base + GLB_CPU_OFF_CAM_INTS, isr_s3_copybit);
+	isr_s3_copybit &= ~(inp32(hisifd->dss_base + GLB_CPU_OFF_CAM_INT_MSK));
+
+	if (isr_s1 & BIT_OFF_WCH0_INTS) {
+		if (hisifd->cmdlist_info->cmdlist_wb_flag[WB_TYPE_WCH0] = 1) {
+			hisifd->cmdlist_info->cmdlist_wb_done[WB_TYPE_WCH0] = 1;
+			wake_up_interruptible_all(&
+						  (hisifd->cmdlist_info->cmdlist_wb_wq
+						   [WB_TYPE_WCH0]));
+		}
+	}
+	if (isr_s1 & BIT_OFF_WCH1_INTS) {
+		if (hisifd->cmdlist_info->cmdlist_wb_flag[WB_TYPE_WCH1] = 1) {
+			hisifd->cmdlist_info->cmdlist_wb_done[WB_TYPE_WCH1] = 1;
+			wake_up_interruptible_all(&
+						  (hisifd->cmdlist_info->cmdlist_wb_wq
+						   [WB_TYPE_WCH1]));
+		}
+	}
+	if (isr_s1 & BIT_OFF_WCH0_WCH1_FRM_END_INT) {
+		if (hisifd->cmdlist_info->cmdlist_wb_flag[WB_TYPE_WCH0_WCH1] =
+		    1) {
+			hisifd->cmdlist_info->
+			    cmdlist_wb_done[WB_TYPE_WCH0_WCH1] = 1;
+			wake_up_interruptible_all(&
+						  (hisifd->cmdlist_info->cmdlist_wb_wq
+						   [WB_TYPE_WCH0_WCH1]));
+		}
+	}
+
+	if (isr_s3_copybit & BIT_OFF_CAM_WCH2_FRMEND_INTS) {
+		if (hisifd->copybit_info->copybit_flag = 1) {
+			hisifd->copybit_info->copybit_done = 1;
+			wake_up_interruptible_all(&
+						  (hisifd->copybit_info->copybit_wq));
+		}
+
+		if (hisifd->cmdlist_info->cmdlist_wb_flag[WB_TYPE_WCH2] = 1) {
+			hisifd->cmdlist_info->cmdlist_wb_done[WB_TYPE_WCH2] = 1;
+			wake_up_interruptible_all(&
+						  (hisifd->cmdlist_info->cmdlist_wb_wq
+						   [WB_TYPE_WCH2]));
+		}
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_panel.c b/drivers/video/fbdev/hisi/dss/hisi_fb_panel.c
new file mode 100755
index 000000000000..a26035e8beba
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_panel.c
@@ -0,0 +1,835 @@
+/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include "hisi_fb.h"
+#include "hisi_fb_panel.h"
+
+DEFINE_SEMAPHORE(hisi_fb_dts_resource_sem);
+mipi_ifbc_division_t g_mipi_ifbc_division[MIPI_DPHY_NUM][IFBC_TYPE_MAX] = {
+
+	{
+	 {XRES_DIV_1, YRES_DIV_1, IFBC_COMP_MODE_0, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_0, PXL0_DSI_GT_EN_1}
+	 ,
+
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_0, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_3, YRES_DIV_1, IFBC_COMP_MODE_1, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_2, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_2, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_3, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_OPEN, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_3, YRES_DIV_1, IFBC_COMP_MODE_4, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_OPEN, PXL0_DIVCFG_2, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_5, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_3, YRES_DIV_1, IFBC_COMP_MODE_5, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_2, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_6, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_3, YRES_DIV_1, IFBC_COMP_MODE_6, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_2, PXL0_DSI_GT_EN_3}
+	 }
+	,
+
+	{
+	 {XRES_DIV_2, YRES_DIV_1, IFBC_COMP_MODE_0, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_1, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_4, YRES_DIV_1, IFBC_COMP_MODE_0, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_3, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_6, YRES_DIV_1, IFBC_COMP_MODE_1, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_5, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_4, YRES_DIV_1, IFBC_COMP_MODE_2, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_3, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_4, YRES_DIV_1, IFBC_COMP_MODE_3, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_OPEN, PXL0_DIVCFG_3, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_3, YRES_DIV_2, IFBC_COMP_MODE_4, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_OPEN, PXL0_DIVCFG_5, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_4, YRES_DIV_1, IFBC_COMP_MODE_5, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_3, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_6, YRES_DIV_1, IFBC_COMP_MODE_5, PXL0_DIV2_GT_EN_CLOSE,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_5, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_4, YRES_DIV_1, IFBC_COMP_MODE_6, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_3, PXL0_DSI_GT_EN_3}
+	 ,
+
+	 {XRES_DIV_6, YRES_DIV_1, IFBC_COMP_MODE_6, PXL0_DIV2_GT_EN_OPEN,
+	  PXL0_DIV4_GT_EN_CLOSE, PXL0_DIVCFG_5, 3}
+	 }
+};
+
+int gpio_cmds_tx(struct gpio_desc *cmds, int cnt)
+{
+	int ret = 0;
+	struct gpio_desc *cm = NULL;
+	int i = 0;
+
+	cm = cmds;
+	for (i = 0; i < cnt; i++) {
+		if ((cm = NULL) || (cm->label = NULL)) {
+			HISI_FB_ERR("cm or cm->label is null! index=%d\n", i);
+			ret = -1;
+			goto error;
+		}
+
+		if (!gpio_is_valid(*(cm->gpio))) {
+			HISI_FB_ERR
+			    ("gpio invalid, dtype=%d, lable=%s, gpio=%d!\n",
+			     cm->dtype, cm->label, *(cm->gpio));
+			ret = -1;
+			goto error;
+		}
+
+		if (cm->dtype = DTYPE_GPIO_INPUT) {
+			if (gpio_direction_input(*(cm->gpio)) != 0) {
+				HISI_FB_ERR
+				    ("failed to gpio_direction_input, lable=%s, gpio=%d!\n",
+				     cm->label, *(cm->gpio));
+				ret = -1;
+				goto error;
+			}
+		} else if (cm->dtype = DTYPE_GPIO_OUTPUT) {
+			if (gpio_direction_output(*(cm->gpio), cm->value) != 0) {
+				HISI_FB_ERR
+				    ("failed to gpio_direction_output, label%s, gpio=%d!\n",
+				     cm->label, *(cm->gpio));
+				ret = -1;
+				goto error;
+			}
+		} else if (cm->dtype = DTYPE_GPIO_REQUEST) {
+			if (gpio_request(*(cm->gpio), cm->label) != 0) {
+				HISI_FB_ERR
+				    ("failed to gpio_request, lable=%s, gpio=%d!\n",
+				     cm->label, *(cm->gpio));
+				ret = -1;
+				goto error;
+			}
+		} else if (cm->dtype = DTYPE_GPIO_FREE) {
+			gpio_free(*(cm->gpio));
+		} else {
+			HISI_FB_ERR("dtype=%x NOT supported\n", cm->dtype);
+			ret = -1;
+			goto error;
+		}
+
+		if (cm->wait) {
+			if (cm->waittype = WAIT_TYPE_US)
+				udelay(cm->wait);
+			else if (cm->waittype = WAIT_TYPE_MS)
+				mdelay(cm->wait);
+			else
+				mdelay(cm->wait * 1000);
+		}
+
+		cm++;
+	}
+
+	return 0;
+
+ error:
+	return ret;
+}
+
+int resource_cmds_tx(struct platform_device *pdev,
+		     struct resource_desc *cmds, int cnt)
+{
+	int ret = 0;
+	struct resource *res = NULL;
+	struct resource_desc *cm = NULL;
+	int i = 0;
+
+	BUG_ON(pdev = NULL);
+	cm = cmds;
+
+	for (i = 0; i < cnt; i++) {
+		if ((cm = NULL) || (cm->name = NULL)) {
+			HISI_FB_ERR("cm or cm->name is null! index=%d\n", i);
+			ret = -1;
+			goto error;
+		}
+
+		res = platform_get_resource_byname(pdev, cm->flag, cm->name);
+		if (!res) {
+			HISI_FB_ERR("failed to get %s resource!\n", cm->name);
+			ret = -1;
+			goto error;
+		}
+		*(cm->value) = res->start;
+		cm++;
+	}
+
+ error:
+	return ret;
+}
+
+int vcc_cmds_tx(struct platform_device *pdev, struct vcc_desc *cmds, int cnt)
+{
+	int ret = 0;
+	struct vcc_desc *cm = NULL;
+	int i = 0;
+
+	cm = cmds;
+	for (i = 0; i < cnt; i++) {
+		if ((cm = NULL) || (cm->id = NULL)) {
+			HISI_FB_ERR("cm or cm->id is null! index=%d\n", i);
+			ret = -1;
+			goto error;
+		}
+
+		if (cm->dtype = DTYPE_VCC_GET) {
+			BUG_ON(pdev = NULL);
+			*(cm->regulator) +			    devm_regulator_get(&pdev->dev, cm->id);
+			if (IS_ERR(*(cm->regulator))) {
+				HISI_FB_ERR("failed to get %s regulator!\n",
+					    cm->id);
+				ret = -1;
+				goto error;
+			}
+		} else if (cm->dtype = DTYPE_VCC_PUT) {
+			if (!IS_ERR(*(cm->regulator))) {
+				devm_regulator_put(*(cm->regulator));
+			}
+		} else if (cm->dtype = DTYPE_VCC_ENABLE) {
+			if (!IS_ERR(*(cm->regulator))) {
+				if (regulator_enable(*(cm->regulator)) != 0) {
+					HISI_FB_ERR
+					    ("failed to enable %s regulator!\n",
+					     cm->id);
+					ret = -1;
+					goto error;
+				}
+			}
+		} else if (cm->dtype = DTYPE_VCC_DISABLE) {
+			if (!IS_ERR(*(cm->regulator))) {
+				if (regulator_disable(*(cm->regulator)) != 0) {
+					HISI_FB_ERR
+					    ("failed to disable %s regulator!\n",
+					     cm->id);
+					ret = -1;
+					goto error;
+				}
+			}
+		} else if (cm->dtype = DTYPE_VCC_SET_VOLTAGE) {
+			if (!IS_ERR(*(cm->regulator))) {
+				if (regulator_set_voltage
+				    (*(cm->regulator), cm->min_uV,
+				     cm->max_uV) != 0) {
+					HISI_FB_ERR
+					    ("failed to set %s regulator voltage!\n",
+					     cm->id);
+					ret = -1;
+					goto error;
+				}
+			}
+		} else {
+			HISI_FB_ERR("dtype=%x NOT supported\n", cm->dtype);
+			ret = -1;
+			goto error;
+		}
+
+		if (cm->wait) {
+			if (cm->waittype = WAIT_TYPE_US)
+				udelay(cm->wait);
+			else if (cm->waittype = WAIT_TYPE_MS)
+				mdelay(cm->wait);
+			else
+				mdelay(cm->wait * 1000);
+		}
+
+		cm++;
+	}
+
+	return 0;
+
+ error:
+	return ret;
+}
+
+int pinctrl_cmds_tx(struct platform_device *pdev, struct pinctrl_cmd_desc *cmds,
+		    int cnt)
+{
+	int ret = 0;
+
+	int i = 0;
+	struct pinctrl_cmd_desc *cm = NULL;
+
+	cm = cmds;
+	for (i = 0; i < cnt; i++) {
+		if (cm = NULL) {
+			HISI_FB_ERR("cm is null! index=%d\n", i);
+			continue;
+		}
+		if (cm->dtype = DTYPE_PINCTRL_GET) {
+			BUG_ON(pdev = NULL);
+			cm->pctrl_data->p = devm_pinctrl_get(&pdev->dev);
+			if (IS_ERR(cm->pctrl_data->p)) {
+				ret = -1;
+				HISI_FB_ERR("failed to get p, index=%d!\n", i);
+				goto err;
+			}
+		} else if (cm->dtype = DTYPE_PINCTRL_STATE_GET) {
+			if (cm->mode = DTYPE_PINCTRL_STATE_DEFAULT) {
+				cm->pctrl_data->pinctrl_def +				    pinctrl_lookup_state(cm->pctrl_data->p,
+							 PINCTRL_STATE_DEFAULT);
+				if (IS_ERR(cm->pctrl_data->pinctrl_def)) {
+					ret = -1;
+					HISI_FB_ERR
+					    ("failed to get pinctrl_def, index=%d!\n",
+					     i);
+					goto err;
+				}
+			} else if (cm->mode = DTYPE_PINCTRL_STATE_IDLE) {
+				cm->pctrl_data->pinctrl_idle +				    pinctrl_lookup_state(cm->pctrl_data->p,
+							 PINCTRL_STATE_IDLE);
+				if (IS_ERR(cm->pctrl_data->pinctrl_idle)) {
+					ret = -1;
+					HISI_FB_ERR
+					    ("failed to get pinctrl_idle, index=%d!\n",
+					     i);
+					goto err;
+				}
+			} else {
+				ret = -1;
+				HISI_FB_ERR("unknown pinctrl type to get!\n");
+				goto err;
+			}
+		} else if (cm->dtype = DTYPE_PINCTRL_SET) {
+			if (cm->mode = DTYPE_PINCTRL_STATE_DEFAULT) {
+				if (cm->pctrl_data->p
+				    && cm->pctrl_data->pinctrl_def) {
+					ret +					    pinctrl_select_state(cm->pctrl_data->p,
+								 cm->pctrl_data->pinctrl_def);
+					if (ret) {
+						HISI_FB_ERR
+						    ("could not set this pin to default state!\n");
+						ret = -1;
+						goto err;
+					}
+				}
+			} else if (cm->mode = DTYPE_PINCTRL_STATE_IDLE) {
+				if (cm->pctrl_data->p
+				    && cm->pctrl_data->pinctrl_idle) {
+					ret +					    pinctrl_select_state(cm->pctrl_data->p,
+								 cm->pctrl_data->pinctrl_idle);
+					if (ret) {
+						HISI_FB_ERR
+						    ("could not set this pin to idle state!\n");
+						ret = -1;
+						goto err;
+					}
+				}
+			} else {
+				ret = -1;
+				HISI_FB_ERR("unknown pinctrl type to set!\n");
+				goto err;
+			}
+		} else if (cm->dtype = DTYPE_PINCTRL_PUT) {
+			if (cm->pctrl_data->p)
+				pinctrl_put(cm->pctrl_data->p);
+		} else {
+			HISI_FB_ERR("not supported command type!\n");
+			ret = -1;
+			goto err;
+		}
+
+		cm++;
+	}
+
+	return 0;
+
+ err:
+	return ret;
+}
+
+int panel_next_on(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_panel_data *next_pdata = NULL;
+	struct platform_device *next_pdev = NULL;
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	next_pdev = pdata->next;
+	if (next_pdev) {
+		next_pdata = dev_get_platdata(&next_pdev->dev);
+		if ((next_pdata) && (next_pdata->on))
+			ret = next_pdata->on(next_pdev);
+	}
+
+	return ret;
+}
+
+int panel_next_off(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_panel_data *next_pdata = NULL;
+	struct platform_device *next_pdev = NULL;
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	next_pdev = pdata->next;
+	if (next_pdev) {
+		next_pdata = dev_get_platdata(&next_pdev->dev);
+		if ((next_pdata) && (next_pdata->off))
+			ret = next_pdata->off(next_pdev);
+	}
+
+	return ret;
+}
+
+int panel_next_remove(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_panel_data *next_pdata = NULL;
+	struct platform_device *next_pdev = NULL;
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	next_pdev = pdata->next;
+	if (next_pdev) {
+		next_pdata = dev_get_platdata(&next_pdev->dev);
+		if ((next_pdata) && (next_pdata->remove))
+			ret = next_pdata->remove(next_pdev);
+	}
+
+	return ret;
+}
+
+int panel_next_set_backlight(struct platform_device *pdev, uint32_t bl_level)
+{
+	int ret = 0;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_panel_data *next_pdata = NULL;
+	struct platform_device *next_pdev = NULL;
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	next_pdev = pdata->next;
+	if (next_pdev) {
+		next_pdata = dev_get_platdata(&next_pdev->dev);
+		if ((next_pdata) && (next_pdata->set_backlight))
+			ret = next_pdata->set_backlight(next_pdev, bl_level);
+	}
+
+	return ret;
+}
+
+int panel_next_vsync_ctrl(struct platform_device *pdev, int enable)
+{
+	int ret = 0;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisi_fb_panel_data *next_pdata = NULL;
+	struct platform_device *next_pdev = NULL;
+
+	BUG_ON(pdev = NULL);
+	pdata = dev_get_platdata(&pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	next_pdev = pdata->next;
+	if (next_pdev) {
+		next_pdata = dev_get_platdata(&next_pdev->dev);
+		if ((next_pdata) && (next_pdata->vsync_ctrl))
+			ret = next_pdata->vsync_ctrl(next_pdev, enable);
+	}
+
+	return ret;
+}
+
+bool is_ldi_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+	if (hisifd->panel_info.type & PANEL_LCDC)
+		return true;
+
+	return false;
+}
+
+bool is_mipi_cmd_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.type & (PANEL_MIPI_CMD | PANEL_DUAL_MIPI_CMD))
+		return true;
+
+	return false;
+}
+
+bool is_mipi_cmd_panel_ext(struct hisi_panel_info *pinfo)
+{
+	BUG_ON(pinfo = NULL);
+
+	if (pinfo->type & (PANEL_MIPI_CMD | PANEL_DUAL_MIPI_CMD))
+		return true;
+
+	return false;
+}
+
+bool is_mipi_video_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.
+	    type & (PANEL_MIPI_VIDEO | PANEL_DUAL_MIPI_VIDEO | PANEL_RGB2MIPI))
+		return true;
+
+	return false;
+}
+
+bool is_mipi_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.type & (PANEL_MIPI_VIDEO | PANEL_MIPI_CMD |
+				       PANEL_DUAL_MIPI_VIDEO |
+				       PANEL_DUAL_MIPI_CMD))
+		return true;
+
+	return false;
+}
+
+bool is_dual_mipi_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.
+	    type & (PANEL_DUAL_MIPI_VIDEO | PANEL_DUAL_MIPI_CMD))
+		return true;
+
+	return false;
+}
+
+bool is_dual_mipi_panel_ext(struct hisi_panel_info *pinfo)
+{
+	BUG_ON(pinfo = NULL);
+
+	if (pinfo->type & (PANEL_DUAL_MIPI_VIDEO | PANEL_DUAL_MIPI_CMD))
+		return true;
+
+	return false;
+}
+
+bool is_hisi_writeback_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.type & PANEL_WRITEBACK)
+		return true;
+
+	return false;
+}
+
+bool is_ifbc_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->panel_info.ifbc_type != IFBC_TYPE_NONE)
+		return true;
+
+	return false;
+}
+
+bool is_ifbc_vesa_panel(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if ((hisifd->panel_info.ifbc_type = IFBC_TYPE_VESA2X_SINGLE) ||
+	    (hisifd->panel_info.ifbc_type = IFBC_TYPE_VESA3X_SINGLE) ||
+	    (hisifd->panel_info.ifbc_type = IFBC_TYPE_VESA2X_DUAL) ||
+	    (hisifd->panel_info.ifbc_type = IFBC_TYPE_VESA3X_DUAL))
+		return true;
+
+	return false;
+}
+
+bool mipi_panel_check_reg(struct hisi_fb_data_type *hisifd,
+			  uint32_t *read_value)
+{
+	int ret = 0;
+	char lcd_reg_05[] = { 0x05 };
+	char lcd_reg_0a[] = { 0x0a };
+	char lcd_reg_0e[] = { 0x0e };
+	char lcd_reg_0f[] = { 0x0f };
+
+	struct dsi_cmd_desc lcd_check_reg[] = {
+		{DTYPE_GEN_WRITE1, 0, 10, WAIT_TYPE_US,
+		 sizeof(lcd_reg_05), lcd_reg_05}
+		,
+		{DTYPE_GEN_WRITE1, 0, 10, WAIT_TYPE_US,
+		 sizeof(lcd_reg_0a), lcd_reg_0a}
+		,
+		{DTYPE_GEN_WRITE1, 0, 10, WAIT_TYPE_US,
+		 sizeof(lcd_reg_0e), lcd_reg_0e}
+		,
+		{DTYPE_GEN_WRITE1, 0, 10, WAIT_TYPE_US,
+		 sizeof(lcd_reg_0f), lcd_reg_0f}
+		,
+	};
+
+	ret = mipi_dsi_cmds_rx(read_value, lcd_check_reg,
+			       ARRAY_SIZE(lcd_check_reg),
+			       hisifd->mipi_dsi0_base);
+	if (ret) {
+		HISI_FB_ERR("Read error number: %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+int mipi_ifbc_get_rect(struct hisi_fb_data_type *hisifd, struct dss_rect *rect)
+{
+	uint32_t ifbc_type = 0;
+	uint32_t mipi_idx = 0;
+	uint32_t xres_div = 1;
+	uint32_t yres_div = 1;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(rect = NULL);
+
+	ifbc_type = hisifd->panel_info.ifbc_type;
+	BUG_ON((ifbc_type < IFBC_TYPE_NONE) || (ifbc_type >= IFBC_TYPE_MAX));
+
+	mipi_idx = is_dual_mipi_panel(hisifd) ? 1 : 0;
+
+	xres_div = g_mipi_ifbc_division[mipi_idx][ifbc_type].xres_div;
+	yres_div = g_mipi_ifbc_division[mipi_idx][ifbc_type].yres_div;
+
+	if ((rect->w % xres_div) > 0) {
+		HISI_FB_ERR
+		    ("fb%d, xres(%d) is not division_h(%d) pixel aligned!\n",
+		     hisifd->index, rect->w, xres_div);
+	}
+
+	if ((rect->h % yres_div) > 0) {
+		HISI_FB_ERR
+		    ("fb%d, yres(%d) is not division_v(%d) pixel aligned!\n",
+		     hisifd->index, rect->h, yres_div);
+	}
+
+	if ((mipi_idx = 0) && (ifbc_type = IFBC_TYPE_RSP3X)
+	    && (hisifd->panel_info.type = PANEL_MIPI_CMD)) {
+		rect->w *= 2;
+		rect->h /= 2;
+	}
+
+	rect->w /= xres_div;
+	rect->h /= yres_div;
+
+	return 0;
+}
+
+bool hisi_fb_device_probe_defer(uint32_t panel_type, uint32_t bl_type)
+{
+	bool flag = true;
+
+	down(&hisi_fb_dts_resource_sem);
+
+	switch (panel_type) {
+	case PANEL_NO:
+		if (g_dts_resouce_ready & DTS_FB_RESOURCE_INIT_READY) {
+			flag = false;
+		}
+		break;
+	case PANEL_LCDC:
+	case PANEL_MIPI2RGB:
+	case PANEL_RGB2MIPI:
+		if ((g_dts_resouce_ready & DTS_FB_RESOURCE_INIT_READY) &&
+		    (g_dts_resouce_ready & DTS_SPI_READY)) {
+			if (bl_type & (BL_SET_BY_PWM | BL_SET_BY_BLPWM)) {
+				if (g_dts_resouce_ready & DTS_PWM_READY)
+					flag = false;
+			} else {
+				flag = false;
+			}
+		}
+		break;
+	case PANEL_MIPI_VIDEO:
+	case PANEL_MIPI_CMD:
+	case PANEL_DUAL_MIPI_VIDEO:
+	case PANEL_DUAL_MIPI_CMD:
+	case PANEL_EDP:
+		if (g_dts_resouce_ready & DTS_FB_RESOURCE_INIT_READY) {
+			if (bl_type & (BL_SET_BY_PWM | BL_SET_BY_BLPWM)) {
+				if (g_dts_resouce_ready & DTS_PWM_READY)
+					flag = false;
+			} else {
+				flag = false;
+			}
+		}
+		break;
+	case PANEL_HDMI:
+		if (g_dts_resouce_ready & DTS_PANEL_PRIMARY_READY)
+			flag = false;
+		break;
+	case PANEL_WRITEBACK:
+		if (g_dts_resouce_ready & DTS_PANEL_OFFLINECOMPOSER_READY)
+			flag = false;
+		break;
+	default:
+		HISI_FB_ERR("not support this panel type(%d).\n", panel_type);
+		break;
+	}
+
+	up(&hisi_fb_dts_resource_sem);
+
+	return flag;
+}
+
+void hisi_fb_device_set_status0(uint32_t status)
+{
+	down(&hisi_fb_dts_resource_sem);
+	g_dts_resouce_ready |= status;
+	up(&hisi_fb_dts_resource_sem);
+}
+
+int hisi_fb_device_set_status1(struct hisi_fb_data_type *hisifd)
+{
+	int ret = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	down(&hisi_fb_dts_resource_sem);
+
+	switch (hisifd->panel_info.type) {
+	case PANEL_LCDC:
+	case PANEL_MIPI_VIDEO:
+	case PANEL_MIPI_CMD:
+	case PANEL_DUAL_MIPI_VIDEO:
+	case PANEL_DUAL_MIPI_CMD:
+	case PANEL_EDP:
+	case PANEL_MIPI2RGB:
+	case PANEL_RGB2MIPI:
+	case PANEL_HDMI:
+		if (hisifd->index = PRIMARY_PANEL_IDX) {
+			g_dts_resouce_ready |= DTS_PANEL_PRIMARY_READY;
+		} else if (hisifd->index = EXTERNAL_PANEL_IDX) {
+			g_dts_resouce_ready |= DTS_PANEL_EXTERNAL_READY;
+		} else {
+			HISI_FB_ERR("not support fb(%d).\n", hisifd->index);
+		}
+		break;
+	case PANEL_WRITEBACK:
+		g_dts_resouce_ready |= DTS_PANEL_WRITEBACK_READY;
+		break;
+	default:
+		HISI_FB_ERR("not support this panel type(%d).\n",
+			    hisifd->panel_info.type);
+		ret = -1;
+		break;
+	}
+
+	up(&hisi_fb_dts_resource_sem);
+
+	return ret;
+}
+
+struct platform_device *hisi_fb_device_alloc(struct hisi_fb_panel_data *pdata,
+					     uint32_t type, uint32_t id)
+{
+	struct platform_device *this_dev = NULL;
+	char dev_name[32] = { 0 };
+
+	BUG_ON(pdata = NULL);
+
+	switch (type) {
+	case PANEL_MIPI_VIDEO:
+	case PANEL_MIPI_CMD:
+	case PANEL_DUAL_MIPI_VIDEO:
+	case PANEL_DUAL_MIPI_CMD:
+		snprintf(dev_name, sizeof(dev_name), DEV_NAME_MIPIDSI);
+		break;
+	case PANEL_EDP:
+		snprintf(dev_name, sizeof(dev_name), DEV_NAME_EDP);
+		break;
+	case PANEL_NO:
+	case PANEL_LCDC:
+	case PANEL_HDMI:
+	case PANEL_WRITEBACK:
+		snprintf(dev_name, sizeof(dev_name), DEV_NAME_DSS_DPE);
+		break;
+	case PANEL_RGB2MIPI:
+		snprintf(dev_name, sizeof(dev_name), DEV_NAME_RGB2MIPI);
+		break;
+	default:
+		HISI_FB_ERR("invalid panel type = %d!\n", type);
+		return NULL;
+	}
+
+	if (pdata != NULL)
+		pdata->next = NULL;
+	else
+		return NULL;
+
+	this_dev +	    platform_device_alloc(dev_name,
+				  (((uint32_t) type << 16) | (uint32_t) id));
+	if (this_dev) {
+		if (platform_device_add_data
+		    (this_dev, pdata, sizeof(struct hisi_fb_panel_data))) {
+			HISI_FB_ERR("failed to platform_device_add_data!\n");
+			platform_device_put(this_dev);
+			return NULL;
+		}
+	}
+
+	return this_dev;
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_panel.h b/drivers/video/fbdev/hisi/dss/hisi_fb_panel.h
new file mode 100755
index 000000000000..8afb1f42a8c5
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_panel.h
@@ -0,0 +1,839 @@
+/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef HISI_FB_PANEL_H
+#define HISI_FB_PANEL_H
+
+#include "hisi_fb_def.h"
+#include "hisi_mipi_dsi.h"
+#include "hisi_dss.h"
+
+/* panel type list */
+#define PANEL_NO	BIT(0)	/* No Panel */
+#define PANEL_LCDC	BIT(1)	/* internal LCDC type */
+#define PANEL_HDMI	BIT(2)	/* HDMI TV */
+#define PANEL_MIPI_VIDEO	BIT(3)	/* MIPI */
+#define PANEL_MIPI_CMD	BIT(4)	/* MIPI */
+#define PANEL_DUAL_MIPI_VIDEO	BIT(5)	/* DUAL MIPI */
+#define PANEL_DUAL_MIPI_CMD	BIT(6)	/* DUAL MIPI */
+#define PANEL_EDP	BIT(7)	/* LVDS */
+#define PANEL_MIPI2RGB	BIT(8)	/* MIPI to RGB */
+#define PANEL_RGB2MIPI	BIT(9)	/* RGB to MIPI */
+#define PANEL_WRITEBACK	BIT(11)	/* Wifi display */
+
+/* dts initial */
+#define DTS_FB_RESOURCE_INIT_READY	BIT(0)
+#define DTS_PWM_READY	BIT(1)
+
+#define DTS_SPI_READY	BIT(3)
+#define DTS_PANEL_PRIMARY_READY	BIT(4)
+#define DTS_PANEL_EXTERNAL_READY	BIT(5)
+#define DTS_PANEL_OFFLINECOMPOSER_READY	BIT(6)
+#define DTS_PANEL_WRITEBACK_READY	BIT(7)
+
+/* device name */
+#define DEV_NAME_DSS_DPE		"dss_dpe"
+#define DEV_NAME_SPI			"spi_dev0"
+#define DEV_NAME_HDMI			"hdmi"
+#define DEV_NAME_EDP			"edp"
+#define DEV_NAME_MIPI2RGB		"mipi2rgb"
+#define DEV_NAME_RGB2MIPI		"rgb2mipi"
+#define DEV_NAME_MIPIDSI		"mipi_dsi"
+#define DEV_NAME_FB				"hisi_fb"
+#define DEV_NAME_PWM			"hisi_pwm"
+#define DEV_NAME_BLPWM			"hisi_blpwm"
+#define DEV_NAME_LCD_BKL		"lcd_backlight0"
+
+/* vcc name */
+#define REGULATOR_PDP_NAME	"regulator_dsssubsys"
+#define REGULATOR_MMBUF	"regulator_mmbuf"
+
+/* irq name */
+#define IRQ_PDP_NAME	"irq_pdp"
+#define IRQ_SDP_NAME	"irq_sdp"
+#define IRQ_ADP_NAME	"irq_adp"
+#define IRQ_DSI0_NAME	"irq_dsi0"
+#define IRQ_DSI1_NAME	"irq_dsi1"
+
+/* dts compatible */
+#define DTS_COMP_FB_NAME	"hisilicon,hisifb"
+#define DTS_COMP_PWM_NAME	"hisilicon,hisipwm"
+#define DTS_COMP_BLPWM_NAME	"hisilicon,hisiblpwm"
+#define DTS_PATH_LOGO_BUFFER	"/reserved-memory/logo-buffer"
+
+/* lcd resource name */
+#define LCD_BL_TYPE_NAME	"lcd-bl-type"
+#define FPGA_FLAG_NAME "fpga_flag"
+#define LCD_DISPLAY_TYPE_NAME	"lcd-display-type"
+#define LCD_IFBC_TYPE_NAME	"lcd-ifbc-type"
+
+/* backlight type */
+#define BL_SET_BY_NONE	BIT(0)
+#define BL_SET_BY_PWM	BIT(1)
+#define BL_SET_BY_BLPWM	BIT(2)
+#define BL_SET_BY_MIPI	BIT(3)
+#define BL_SET_BY_SH_BLPWM	BIT(4)
+
+/* supported display effect type */
+#define COMFORM_MODE			BIT(0)
+#define ACM_COLOR_ENHANCE_MODE	BIT(1)
+#define IC_COLOR_ENHANCE_MODE	BIT(2)
+#define CINEMA_MODE				BIT(3)
+#define VR_MODE                     BIT(4)
+#define LED_RG_COLOR_TEMP_MODE	BIT(16)
+#define GAMMA_MAP    BIT(19)
+
+#define LCD_BL_IC_NAME_MAX	(50)
+#define DEV_DSS_VOLTAGE_ID (20)
+
+enum BLPWM_PRECISION_TYPE {
+	BLPWM_PRECISION_DEFAULT_TYPE = 0,
+	BLPWM_PRECISION_10000_TYPE = 1,
+	BLPWM_PRECISION_2048_TYPE = 2,
+};
+
+enum LCD_INIT_STEP {
+	LCD_INIT_NONE = 0,
+	LCD_INIT_POWER_ON,
+	LCD_INIT_LDI_SEND_SEQUENCE,
+	LCD_INIT_MIPI_LP_SEND_SEQUENCE,
+	LCD_INIT_MIPI_HS_SEND_SEQUENCE,
+};
+
+enum LCD_UNINIT_STEP {
+	LCD_UNINIT_NONE = 0,
+	LCD_UNINIT_POWER_OFF,
+	LCD_UNINIT_LDI_SEND_SEQUENCE,
+	LCD_UNINIT_MIPI_LP_SEND_SEQUENCE,
+	LCD_UNINIT_MIPI_HS_SEND_SEQUENCE,
+};
+
+enum LCD_ESD_RECOVER_STEP {
+	LCD_ESD_RECOVER_NONE = 0,
+	LCD_ESD_RECOVER_POWER_OFF,
+	LCD_ESD_RECOVER_POWER_ON,
+};
+
+enum LCD_REFRESH_DIRECTION {
+	LCD_REFRESH_LEFT_TOP = 0,
+	LCD_REFRESH_RIGHT_TOP,
+	LCD_REFRESH_LEFT_BOTTOM,
+	LCD_REFRESH_RIGHT_BOTTOM,
+};
+
+enum IFBC_TYPE {
+	IFBC_TYPE_NONE = 0,
+	IFBC_TYPE_ORISE2X,
+	IFBC_TYPE_ORISE3X,
+	IFBC_TYPE_HIMAX2X,
+	IFBC_TYPE_RSP2X,
+	IFBC_TYPE_RSP3X,
+	IFBC_TYPE_VESA2X_SINGLE,
+	IFBC_TYPE_VESA3X_SINGLE,
+	IFBC_TYPE_VESA2X_DUAL,
+	IFBC_TYPE_VESA3X_DUAL,
+
+	IFBC_TYPE_MAX
+};
+
+enum IFBC_COMP_MODE {
+	IFBC_COMP_MODE_0 = 0,
+	IFBC_COMP_MODE_1,
+	IFBC_COMP_MODE_2,
+	IFBC_COMP_MODE_3,
+	IFBC_COMP_MODE_4,
+	IFBC_COMP_MODE_5,
+	IFBC_COMP_MODE_6,
+};
+
+enum XRES_DIV {
+	XRES_DIV_1 = 1,
+	XRES_DIV_2,
+	XRES_DIV_3,
+	XRES_DIV_4,
+	XRES_DIV_5,
+	XRES_DIV_6,
+};
+
+enum YRES_DIV {
+	YRES_DIV_1 = 1,
+	YRES_DIV_2,
+	YRES_DIV_3,
+	YRES_DIV_4,
+	YRES_DIV_5,
+	YRES_DIV_6,
+};
+
+enum PXL0_DIVCFG {
+	PXL0_DIVCFG_0 = 0,
+	PXL0_DIVCFG_1,
+	PXL0_DIVCFG_2,
+	PXL0_DIVCFG_3,
+	PXL0_DIVCFG_4,
+	PXL0_DIVCFG_5,
+	PXL0_DIVCFG_6,
+	PXL0_DIVCFG_7,
+};
+
+enum PXL0_DIV2_GT_EN {
+	PXL0_DIV2_GT_EN_CLOSE = 0,
+	PXL0_DIV2_GT_EN_OPEN,
+};
+
+enum PXL0_DIV4_GT_EN {
+	PXL0_DIV4_GT_EN_CLOSE = 0,
+	PXL0_DIV4_GT_EN_OPEN,
+};
+
+enum PXL0_DSI_GT_EN {
+	PXL0_DSI_GT_EN_0 = 0,
+	PXL0_DSI_GT_EN_1,
+	PXL0_DSI_GT_EN_2,
+	PXL0_DSI_GT_EN_3,
+};
+
+enum VSYNC_CTRL_TYPE {
+	VSYNC_CTRL_NONE = 0x0,
+	VSYNC_CTRL_ISR_OFF = BIT(0),
+	VSYNC_CTRL_MIPI_ULPS = BIT(1),
+	VSYNC_CTRL_CLK_OFF = BIT(2),
+	VSYNC_CTRL_VCC_OFF = BIT(3),
+};
+
+enum PERI_VOLTAGE_VALUE {
+	PERI_VOLTAGE_07V = 0x0,
+	PERI_VOLTAGE_08V = 0x2,
+};
+
+#define MIPI_DSI_BIT_CLK_STR1	"00001"
+#define MIPI_DSI_BIT_CLK_STR2	"00010"
+#define MIPI_DSI_BIT_CLK_STR3	"00100"
+#define MIPI_DSI_BIT_CLK_STR4	"01000"
+#define MIPI_DSI_BIT_CLK_STR5	"10000"
+
+/* resource desc */
+struct resource_desc {
+	uint32_t flag;
+	char *name;
+	uint32_t *value;
+};
+
+/* dtype for vcc */
+enum {
+	DTYPE_VCC_GET,
+	DTYPE_VCC_PUT,
+	DTYPE_VCC_ENABLE,
+	DTYPE_VCC_DISABLE,
+	DTYPE_VCC_SET_VOLTAGE,
+};
+
+/* vcc desc */
+struct vcc_desc {
+	int dtype;
+	char *id;
+	struct regulator **regulator;
+	int min_uV;
+	int max_uV;
+	int waittype;
+	int wait;
+};
+
+/* pinctrl operation */
+enum {
+	DTYPE_PINCTRL_GET,
+	DTYPE_PINCTRL_STATE_GET,
+	DTYPE_PINCTRL_SET,
+	DTYPE_PINCTRL_PUT,
+};
+
+/* pinctrl state */
+enum {
+	DTYPE_PINCTRL_STATE_DEFAULT,
+	DTYPE_PINCTRL_STATE_IDLE,
+};
+
+/* pinctrl data */
+struct pinctrl_data {
+	struct pinctrl *p;
+	struct pinctrl_state *pinctrl_def;
+	struct pinctrl_state *pinctrl_idle;
+};
+struct pinctrl_cmd_desc {
+	int dtype;
+	struct pinctrl_data *pctrl_data;
+	int mode;
+};
+
+/* dtype for gpio */
+enum {
+	DTYPE_GPIO_REQUEST,
+	DTYPE_GPIO_FREE,
+	DTYPE_GPIO_INPUT,
+	DTYPE_GPIO_OUTPUT,
+};
+
+/* gpio desc */
+struct gpio_desc {
+	int dtype;
+	int waittype;
+	int wait;
+	char *label;
+	uint32_t *gpio;
+	int value;
+};
+
+struct spi_cmd_desc {
+	int reg_len;
+	char *reg;
+	int val_len;
+	char *val;
+	int waittype;
+	int wait;
+};
+
+enum {
+	IFBC_ORISE_CTL_8LINE = 0,
+	IFBC_ORISE_CTL_16LINE,
+	IFBC_ORISE_CTL_32LINE,
+	IFBC_ORISE_CTL_FRAME,
+};
+
+typedef struct mipi_ifbc_division {
+	uint32_t xres_div;
+	uint32_t yres_div;
+	uint32_t comp_mode;
+	uint32_t pxl0_div2_gt_en;
+	uint32_t pxl0_div4_gt_en;
+	uint32_t pxl0_divxcfg;
+	uint32_t pxl0_dsi_gt_en;
+} mipi_ifbc_division_t;
+
+struct ldi_panel_info {
+	uint32_t h_back_porch;
+	uint32_t h_front_porch;
+	uint32_t h_pulse_width;
+
+	/*
+	 ** note: vbp > 8 if used overlay compose,
+	 ** also lcd vbp > 8 in lcd power on sequence
+	 */
+	uint32_t v_back_porch;
+	uint32_t v_front_porch;
+	uint32_t v_pulse_width;
+
+	uint8_t hsync_plr;
+	uint8_t vsync_plr;
+	uint8_t pixelclk_plr;
+	uint8_t data_en_plr;
+
+	/* for cabc */
+	uint8_t dpi0_overlap_size;
+	uint8_t dpi1_overlap_size;
+};
+
+/* DSI PHY configuration */
+struct mipi_dsi_phy_ctrl {
+	uint64_t lane_byte_clk;
+	uint32_t clk_division;
+
+	uint32_t clk_lane_lp2hs_time;
+	uint32_t clk_lane_hs2lp_time;
+	uint32_t data_lane_lp2hs_time;
+	uint32_t data_lane_hs2lp_time;
+	uint32_t clk2data_delay;
+	uint32_t data2clk_delay;
+
+	uint32_t clk_pre_delay;
+	uint32_t clk_post_delay;
+	uint32_t clk_t_lpx;
+	uint32_t clk_t_hs_prepare;
+	uint32_t clk_t_hs_zero;
+	uint32_t clk_t_hs_trial;
+	uint32_t clk_t_wakeup;
+	uint32_t data_pre_delay;
+	uint32_t data_post_delay;
+	uint32_t data_t_lpx;
+	uint32_t data_t_hs_prepare;
+	uint32_t data_t_hs_zero;
+	uint32_t data_t_hs_trial;
+	uint32_t data_t_ta_go;
+	uint32_t data_t_ta_get;
+	uint32_t data_t_wakeup;
+
+	uint32_t phy_stop_wait_time;
+
+	uint32_t rg_vrefsel_vcm;
+	uint32_t rg_hstx_ckg_sel;
+	uint32_t rg_pll_fbd_div5f;
+	uint32_t rg_pll_fbd_div1f;
+	uint32_t rg_pll_fbd_2p;
+	uint32_t rg_pll_enbwt;
+	uint32_t rg_pll_fbd_p;
+	uint32_t rg_pll_fbd_s;
+	uint32_t rg_pll_pre_div1p;
+	uint32_t rg_pll_pre_p;
+	uint32_t rg_pll_vco_750m;
+	uint32_t rg_pll_lpf_rs;
+	uint32_t rg_pll_lpf_cs;
+	uint32_t rg_pll_enswc;
+	uint32_t rg_pll_chp;
+
+
+	uint32_t pll_register_override;
+	uint32_t pll_power_down;
+	uint32_t rg_band_sel;
+	uint32_t rg_phase_gen_en;
+	uint32_t reload_sel;
+	uint32_t rg_pll_cp_p;
+	uint32_t rg_pll_refsel;
+	uint32_t rg_pll_cp;
+	uint32_t load_command;
+};
+
+struct mipi_panel_info {
+	uint8_t dsi_version;
+	uint8_t vc;
+	uint8_t lane_nums;
+	uint8_t lane_nums_select_support;
+	uint8_t color_mode;
+	uint32_t dsi_bit_clk;	/* clock lane(p/n) */
+	uint32_t burst_mode;
+	uint32_t max_tx_esc_clk;
+	uint8_t non_continue_en;
+
+	uint32_t dsi_bit_clk_val1;
+	uint32_t dsi_bit_clk_val2;
+	uint32_t dsi_bit_clk_val3;
+	uint32_t dsi_bit_clk_val4;
+	uint32_t dsi_bit_clk_val5;
+	uint32_t dsi_bit_clk_upt;
+	/*uint32_t dsi_pclk_rate; */
+
+	uint32_t hs_wr_to_time;
+
+	uint32_t clk_post_adjust;
+	uint32_t clk_pre_adjust;
+	uint32_t clk_pre_delay_adjust;
+	uint32_t clk_t_hs_exit_adjust;
+	uint32_t clk_t_hs_trial_adjust;
+	uint32_t clk_t_hs_prepare_adjust;
+	int clk_t_lpx_adjust;
+	uint32_t clk_t_hs_zero_adjust;
+	uint32_t data_post_delay_adjust;
+	int data_t_lpx_adjust;
+	uint32_t data_t_hs_prepare_adjust;
+	uint32_t data_t_hs_zero_adjust;
+	uint32_t data_t_hs_trial_adjust;
+	uint32_t rg_vrefsel_vcm_adjust;
+
+	uint32_t rg_vrefsel_vcm_clk_adjust;
+	uint32_t rg_vrefsel_vcm_data_adjust;
+};
+
+struct sbl_panel_info {
+	uint32_t strength_limit;
+	uint32_t calibration_a;
+	uint32_t calibration_b;
+	uint32_t calibration_c;
+	uint32_t calibration_d;
+	uint32_t t_filter_control;
+	uint32_t backlight_min;
+	uint32_t backlight_max;
+	uint32_t backlight_scale;
+	uint32_t ambient_light_min;
+	uint32_t filter_a;
+	uint32_t filter_b;
+	uint32_t logo_left;
+	uint32_t logo_top;
+	uint32_t variance_intensity_space;
+	uint32_t slope_max;
+	uint32_t slope_min;
+};
+
+typedef struct dss_sharpness_bit {
+	uint32_t sharp_en;
+	uint32_t sharp_mode;
+
+	uint32_t flt0_c0;
+	uint32_t flt0_c1;
+	uint32_t flt0_c2;
+
+	uint32_t flt1_c0;
+	uint32_t flt1_c1;
+	uint32_t flt1_c2;
+
+	uint32_t flt2_c0;
+	uint32_t flt2_c1;
+	uint32_t flt2_c2;
+
+	uint32_t ungain;
+	uint32_t ovgain;
+
+	uint32_t lineamt1;
+	uint32_t linedeten;
+	uint32_t linethd2;
+	uint32_t linethd1;
+
+	uint32_t sharpthd1;
+	uint32_t sharpthd1mul;
+	uint32_t sharpamt1;
+
+	uint32_t edgethd1;
+	uint32_t edgethd1mul;
+	uint32_t edgeamt1;
+} sharp2d_t;
+
+struct dsc_panel_info {
+
+	uint32_t bits_per_pixel;
+	uint32_t block_pred_enable;
+	uint32_t linebuf_depth;
+	uint32_t bits_per_component;
+	uint32_t slice_width;
+	uint32_t slice_height;
+	uint32_t initial_xmit_delay;
+	uint32_t first_line_bpg_offset;
+	uint32_t mux_word_size;
+	uint32_t initial_offset;
+	uint32_t flatness_max_qp;
+	uint32_t flatness_min_qp;
+	uint32_t rc_edge_factor;
+	uint32_t rc_model_size;
+	uint32_t rc_tgt_offset_lo;
+	uint32_t rc_tgt_offset_hi;
+	uint32_t rc_quant_incr_limit1;
+	uint32_t rc_quant_incr_limit0;
+	uint32_t rc_buf_thresh0;
+	uint32_t rc_buf_thresh1;
+	uint32_t rc_buf_thresh2;
+	uint32_t rc_buf_thresh3;
+	uint32_t rc_buf_thresh4;
+	uint32_t rc_buf_thresh5;
+	uint32_t rc_buf_thresh6;
+	uint32_t rc_buf_thresh7;
+	uint32_t rc_buf_thresh8;
+	uint32_t rc_buf_thresh9;
+	uint32_t rc_buf_thresh10;
+	uint32_t rc_buf_thresh11;
+	uint32_t rc_buf_thresh12;
+	uint32_t rc_buf_thresh13;
+	uint32_t range_min_qp0;
+	uint32_t range_max_qp0;
+	uint32_t range_bpg_offset0;
+	uint32_t range_min_qp1;
+	uint32_t range_max_qp1;
+	uint32_t range_bpg_offset1;
+	uint32_t range_min_qp2;
+	uint32_t range_max_qp2;
+	uint32_t range_bpg_offset2;
+	uint32_t range_min_qp3;
+	uint32_t range_max_qp3;
+	uint32_t range_bpg_offset3;
+	uint32_t range_min_qp4;
+	uint32_t range_max_qp4;
+	uint32_t range_bpg_offset4;
+	uint32_t range_min_qp5;
+	uint32_t range_max_qp5;
+	uint32_t range_bpg_offset5;
+	uint32_t range_min_qp6;
+	uint32_t range_max_qp6;
+	uint32_t range_bpg_offset6;
+	uint32_t range_min_qp7;
+	uint32_t range_max_qp7;
+	uint32_t range_bpg_offset7;
+	uint32_t range_min_qp8;
+	uint32_t range_max_qp8;
+	uint32_t range_bpg_offset8;
+	uint32_t range_min_qp9;
+	uint32_t range_max_qp9;
+	uint32_t range_bpg_offset9;
+	uint32_t range_min_qp10;
+	uint32_t range_max_qp10;
+	uint32_t range_bpg_offset10;
+	uint32_t range_min_qp11;
+	uint32_t range_max_qp11;
+	uint32_t range_bpg_offset11;
+	uint32_t range_min_qp12;
+	uint32_t range_max_qp12;
+	uint32_t range_bpg_offset12;
+	uint32_t range_min_qp13;
+	uint32_t range_max_qp13;
+	uint32_t range_bpg_offset13;
+	uint32_t range_min_qp14;
+	uint32_t range_max_qp14;
+	uint32_t range_bpg_offset14;
+};
+
+struct hisi_panel_info {
+	uint32_t type;
+	uint32_t xres;
+	uint32_t yres;
+	uint32_t width;
+	uint32_t height;
+	uint32_t bpp;
+	uint32_t fps;
+	uint32_t fps_updt;
+	uint32_t orientation;
+	uint32_t bgr_fmt;
+	uint32_t bl_set_type;
+	uint32_t bl_min;
+	uint32_t bl_max;
+	uint32_t bl_default;
+	uint32_t blpwm_precision_type;
+	uint32_t blpwm_out_div_value;
+	uint32_t blpwm_input_ena;
+	uint32_t blpwm_in_num;
+	uint32_t blpwm_input_precision;
+	uint32_t bl_ic_ctrl_mode;
+	uint64_t pxl_clk_rate;
+	uint64_t pxl_clk_rate_adjust;
+	uint32_t pxl_clk_rate_div;
+	uint32_t vsync_ctrl_type;
+	uint8_t fake_hdmi;
+	uint8_t reserved[3];
+
+	uint32_t ifbc_type;
+	uint32_t ifbc_cmp_dat_rev0;
+	uint32_t ifbc_cmp_dat_rev1;
+	uint32_t ifbc_auto_sel;
+	uint32_t ifbc_orise_ctl;
+	uint32_t ifbc_orise_ctr;
+
+	uint8_t lcd_init_step;
+	uint8_t lcd_uninit_step;
+	uint8_t lcd_uninit_step_support;
+	uint8_t lcd_refresh_direction_ctrl;
+	uint8_t lcd_adjust_support;
+
+	uint8_t sbl_support;
+	uint8_t color_temperature_support;
+	uint8_t color_temp_rectify_support;
+	uint32_t color_temp_rectify_R;
+	uint32_t color_temp_rectify_G;
+	uint32_t color_temp_rectify_B;
+	uint8_t comform_mode_support;
+	uint8_t cinema_mode_support;
+	uint8_t frc_enable;
+	uint8_t esd_enable;
+	uint8_t esd_skip_mipi_check;
+	uint8_t esd_recover_step;
+	uint8_t dirty_region_updt_support;
+	uint8_t dsi_bit_clk_upt_support;
+	uint8_t fps_updt_support;
+	uint8_t panel_effect_support;
+
+	uint8_t prefix_ce_support;
+	uint8_t prefix_sharpness1D_support;
+	uint8_t prefix_sharpness2D_support;
+	sharp2d_t *sharp2d_table;
+
+	uint8_t gmp_support;
+	uint8_t gamma_support;
+	uint8_t gamma_type;
+	uint8_t xcc_support;
+	uint8_t acm_support;
+	uint8_t acm_ce_support;
+	uint8_t hiace_support;
+	uint8_t dither_support;
+	uint8_t arsr1p_sharpness_support;
+	uint8_t post_scf_support;
+	uint8_t default_gmp_off;
+
+	uint32_t acm_valid_num;
+	uint32_t r0_hh;
+	uint32_t r0_lh;
+	uint32_t r1_hh;
+	uint32_t r1_lh;
+	uint32_t r2_hh;
+	uint32_t r2_lh;
+	uint32_t r3_hh;
+	uint32_t r3_lh;
+	uint32_t r4_hh;
+	uint32_t r4_lh;
+	uint32_t r5_hh;
+	uint32_t r5_lh;
+	uint32_t r6_hh;
+	uint32_t r6_lh;
+
+	uint32_t cinema_acm_valid_num;
+	uint32_t cinema_r0_hh;
+	uint32_t cinema_r0_lh;
+	uint32_t cinema_r1_hh;
+	uint32_t cinema_r1_lh;
+	uint32_t cinema_r2_hh;
+	uint32_t cinema_r2_lh;
+	uint32_t cinema_r3_hh;
+	uint32_t cinema_r3_lh;
+	uint32_t cinema_r4_hh;
+	uint32_t cinema_r4_lh;
+	uint32_t cinema_r5_hh;
+	uint32_t cinema_r5_lh;
+	uint32_t cinema_r6_hh;
+	uint32_t cinema_r6_lh;
+
+	uint32_t *acm_lut_hue_table;
+	uint32_t acm_lut_hue_table_len;
+	uint32_t *acm_lut_value_table;
+	uint32_t acm_lut_value_table_len;
+	uint32_t *acm_lut_sata_table;
+	uint32_t acm_lut_sata_table_len;
+	uint32_t *acm_lut_satr_table;
+	uint32_t acm_lut_satr_table_len;
+
+	uint32_t *cinema_acm_lut_hue_table;
+	uint32_t cinema_acm_lut_hue_table_len;
+	uint32_t *cinema_acm_lut_value_table;
+	uint32_t cinema_acm_lut_value_table_len;
+	uint32_t *cinema_acm_lut_sata_table;
+	uint32_t cinema_acm_lut_sata_table_len;
+	uint32_t *cinema_acm_lut_satr_table;
+	uint32_t cinema_acm_lut_satr_table_len;
+
+	uint32_t *acm_lut_satr0_table;
+	uint32_t acm_lut_satr0_table_len;
+	uint32_t *acm_lut_satr1_table;
+	uint32_t acm_lut_satr1_table_len;
+	uint32_t *acm_lut_satr2_table;
+	uint32_t acm_lut_satr2_table_len;
+	uint32_t *acm_lut_satr3_table;
+	uint32_t acm_lut_satr3_table_len;
+	uint32_t *acm_lut_satr4_table;
+	uint32_t acm_lut_satr4_table_len;
+	uint32_t *acm_lut_satr5_table;
+	uint32_t acm_lut_satr5_table_len;
+	uint32_t *acm_lut_satr6_table;
+	uint32_t acm_lut_satr6_table_len;
+	uint32_t *acm_lut_satr7_table;
+	uint32_t acm_lut_satr7_table_len;
+
+	uint32_t *cinema_acm_lut_satr0_table;
+	uint32_t *cinema_acm_lut_satr1_table;
+	uint32_t *cinema_acm_lut_satr2_table;
+	uint32_t *cinema_acm_lut_satr3_table;
+	uint32_t *cinema_acm_lut_satr4_table;
+	uint32_t *cinema_acm_lut_satr5_table;
+	uint32_t *cinema_acm_lut_satr6_table;
+	uint32_t *cinema_acm_lut_satr7_table;
+
+	uint32_t *gamma_lut_table_R;
+	uint32_t *gamma_lut_table_G;
+	uint32_t *gamma_lut_table_B;
+	uint32_t gamma_lut_table_len;
+	uint32_t *cinema_gamma_lut_table_R;
+	uint32_t *cinema_gamma_lut_table_G;
+	uint32_t *cinema_gamma_lut_table_B;
+	uint32_t cinema_gamma_lut_table_len;
+	uint32_t *igm_lut_table_R;
+	uint32_t *igm_lut_table_G;
+	uint32_t *igm_lut_table_B;
+	uint32_t igm_lut_table_len;
+	uint32_t *gmp_lut_table_low32bit;
+	uint32_t *gmp_lut_table_high4bit;
+	uint32_t gmp_lut_table_len;
+	uint32_t *xcc_table;
+	uint32_t xcc_table_len;
+
+	uint32_t *pgainlsc0;
+	uint32_t *pgainlsc1;
+	uint32_t pgainlsc_len;
+	uint32_t *hcoeff0y;
+	uint32_t *hcoeff1y;
+	uint32_t *hcoeff2y;
+	uint32_t *hcoeff3y;
+	uint32_t *hcoeff4y;
+	uint32_t *hcoeff5y;
+	uint32_t hcoeffy_len;
+	uint32_t *vcoeff0y;
+	uint32_t *vcoeff1y;
+	uint32_t *vcoeff2y;
+	uint32_t *vcoeff3y;
+	uint32_t *vcoeff4y;
+	uint32_t *vcoeff5y;
+	uint32_t vcoeffy_len;
+	uint32_t *hcoeff0uv;
+	uint32_t *hcoeff1uv;
+	uint32_t *hcoeff2uv;
+	uint32_t *hcoeff3uv;
+	uint32_t hcoeffuv_len;
+	uint32_t *vcoeff0uv;
+	uint32_t *vcoeff1uv;
+	uint32_t *vcoeff2uv;
+	uint32_t *vcoeff3uv;
+	uint32_t vcoeffuv_len;
+
+	struct spi_device *spi_dev;
+	struct ldi_panel_info ldi;
+	struct ldi_panel_info ldi_updt;
+	struct ldi_panel_info ldi_lfps;
+	struct mipi_panel_info mipi;
+	struct sbl_panel_info smart_bl;
+	struct dsc_panel_info vesa_dsc;
+	struct lcd_dirty_region_info dirty_region_info;
+
+	struct mipi_dsi_phy_ctrl dsi_phy_ctrl;
+
+	struct hiace_alg_parameter hiace_param;
+	struct ce_algorithm_parameter ce_alg_param;
+};
+
+struct hisi_fb_data_type;
+struct hisi_fb_panel_data {
+	struct hisi_panel_info *panel_info;
+
+	/* function entry chain */
+	int (*on) (struct platform_device *pdev);
+	int (*off) (struct platform_device *pdev);
+	int (*remove) (struct platform_device *pdev);
+	int (*set_backlight) (struct platform_device *pdev, uint32_t bl_level);
+	int (*vsync_ctrl) (struct platform_device *pdev, int enable);
+
+	struct platform_device *next;
+};
+
+/*******************************************************************************
+ ** FUNCTIONS PROTOTYPES
+ */
+#define MIPI_DPHY_NUM	(2)
+
+extern uint32_t g_dts_resouce_ready;
+extern mipi_ifbc_division_t g_mipi_ifbc_division[MIPI_DPHY_NUM][IFBC_TYPE_MAX];
+int resource_cmds_tx(struct platform_device *pdev,
+		     struct resource_desc *cmds, int cnt);
+int vcc_cmds_tx(struct platform_device *pdev, struct vcc_desc *cmds, int cnt);
+int pinctrl_cmds_tx(struct platform_device *pdev, struct pinctrl_cmd_desc *cmds,
+		    int cnt);
+int gpio_cmds_tx(struct gpio_desc *cmds, int cnt);
+extern struct spi_device *g_spi_dev;
+
+int panel_next_on(struct platform_device *pdev);
+int panel_next_off(struct platform_device *pdev);
+int panel_next_remove(struct platform_device *pdev);
+int panel_next_set_backlight(struct platform_device *pdev, uint32_t bl_level);
+int panel_next_vsync_ctrl(struct platform_device *pdev, int enable);
+
+bool is_ldi_panel(struct hisi_fb_data_type *hisifd);
+bool is_mipi_cmd_panel(struct hisi_fb_data_type *hisifd);
+bool is_mipi_cmd_panel_ext(struct hisi_panel_info *pinfo);
+bool is_mipi_video_panel(struct hisi_fb_data_type *hisifd);
+bool is_mipi_panel(struct hisi_fb_data_type *hisifd);
+bool is_dual_mipi_panel(struct hisi_fb_data_type *hisifd);
+bool is_dual_mipi_panel_ext(struct hisi_panel_info *pinfo);
+bool is_ifbc_panel(struct hisi_fb_data_type *hisifd);
+bool is_ifbc_vesa_panel(struct hisi_fb_data_type *hisifd);
+bool mipi_panel_check_reg(struct hisi_fb_data_type *hisifd,
+			  uint32_t *read_value);
+int mipi_ifbc_get_rect(struct hisi_fb_data_type *hisifd, struct dss_rect *rect);
+bool is_hisi_writeback_panel(struct hisi_fb_data_type *hisifd);
+void hisi_fb_device_set_status0(uint32_t status);
+int hisi_fb_device_set_status1(struct hisi_fb_data_type *hisifd);
+bool hisi_fb_device_probe_defer(uint32_t panel_type, uint32_t bl_type);
+#endif				/* HISI_FB_PANEL_H */
-- 
2.12.0-rc0

