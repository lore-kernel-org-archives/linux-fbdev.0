From: cailiwei <cailiwei@hisilicon.com>
Date: Tue, 07 Feb 2017 02:35:57 +0000
Subject: [PATCH 6/8] fb: hisilicon: Add framebuffer driver for hi3660 SoC
Message-Id: <20170207023559.79455-6-cailiwei@hisilicon.com>
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
 drivers/video/fbdev/hisi/dss/hisi_fb_utils.c       |  249 ++++
 drivers/video/fbdev/hisi/dss/hisi_fb_vsync.c       |  680 +++++++++
 drivers/video/fbdev/hisi/dss/hisi_mipi_dsi_host.c  |  401 ++++++
 .../fbdev/hisi/dss/hisi_overlay_cmdlist_utils.c    | 1450 ++++++++++++++++++++
 .../fbdev/hisi/dss/hisi_overlay_cmdlist_utils.h    |  249 ++++
 5 files changed, 3029 insertions(+)
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_utils.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_fb_vsync.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_mipi_dsi_host.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.c
 create mode 100755 drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.h

diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_utils.c b/drivers/video/fbdev/hisi/dss/hisi_fb_utils.c
new file mode 100755
index 000000000000..3c7965716890
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_utils.c
@@ -0,0 +1,249 @@
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
+#if defined (CONFIG_HISI_PERIDVFS)
+#include "peri_volt_poll.h"
+#endif
+
+#define MAX_BUF 60
+void set_reg(char __iomem *addr, uint32_t val, uint8_t bw, uint8_t bs)
+{
+	uint32_t mask = (1UL << bw) - 1UL;
+	uint32_t tmp = 0;
+
+	tmp = inp32(addr);
+	tmp &= ~(mask << bs);
+
+	outp32(addr, tmp | ((val & mask) << bs));
+
+	if (g_debug_set_reg_val) {
+		HISI_FB_INFO("writel: [%p] = 0x%x\n", addr,
+			     tmp | ((val & mask) << bs));
+	}
+}
+
+uint32_t set_bits32(uint32_t old_val, uint32_t val, uint8_t bw, uint8_t bs)
+{
+	uint32_t mask = (1UL << bw) - 1UL;
+	uint32_t tmp = 0;
+
+	tmp = old_val;
+	tmp &= ~(mask << bs);
+
+	return (tmp | ((val & mask) << bs));
+}
+
+void hisifb_set_reg(struct hisi_fb_data_type *hisifd,
+		    char __iomem *addr, uint32_t val, uint8_t bw, uint8_t bs)
+{
+	set_reg(addr, val, bw, bs);
+}
+
+bool is_dss_idle_enable(void)
+{
+	return ((g_enable_dss_idle = 1) ? true : false);
+}
+
+uint32_t get_panel_xres(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	return ((hisifd->resolution_rect.w >
+		 0) ? hisifd->resolution_rect.w : hisifd->panel_info.xres);
+}
+
+uint32_t get_panel_yres(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	return ((hisifd->resolution_rect.h >
+		 0) ? hisifd->resolution_rect.h : hisifd->panel_info.yres);
+}
+
+uint32_t hisifb_line_length(int index, uint32_t xres, int bpp)
+{
+	return ALIGN_UP(xres * bpp, DMA_STRIDE_ALIGN);
+}
+
+void hisifb_get_timestamp(struct timeval *tv)
+{
+	struct timespec ts;
+
+	ktime_get_ts(&ts);
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+}
+
+uint32_t hisifb_timestamp_diff(struct timeval *lasttime,
+			       struct timeval *curtime)
+{
+	uint32_t ret;
+	ret = (curtime->tv_usec >= lasttime->tv_usec) ?
+	    curtime->tv_usec - lasttime->tv_usec :
+	    1000000 - (lasttime->tv_usec - curtime->tv_usec);
+
+	return ret;
+}
+
+void hisifb_save_file(char *filename, char *buf, uint32_t buf_len)
+{
+	ssize_t write_len = 0;
+	struct file *fd = NULL;
+	mm_segment_t old_fs;
+	loff_t pos = 0;
+
+	BUG_ON(filename = NULL);
+	BUG_ON(buf = NULL);
+
+	fd = filp_open(filename, O_CREAT | O_RDWR, 0644);
+	if (IS_ERR(fd)) {
+		HISI_FB_ERR("filp_open returned:filename %s, error %ld\n",
+			    filename, PTR_ERR(fd));
+		return;
+	}
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	write_len = vfs_write(fd, (char __user *)buf, buf_len, &pos);
+
+	pos = 0;
+	set_fs(old_fs);
+	filp_close(fd, NULL);
+}
+
+int hisifb_ctrl_on(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+	int ret = 0;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	if (pdata->on) {
+		ret = pdata->on(hisifd->pdev);
+	}
+
+	hisifb_vsync_resume(hisifd);
+	hisi_overlay_on(hisifd, false);
+
+	if (hisifd->panel_info.esd_enable) {
+		hrtimer_start(&hisifd->esd_ctrl.esd_hrtimer,
+			      ktime_set(ESD_CHECK_TIME_PERIOD / 1000,
+					(ESD_CHECK_TIME_PERIOD % 1000) *
+					1000000), HRTIMER_MODE_REL);
+	}
+
+	return ret;
+}
+
+int hisifb_ctrl_off(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+	int ret = 0;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	if (hisifd->panel_info.esd_enable) {
+		hrtimer_cancel(&hisifd->esd_ctrl.esd_hrtimer);
+	}
+
+	hisifb_vsync_suspend(hisifd);
+	hisi_overlay_off(hisifd);
+
+	if (pdata->off) {
+		ret = pdata->off(hisifd->pdev);
+	}
+
+	if ((hisifd->index = PRIMARY_PANEL_IDX) ||
+	    (hisifd->index = EXTERNAL_PANEL_IDX)) {
+
+		hisifb_layerbuf_unlock(hisifd,
+				       &(hisifd->buf_sync_ctrl.layerbuf_list));
+	}
+
+	return ret;
+}
+
+int hisifb_ctrl_dss_clk_rate_set(struct fb_info *info, void __user *argp)
+{
+	int ret = 0;
+	struct hisi_fb_data_type *hisifd = NULL;
+	dss_clk_rate_t dss_clk_rate;
+
+	if (NULL = info) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	hisifd = (struct hisi_fb_data_type *)info->par;
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	if (hisifd->index != PRIMARY_PANEL_IDX) {
+		HISI_FB_ERR("fb%d, not supported!\n", hisifd->index);
+		return -EINVAL;
+	}
+
+	if (NULL = argp) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	if (hisifd->core_clk_upt_support = 0) {
+		HISI_FB_DEBUG("no support core_clk_upt\n");
+		return ret;
+	}
+
+	ret = copy_from_user(&dss_clk_rate, argp, sizeof(dss_clk_rate_t));
+	if (ret) {
+		HISI_FB_ERR("copy_from_user failed!ret=%d.", ret);
+		return ret;
+	}
+
+	down(&hisifd->blank_sem);
+
+	if (!hisifd->panel_power_on) {
+		HISI_FB_DEBUG("fb%d, panel power off!\n", hisifd->index);
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	ret = set_dss_clk_rate(hisifd, dss_clk_rate);
+
+ err_out:
+	up(&hisifd->blank_sem);
+
+	return ret;
+}
+
+/*lint +e665, +e514, +e84, +e886, +e846, +e778*/
+void hisifb_sysfs_attrs_add(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	if (hisifd->sysfs_attrs_append_fnc) {
+		/* hisifd->sysfs_attrs_append_fnc(hisifd, &dev_attr_lcd_model.attr); */
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_fb_vsync.c b/drivers/video/fbdev/hisi/dss/hisi_fb_vsync.c
new file mode 100755
index 000000000000..3778ac0b4b2c
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_fb_vsync.c
@@ -0,0 +1,680 @@
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
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat"
+#include "hisi_fb.h"
+
+/*
+ ** /sys/class/graphics/fb0/vsync_event
+ */
+#if defined(CONFIG_HISI_FB_VSYNC_THREAD)
+#define VSYNC_TIMEOUT_MSEC (100)
+#endif
+#define VSYNC_CTRL_EXPIRE_COUNT	(4)
+
+#ifdef CONFIG_REPORT_VSYNC
+extern void mali_kbase_pm_report_vsync(int);
+#endif
+extern int mipi_dsi_ulps_cfg(struct hisi_fb_data_type *hisifd, int enable);
+extern bool hisi_dss_check_reg_reload_status(struct hisi_fb_data_type *hisifd);
+
+void hisifb_frame_updated(struct hisi_fb_data_type *hisifd)
+{
+	BUG_ON(hisifd = NULL);
+
+	if (hisifd->vsync_ctrl.vsync_report_fnc) {
+		atomic_inc(&(hisifd->vsync_ctrl.buffer_updated));
+	}
+}
+
+void hisifb_vsync_isr_handler(struct hisi_fb_data_type *hisifd)
+{
+	struct hisifb_vsync *vsync_ctrl = NULL;
+	struct hisi_fb_panel_data *pdata = NULL;
+	int buffer_updated = 0;
+	ktime_t pre_vsync_timestamp;
+
+	BUG_ON(hisifd = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	pre_vsync_timestamp = vsync_ctrl->vsync_timestamp;
+	vsync_ctrl->vsync_timestamp = ktime_get();
+	wake_up_interruptible_all(&(vsync_ctrl->vsync_wait));
+
+	if (hisifd->panel_info.vsync_ctrl_type != VSYNC_CTRL_NONE) {
+		spin_lock(&vsync_ctrl->spin_lock);
+		if (vsync_ctrl->vsync_ctrl_expire_count) {
+			vsync_ctrl->vsync_ctrl_expire_count--;
+			if (vsync_ctrl->vsync_ctrl_expire_count = 0)
+				schedule_work(&vsync_ctrl->vsync_ctrl_work);
+		}
+		spin_unlock(&vsync_ctrl->spin_lock);
+	}
+
+	if (vsync_ctrl->vsync_report_fnc) {
+		if (hisifd->vsync_ctrl.vsync_enabled) {
+			buffer_updated +			    atomic_dec_return(&(vsync_ctrl->buffer_updated));
+		} else {
+			buffer_updated = 1;
+		}
+
+		if (buffer_updated < 0) {
+			atomic_cmpxchg(&(vsync_ctrl->buffer_updated),
+				       buffer_updated, 1);
+		} else {
+			vsync_ctrl->vsync_report_fnc(buffer_updated);
+		}
+	}
+
+	if (g_debug_online_vsync) {
+		HISI_FB_INFO("fb%d, VSYNC=%llu, time_diff=%llu.\n",
+			     hisifd->index,
+			     ktime_to_ns(hisifd->vsync_ctrl.vsync_timestamp),
+			     (ktime_to_ns(hisifd->vsync_ctrl.vsync_timestamp) -
+			      ktime_to_ns(pre_vsync_timestamp)));
+	}
+}
+
+static int vsync_timestamp_changed(struct hisi_fb_data_type *hisifd,
+				   ktime_t prev_timestamp)
+{
+	BUG_ON(hisifd = NULL);
+	return !ktime_equal(prev_timestamp, hisifd->vsync_ctrl.vsync_timestamp);
+}
+
+#if defined(CONFIG_HISI_FB_VSYNC_THREAD)
+static int wait_for_vsync_thread(void *data)
+{
+	struct hisi_fb_data_type *hisifd = (struct hisi_fb_data_type *)data;
+	ktime_t prev_timestamp;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		prev_timestamp = hisifd->vsync_ctrl.vsync_timestamp;
+		ret +		    wait_event_interruptible_timeout(hisifd->vsync_ctrl.
+						     vsync_wait,
+						     vsync_timestamp_changed
+						     (hisifd, prev_timestamp)
+						     && hisifd->vsync_ctrl.
+						     vsync_enabled,
+						     msecs_to_jiffies
+						     (VSYNC_TIMEOUT_MSEC));
+
+		/*if (ret = 0) {
+		   HISI_FB_ERR("wait vsync timeout!");
+		   return -ETIMEDOUT;
+		   }
+		*/
+
+		if (ret > 0) {
+			char *envp[2];
+			char buf[64];
+			/* fb%d_VSYNC=%llu */
+			snprintf(buf, sizeof(buf), "VSYNC=%llu",
+				 ktime_to_ns(hisifd->vsync_ctrl.
+					     vsync_timestamp));
+			envp[0] = buf;
+			envp[1] = NULL;
+			kobject_uevent_env(&hisifd->pdev->dev.kobj, KOBJ_CHANGE,
+					   envp);
+		}
+	}
+
+	return 0;
+}
+#else
+static ssize_t vsync_show_event(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t ret = -1;
+	int vsync_flag = 0;
+	struct fb_info *fbi = NULL;
+	struct hisi_fb_data_type *hisifd = NULL;
+	ktime_t prev_timestamp;
+
+	if (NULL = dev) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	fbi = dev_get_drvdata(dev);
+	if (NULL = fbi) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	hisifd = (struct hisi_fb_data_type *)fbi->par;
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	if (NULL = buf) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	prev_timestamp = hisifd->vsync_ctrl.vsync_timestamp;
+
+	/*lint -e666 */
+	ret = wait_event_interruptible(hisifd->vsync_ctrl.vsync_wait,
+				       (vsync_timestamp_changed
+					(hisifd, prev_timestamp)
+					&& hisifd->vsync_ctrl.vsync_enabled));
+	/*lint +e666 */
+	vsync_flag = (vsync_timestamp_changed(hisifd, prev_timestamp) &&
+		      hisifd->vsync_ctrl.vsync_enabled);
+
+	if (vsync_flag) {
+		ret = snprintf(buf, PAGE_SIZE, "VSYNC=%llu, xxxxxxEvent=x \n",
+			       ktime_to_ns(hisifd->vsync_ctrl.vsync_timestamp));
+		buf[strlen(buf) + 1] = '\0';
+
+	} else {
+		return -1;
+	}
+
+	return ret;
+}
+
+static ssize_t vsync_timestamp_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	ssize_t ret = -1;
+	struct fb_info *fbi = NULL;
+	struct hisi_fb_data_type *hisifd = NULL;
+
+	if (NULL = dev) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	fbi = dev_get_drvdata(dev);
+	if (NULL = fbi) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	hisifd = (struct hisi_fb_data_type *)fbi->par;
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	if (NULL = buf) {
+		HISI_FB_ERR("NULL Pointer.\n");
+		return -1;
+	}
+
+	ret = snprintf(buf, PAGE_SIZE, "%llu \n",
+		       ktime_to_ns(hisifd->vsync_ctrl.vsync_timestamp));
+	buf[strlen(buf) + 1] = '\0';
+
+	return ret;
+}
+
+static DEVICE_ATTR(vsync_event, S_IRUGO, vsync_show_event, NULL);
+static DEVICE_ATTR(vsync_timestamp, S_IRUGO, vsync_timestamp_show, NULL);
+#endif
+
+#ifdef CONFIG_FAKE_VSYNC_USED
+enum hrtimer_restart hisifb_fake_vsync(struct hrtimer *timer)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	int fps = 60;
+
+	hisifd +	    container_of(timer, struct hisi_fb_data_type, fake_vsync_hrtimer);
+	BUG_ON(hisifd = NULL);
+
+	if (!hisifd->panel_power_on)
+		goto error;
+
+	if (hisifd->fake_vsync_used && hisifd->vsync_ctrl.vsync_enabled) {
+		hisifd->vsync_ctrl.vsync_timestamp = ktime_get();
+		wake_up_interruptible_all(&hisifd->vsync_ctrl.vsync_wait);
+	}
+
+ error:
+	hrtimer_start(&hisifd->fake_vsync_hrtimer,
+		      ktime_set(0, NSEC_PER_SEC / fps), HRTIMER_MODE_REL);
+
+	return HRTIMER_NORESTART;
+}
+#endif
+
+static void hisifb_vsync_ctrl_workqueue_handler(struct work_struct *work)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+	struct hisi_fb_panel_data *pdata = NULL;
+	unsigned long flags = 0;
+
+	vsync_ctrl = container_of(work, typeof(*vsync_ctrl), vsync_ctrl_work);
+	BUG_ON(vsync_ctrl = NULL);
+	hisifd = vsync_ctrl->hisifd;
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+
+	down(&(hisifd->blank_sem));
+
+	if (!hisifd->panel_power_on) {
+		HISI_FB_INFO("fb%d, panel is power off!", hisifd->index);
+		up(&(hisifd->blank_sem));
+		return;
+	}
+
+	mutex_lock(&(vsync_ctrl->vsync_lock));
+	if (vsync_ctrl->vsync_ctrl_disabled_set &&
+	    (vsync_ctrl->vsync_ctrl_expire_count = 0) &&
+	    vsync_ctrl->vsync_ctrl_enabled &&
+	    !vsync_ctrl->vsync_enabled
+	    && !vsync_ctrl->vsync_ctrl_offline_enabled) {
+		HISI_FB_DEBUG("fb%d, dss clk off!\n", hisifd->index);
+
+		spin_lock_irqsave(&(vsync_ctrl->spin_lock), flags);
+		if (pdata->vsync_ctrl) {
+			pdata->vsync_ctrl(hisifd->pdev, 0);
+		} else {
+			HISI_FB_ERR("fb%d, vsync_ctrl not supported!\n",
+				    hisifd->index);
+		}
+		vsync_ctrl->vsync_ctrl_enabled = 0;
+		vsync_ctrl->vsync_ctrl_disabled_set = 0;
+		spin_unlock_irqrestore(&(vsync_ctrl->spin_lock), flags);
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_MIPI_ULPS) {
+			mipi_dsi_ulps_cfg(hisifd, 0);
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_VCC_OFF) {
+			if (hisifd->lp_fnc)
+				hisifd->lp_fnc(hisifd, true);
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_CLK_OFF) {
+			dpe_inner_clk_disable(hisifd);
+			dpe_common_clk_disable(hisifd);
+			mipi_dsi_clk_disable(hisifd);
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_VCC_OFF) {
+			/* dpe_regulator_disable(hisifd); */
+		}
+	}
+	mutex_unlock(&(vsync_ctrl->vsync_lock));
+
+	if (vsync_ctrl->vsync_report_fnc) {
+		vsync_ctrl->vsync_report_fnc(1);
+	}
+
+	up(&(hisifd->blank_sem));
+}
+
+void hisifb_vsync_register(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+#if defined(CONFIG_HISI_FB_VSYNC_THREAD)
+	char name[64] = { 0 };
+#endif
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	if (vsync_ctrl->vsync_created)
+		return;
+
+	vsync_ctrl->hisifd = hisifd;
+	vsync_ctrl->vsync_infinite = 0;
+	vsync_ctrl->vsync_enabled = 0;
+	vsync_ctrl->vsync_ctrl_offline_enabled = 0;
+	vsync_ctrl->vsync_timestamp = ktime_get();
+	init_waitqueue_head(&(vsync_ctrl->vsync_wait));
+	spin_lock_init(&(vsync_ctrl->spin_lock));
+	INIT_WORK(&vsync_ctrl->vsync_ctrl_work,
+		  hisifb_vsync_ctrl_workqueue_handler);
+
+	mutex_init(&(vsync_ctrl->vsync_lock));
+
+	atomic_set(&(vsync_ctrl->buffer_updated), 1);
+#ifdef CONFIG_REPORT_VSYNC
+	vsync_ctrl->vsync_report_fnc = mali_kbase_pm_report_vsync;
+#else
+	vsync_ctrl->vsync_report_fnc = NULL;
+#endif
+
+#ifdef CONFIG_FAKE_VSYNC_USED
+	/* hrtimer for fake vsync timing */
+	hisifd->fake_vsync_used = false;
+	hrtimer_init(&hisifd->fake_vsync_hrtimer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	hisifd->fake_vsync_hrtimer.function = hisifb_fake_vsync;
+	hrtimer_start(&hisifd->fake_vsync_hrtimer,
+		      ktime_set(0, NSEC_PER_SEC / 60), HRTIMER_MODE_REL);
+#endif
+
+#if defined(CONFIG_HISI_FB_VSYNC_THREAD)
+	snprintf(name, sizeof(name), "hisifb%d_vsync", hisifd->index);
+	vsync_ctrl->vsync_thread +	    kthread_run(wait_for_vsync_thread, hisifd, name);
+	if (IS_ERR(vsync_ctrl->vsync_thread)) {
+		vsync_ctrl->vsync_thread = NULL;
+		HISI_FB_ERR("failed to run vsync thread!\n");
+		return;
+	}
+#else
+	if (hisifd->sysfs_attrs_append_fnc) {
+		hisifd->sysfs_attrs_append_fnc(hisifd,
+					       &dev_attr_vsync_event.attr);
+		hisifd->sysfs_attrs_append_fnc(hisifd,
+					       &dev_attr_vsync_timestamp.attr);
+	}
+#endif
+
+	vsync_ctrl->vsync_created = 1;
+}
+
+void hisifb_vsync_unregister(struct platform_device *pdev)
+{
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+
+	BUG_ON(pdev = NULL);
+	hisifd = platform_get_drvdata(pdev);
+	BUG_ON(hisifd = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	if (!vsync_ctrl->vsync_created)
+		return;
+
+#ifdef CONFIG_FAKE_VSYNC_USED
+	hisifd->fake_vsync_used = false;
+	hrtimer_cancel(&hisifd->fake_vsync_hrtimer);
+#endif
+
+#if defined(CONFIG_HISI_FB_VSYNC_THREAD)
+	if (vsync_ctrl->vsync_thread)
+		kthread_stop(vsync_ctrl->vsync_thread);
+#endif
+
+	vsync_ctrl->vsync_created = 0;
+}
+
+void hisifb_set_vsync_activate_state(struct hisi_fb_data_type *hisifd,
+				     bool infinite)
+{
+	struct hisifb_vsync *vsync_ctrl = NULL;
+
+	BUG_ON(hisifd = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	if (hisifd->panel_info.vsync_ctrl_type = VSYNC_CTRL_NONE)
+		return;
+
+	mutex_lock(&(vsync_ctrl->vsync_lock));
+
+	if (infinite) {
+		vsync_ctrl->vsync_infinite_count += 1;
+	} else {
+		vsync_ctrl->vsync_infinite_count -= 1;
+	}
+
+	if (vsync_ctrl->vsync_infinite_count >= 1) {
+		vsync_ctrl->vsync_infinite = 1;
+	}
+
+	if (vsync_ctrl->vsync_infinite_count = 0) {
+		vsync_ctrl->vsync_infinite = 0;
+	}
+
+	mutex_unlock(&(vsync_ctrl->vsync_lock));
+}
+
+void hisifb_activate_vsync(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+	unsigned long flags = 0;
+	int clk_enabled = 0;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	if (hisifd->panel_info.vsync_ctrl_type = VSYNC_CTRL_NONE)
+		return;
+
+	mutex_lock(&(vsync_ctrl->vsync_lock));
+
+	if (vsync_ctrl->vsync_ctrl_enabled = 0) {
+		HISI_FB_DEBUG("fb%d, dss clk on!\n", hisifd->index);
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_VCC_OFF) {
+			/* dpe_regulator_enable(hisifd); */
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_CLK_OFF) {
+			mipi_dsi_clk_enable(hisifd);
+			dpe_common_clk_enable(hisifd);
+			dpe_inner_clk_enable(hisifd);
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_VCC_OFF) {
+			if (hisifd->lp_fnc)
+				hisifd->lp_fnc(hisifd, false);
+		}
+
+		if (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_MIPI_ULPS) {
+			mipi_dsi_ulps_cfg(hisifd, 1);
+		}
+
+		vsync_ctrl->vsync_ctrl_enabled = 1;
+		clk_enabled = 1;
+	} else if (vsync_ctrl->vsync_ctrl_isr_enabled) {
+		clk_enabled = 1;
+		vsync_ctrl->vsync_ctrl_isr_enabled = 0;
+	} else {
+		;
+	}
+
+	spin_lock_irqsave(&(vsync_ctrl->spin_lock), flags);
+	vsync_ctrl->vsync_ctrl_disabled_set = 0;
+	vsync_ctrl->vsync_ctrl_expire_count = 0;
+	if (clk_enabled) {
+		if (pdata->vsync_ctrl) {
+			pdata->vsync_ctrl(hisifd->pdev, 1);
+		} else {
+			HISI_FB_ERR("fb%d, vsync_ctrl not supported!\n",
+				    hisifd->index);
+		}
+	}
+	spin_unlock_irqrestore(&(vsync_ctrl->spin_lock), flags);
+
+	mutex_unlock(&(vsync_ctrl->vsync_lock));
+}
+
+void hisifb_deactivate_vsync(struct hisi_fb_data_type *hisifd)
+{
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+	unsigned long flags = 0;
+
+	BUG_ON(hisifd = NULL);
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	BUG_ON(pdata = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	if (hisifd->panel_info.vsync_ctrl_type = VSYNC_CTRL_NONE)
+		return;
+
+	mutex_lock(&(vsync_ctrl->vsync_lock));
+
+	spin_lock_irqsave(&(vsync_ctrl->spin_lock), flags);
+	if (vsync_ctrl->vsync_infinite = 0)
+		vsync_ctrl->vsync_ctrl_disabled_set = 1;
+
+	if (vsync_ctrl->vsync_ctrl_enabled)
+		vsync_ctrl->vsync_ctrl_expire_count = VSYNC_CTRL_EXPIRE_COUNT;
+	spin_unlock_irqrestore(&(vsync_ctrl->spin_lock), flags);
+
+	mutex_unlock(&(vsync_ctrl->vsync_lock));
+}
+
+int hisifb_vsync_ctrl(struct fb_info *info, void __user *argp)
+{
+	int ret = 0;
+	struct hisi_fb_data_type *hisifd = NULL;
+	struct hisi_fb_panel_data *pdata = NULL;
+	struct hisifb_vsync *vsync_ctrl = NULL;
+	int enable = 0;
+
+	if (NULL = info) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	hisifd = (struct hisi_fb_data_type *)info->par;
+	if (NULL = hisifd) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	if (hisifd->index != PRIMARY_PANEL_IDX) {
+		HISI_FB_ERR("fb%d, not supported!\n", hisifd->index);
+		return -EINVAL;
+	}
+
+	pdata = dev_get_platdata(&hisifd->pdev->dev);
+	if (NULL = pdata) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	if (NULL = vsync_ctrl) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	if (NULL = argp) {
+		HISI_FB_ERR("NULL Pointer!\n");
+		return -EINVAL;
+	}
+
+	ret = copy_from_user(&enable, argp, sizeof(enable));
+	if (ret) {
+		HISI_FB_ERR("hisifb_vsync_ctrl ioctl failed!\n");
+		return ret;
+	}
+
+	enable = (enable) ? 1 : 0;
+
+	mutex_lock(&(vsync_ctrl->vsync_lock));
+
+	if (vsync_ctrl->vsync_enabled = enable) {
+		mutex_unlock(&(vsync_ctrl->vsync_lock));
+		return 0;
+	}
+
+	if (g_debug_online_vsync)
+		HISI_FB_INFO("fb%d, enable=%d!\n", hisifd->index, enable);
+
+	vsync_ctrl->vsync_enabled = enable;
+
+	mutex_unlock(&(vsync_ctrl->vsync_lock));
+
+	down(&hisifd->blank_sem);
+
+	if (!hisifd->panel_power_on) {
+		HISI_FB_INFO("fb%d, panel is power off!", hisifd->index);
+		up(&hisifd->blank_sem);
+		return 0;
+	}
+
+	if (enable) {
+		hisifb_activate_vsync(hisifd);
+	} else {
+		hisifb_deactivate_vsync(hisifd);
+	}
+
+	up(&hisifd->blank_sem);
+
+	return 0;
+}
+
+int hisifb_vsync_resume(struct hisi_fb_data_type *hisifd)
+{
+	struct hisifb_vsync *vsync_ctrl = NULL;
+
+	BUG_ON(hisifd = NULL);
+	vsync_ctrl = &(hisifd->vsync_ctrl);
+	BUG_ON(vsync_ctrl = NULL);
+
+	vsync_ctrl->vsync_enabled = 0;
+	vsync_ctrl->vsync_ctrl_expire_count = 0;
+	vsync_ctrl->vsync_ctrl_disabled_set = 0;
+	vsync_ctrl->vsync_ctrl_enabled = 1;
+	vsync_ctrl->vsync_ctrl_isr_enabled = 1;
+
+	atomic_set(&(vsync_ctrl->buffer_updated), 1);
+
+#if 0
+	if (hisifd->panel_info.vsync_ctrl_type != VSYNC_CTRL_NONE) {
+		if ((hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_MIPI_ULPS)
+		    || (hisifd->panel_info.vsync_ctrl_type & VSYNC_CTRL_CLK_OFF)
+		    || (hisifd->panel_info.
+			vsync_ctrl_type & VSYNC_CTRL_VCC_OFF)) {
+
+			if (hisifd->panel_info.
+			    vsync_ctrl_type & VSYNC_CTRL_MIPI_ULPS) {
+				mipi_dsi_ulps_cfg(hisifd, 0);
+			}
+
+			if (hisifd->panel_info.
+			    vsync_ctrl_type & VSYNC_CTRL_CLK_OFF) {
+				dpe_inner_clk_disable(hisifd);
+				dpe_common_clk_disable(hisifd);
+				mipi_dsi_clk_disable(hisifd);
+			}
+
+			if (hisifd->panel_info.
+			    vsync_ctrl_type & VSYNC_CTRL_VCC_OFF) {
+				dpe_regulator_disable(hisifd);
+			}
+		}
+	}
+#endif
+
+	return 0;
+}
+
+int hisifb_vsync_suspend(struct hisi_fb_data_type *hisifd)
+{
+	return 0;
+}
+
+#pragma GCC diagnostic pop
diff --git a/drivers/video/fbdev/hisi/dss/hisi_mipi_dsi_host.c b/drivers/video/fbdev/hisi/dss/hisi_mipi_dsi_host.c
new file mode 100755
index 000000000000..0d00d3fd9c60
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_mipi_dsi_host.c
@@ -0,0 +1,401 @@
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
+#include "hisi_mipi_dsi.h"
+
+/*
+ * mipi dsi short write with 0, 1 2 parameters
+ * Write to GEN_HDR 24 bit register the value:
+ * 1. 00h, MCS_command[15:8] ,VC[7:6],13h
+ * 2. Data1[23:16], MCS_command[15:8] ,VC[7:6],23h
+ */
+int mipi_dsi_swrite(struct dsi_cmd_desc *cm, char __iomem *dsi_base)
+{
+	uint32_t hdr = 0;
+	int len = 0;
+
+	if (cm->dlen && cm->payload = 0) {
+		HISI_FB_ERR("NO payload error!\n");
+		return 0;
+	}
+
+	BUG_ON(cm->dlen > 2);
+	len = cm->dlen;
+	hdr |= DSI_HDR_DTYPE(cm->dtype);
+	hdr |= DSI_HDR_VC(cm->vc);
+	if (len = 1) {
+		hdr |= DSI_HDR_DATA1(cm->payload[0]);
+		hdr |= DSI_HDR_DATA2(0);
+	} else if (len = 2) {
+		hdr |= DSI_HDR_DATA1(cm->payload[0]);
+		hdr |= DSI_HDR_DATA2(cm->payload[1]);
+	} else {
+		hdr |= DSI_HDR_DATA1(0);
+		hdr |= DSI_HDR_DATA2(0);
+	}
+
+	set_reg(dsi_base + MIPIDSI_GEN_HDR_OFFSET, hdr, 24, 0);
+
+	return len;		/* 4 bytes */
+}
+
+/*
+ * mipi dsi long write
+ * Write to GEN_PLD_DATA 32 bit register the value:
+ * Data3[31:24], Data2[23:16], Data1[15:8], MCS_command[7:0]
+ * If need write again to GEN_PLD_DATA 32 bit register the value:
+ * Data7[31:24], Data6[23:16], Data5[15:8], Data4[7:0]
+ *
+ * Write to GEN_HDR 24 bit register the value: WC[23:8] ,VC[7:6],29h
+ */
+int mipi_dsi_lwrite(struct dsi_cmd_desc *cm, char __iomem *dsi_base)
+{
+	uint32_t hdr = 0;
+	int i = 0;
+
+	if (cm->dlen && cm->payload = 0) {
+		HISI_FB_ERR("NO payload error!\n");
+		return 0;
+	}
+
+	/* fill up payload */
+	for (i = 0; i < cm->dlen; i += 4) {
+		set_reg(dsi_base + MIPIDSI_GEN_PLD_DATA_OFFSET,
+			*((uint32_t *) (cm->payload + i)), 32, 0);
+	}
+
+	/* fill up header */
+	hdr |= DSI_HDR_DTYPE(cm->dtype);
+	hdr |= DSI_HDR_VC(cm->vc);
+	hdr |= DSI_HDR_WC(cm->dlen);
+	set_reg(dsi_base + MIPIDSI_GEN_HDR_OFFSET, hdr, 24, 0);
+
+	return cm->dlen;
+}
+
+void mipi_dsi_max_return_packet_size(struct dsi_cmd_desc *cm,
+				     char __iomem *dsi_base)
+{
+	uint32_t hdr = 0;
+
+	/* fill up header */
+	hdr |= DSI_HDR_DTYPE(cm->dtype);
+	hdr |= DSI_HDR_VC(cm->vc);
+	hdr |= DSI_HDR_WC(cm->dlen);
+	set_reg(dsi_base + MIPIDSI_GEN_HDR_OFFSET, hdr, 24, 0);
+}
+
+uint32_t mipi_dsi_read(uint32_t *out, char __iomem *dsi_base)
+{
+	uint32_t pkg_status;
+	uint32_t try_times = 700;
+
+	do {
+		pkg_status = inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET);
+		if (!(pkg_status & 0x10))
+			break;
+		udelay(50);
+	} while (--try_times);
+
+	*out = inp32(dsi_base + MIPIDSI_GEN_PLD_DATA_OFFSET);
+	if (!try_times)
+		HISI_FB_ERR("mipi_dsi_read timeout\n"
+			    "MIPIDSI_CMD_PKT_STATUS = 0x%x \n"
+			    "MIPIDSI_PHY_STATUS = 0x%x \n",
+			    inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET),
+			    inp32(dsi_base + MIPIDSI_PHY_STATUS_OFFSET));
+
+	return try_times;
+}
+
+void mipi_dsi_sread(uint32_t *out, char __iomem *dsi_base)
+{
+	unsigned long dw_jiffies = 0;
+	uint32_t tmp = 0;
+
+	dw_jiffies = jiffies + HZ / 2;
+	do {
+		tmp = inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET);
+		if ((tmp & 0x00000040) = 0x00000040) {
+			break;
+		}
+	} while (time_after(dw_jiffies, jiffies));
+
+	dw_jiffies = jiffies + HZ / 2;
+	do {
+		tmp = inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET);
+		if ((tmp & 0x00000040) != 0x00000040) {
+			break;
+		}
+	} while (time_after(dw_jiffies, jiffies));
+
+	*out = inp32(dsi_base + MIPIDSI_GEN_PLD_DATA_OFFSET);
+}
+
+void mipi_dsi_lread(uint32_t *out, char __iomem *dsi_base)
+{
+	/* do something here */
+}
+
+/*
+ * prepare cmd buffer to be txed
+ */
+int mipi_dsi_cmd_add(struct dsi_cmd_desc *cm, char __iomem *dsi_base)
+{
+	int len = 0;
+
+	BUG_ON(cm = NULL);
+	BUG_ON(dsi_base = NULL);
+
+	switch (cm->dtype) {
+	case DTYPE_GEN_WRITE:
+	case DTYPE_GEN_WRITE1:
+	case DTYPE_GEN_WRITE2:
+
+	case DTYPE_DCS_WRITE:
+	case DTYPE_DCS_WRITE1:
+		len = mipi_dsi_swrite(cm, dsi_base);
+		break;
+	case DTYPE_GEN_LWRITE:
+	case DTYPE_DCS_LWRITE:
+	case DTYPE_DSC_LWRITE:
+
+		len = mipi_dsi_lwrite(cm, dsi_base);
+		break;
+	default:
+		HISI_FB_ERR("dtype=%x NOT supported!\n", cm->dtype);
+		break;
+	}
+
+	return len;
+}
+
+int mipi_dsi_cmds_tx(struct dsi_cmd_desc *cmds, int cnt,
+		     char __iomem *dsi_base)
+{
+	struct dsi_cmd_desc *cm = NULL;
+	int i = 0;
+
+	BUG_ON(cmds = NULL);
+	BUG_ON(dsi_base = NULL);
+
+	cm = cmds;
+
+	for (i = 0; i < cnt; i++) {
+		mipi_dsi_cmd_add(cm, dsi_base);
+
+		if (cm->wait) {
+			if (cm->waittype = WAIT_TYPE_US)
+				udelay(cm->wait);
+			else if (cm->waittype = WAIT_TYPE_MS)
+				mdelay(cm->wait);
+			else
+				mdelay(cm->wait * 1000);
+		}
+		cm++;
+	}
+
+	return cnt;
+}
+
+void mipi_dsi_check_0lane_is_ready(char __iomem *dsi_base)
+{
+	unsigned long dw_jiffies = 0;
+	uint32_t tmp = 0;
+
+	dw_jiffies = jiffies + HZ / 10;
+	do {
+		tmp = inp32(dsi_base + MIPIDSI_PHY_STATUS_OFFSET);
+		if ((tmp & 0x10) = 0x10) {
+			HISI_FB_INFO("0 lane is stopping state");
+			return;
+		}
+	} while (time_after(dw_jiffies, jiffies));
+
+	HISI_FB_ERR("0 lane is not stopping state:tmp=0x%x", tmp);
+}
+
+static void mipi_dsi_sread_request(struct dsi_cmd_desc *cm,
+				   char __iomem *dsi_base)
+{
+	uint32_t hdr = 0;
+
+	/* fill up header */
+	hdr |= DSI_HDR_DTYPE(cm->dtype);
+	hdr |= DSI_HDR_VC(cm->vc);
+	hdr |= DSI_HDR_DATA1(cm->payload[0]);
+	hdr |= DSI_HDR_DATA2(0);
+	set_reg(dsi_base + MIPIDSI_GEN_HDR_OFFSET, hdr, 24, 0);
+}
+
+static int mipi_dsi_read_add(uint32_t *out, struct dsi_cmd_desc *cm,
+			     char __iomem *dsi_base)
+{
+	unsigned long dw_jiffies = 0;
+	uint32_t pkg_status = 0;
+	uint32_t phy_status = 0;
+	int is_timeout = 1;
+	int ret = 0;
+
+	BUG_ON(cm = NULL);
+	BUG_ON(dsi_base = NULL);
+
+	if (cm->dtype = DTYPE_DCS_READ) {
+		mipi_dsi_sread_request(cm, dsi_base);
+
+		if (!mipi_dsi_read(out, dsi_base)) {
+			HISI_FB_ERR("Read register 0x%X timeout\n",
+				    cm->payload[0]);
+			return -1;
+		}
+	} else if (cm->dtype = DTYPE_GEN_READ1) {
+
+		/*read status register */
+		dw_jiffies = jiffies + HZ;
+		do {
+			pkg_status +			    inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET);
+			phy_status +			    inp32(dsi_base + MIPIDSI_PHY_STATUS_OFFSET);
+			if ((pkg_status & 0x1) = 0x1 && !(phy_status & 0x2)) {
+				is_timeout = 0;
+				break;
+			}
+		} while (time_after(dw_jiffies, jiffies));
+
+		if (is_timeout) {
+			HISI_FB_ERR("mipi_dsi_read timeout :0x%x\n"
+					"MIPIDSI_CMD_PKT_STATUS = 0x%x\n"
+					"MIPIDSI_PHY_STATUS = 0x%x \n"
+					"MIPIDSI_INT_ST1_OFFSET = 0x%x \n",
+					cm->payload[0],
+					inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET),
+					inp32(dsi_base + MIPIDSI_PHY_STATUS_OFFSET),
+					inp32(dsi_base + MIPIDSI_INT_ST1_OFFSET));
+			return -1;
+		}
+		/*send read cmd to fifo */
+		set_reg(dsi_base + MIPIDSI_GEN_HDR_OFFSET,
+			((cm->payload[0] << 8) | cm->dtype), 24, 0);
+
+		is_timeout = 1;
+		/*wait dsi read data */
+		dw_jiffies = jiffies + HZ;
+		do {
+			pkg_status +			    inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET);
+			if (!(pkg_status & 0x10)) {
+				is_timeout = 0;
+				break;
+			}
+		} while (time_after(dw_jiffies, jiffies));
+
+		if (is_timeout) {
+			HISI_FB_ERR("mipi_dsi_read timeout :0x%x\n"
+					"MIPIDSI_CMD_PKT_STATUS = 0x%x\n"
+					"MIPIDSI_PHY_STATUS = 0x%x \n"
+					"MIPIDSI_INT_ST1_OFFSET = 0x%x \n",
+					cm->payload[0],
+					inp32(dsi_base + MIPIDSI_CMD_PKT_STATUS_OFFSET),
+					inp32(dsi_base + MIPIDSI_PHY_STATUS_OFFSET),
+					inp32(dsi_base + MIPIDSI_INT_ST1_OFFSET));
+			return -1;
+		}
+		/*get read data */
+		*out = inp32(dsi_base + MIPIDSI_GEN_PLD_DATA_OFFSET);
+	} else {
+		ret = -1;
+		HISI_FB_ERR("dtype=%x NOT supported!\n", cm->dtype);
+	}
+
+	return ret;
+}
+
+int mipi_dsi_cmds_rx(uint32_t *out, struct dsi_cmd_desc *cmds, int cnt,
+		     char __iomem *dsi_base)
+{
+	struct dsi_cmd_desc *cm = NULL;
+	int i = 0;
+	int err_num = 0;
+
+	BUG_ON(cmds = NULL);
+	BUG_ON(dsi_base = NULL);
+
+	cm = cmds;
+
+	for (i = 0; i < cnt; i++) {
+		if (mipi_dsi_read_add(&(out[i]), cm, dsi_base)) {
+			err_num++;
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
+		cm++;
+	}
+
+	return err_num;
+}
+
+int mipi_dsi_read_compare(struct mipi_dsi_read_compare_data *data,
+			  char __iomem *dsi_base)
+{
+	uint32_t *read_value = NULL;
+	uint32_t *expected_value = NULL;
+	uint32_t *read_mask = NULL;
+	char **reg_name = NULL;
+	int log_on = 0;
+	struct dsi_cmd_desc *cmds = NULL;
+
+	int cnt = 0;
+	int cnt_not_match = 0;
+	int ret = 0;
+	int i;
+
+	BUG_ON(data = NULL);
+	BUG_ON(dsi_base = NULL);
+
+	read_value = data->read_value;
+	expected_value = data->expected_value;
+	read_mask = data->read_mask;
+	reg_name = data->reg_name;
+	log_on = data->log_on;
+
+	cmds = data->cmds;
+	cnt = data->cnt;
+
+	ret = mipi_dsi_cmds_rx(read_value, cmds, cnt, dsi_base);
+	if (ret) {
+		HISI_FB_ERR("Read error number: %d\n", ret);
+		return cnt;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (log_on) {
+			HISI_FB_INFO("Read reg %s: 0x%x, value = 0x%x\n",
+				     reg_name[i], cmds[i].payload[0],
+				     read_value[i]);
+		}
+
+		if (expected_value[i] != (read_value[i] & read_mask[i])) {
+			cnt_not_match++;
+		}
+	}
+
+	return cnt_not_match;
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.c b/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.c
new file mode 100755
index 000000000000..6b1832f49e3c
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.c
@@ -0,0 +1,1450 @@
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
+
+#define MAX_ITEM_OFFSET	(0x3F)
+#define CMDLIST_ADDR_OFFSET	(0x3FFFF)
+
+#define CMDLIST_HEADER_LEN	(SZ_1K)
+#define CMDLIST_ITEM_LEN	(SZ_8K)
+#define MAX_ITEM_INDEX	(SZ_1K)
+
+dss_cmdlist_data_t *g_cmdlist_data = NULL;
+uint32_t g_online_cmdlist_idxs = 0;
+uint32_t g_offline_cmdlist_idxs = 0;
+
+/* get cmdlist indexs */
+int hisi_cmdlist_get_cmdlist_idxs(dss_overlay_t *pov_req,
+				  uint32_t *cmdlist_pre_idxs,
+				  uint32_t *cmdlist_idxs)
+{
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int k = 0;
+	int m = 0;
+	dss_layer_t *layer = NULL;
+	dss_wb_layer_t *wb_layer = NULL;
+	dss_overlay_block_t *pov_h_block_infos = NULL;
+	dss_overlay_block_t *pov_h_block = NULL;
+	bool no_ovl_idx = false;
+
+	BUG_ON(pov_req = NULL);
+
+	pov_h_block_infos = (dss_overlay_block_t *) pov_req->ov_block_infos_ptr;
+	for (m = 0; m < pov_req->ov_block_nums; m++) {
+		pov_h_block = &(pov_h_block_infos[m]);
+		for (i = 0; i < pov_h_block->layer_nums; i++) {
+			layer = &(pov_h_block->layer_infos[i]);
+
+			if (layer->need_cap & (CAP_BASE | CAP_DIM | CAP_PURE_COLOR))
+				continue;
+
+			if (layer->chn_idx = DSS_RCHN_V2) {
+				cmdlist_idxs_temp |= (1 << DSS_CMDLIST_V2);
+			} else {
+				cmdlist_idxs_temp |= (1 << layer->chn_idx);
+			}
+		}
+	}
+
+	if (pov_req->wb_enable = 1) {
+		for (k = 0; k < pov_req->wb_layer_nums; k++) {
+			wb_layer = &(pov_req->wb_layer_infos[k]);
+
+			if (wb_layer->chn_idx = DSS_WCHN_W2) {
+				no_ovl_idx = true;
+				cmdlist_idxs_temp |= (1 << DSS_CMDLIST_W2);
+			} else {
+				cmdlist_idxs_temp |= (1 << wb_layer->chn_idx);
+			}
+		}
+	}
+
+	if (no_ovl_idx = false) {
+		cmdlist_idxs_temp |+		    (1 << (DSS_CMDLIST_OV0 + pov_req->ovl_idx));
+	}
+
+	if (cmdlist_idxs_temp & (~HISI_DSS_CMDLIST_IDXS_MAX)) {
+		HISI_FB_ERR("cmdlist_idxs_temp(0x%x) is invalid!\n",
+			    cmdlist_idxs_temp);
+		return -EINVAL;
+	}
+
+	if (cmdlist_idxs && cmdlist_pre_idxs) {
+		*cmdlist_idxs = cmdlist_idxs_temp;
+		*cmdlist_pre_idxs &= (~(*cmdlist_idxs));
+	} else if (cmdlist_idxs) {
+		*cmdlist_idxs = cmdlist_idxs_temp;
+	} else if (cmdlist_pre_idxs) {
+		*cmdlist_pre_idxs = cmdlist_idxs_temp;
+	} else {
+		HISI_FB_ERR("cmdlist_idxs && cmdlist_pre_idxs is NULL!\n");
+		return -EINVAL;
+	}
+
+	if (g_debug_ovl_cmdlist) {
+		HISI_FB_INFO("cmdlist_pre_idxs(0x%x), cmdlist_idxs(0x%x).\n",
+			     (cmdlist_pre_idxs ? *cmdlist_pre_idxs : 0),
+			     (cmdlist_idxs ? *cmdlist_idxs : 0));
+	}
+
+	return 0;
+}
+
+uint32_t hisi_cmdlist_get_cmdlist_need_start(struct hisi_fb_data_type *hisifd,
+					     uint32_t cmdlist_idxs)
+{
+	uint32_t cmdlist_idxs_temp = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_idxs_temp = g_offline_cmdlist_idxs;
+	g_offline_cmdlist_idxs |= cmdlist_idxs;
+	cmdlist_idxs_temp = (g_offline_cmdlist_idxs & (~cmdlist_idxs_temp));
+
+	cmdlist_idxs_temp |= (cmdlist_idxs & g_online_cmdlist_idxs);
+	g_online_cmdlist_idxs &= (~cmdlist_idxs_temp);
+
+	if (g_debug_ovl_cmdlist) {
+		HISI_FB_INFO
+		    ("g_online_cmdlist_idxs=0x%x, cmdlist_idxs_need_start=0x%x\n",
+		     g_online_cmdlist_idxs, cmdlist_idxs_temp);
+	}
+
+	return cmdlist_idxs_temp;
+}
+
+/*
+ ** data0: addr0[17:0]
+ ** data1: addr0[17:0] + addr1[5:0]
+ ** data2: addr0[17:0] + addr2[5:0]
+ **
+ ** cnt[1:0]:
+ ** 2'b00:	reg0
+ ** 2'b01: reg0, reg1
+ ** 2'b10: reg0, reg1, reg2
+ ** 2'b11: ((inp32(addr0) & data1) | data2) -> addr0
+ */
+void hisi_cmdlist_set_reg(struct hisi_fb_data_type *hisifd, char __iomem *addr,
+			  uint32_t value, uint8_t bw, uint8_t bs)
+{
+	uint32_t mask = (1 << bw) - 1;
+	dss_cmdlist_node_t *node = NULL;
+	int cmdlist_idx = -1;
+	int index = 0;
+	uint32_t new_addr = 0;
+	uint32_t old_addr = 0;
+	int condition = 0;
+
+	BUG_ON(addr = NULL);
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_idx = hisifd->cmdlist_idx;
+	BUG_ON((cmdlist_idx < 0) || (cmdlist_idx >= HISI_DSS_CMDLIST_MAX));
+
+	node +	    list_entry(hisifd->cmdlist_data->cmdlist_head_temp[cmdlist_idx].prev,
+	    	dss_cmdlist_node_t, list_node);
+	BUG_ON(node = NULL);
+
+	if (node->node_type = CMDLIST_NODE_NOP) {
+		HISI_FB_ERR("can't set register value to NOP node!");
+		return;
+	}
+
+	index = node->item_index;
+	new_addr = (uint32_t) (addr - hisifd->dss_base + hisifd->dss_base_phy);
+	new_addr = (new_addr >> 2) & CMDLIST_ADDR_OFFSET;
+	old_addr = node->list_item[index].reg_addr.ul32 & CMDLIST_ADDR_OFFSET;
+	condition = (((new_addr - old_addr) < MAX_ITEM_OFFSET)
+		     && (new_addr >= old_addr));
+
+	if (bw != 32) {
+		if (node->item_flag != 0)
+			index++;
+
+		node->list_item[index].reg_addr.bits.add0 = new_addr;
+		node->list_item[index].data0 = value;
+		node->list_item[index].data1 = ~(mask << bs);
+		node->list_item[index].data2 = (mask & value) << bs;
+		node->list_item[index].reg_addr.bits.cnt = 3;
+		node->item_flag = 3;
+	} else {
+		if (node->item_flag = 0) {
+			node->list_item[index].reg_addr.bits.add0 = new_addr;
+			node->list_item[index].data0 = value;
+			node->list_item[index].reg_addr.bits.cnt = 0;
+			node->item_flag = 1;
+		} else if (node->item_flag = 1 && condition) {
+			node->list_item[index].reg_addr.bits.add1 +			    new_addr - old_addr;
+			node->list_item[index].data1 = value;
+			node->list_item[index].reg_addr.bits.cnt = 1;
+			node->item_flag = 2;
+		} else if (node->item_flag = 2 && condition) {
+			node->list_item[index].reg_addr.bits.add2 +			    new_addr - old_addr;
+			node->list_item[index].data2 = value;
+			node->list_item[index].reg_addr.bits.cnt = 2;
+			node->item_flag = 3;
+		} else {
+			index++;
+			node->list_item[index].reg_addr.bits.add0 = new_addr;
+			node->list_item[index].data0 = value;
+			node->list_item[index].reg_addr.bits.cnt = 0;
+			node->item_flag = 1;
+		}
+	}
+
+	BUG_ON(index >= MAX_ITEM_INDEX);
+
+	node->item_index = index;
+	node->list_header->total_items.bits.count = node->item_index + 1;
+}
+
+/*
+ ** flush cache for cmdlist, make sure that
+ ** cmdlist has writen through to memory before config register
+ */
+void hisi_cmdlist_flush_cache(struct hisi_fb_data_type *hisifd,
+			      struct ion_client *ion_client,
+			      uint32_t cmdlist_idxs)
+{
+	uint32_t i = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	dss_cmdlist_node_t *node = NULL;
+	dss_cmdlist_node_t *_node_ = NULL;
+	struct sg_table *table = NULL;
+	struct list_head *cmdlist_heads = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			cmdlist_heads +			    &(hisifd->cmdlist_data->cmdlist_head_temp[i]);
+			if (!cmdlist_heads) {
+				HISI_FB_ERR("cmdlist_data is NULL!\n");
+				continue;
+			}
+
+			list_for_each_entry_safe_reverse(node, _node_,
+							 cmdlist_heads,
+							 list_node) {
+
+				if (!node->header_ion_handle) {
+					HISI_FB_ERR
+					    ("header_ion_handle is NULL!\n");
+				} else {
+					table = ion_sg_table(ion_client,
+							 node->header_ion_handle);
+					BUG_ON(table = NULL);
+					dma_sync_sg_for_device(NULL, table->sgl,
+							       table->nents,
+							       DMA_TO_DEVICE);
+				}
+
+				if (!node->item_ion_handle) {
+					HISI_FB_ERR("item_ion_handle is NULL!\n");
+				} else {
+					table = ion_sg_table(ion_client,
+							 node->item_ion_handle);
+					BUG_ON(table = NULL);
+					dma_sync_sg_for_device(NULL, table->sgl,
+							       table->nents,
+							       DMA_TO_DEVICE);
+				}
+			}
+		}
+
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+}
+
+dss_cmdlist_node_t *hisi_cmdlist_node_alloc(struct ion_client *ion_client)
+{
+	int ret = 0;
+	dss_cmdlist_node_t *node = NULL;
+	size_t header_len = CMDLIST_HEADER_LEN;
+	size_t item_len = CMDLIST_ITEM_LEN;
+
+	BUG_ON(ion_client = NULL);
+
+	node +	    (dss_cmdlist_node_t *) kzalloc(sizeof(dss_cmdlist_node_t),
+					   GFP_KERNEL);
+	if (IS_ERR(node)) {
+		HISI_FB_ERR("failed to alloc dss_cmdlist_node_t!");
+		goto err_alloc_cmdlist_node;
+	}
+
+	memset(node, 0, sizeof(dss_cmdlist_node_t));
+
+	/*alloc buffer for header */
+	node->header_ion_handle +	    ion_alloc(ion_client, header_len, 0, ION_HEAP(ION_GRALLOC_HEAP_ID), 0);
+	if (IS_ERR(node->header_ion_handle)) {
+		HISI_FB_ERR("failed to ion_alloc node->header_ion_handle!");
+		goto err_header_ion_handle;
+	}
+
+	node->list_header +	    (cmd_header_t *) ion_map_kernel(ion_client,
+					    node->header_ion_handle);
+	if (!node->list_header) {
+		HISI_FB_ERR("failed to ion_map_kernel node->list_header!");
+		goto err_header_ion_map;
+	}
+	memset(node->list_header, 0, header_len);
+
+	ret +	    ion_phys(ion_client, node->header_ion_handle, &node->header_phys,
+		     &header_len);
+	if (ret < 0) {
+		HISI_FB_ERR("failed to ion_phys node->header_phys!");
+		goto err_header_ion_phys;
+	}
+
+	/*alloc buffer for items */
+	node->item_ion_handle +	    ion_alloc(ion_client, item_len, 0, ION_HEAP(ION_GRALLOC_HEAP_ID), 0);
+	if (!node->item_ion_handle) {
+		HISI_FB_ERR("failed to ion_alloc node->item_ion_handle!");
+		goto err_item_ion_handle;
+	}
+
+	node->list_item +	    (cmd_item_t *) ion_map_kernel(ion_client, node->item_ion_handle);
+	if (!node->list_item) {
+		HISI_FB_ERR("failed to ion_map_kernel node->list_item!");
+		goto err_item_ion_map;
+	}
+
+	memset(node->list_item, 0, item_len);
+	ret +	    ion_phys(ion_client, node->item_ion_handle, &node->item_phys,
+		     &item_len);
+	if (ret < 0) {
+		HISI_FB_ERR("failed to ion_phys node->item_phys!");
+		goto err_item_ion_phys;
+	}
+
+	/* fill node info */
+	node->item_flag = 0;
+	node->item_index = 0;
+
+	node->is_used = 0;
+	node->node_type = CMDLIST_NODE_NONE;
+	return node;
+
+ err_item_ion_phys:
+	if (node->item_ion_handle)
+		ion_unmap_kernel(ion_client, node->item_ion_handle);
+ err_item_ion_map:
+	if (node->item_ion_handle)
+		ion_free(ion_client, node->item_ion_handle);
+ err_item_ion_handle:
+ err_header_ion_phys:
+	if (node->header_ion_handle)
+		ion_unmap_kernel(ion_client, node->header_ion_handle);
+ err_header_ion_map:
+	if (node->header_ion_handle)
+		ion_free(ion_client, node->header_ion_handle);
+ err_header_ion_handle:
+	if (node)
+		kfree(node);
+ err_alloc_cmdlist_node:
+	return NULL;
+}
+
+void hisi_cmdlist_node_free(struct ion_client *ion_client,
+			    dss_cmdlist_node_t *node)
+{
+	BUG_ON(ion_client = NULL);
+	BUG_ON(node = NULL);
+
+	if (node->header_ion_handle) {
+		ion_unmap_kernel(ion_client, node->header_ion_handle);
+		ion_free(ion_client, node->header_ion_handle);
+	}
+
+	if (node->item_ion_handle) {
+		ion_unmap_kernel(ion_client, node->item_ion_handle);
+		ion_free(ion_client, node->item_ion_handle);
+	}
+
+	kfree(node);
+	node = NULL;
+}
+
+static dss_cmdlist_node_t *hisi_cmdlist_get_free_node(dss_cmdlist_node_t *
+						      node[], int *id)
+{
+	int i = 0;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_NODE_MAX; i++) {
+		if (node[i] && (node[i]->is_used = 0)) {
+			node[i]->is_used = 1;
+			*id = i + 1;
+			return node[i];
+		}
+	}
+
+	return NULL;
+}
+
+int hisi_cmdlist_add_nop_node(struct hisi_fb_data_type *hisifd,
+			      uint32_t cmdlist_idxs, int pending, int reserved)
+{
+	dss_cmdlist_node_t *node = NULL;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int id = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			node +			    hisi_cmdlist_get_free_node(hisifd->cmdlist_data->
+						       cmdlist_nodes_temp[i],
+						       &id);
+			if (!node) {
+				HISI_FB_ERR
+				    ("failed to hisi_get_free_cmdlist_node!\n");
+				return -EINVAL;
+			}
+
+			node->list_header->flag.bits.id = id;
+			node->list_header->flag.bits.nop = 0x1;
+			node->list_header->flag.bits.pending +			    pending ? 0x1 : 0x0;
+			node->list_header->flag.bits.valid_flag +			    CMDLIST_NODE_VALID;
+			node->list_header->next_list = node->header_phys;
+
+			node->is_used = 1;
+			node->node_type = CMDLIST_NODE_NOP;
+			node->reserved = reserved ? 0x1 : 0x0;
+
+			/*add this nop to list */
+			list_add_tail(&(node->list_node),
+				      &(hisifd->cmdlist_data->cmdlist_head_temp[i]));
+
+			if (node->list_node.prev !+			    &(hisifd->cmdlist_data->cmdlist_head_temp[i])) {
+				dss_cmdlist_node_t *pre_node = NULL;
+				pre_node +				    list_entry(node->list_node.prev,
+					       dss_cmdlist_node_t, list_node);
+				pre_node->list_header->next_list +				    node->header_phys;
+				if (node->list_header->flag.bits.pending = 0x1) {
+					pre_node->reserved = 0x0;
+				}
+
+				pre_node->list_header->flag.bits.task_end = 0x1;
+
+				if (g_debug_ovl_cmdlist) {
+					HISI_FB_DEBUG
+					    ("i = %d, next_list = 0x%x\n", i,
+					     (uint32_t) (node->header_phys));
+				}
+			}
+		}
+
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	return 0;
+}
+
+int hisi_cmdlist_add_new_node(struct hisi_fb_data_type *hisifd,
+			      uint32_t cmdlist_idxs, int pending, int task_end,
+			      int remove, int last, uint32_t wb_type)
+{
+	char __iomem *cmdlist_base = NULL;
+	dss_cmdlist_node_t *node = NULL;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int id = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			node +			    hisi_cmdlist_get_free_node(hisifd->cmdlist_data->
+						       cmdlist_nodes_temp[i],
+						       &id);
+			if (!node) {
+				HISI_FB_ERR
+				    ("failed to hisi_get_free_cmdnode!\n");
+				return -EINVAL;
+			}
+
+			/*fill the header and item info */
+			node->list_header->flag.bits.id = id;
+			node->list_header->flag.bits.pending +			    pending ? 0x1 : 0x0;
+
+			if (i < DSS_CMDLIST_W0) {
+				node->list_header->flag.bits.event_list +				    remove ? 0x8 : (0xE + i);
+			} else if (i < DSS_CMDLIST_OV0) {
+				node->list_header->flag.bits.event_list +				    remove ? 0x8 : (0x16 + i);
+			} else if (i = DSS_CMDLIST_V2) {
+				node->list_header->flag.bits.event_list +				    remove ? 0x8 : 0x16;
+			} else if (i = DSS_CMDLIST_W2) {
+				node->list_header->flag.bits.event_list +				    remove ? 0x8 : 0x20;
+			} else {
+				node->list_header->flag.bits.event_list +				    remove ? 0x8 : (0xE + i);
+			}
+
+			node->list_header->flag.bits.task_end +			    task_end ? 0x1 : 0x0;
+			node->list_header->flag.bits.last = last ? 0x1 : 0x0;
+
+			node->list_header->flag.bits.valid_flag +			    CMDLIST_NODE_VALID;
+			node->list_header->flag.bits.exec = 0x1;
+			node->list_header->list_addr = node->item_phys;
+			node->list_header->next_list = node->item_phys;
+
+			node->is_used = 1;
+			node->node_type = CMDLIST_NODE_FRAME;
+			node->item_flag = 0;
+			node->reserved = 0;
+
+			/* add this nop to list */
+			list_add_tail(&(node->list_node),
+				      &(hisifd->cmdlist_data->cmdlist_head_temp[i]));
+
+			if (node->list_node.prev !+			    &(hisifd->cmdlist_data->cmdlist_head_temp[i])) {
+				dss_cmdlist_node_t *pre_node = NULL;
+				pre_node +				    list_entry(node->list_node.prev,
+					       dss_cmdlist_node_t, list_node);
+				pre_node->list_header->next_list +				    node->header_phys;
+				pre_node->reserved = 0x0;
+				if (g_debug_ovl_cmdlist) {
+					HISI_FB_DEBUG
+					    ("i = %d, next_list = 0x%x\n", i,
+					     (uint32_t) node->header_phys);
+				}
+			}
+		}
+
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	return 0;
+}
+
+int hisi_cmdlist_del_all_node(struct list_head *cmdlist_heads)
+{
+	dss_cmdlist_node_t *node = NULL;
+	dss_cmdlist_node_t *_node_ = NULL;
+
+	BUG_ON(cmdlist_heads = NULL);
+
+	list_for_each_entry_safe(node, _node_, cmdlist_heads, list_node) {
+		if (node->reserved != 0x1) {
+			list_del(&node->list_node);
+
+			memset(node->list_header, 0, CMDLIST_HEADER_LEN);
+			memset(node->list_item, 0, CMDLIST_ITEM_LEN);
+
+			node->item_index = 0;
+			node->item_flag = 0;
+			node->node_type = CMDLIST_NODE_NONE;
+			node->is_used = 0;
+		}
+	}
+
+	return 0;
+}
+
+int hisi_cmdlist_check_cmdlist_state(struct hisi_fb_data_type *hisifd,
+				     uint32_t cmdlist_idxs)
+{
+	char __iomem *cmdlist_base = NULL;
+	uint32_t offset = 0;
+	uint32_t tmp = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int delay_count = 0;
+	bool is_timeout = true;
+	int ret = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	offset = 0x40;
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			while (1) {
+				tmp +				    inp32(cmdlist_base + CMDLIST_CH0_STATUS +
+					  i * offset);
+				if (((tmp & 0xF) = 0x0) || delay_count > 5000) {
+					is_timeout +					    (delay_count > 5000) ? true : false;
+					delay_count = 0;
+					break;
+				} else {
+					udelay(1);
+					++delay_count;
+				}
+			}
+
+			if (is_timeout) {
+				HISI_FB_ERR
+				    ("cmdlist_ch%d not in idle state,ints=0x%x !\n",
+				     i, tmp);
+				ret = -1;
+			}
+		}
+
+		cmdlist_idxs_temp = (cmdlist_idxs_temp >> 1);
+	}
+
+	return ret;
+}
+
+/*
+ ** stop the pending state for one new frame
+ ** if the current cmdlist status is e_status_wait.
+ */
+int hisi_cmdlist_exec(struct hisi_fb_data_type *hisifd, uint32_t cmdlist_idxs)
+{
+	char __iomem *cmdlist_base = NULL;
+	uint32_t offset = 0;
+	uint32_t tmp = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int delay_count = 0;
+	bool is_timeout = true;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	offset = 0x40;
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			while (1) {
+				tmp +				    inp32(cmdlist_base + CMDLIST_CH0_STATUS +
+					  i * offset);
+				if (((tmp & 0xF) = 0x0) || delay_count > 500) {
+					is_timeout +					    (delay_count > 500) ? true : false;
+					delay_count = 0;
+					break;
+				} else {
+					udelay(1);
+					++delay_count;
+				}
+			}
+
+			if (is_timeout) {
+				HISI_FB_ERR
+				    ("cmdlist_ch%d not in idle state,ints=0x%x !\n",
+				     i, tmp);
+				if (g_debug_ovl_cmdlist) {
+					hisi_cmdlist_dump_all_node(hisifd, NULL,
+								   cmdlist_idxs);
+				}
+			}
+		}
+
+		cmdlist_idxs_temp = (cmdlist_idxs_temp >> 1);
+	}
+	return 0;
+}
+
+/*
+ **start cmdlist.
+ **it will set cmdlist into pending state.
+ */
+extern uint32_t g_dss_module_ovl_base[DSS_MCTL_IDX_MAX][MODULE_OVL_MAX];
+int hisi_cmdlist_config_start(struct hisi_fb_data_type *hisifd, int mctl_idx,
+			      uint32_t cmdlist_idxs, uint32_t wb_compose_type)
+{
+	char __iomem *mctl_base = NULL;
+	char __iomem *cmdlist_base = NULL;
+	dss_cmdlist_node_t *cmdlist_node = NULL;
+	uint32_t offset = 0;
+	uint32_t list_addr = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int temp = 0;
+	int status_temp = 0;
+	int ints_temp = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	mctl_base +	    hisifd->dss_base +
+	    g_dss_module_ovl_base[mctl_idx][MODULE_MCTL_BASE];
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	offset = 0x40;
+	cmdlist_idxs_temp = cmdlist_idxs;
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			status_temp +			    inp32(cmdlist_base + CMDLIST_CH0_STATUS +
+				  i * offset);
+			ints_temp +			    inp32(cmdlist_base + CMDLIST_CH0_INTS + i * offset);
+
+			if (mctl_idx >= DSS_MCTL2) {
+				cmdlist_node +				    list_first_entry(&(hisifd->cmdlist_data_tmp
+						      [wb_compose_type]->cmdlist_head_temp[i]),
+						     dss_cmdlist_node_t,
+						     list_node);
+			} else {
+				cmdlist_node +				    list_first_entry(&(hisifd->cmdlist_data->
+				    		 cmdlist_head_temp[i]),
+						     dss_cmdlist_node_t,
+						     list_node);
+			}
+
+			list_addr = cmdlist_node->header_phys;
+			if (g_debug_ovl_cmdlist) {
+				HISI_FB_INFO
+				    ("list_addr:0x%x, i=%d, ints_temp=0x%x\n",
+				     list_addr, i, ints_temp);
+			}
+
+			temp |= (1 << i);
+			outp32(cmdlist_base + CMDLIST_ADDR_MASK_EN, BIT(i));
+			if (g_debug_set_reg_val) {
+				HISI_FB_INFO("writel: [%p] = 0x%lx\n",
+					     cmdlist_base +
+					     CMDLIST_ADDR_MASK_EN, BIT(i));
+			}
+
+			set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i*offset,
+					mctl_idx, 3, 2);
+			if (mctl_idx <= DSS_MCTL1) {
+				set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i*offset, 0x1, 1, 6);
+			} else {
+				set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i*offset, 0x0, 1, 6);
+			}
+
+			set_reg(cmdlist_base + CMDLIST_CH0_STAAD + i*offset,
+					list_addr, 32, 0);
+			set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i*offset, 0x1, 1, 0);
+			if ((mctl_idx <= DSS_MCTL1)
+			    && ((ints_temp & 0x2) = 0x2)) {
+				set_reg(cmdlist_base + CMDLIST_SWRST, 0x1, 1, i);
+			}
+
+			if (mctl_idx >= DSS_MCTL2) {
+				if (((status_temp & 0xF) = 0x0)
+				    || ((ints_temp & 0x2) = 0x2)) {
+					set_reg(cmdlist_base + CMDLIST_SWRST,
+						0x1, 1, i);
+				} else {
+					HISI_FB_INFO
+					    ("i=%d, status_temp=0x%x, ints_temp=0x%x\n",
+					     i, status_temp, ints_temp);
+				}
+			}
+		}
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	outp32(cmdlist_base + CMDLIST_ADDR_MASK_DIS, temp);
+	if (g_debug_set_reg_val) {
+		HISI_FB_INFO("writel: [%p] = 0x%x\n",
+			     cmdlist_base + CMDLIST_ADDR_MASK_DIS, temp);
+	}
+
+	if (mctl_idx >= DSS_MCTL2) {
+		set_reg(mctl_base + MCTL_CTL_ST_SEL, 0x1, 1, 0);
+		set_reg(mctl_base + MCTL_CTL_SW_ST, 0x1, 1, 0);
+	}
+
+	return 0;
+}
+
+void hisi_cmdlist_config_mif_reset(struct hisi_fb_data_type *hisifd,
+				   dss_overlay_t *pov_req,
+				   uint32_t cmdlist_idxs, int mctl_idx)
+{
+	char __iomem *dss_base = NULL;
+	char __iomem *tmp_base = NULL;
+
+	uint32_t cmdlist_idxs_temp = 0;
+	int delay_count = 0;
+	bool is_timeout = true;
+	int i = 0;
+	int j = 0;
+	int mif_sub_ch_nums = 4;
+	int tmp = 0;
+	int mif_nums_max = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(pov_req = NULL);
+
+	dss_base = hisifd->dss_base;
+
+	if (mctl_idx <= DSS_MCTL1) {
+		mif_nums_max = DSS_WCHN_W0;
+	} else {
+		mif_nums_max = DSS_CHN_MAX;
+	}
+
+	if (mctl_idx = DSS_MCTL5) {
+		for (i = DSS_RCHN_V2; i < DSS_CHN_MAX_DEFINE; i++) {
+			is_timeout = false;
+
+			while (1) {
+				for (j = 1; j <= mif_sub_ch_nums; j++) {
+					tmp |+					    inp32(dss_base + DSS_MIF_OFFSET +
+						  MIF_STAT1 +
+						  0x10 * (i * mif_sub_ch_nums +j));
+				}
+
+				if (((tmp & 0x1f) = 0x0) || delay_count > 500) {
+					is_timeout +					    (delay_count > 500) ? true : false;
+					delay_count = 0;
+					break;
+				} else {
+					udelay(10);
+					++delay_count;
+				}
+			}
+
+			if (is_timeout) {
+				HISI_FB_ERR("mif_ch%d MIF_STAT1=0x%x !\n", i,
+					    tmp);
+			}
+		}
+
+		tmp_base = hisifd->dss_module.mif_ch_base[DSS_RCHN_V2];
+		if (tmp_base) {
+			set_reg(tmp_base + MIF_CTRL0, 0x0, 1, 0);
+		}
+
+		tmp_base = hisifd->dss_module.mif_ch_base[DSS_WCHN_W2];
+		if (tmp_base) {
+			set_reg(tmp_base + MIF_CTRL0, 0x0, 1, 0);
+		}
+	} else {
+		cmdlist_idxs_temp = cmdlist_idxs;
+		for (i = 0; i < mif_nums_max; i++) {
+			if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+				is_timeout = false;
+
+				while (1) {
+					for (j = 1; j <= mif_sub_ch_nums; j++) {
+						tmp |+						    inp32(dss_base + DSS_MIF_OFFSET + MIF_STAT1 +
+							  0x10 * (i * mif_sub_ch_nums + j));
+					}
+					if (((tmp & 0x1f) = 0x0)
+					    || delay_count > 500) {
+						is_timeout +						    (delay_count > 500) ? true : false;
+						delay_count = 0;
+						break;
+					} else {
+						udelay(10);
+						++delay_count;
+					}
+				}
+
+				if (is_timeout) {
+					HISI_FB_ERR
+					    ("mif_ch%d MIF_STAT1=0x%x !\n", i, tmp);
+				}
+			}
+
+			cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+		}
+
+		cmdlist_idxs_temp = cmdlist_idxs;
+		for (i = 0; i < mif_nums_max; i++) {
+			if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+				tmp_base = hisifd->dss_module.mif_ch_base[i];
+				if (tmp_base) {
+					set_reg(tmp_base + MIF_CTRL0, 0x0, 1,
+						0);
+				}
+			}
+			cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+		}
+	}
+	mdelay(5);
+
+	if (mctl_idx = DSS_MCTL5) {
+		tmp_base = hisifd->dss_module.mif_ch_base[DSS_RCHN_V2];
+		if (tmp_base) {
+			set_reg(tmp_base + MIF_CTRL0, 0x1, 1, 0);
+		}
+
+		tmp_base = hisifd->dss_module.mif_ch_base[DSS_WCHN_W2];
+		if (tmp_base) {
+			set_reg(tmp_base + MIF_CTRL0, 0x1, 1, 0);
+		}
+	} else {
+		cmdlist_idxs_temp = cmdlist_idxs;
+		for (i = 0; i < mif_nums_max; i++) {
+			if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+				tmp_base = hisifd->dss_module.mif_ch_base[i];
+				if (tmp_base) {
+					set_reg(tmp_base + MIF_CTRL0, 0x1, 1,
+						0);
+				}
+			}
+			cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+		}
+	}
+}
+
+void hisi_cmdlist_config_reset(struct hisi_fb_data_type *hisifd,
+			       dss_overlay_t *pov_req, uint32_t cmdlist_idxs)
+{
+	char __iomem *dss_base = NULL;
+	char __iomem *cmdlist_base = NULL;
+	char __iomem *tmp_base = NULL;
+	struct hisi_panel_info *pinfo = NULL;
+
+	uint32_t offset = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	int i = 0;
+	int ovl_idx = 0;
+	int mctl_idx = 0;
+	int ints_temp = 0;
+	int start_sel = 0;
+	uint32_t start_sel_temp = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(pov_req = NULL);
+
+	HISI_FB_DEBUG("fb%d, +.\n", hisifd->index);
+
+	dss_base = hisifd->dss_base;
+	cmdlist_base = dss_base + DSS_CMDLIST_OFFSET;
+	ovl_idx = pov_req->ovl_idx;
+	pinfo = &(hisifd->panel_info);
+
+	if (cmdlist_idxs = 0) return;
+
+	mctl_idx = ovl_idx;
+	if (pov_req->wb_compose_type = DSS_WB_COMPOSE_COPYBIT) {
+		mctl_idx = DSS_MCTL5;
+	}
+
+	offset = 0x40;
+	cmdlist_idxs_temp = HISI_DSS_CMDLIST_IDXS_MAX;
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			ints_temp +			    inp32(cmdlist_base + CMDLIST_CH0_INTS + i * offset);
+			start_sel +			    inp32(cmdlist_base + CMDLIST_CH0_CTRL + i * offset);
+
+			if (((ints_temp & 0x2) = 0x2)
+			    && ((start_sel & 0x1c) = 0)) {
+				set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i * offset, 0x6, 3, 2);
+				start_sel_temp |= (1 << i);
+			}
+		}
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	tmp_base = hisifd->dss_module.mctl_base[mctl_idx];
+	if (tmp_base) {
+		set_reg(tmp_base + MCTL_CTL_CLEAR, 0x1, 1, 0);
+	}
+
+	hisi_cmdlist_config_mif_reset(hisifd, pov_req, cmdlist_idxs, mctl_idx);
+	cmdlist_idxs_temp = start_sel_temp;
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			set_reg(cmdlist_base + CMDLIST_CH0_CTRL + i * offset, mctl_idx, 3, 2);
+		}
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	if (mctl_idx >= DSS_MCTL2) {
+		offset = 0x40;
+		cmdlist_idxs_temp = cmdlist_idxs;
+		for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+			if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+				set_reg(cmdlist_base + CMDLIST_CH0_CTRL +
+					i * offset, 0x6, 3, 2);
+				set_reg(cmdlist_base + CMDLIST_CH0_CTRL +
+					i * offset, 0x0, 1, 0);
+			}
+			cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+		}
+	}
+
+	HISI_FB_DEBUG("fb%d, -.\n", hisifd->index);
+	return;
+}
+
+int hisi_cmdlist_config_stop(struct hisi_fb_data_type *hisifd,
+			     uint32_t cmdlist_pre_idxs)
+{
+	dss_overlay_t *pov_req = NULL;
+	char __iomem *cmdlist_base = NULL;
+	int i = 0;
+	uint32_t tmp = 0;
+	uint32_t offset = 0;
+	int ret = 0;
+
+	BUG_ON(hisifd = NULL);
+	pov_req = &(hisifd->ov_req);
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	offset = 0x40;
+
+	ret +	    hisi_cmdlist_add_new_node(hisifd, cmdlist_pre_idxs, 0, 1, 1, 1, 0);
+	if (ret != 0) {
+		HISI_FB_ERR("fb%d, hisi_cmdlist_add_new_node err:%d \n",
+			    hisifd->index, ret);
+		goto err_return;
+	}
+
+	for (i = 0; i < DSS_WCHN_W0; i++) {
+		tmp = (0x1 << i);
+		hisifd->cmdlist_idx = i;
+
+		if ((cmdlist_pre_idxs & tmp) = tmp) {
+			hisifd->set_reg(hisifd,
+					hisifd->dss_module.mctl_base[pov_req->
+								     ovl_idx] +
+					MCTL_CTL_MUTEX_RCH0 + i * 0x4, 0, 32,
+					0);
+			hisifd->set_reg(hisifd, cmdlist_base + CMDLIST_CH0_CTRL + i * offset, 0x6, 3, 2);
+		}
+	}
+
+	return 0;
+
+ err_return:
+	return ret;
+}
+
+void hisi_dss_cmdlist_qos_on(struct hisi_fb_data_type *hisifd)
+{
+	char __iomem *cmdlist_base = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_base = hisifd->dss_base + DSS_CMDLIST_OFFSET;
+	set_reg(cmdlist_base + CMDLIST_CTRL, 0x3, 2, 4);
+}
+
+void hisi_dump_cmdlist_node_items(cmd_item_t *item, uint32_t count)
+{
+	uint32_t index = 0;
+	uint32_t addr = 0;
+
+	for (index = 0; index < count; index++) {
+		addr = item[index].reg_addr.bits.add0;
+		addr = addr & CMDLIST_ADDR_OFFSET;
+		addr = addr << 2;
+		HISI_FB_INFO
+		    ("set addr:0x%x value:0x%x add1:0x%x value:0x%x "
+		     "add2:0x%x value:0x%x \n",
+		     addr, item[index].data0,
+		     item[index].reg_addr.bits.add1 << 2, item[index].data1,
+		     item[index].reg_addr.bits.add2 << 2, item[index].data2);
+	}
+}
+
+static void hisi_dump_cmdlist_content(struct list_head *cmdlist_head,
+				      char *filename, uint32_t addr)
+{
+	dss_cmdlist_node_t *node = NULL;
+	dss_cmdlist_node_t *_node_ = NULL;
+
+	BUG_ON(cmdlist_head = NULL);
+	BUG_ON(filename = NULL);
+
+	if (g_dump_cmdlist_content = 0)
+		return;
+
+	HISI_FB_INFO("%s\n", filename);
+
+	list_for_each_entry_safe(node, _node_, cmdlist_head, list_node) {
+		if (node->header_phys = addr) {
+			hisifb_save_file(filename, (char *)(node->list_header),
+					 CMDLIST_HEADER_LEN);
+		}
+
+		if (node->item_phys = addr) {
+			hisifb_save_file(filename, (char *)(node->list_item),
+					 CMDLIST_ITEM_LEN);
+		}
+	}
+}
+
+static void hisi_dump_cmdlist_one_node(struct list_head *cmdlist_head,
+				       uint32_t cmdlist_idx)
+{
+	dss_cmdlist_node_t *node = NULL;
+	dss_cmdlist_node_t *_node_ = NULL;
+	uint32_t count = 0;
+	int i = 0;
+	char filename[256] = { 0 };
+
+	BUG_ON(cmdlist_head = NULL);
+
+	list_for_each_entry_safe(node, _node_, cmdlist_head, list_node) {
+		if (node->node_type = CMDLIST_NODE_NOP) {
+			HISI_FB_INFO("node type = NOP node\n");
+		} else if (node->node_type = CMDLIST_NODE_FRAME) {
+			HISI_FB_INFO("node type = Frame node\n");
+		}
+
+		HISI_FB_INFO
+		    ("\t qos  | flag | pending | tast_end | last  | event_list | list_addr  | next_list  | count | id | is_used | reserved | cmdlist_idx\n");
+		HISI_FB_INFO
+		    ("\t ------+---------+------------+------------+------------+------------\n");
+		HISI_FB_INFO
+		    ("\t 0x%2x | 0x%2x |0x%6x | 0x%5x | 0x%3x | 0x%8x | 0x%8x | 0x%8x | 0x%3x | 0x%2x | 0x%2x | 0x%2x | 0x%2x\n",
+		     node->list_header->flag.bits.qos,
+		     node->list_header->flag.bits.valid_flag,
+		     node->list_header->flag.bits.pending,
+		     node->list_header->flag.bits.task_end,
+		     node->list_header->flag.bits.last,
+		     node->list_header->flag.bits.event_list,
+		     node->list_header->list_addr, node->list_header->next_list,
+		     node->list_header->total_items.bits.count,
+		     node->list_header->flag.bits.id, node->is_used,
+		     node->reserved, cmdlist_idx);
+
+		if (i = 0) {
+			snprintf(filename, 256,
+				 "/data/dssdump/list_start_0x%x.txt",
+				 (uint32_t) node->header_phys);
+			hisi_dump_cmdlist_content(cmdlist_head, filename,
+						  node->header_phys);
+		}
+#if 0
+		if ((node->list_header->next_list != 0x0) &&
+		    (node->list_header->next_list != 0xFFFFFFFF)) {
+			snprintf(filename, 256,
+				 "/data/dssdump/next_list_0x%x.txt",
+				 node->list_header->next_list);
+			hisi_dump_cmdlist_content(cmdlist_head, filename,
+						  node->list_header->next_list);
+		}
+
+		if ((node->list_header->list_addr != 0x0) &&
+		    (node->list_header->list_addr != 0xFFFFFFFF)) {
+			snprintf(filename, 256,
+				 "/data/dssdump/list_addr_0x%x.txt",
+				 node->list_header->list_addr);
+			hisi_dump_cmdlist_content(cmdlist_head, filename,
+						  node->list_header->list_addr);
+		}
+#endif
+		count = node->list_header->total_items.bits.count;
+		hisi_dump_cmdlist_node_items(node->list_item, count);
+
+		i++;
+	}
+}
+
+int hisi_cmdlist_dump_all_node(struct hisi_fb_data_type *hisifd,
+			       dss_overlay_t *pov_req, uint32_t cmdlist_idxs)
+{
+	int i = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	uint32_t wb_compose_type = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	if (pov_req) {
+		if (pov_req->wb_enable)
+			wb_compose_type = pov_req->wb_compose_type;
+	}
+
+	cmdlist_idxs_temp = cmdlist_idxs;
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if (0x1 = (cmdlist_idxs_temp & 0x1)) {
+			if (pov_req && pov_req->wb_enable) {
+				hisi_dump_cmdlist_one_node(&(hisifd->cmdlist_data_tmp
+							    [wb_compose_type]->cmdlist_head_temp[i]), i);
+			} else {
+				hisi_dump_cmdlist_one_node(&
+							   (hisifd->cmdlist_data->cmdlist_head_temp[i]), i);
+			}
+		}
+		cmdlist_idxs_temp = cmdlist_idxs_temp >> 1;
+	}
+
+	return 0;
+}
+
+int hisi_cmdlist_del_node(struct hisi_fb_data_type *hisifd,
+			  dss_overlay_t *pov_req, uint32_t cmdlist_idxs)
+{
+	int i = 0;
+	uint32_t cmdlist_idxs_temp = 0;
+	uint32_t wb_compose_type = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	if (pov_req) {
+		if (pov_req->wb_enable)
+			wb_compose_type = pov_req->wb_compose_type;
+	}
+
+	cmdlist_idxs_temp = cmdlist_idxs;
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		if ((cmdlist_idxs_temp & 0x1) = 0x1) {
+			if (pov_req && pov_req->wb_enable) {
+				hisi_cmdlist_del_all_node(&(hisifd->cmdlist_data_tmp
+							   [wb_compose_type]->cmdlist_head_temp[i]));
+			} else {
+				hisi_cmdlist_del_all_node(&
+							  (hisifd->cmdlist_data->cmdlist_head_temp[i]));
+			}
+		}
+		cmdlist_idxs_temp = (cmdlist_idxs_temp >> 1);
+	}
+
+	return 0;
+}
+
+static dss_cmdlist_data_t *hisi_cmdlist_data_alloc(struct hisi_fb_data_type
+						   *hisifd)
+{
+	int i = 0;
+	int j = 0;
+	dss_cmdlist_data_t *cmdlist_data = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_data +	    (dss_cmdlist_data_t *) kmalloc(sizeof(dss_cmdlist_data_t),
+					   GFP_ATOMIC);
+	if (cmdlist_data) {
+		memset(cmdlist_data, 0, sizeof(dss_cmdlist_data_t));
+	} else {
+		HISI_FB_ERR("failed to kmalloc cmdlist_data!\n");
+		return NULL;
+	}
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		INIT_LIST_HEAD(&(cmdlist_data->cmdlist_head_temp[i]));
+
+		for (j = 0; j < HISI_DSS_CMDLIST_NODE_MAX; j++) {
+			cmdlist_data->cmdlist_nodes_temp[i][j] +			    hisi_cmdlist_node_alloc(hisifd->ion_client);
+			if (cmdlist_data->cmdlist_nodes_temp[i][j] = NULL) {
+				HISI_FB_ERR
+				    ("failed to hisi_cmdlist_node_alloc!\n");
+				kfree(cmdlist_data);
+				return NULL;
+			}
+		}
+	}
+
+	return cmdlist_data;
+}
+
+static void hisi_cmdlist_data_free(struct hisi_fb_data_type *hisifd,
+				   dss_cmdlist_data_t *cmdlist_data)
+{
+	int i = 0;
+	int j = 0;
+
+	BUG_ON(hisifd = NULL);
+	BUG_ON(cmdlist_data = NULL);
+
+	for (i = 0; i < HISI_DSS_CMDLIST_MAX; i++) {
+		for (j = 0; j < HISI_DSS_CMDLIST_NODE_MAX; j++) {
+			hisi_cmdlist_node_free(hisifd->ion_client,
+					       hisifd->cmdlist_data->cmdlist_nodes_temp[i][j]);
+		}
+	}
+}
+
+static dss_cmdlist_info_t *hisi_cmdlist_info_alloc(struct hisi_fb_data_type
+						   *hisifd)
+{
+	int i = 0;
+	dss_cmdlist_info_t *cmdlist_info = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	cmdlist_info +	    (dss_cmdlist_info_t *) kmalloc(sizeof(dss_cmdlist_info_t), GFP_ATOMIC);
+	if (cmdlist_info) {
+		memset(cmdlist_info, 0, sizeof(dss_cmdlist_info_t));
+	} else {
+		HISI_FB_ERR("failed to kmalloc cmdlist_info!\n");
+		return NULL;
+	}
+
+	sema_init(&(cmdlist_info->cmdlist_wb_common_sem), 1);
+
+	for (i = 0; i < WB_TYPE_MAX; i++) {
+		sema_init(&(cmdlist_info->cmdlist_wb_sem[i]), 1);
+		init_waitqueue_head(&(cmdlist_info->cmdlist_wb_wq[i]));
+		cmdlist_info->cmdlist_wb_done[i] = 0;
+		cmdlist_info->cmdlist_wb_flag[i] = 0;
+	}
+
+	return cmdlist_info;
+}
+
+static dss_copybit_info_t *hisi_copybit_info_alloc(struct hisi_fb_data_type
+						   *hisifd)
+{
+	dss_copybit_info_t *copybit_info = NULL;
+
+	BUG_ON(hisifd = NULL);
+
+	copybit_info +	    (dss_copybit_info_t *) kmalloc(sizeof(dss_copybit_info_t),
+					   GFP_ATOMIC);
+	if (copybit_info) {
+		memset(copybit_info, 0, sizeof(dss_copybit_info_t));
+	} else {
+		HISI_FB_ERR("failed to kmalloc copybit_info!\n");
+		return NULL;
+	}
+
+	sema_init(&(copybit_info->copybit_sem), 1);
+
+	init_waitqueue_head(&(copybit_info->copybit_wq));
+	copybit_info->copybit_done = 0;
+
+	return copybit_info;
+}
+
+void hisi_cmdlist_data_get_online(struct hisi_fb_data_type *hisifd)
+{
+	int tmp = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	tmp = (hisifd->frame_count + 1) % HISI_DSS_CMDLIST_DATA_MAX;
+	hisifd->cmdlist_data = hisifd->cmdlist_data_tmp[tmp];
+	hisi_cmdlist_del_node(hisifd, NULL, HISI_DSS_CMDLIST_IDXS_MAX);
+
+	tmp = hisifd->frame_count % HISI_DSS_CMDLIST_DATA_MAX;
+	hisifd->cmdlist_data = hisifd->cmdlist_data_tmp[tmp];
+	hisi_cmdlist_del_node(hisifd, NULL, HISI_DSS_CMDLIST_IDXS_MAX);
+}
+
+int hisi_cmdlist_init(struct hisi_fb_data_type *hisifd)
+{
+	int ret = 0;
+	int i = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	for (i = 0; i < HISI_DSS_CMDLIST_BLOCK_MAX; i++) {
+		hisifd->ov_block_rects[i] +		    (dss_rect_t *) kmalloc(sizeof(dss_rect_t), GFP_ATOMIC);
+		if (!hisifd->ov_block_rects[i]) {
+			HISI_FB_ERR("ov_block_rects[%d] failed to alloc!", i);
+			return -EINVAL;
+		}
+	}
+
+	if (hisifd->index = AUXILIARY_PANEL_IDX) {
+		hisifd->cmdlist_data_tmp[0] = hisi_cmdlist_data_alloc(hisifd);
+		hisifd->cmdlist_data_tmp[1] = hisi_cmdlist_data_alloc(hisifd);
+		hisifd->cmdlist_info = hisi_cmdlist_info_alloc(hisifd);
+		hisifd->copybit_info = hisi_copybit_info_alloc(hisifd);
+	} else {
+		if (hisifd->index = PRIMARY_PANEL_IDX
+		    || (hisifd->index = EXTERNAL_PANEL_IDX
+			&& !hisifd->panel_info.fake_hdmi)) {
+			for (i = 0; i < HISI_DSS_CMDLIST_DATA_MAX; i++) {
+				hisifd->cmdlist_data_tmp[i] +				    hisi_cmdlist_data_alloc(hisifd);
+			}
+		}
+	}
+
+	hisifd->cmdlist_data = hisifd->cmdlist_data_tmp[0];
+	hisifd->cmdlist_idx = -1;
+
+	return ret;
+}
+
+int hisi_cmdlist_deinit(struct hisi_fb_data_type *hisifd)
+{
+	int i = 0;
+
+	BUG_ON(hisifd = NULL);
+
+	for (i = 0; i < HISI_DSS_CMDLIST_BLOCK_MAX; i++) {
+		if (hisifd->ov_block_rects[i]) {
+			kfree(hisifd->ov_block_rects[i]);
+			hisifd->ov_block_rects[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < HISI_DSS_CMDLIST_DATA_MAX; i++) {
+		if (hisifd->cmdlist_data_tmp[i]) {
+			hisi_cmdlist_data_free(hisifd,
+					       hisifd->cmdlist_data_tmp[i]);
+			kfree(hisifd->cmdlist_data_tmp[i]);
+			hisifd->cmdlist_data_tmp[i] = NULL;
+		}
+	}
+
+	if (hisifd->index = AUXILIARY_PANEL_IDX) {
+		if (hisifd->cmdlist_info) {
+			kfree(hisifd->cmdlist_info);
+			hisifd->cmdlist_info = NULL;
+		}
+
+		if (hisifd->copybit_info) {
+			kfree(hisifd->copybit_info);
+			hisifd->copybit_info = NULL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.h b/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.h
new file mode 100755
index 000000000000..5f5d8c0fd506
--- /dev/null
+++ b/drivers/video/fbdev/hisi/dss/hisi_overlay_cmdlist_utils.h
@@ -0,0 +1,249 @@
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
+#ifndef _CMD_LIST_UTILS_H_
+#define _CMD_LIST_UTILS_H_
+#include "hisi_overlay_utils_hi3660.h"
+
+#define HISI_DSS_CMDLIST_DATA_MAX	(3)
+#define HISI_DSS_CMDLIST_NODE_MAX	(32)
+#define HISI_DSS_CMDLIST_BLOCK_MAX	(32)
+
+#define HISI_DSS_SUPPORT_DPP_MODULE_BIT(module) \
+	(BIT(module) & HISI_DSS_DPP_MAX_SUPPORT_BIT)
+
+enum dpp_module_idx {
+	DPP_MODULE_POST_SCF = 0,
+	DPP_MODULE_DBUF,
+	DPP_MODULE_SBL,
+	DPP_MODULE_ACM,
+	DPP_MODULE_ACE,
+	DPP_MODULE_LCP_IGM,
+	DPP_MODULE_LCP_GMP,
+	DPP_MODULE_LCP_XCC,
+	DPP_MODULE_GAMA,
+	DPP_MODULE_DITHER,
+	DPP_MODULE_IFBC,
+	DPP_MODULE_MAX
+};
+
+enum wb_type {
+	WB_TYPE_WCH0,
+	WB_TYPE_WCH1,
+	WB_TYPE_WCH2,
+	WB_TYPE_WCH0_WCH1,
+
+	WB_TYPE_MAX,
+};
+
+enum dss_cmdlist_idx {
+	DSS_CMDLIST_NONE = -1,
+	DSS_CMDLIST_D2 = 0,
+	DSS_CMDLIST_D3,
+	DSS_CMDLIST_V0,
+	DSS_CMDLIST_G0,
+	DSS_CMDLIST_V1,
+	DSS_CMDLIST_G1,
+	DSS_CMDLIST_D0,
+	DSS_CMDLIST_D1,
+
+	DSS_CMDLIST_W0,
+	DSS_CMDLIST_W1,
+
+	DSS_CMDLIST_OV0,
+	DSS_CMDLIST_OV1,
+	DSS_CMDLIST_OV2,
+	DSS_CMDLIST_OV3,
+
+	DSS_CMDLIST_V2,
+	DSS_CMDLIST_W2,
+	DSS_CMDLIST_MAX,
+};
+
+typedef union {
+	struct {
+		uint32_t exec:1;
+		uint32_t last:1;
+		uint32_t nop:1;
+		uint32_t interrupt:1;
+		uint32_t pending:1;
+		uint32_t id:10;
+		uint32_t event_list:6;
+		uint32_t qos:1;
+		uint32_t task_end:1;
+		uint32_t reserved:1;
+		uint32_t valid_flag:8;
+	} bits;
+	uint32_t ul32;
+} cmd_flag_t;
+
+typedef union {
+	struct {
+		uint32_t count:14;
+		uint32_t reserved:18;
+	} bits;
+	uint32_t ul32;
+} total_items_t;
+
+typedef union {
+	struct {
+		uint32_t add0:18;
+		uint32_t add1:6;
+		uint32_t add2:6;
+		uint32_t cnt:2;
+	} bits;
+	uint32_t ul32;
+} reg_addr_t;
+
+typedef struct cmd_item {
+	reg_addr_t reg_addr;
+	uint32_t data0;
+	uint32_t data1;
+	uint32_t data2;
+} cmd_item_t;
+
+typedef struct cmd_header {
+	cmd_flag_t flag;
+	uint32_t next_list;
+	total_items_t total_items;
+	uint32_t list_addr;
+} cmd_header_t;
+
+enum dss_cmdlist_node_valid {
+	CMDLIST_NODE_INVALID = 0x0,
+	CMDLIST_NODE_VALID = 0xA5,
+};
+
+enum dss_cmdlist_node_type {
+	CMDLIST_NODE_NONE = 0x0,
+	CMDLIST_NODE_NOP = 0x1,
+	CMDLIST_NODE_FRAME = 0x2,
+};
+
+enum dss_cmdlist_status {
+	e_status_idle = 0x0,
+	e_status_wait = 0x1,
+	e_status_other,
+};
+
+/*
+ ** for normal node,all variable should be filled.
+ ** for NOP node, just the list_header,header_ion_handle, list_node, node_flag should be filled.
+ ** node_type must be CMDLIST_NODE_NOP when it is NOP node.
+ ** And item_ion_handle in NOP node should be NULL.
+ */
+typedef struct dss_cmdlist_node {
+	struct list_head list_node;
+
+	struct ion_handle *header_ion_handle;
+	ion_phys_addr_t header_phys;
+	cmd_header_t *list_header;
+
+	struct ion_handle *item_ion_handle;
+	ion_phys_addr_t item_phys;
+	cmd_item_t *list_item;
+
+	uint32_t item_index;
+	int item_flag;
+	uint32_t node_type;
+	int is_used;
+	int reserved;
+} dss_cmdlist_node_t;
+
+typedef struct dss_cmdlist_heads {
+	struct list_head cmdlist_head;
+
+	dss_cmdlist_node_t *cmdlist_nodes[HISI_DSS_CMDLIST_NODE_MAX];
+} dss_cmdlist_heads_t;
+
+typedef struct dss_cmdlist_data {
+	dss_cmdlist_heads_t *cmdlist_heads[HISI_DSS_CMDLIST_MAX];
+	struct list_head cmdlist_head_temp[HISI_DSS_CMDLIST_MAX];
+	dss_cmdlist_node_t
+	    *cmdlist_nodes_temp[HISI_DSS_CMDLIST_MAX]
+	    [HISI_DSS_CMDLIST_NODE_MAX];
+} dss_cmdlist_data_t;
+
+typedef struct dss_cmdlist_info {
+	struct semaphore cmdlist_wb_common_sem;
+	struct semaphore cmdlist_wb_sem[WB_TYPE_MAX];
+	wait_queue_head_t cmdlist_wb_wq[WB_TYPE_MAX];
+	uint32_t cmdlist_wb_done[WB_TYPE_MAX];
+	uint32_t cmdlist_wb_flag[WB_TYPE_MAX];
+} dss_cmdlist_info_t;
+
+typedef struct dss_copybit_info {
+	struct semaphore copybit_sem;
+	wait_queue_head_t copybit_wq;
+	uint32_t copybit_flag;
+	uint32_t copybit_done;
+} dss_copybit_info_t;
+
+typedef struct dss_wb_info {
+	uint32_t to_be_continued;
+	uint32_t cmdlist_idxs;
+	uint32_t wb_compose_type;
+	uint32_t mctl_idx;
+} dss_wb_info_t;
+
+extern dss_cmdlist_data_t *g_cmdlist_data;
+
+/******************************************************************************
+ ** FUNCTIONS PROTOTYPES
+ */
+void hisi_cmdlist_set_reg(struct hisi_fb_data_type *hisifd,
+			  char __iomem *addr, uint32_t value, uint8_t bw,
+			  uint8_t bs);
+void hisi_cmdlist_flush_cache(struct hisi_fb_data_type *hisifd,
+			      struct ion_client *ion_client,
+			      uint32_t cmdlist_idxs);
+
+dss_cmdlist_node_t *hisi_cmdlist_node_alloc(struct ion_client *ion_client);
+void hisi_cmdlist_node_free(struct ion_client *ion_client,
+			    dss_cmdlist_node_t *node);
+
+uint32_t hisi_cmdlist_get_cmdlist_need_start(struct hisi_fb_data_type *hisifd,
+					     uint32_t cmdlist_idxs);
+
+int hisi_cmdlist_get_cmdlist_idxs(dss_overlay_t *pov_req,
+				  uint32_t *cmdlist_pre_idxs,
+				  uint32_t *cmdlist_idxs);
+void hisi_cmdlist_data_get_online(struct hisi_fb_data_type *hisifd);
+
+int hisi_cmdlist_add_nop_node(struct hisi_fb_data_type *hisifd,
+			      uint32_t cmdlist_idxs, int pending, int reserved);
+int hisi_cmdlist_add_new_node(struct hisi_fb_data_type *hisifd,
+			      uint32_t cmdlist_idxs, int pending, int task_end,
+			      int remove, int last, uint32_t wb_type);
+int hisi_cmdlist_del_all_node(struct list_head *cmdlist_heads);
+
+int hisi_cmdlist_config_start(struct hisi_fb_data_type *hisifd, int mctl_idx,
+			      uint32_t cmdlist_idxs, uint32_t wb_compose_type);
+int hisi_cmdlist_config_stop(struct hisi_fb_data_type *hisifd,
+			     uint32_t cmdlist_idxs);
+void hisi_cmdlist_config_reset(struct hisi_fb_data_type *hisifd,
+			       dss_overlay_t *pov_req, uint32_t cmdlist_idxs);
+
+int hisi_cmdlist_del_node(struct hisi_fb_data_type *hisifd,
+			  dss_overlay_t *pov_req, uint32_t cmdlist_idxs);
+int hisi_cmdlist_check_cmdlist_state(struct hisi_fb_data_type *hisifd,
+				     uint32_t cmdlist_idxs);
+
+int hisi_cmdlist_exec(struct hisi_fb_data_type *hisifd, uint32_t cmdlist_idxs);
+void hisi_dss_cmdlist_qos_on(struct hisi_fb_data_type *hisifd);
+int hisi_cmdlist_dump_all_node(struct hisi_fb_data_type *hisifd,
+			       dss_overlay_t *pov_req, uint32_t cmdlist_idxs);
+
+int hisi_cmdlist_init(struct hisi_fb_data_type *hisifd);
+int hisi_cmdlist_deinit(struct hisi_fb_data_type *hisifd);
+
+#endif
-- 
2.12.0-rc0

