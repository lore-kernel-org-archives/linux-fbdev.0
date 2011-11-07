From: Jun Nie <niej0001@gmail.com>
Date: Mon, 07 Nov 2011 10:20:10 +0000
Subject: RFC: abstract common HDMI code
Message-Id: <CAGA24MJM8rW2S24Tn97iYD6Sxw2q+DVb1Dq8kzSY6+hbv-1x2w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f46d0444016258a5e404b12266ab"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--f46d0444016258a5e404b12266ab
Content-Type: text/plain; charset=ISO-8859-1

Hi everyone,

    I am writing another HDMI driver for our new SOC and find that
sh_mobile_hdmi.c implemented some logic that can be reused by my
driver. I do not want to duplicated similar code and enlarge kernel
code size with it. So my plan is to abstract some common code to an
independent file to ease other developers. If you guys think it is
good to have a such common layer, I will put more effort on this and
contribute to the community. Also any help and co-work is warmly
welcomed!

    The attachment is my every preliminary code that only support
video resolution change and hot-plug on my platform with my private
code base. Sorry for the lot of style issues and small bugs for my
hurry debug. In my code, video resolution interface is still based on
original /sys/class/graphics/fb1/mode and more HDMI specific item is
added in /sys/class/hdmi/, such as video ratio. EDID part is not
ported yet and use predefined mode list in the first step. ASoC can be
added later just as sh_mobile_hdmi.c does, CEC and DHCP are the same.

    Thanks for any comments!

Jun


diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
new file mode 100644
index 0000000..c845dc7
--- /dev/null
+++ b/drivers/video/hdmi.c
@@ -0,0 +1,675 @@
+/*
+ * HDMI Control Abstraction
+ *
+ * This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/freezer.h>
+#include <linux/hdmi.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/lcd.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define HDMI_DEBUG
+static int hdmi_core_debug = 5;
+#define hdmi_dprintk(level, fmt, arg...)	if (hdmi_core_debug >= level) \
+	printk(KERN_DEBUG "%s: " fmt , __func__, ## arg)
+
+/* Define the max number of events to buffer */
+#define MAX_HDMI_EVENT_SIZE      16
+
+static int hdmidevno;
+
+/* ==================== info frame utility ===================== */
+
+int hdmi_vender_info_frame (struct hdmi_dev *hd, char buf[])
+{
+	buf[0] = 0x84;
+	buf[1] = 0x1;
+	buf[2] = 0xa;
+	buf[3] = 0x70;
+	buf[4] = 0x1;
+}
+EXPORT_SYMBOL_GPL(hdmi_vender_info_frame);
+
+int hdmi_avi_info_frame (struct hdmi_dev *hd, char buf[])
+{
+	int count;
+	char check_sum;
+
+	hdmi_dprintk(3, "pack avi infoframe\n");
+	/* packet header for AVI Packet in pkt1 */
+	/* Fix me. we should set bits according to format */
+	buf[0] = 0x82; /* InfoFrame Type, AVI frame */
+	buf[1] = 0x2;  /* Version = 02 */
+	buf[2] = 0xd;  /* Length = 13 */
+	buf[3] = 0x0;  /* checksum */
+	buf[4] = 0x0; /* Fix to RGB format currently */
+	/*
+	buf[4] = 0x10; // RGB, Active Format(r0,r1,r2,r3) valid, no bar, no scan
+	buf[4] = 0x30; // HDMI_YUV422, Active Format(r0,r1,r2,r3) valid, no
bar, no scan
+	buf[4] = 0x50; // HDMI_YUV444, Active Format(r0,r1,r2,r3) valid, no
bar, no scan
+	*/
+
+	buf[5] = 0xa8;  /* ITU-R 709, 16:9 */
+	buf[6] = 0x20;
+	/* buf[6] = 0x0;   // No IT content, xvYCC601, no scaling */
+	buf[7] = hd->mode_id;
+	/* limited YCC range, graphics, no repeat  Pixel repitition factor */
+	buf[8] = hd->pixel_rept;
+
+	buf[9] = 0x0;
+	buf[10] = 0x0;
+	buf[11] = 0x0;
+	buf[12] = 0x0;
+	buf[13] = 0x0;
+	check_sum = 0;
+    for (count = 0; count < 14; count++)
+	    check_sum += buf[count];
+    buf[3] = 0x100 - check_sum;
+    return 0;
+}
+EXPORT_SYMBOL_GPL(hdmi_avi_info_frame);
+
+int hdmi_get_freq (struct hdmi_dev *hd, u32 *need_freq)
+{
+	u64 div_result;
+	int freq;
+
+	/* Calc divider according to pclk in pico second */
+	div_result = 1000000000000ll;
+	do_div(div_result, cea_modes[hd->mode_id].pixclock);
+	freq = (u32)div_result;
+
+	hdmi_dprintk(3, "get base pclk %d\n", freq);
+
+	if (FB_VMODE_INTERLACED & cea_modes[hd->mode_id].vmode)
+		freq >>= 1;
+
+	if (36 == hd->fb_info->var.bits_per_pixel)
+		freq += freq >> 1;
+	else if (30 == hd->fb_info->var.bits_per_pixel)
+		freq += freq >> 2;
+
+	/* We only support repeat=2/4 currently. Add more later */
+	if (!(hd->pixel_rept == 0 || hd->pixel_rept == 1
+				|| hd->pixel_rept == 3)) {
+		hdmi_dprintk(3, "Not support pix repeat %d\n", hd->pixel_rept);
+		return -EINVAL;
+	}
+
+	if (1 == hd->pixel_rept)
+	{
+		if (!(FB_VMODE_INTERLACED & cea_modes[hd->mode_id].vmode))
+			freq <<= 1;
+	} else if (3 == hd->pixel_rept) {
+		if (!(FB_VMODE_INTERLACED & cea_modes[hd->mode_id].vmode))
+			freq <<= 2;
+		else
+			freq <<= 1;
+	}
+
+	hdmi_dprintk(3, "get hdmi pclk %d\n", freq);
+	*need_freq = freq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdmi_get_freq);
+
+/* ==================== video part ===================== */
+int hdmi_lcd_check_fb(struct lcd_device * ld, struct fb_info *fi)
+{
+	struct hdmi_dev *hd = lcd_get_data(ld);
+
+	hdmi_dprintk(3, "hdmi_lcd_check_fb..\n");
+	return 1;
+}
+
+/* We'd better update mode list in hot plug operation.
+   LCD framework does not implement get_mode yet */
+static int hdmi_lcd_get_mode(struct lcd_device *ld, struct fb_videomode *mode)
+{
+	struct hdmi_dev *hd = lcd_get_data(ld);
+
+	/* TODO: return parsed mode list */
+	return 0;
+}
+
+static int hdmi_lcd_set_mode(struct lcd_device *ld, struct fb_videomode *mode)
+{
+	//struct hdmi_lcd_data *data = lcd_get_data(lcd);
+	struct hdmi_dev *hd = lcd_get_data(ld);
+	cea_mode_id mode_id;
+
+	hdmi_dprintk(3, "hdmi_lcd_set_mode dev\n");
+	mode_id = fb_find_cea_mode_index(mode);
+	if (!mode_id) {
+		hdmi_dprintk(1, "unknown video mode %d\n", mode_id);
+		return -EINVAL;
+	}
+	/* If high level on detection signal, no connection */
+	if(! hd->ops->get_hpd(hd))
+		return 0;
+
+	hd->ops->set_mode(hd, mode_id);
+
+	if (hd->ops && hd->ops->set_enable)
+		hd->ops->set_enable(hd, 1);
+}
+
+static struct lcd_ops hdmi_lcd_ops = {
+	.get_mode = hdmi_lcd_get_mode,
+	.set_mode = hdmi_lcd_set_mode,
+	.check_fb = hdmi_lcd_check_fb,
+};
+
+static int hdmi_register_lcd(struct hdmi_dev *dev)
+{
+	int ret = 0;
+
+	hdmi_dprintk(3, "registering lcd device...\n");
+	/* FIX ME! How to hook expected fb if more than one fb exist? */
+	dev->lcd = lcd_device_register("hdmi-lcd", dev->dev, dev,
+			&hdmi_lcd_ops);
+
+	if (IS_ERR(dev->lcd)) {
+		ret = PTR_ERR(dev->lcd);
+		dev->lcd = NULL;
+		return ret;
+	}
+	hdmi_dprintk(3, "registering lcd device ok\n");
+	return 0;
+}
+
+/* ==================== audio part ===================== */
+/* ==================== cec part ===================== */
+/* ==================== edid part ===================== */
+
+/* ==================== hot plug part ===================== */
+static int hdmi_hotplug(struct hdmi_dev *hd)
+{
+	int ret;
+
+	msleep(100);
+	ret = hd->ops->get_hpd(hd);
+	if(!ret) {
+		hdmi_dprintk(3, "uplugged. dev %p\n", hd);
+		ret = hd->ops->set_enable(hd, 0);
+		lock_fb_info(hd->fb_info);
+		/* We should clear mode list here */
+		/* ... */
+		unlock_fb_info(hd->fb_info);
+		return 0;
+	}
+
+	ret = hd->ops->init(hd);
+	if (ret) {
+		hdmi_dprintk(1, "init fail\n");
+	}
+
+	if(hd->fb_info && hd->fb_info->mode) {
+		lock_fb_info(hd->fb_info);
+		/* Fix me! We should get EDID and parse mode list here */
+		/* But now we use fix mode list first before EDID util is ready */
+		/* ... */
+		unlock_fb_info(hd->fb_info);
+
+		ret = hdmi_lcd_set_mode(hd->lcd, hd->fb_info->mode);
+		if (ret) {
+			hdmi_dprintk(1, "fail to set video mode\n");
+		}
+	} else {
+		hdmi_dprintk(3, "no avaliable video mode\n");
+	}
+
+	if (hd->enable)
+		ret = hd->ops->set_enable(hd, 1);
+	return ret;
+}
+
+/* Handling hot plug HDCP and CEC */
+static int hdmi_event_thread(void *data)
+{
+	struct hdmi_dev *dev = (struct hdmi_dev *)data;
+	struct hdmi_event *evt;
+
+	while (!kthread_should_stop()) {
+
+		spin_lock_irq(&dev->lock);
+		if (list_empty(&dev->hdmi_evt_list)) {
+			set_current_state(TASK_INTERRUPTIBLE);
+
+			if (kthread_should_stop())
+				set_current_state(TASK_RUNNING);
+
+			spin_unlock_irq(&dev->lock);
+			schedule();
+			continue;
+		}
+
+		evt = list_entry(dev->hdmi_evt_list.next, typeof(*evt), list);
+		list_del(&evt->list);
+		spin_unlock_irq(&dev->lock);
+		hdmi_dprintk(1, "Receive evt type %d\n", evt->type);
+
+		mutex_lock(&dev->hdmi_lock);
+		switch (evt->type) {
+			/* trigger gpio irq */
+			case HDMI_EV_PLUG:
+				hdmi_hotplug(dev);
+				break;
+			/* trigger from TV/CEC */
+			case HDMI_EV_CEC:
+				break;
+			default:
+				hdmi_dprintk(1, "Invalid event type %d\n", evt->type);
+				break;
+		}
+		mutex_unlock(&dev->hdmi_lock);
+	}
+
+	return 0;
+}
+
+/**
+ * hdmi_event_signal() - schedules the hdmi event thread
+ * @dev:	the struct hdmi_dev device
+ *
+ * This routine will tell hdmi-core to start decoding stored ir data.
+ */
+void hdmi_event_signal(struct hdmi_dev *dev, enum hdmi_event_type type)
+{
+	unsigned long flags;
+	struct hdmi_event *evt;
+
+	hdmi_dprintk(1, "hdmi event %d stored, dev %p\n", type, dev);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if(HDMI_EV_PLUG == type) {
+		list_for_each_entry(evt, &dev->hdmi_evt_list, list) {
+			if (HDMI_EV_PLUG == evt->type) {
+				hdmi_dprintk(1, "pending hotplug event, ignore new ones\n");
+				spin_unlock_irqrestore(&dev->lock, flags);
+				return;
+			}
+		}
+	}
+	evt = list_entry(dev->free_evt_list.next, struct hdmi_event, list);
+	evt->type = type;
+	list_move_tail(&evt->list, &dev->hdmi_evt_list);
+	wake_up_process(dev->thread);
+	spin_unlock_irqrestore(&dev->lock, flags);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_signal);
+
+/* ==================== sys fs part ===================== */
+#ifdef HDMI_DEBUG
+static ssize_t hdmi_show_reg(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int rc;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->get_reg)
+		rc = sprintf(buf, "%d\n", hd->ops->get_reg(hd));
+	else
+		rc = -ENXIO;
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_store_reg(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	char *endp;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+	int power = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->set_reg) {
+		hd->ops->set_reg(hd, power, power);
+		rc = count;
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_show_reg_addr(struct device *dev, struct
device_attribute *attr,
+		char *buf)
+{
+	int rc;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->get_reg)
+		rc = sprintf(buf, "%d\n", hd->ops->get_reg(hd));
+	else
+		rc = -ENXIO;
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_store_reg_addr(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	char *endp;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+	int power = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->set_reg) {
+		hd->ops->set_reg(hd, power, power);
+		rc = count;
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+#endif
+
+static ssize_t hdmi_show_ratio(struct device *dev, struct
device_attribute *attr,
+		char *buf)
+{
+	int rc;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ratio == RATIO_16V9)
+		rc = sprintf(buf, "%s\n", RATIO_16V9_STR);
+	else if (hd->ratio == RATIO_4V3)
+		rc = sprintf(buf, "%s\n", RATIO_4V3_STR);
+	else
+		rc = -ENXIO;
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_store_ratio(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (sysfs_streq(buf, RATIO_16V9_STR)) {
+		hd->ratio = RATIO_16V9;
+	} else if (sysfs_streq(buf, RATIO_4V3_STR)) {
+		hd->ratio = RATIO_4V3;
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_show_power(struct device *dev, struct
device_attribute *attr,
+		char *buf)
+{
+	int rc;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->get_power) {
+		hd->ops->get_power(hd);
+		rc = sprintf(buf, "%d\n", hd->ops->get_power(hd));
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_store_power(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	char *endp;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+	int power = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
+
+	if (isspace(*endp))
+		size++;
+	if (size != count)
+		return -EINVAL;
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->set_power) {
+		hdmi_dprintk(3, "hdmi: set power to %d\n", power);
+		hd->ops->set_power(hd, power);
+		rc = count;
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_show_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int rc = -ENXIO;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->get_enable)
+		rc = sprintf(buf, "%d\n", hd->ops->get_enable(hd));
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_store_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	char *endp;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+	int enable = simple_strtoul(buf, &endp, 0);
+	size_t size = endp - buf;
+
+	if (isspace(*endp))
+		size++;
+	if (size != count)
+		return -EINVAL;
+
+	mutex_lock(&hd->update_lock);
+	hd->enable = enable;
+	if (hd->ops && hd->ops->set_enable) {
+		hdmi_dprintk(3, "hdmi: set enable to %d\n", enable);
+		hd->ops->set_enable(hd, enable);
+		rc = count;
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static ssize_t hdmi_show_hotplug(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc = -ENXIO;
+	char *endp;
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+
+	mutex_lock(&hd->update_lock);
+	if (hd->ops && hd->ops->get_hpd) {
+		rc = sprintf(buf, "%d\n", ! hd->ops->get_hpd(hd));
+	}
+	mutex_unlock(&hd->update_lock);
+
+	return rc;
+}
+
+static struct class *hdmi_class;
+
+static void hdmi_dev_release(struct device *dev)
+{
+	struct hdmi_dev *hd = dev_get_drvdata(dev);
+	kfree(hd);
+}
+
+static struct device_attribute hdmi_dev_attributes[] = {
+	__ATTR(power, 0644, hdmi_show_power, hdmi_store_power),
+	__ATTR(ratio, 0644, hdmi_show_ratio, hdmi_store_ratio),
+#ifdef HDMI_DEBUG
+	__ATTR(reg_val, 0644, hdmi_show_reg, hdmi_store_reg),
+	__ATTR(reg_addr, 0644, hdmi_show_reg_addr, hdmi_store_reg_addr),
+#endif
+	__ATTR(enable, 0644, hdmi_show_enable, hdmi_store_enable),
+	__ATTR(hotplug, 0644, hdmi_show_hotplug, NULL),
+	__ATTR_NULL,
+};
+
+/**
+ * hdmi_dev_register - register a new object of hdmi_dev class.
+ * @name: the name of the new object(must be the same as the name of the
+ *   respective framebuffer device).
+ * @devdata: an optional pointer to be stored in the device. The
+ *   methods may retrieve it by using hdmi_get_data(hd).
+ * @ops: the hdmi operations structure.
+ *
+ * Creates and registers a new hdmi device. Returns either an ERR_PTR()
+ * or a pointer to the newly allocated device.
+ */
+int hdmi_dev_register(struct hdmi_dev *hd, struct device *parent,
+		void *devdata, struct hdmi_ops *ops, int fb_index)
+{
+	struct hdmi_event *evt_list;
+	int i;
+	int rc;
+
+	hd->dev = device_create(hdmi_class, parent,
+			MKDEV(HDMI_MAJOR, hdmidevno), hd, "hdmi%d", hdmidevno);
+	if (IS_ERR(hd->dev)) {
+		/* Not fatal */
+		hdmi_dprintk(1, "Unable to create device for hdmi %d; errno = %ld\n",
+			hdmidevno, PTR_ERR(hd->dev));
+		hd->dev = NULL;
+	}
+
+	spin_lock_init(&hd->lock);
+	mutex_init(&hd->hdmi_lock);
+	mutex_init(&hd->update_lock);
+
+	INIT_LIST_HEAD(&hd->hdmi_evt_list);
+	INIT_LIST_HEAD(&hd->free_evt_list);
+	hd->evt_ptr = evt_list =
+		kzalloc(MAX_HDMI_EVENT_SIZE * sizeof(struct hdmi_event), GFP_KERNEL);
+	for (i = 0; i < MAX_HDMI_EVENT_SIZE; i++) {
+		list_add(&evt_list->list, &hd->free_evt_list);
+		evt_list ++;
+	}
+
+	rc = hdmi_register_lcd(hd);
+	if (rc) {
+		device_unregister(hd->dev);
+		hdmi_dprintk(1, "Unable to create lcd device for hdmi\n");
+		goto dev_out;
+	}
+
+	hd->ops = ops;
+	hd->fb_info = registered_fb[fb_index];
+	if (! hd->fb_info) {
+		hdmi_dprintk(1, "Invalid associated fb\n");
+		goto dev_out;
+	}
+
+	/* Register CEC input device here */
+	/* Register audio Asoc device here */
+	/* Init hot plug uevent here */
+	/* Init HDCP here */
+
+	hd->thread = kthread_run(hdmi_event_thread, hd,
+				       "hdmi%d", hdmidevno++);
+
+	if (IS_ERR(hd->thread)) {
+		rc = PTR_ERR(hd->thread);
+		hdmi_dprintk(1, "Unable to create internal thread for hdmi\n");
+		goto lcd_out;
+	}
+
+	return 0;
+
+	kthread_stop(hd->thread);
+lcd_out:
+	lcd_device_unregister(hd->lcd);
+dev_out:
+	device_unregister(hd->dev);
+	hdmi_dprintk(1, "Fail to register hdmi dev\n");
+	return rc;
+}
+EXPORT_SYMBOL(hdmi_dev_register);
+
+/**
+ * hdmi_dev_unregister - unregisters a object of hdmi_dev class.
+ * @hd: the hdmi device object to be unregistered and freed.
+ *
+ * Unregisters a previously registered via hdmi_dev_register object.
+ */
+void hdmi_dev_unregister(struct hdmi_dev *hd)
+{
+	if (!hd)
+		return;
+
+	mutex_lock(&hd->hdmi_lock);
+	hd->ops = NULL;
+	mutex_unlock(&hd->hdmi_lock);
+	lcd_device_unregister(hd->lcd);
+
+	kthread_stop(hd->thread);
+	device_unregister(hd->dev);
+}
+EXPORT_SYMBOL(hdmi_dev_unregister);
+
+static void __exit hdmi_class_exit(void)
+{
+	class_destroy(hdmi_class);
+}
+
+static int __init hdmi_class_init(void)
+{
+	hdmi_dprintk(1, "create hdmi class...\n");
+	hdmi_class = class_create(THIS_MODULE, "hdmi");
+	if (IS_ERR(hdmi_class)) {
+		hdmi_dprintk(1, "Unable to create hdmi class; errno = %ld\n",
+				PTR_ERR(hdmi_class));
+		return PTR_ERR(hdmi_class);
+	}
+
+	hdmi_class->dev_attrs = hdmi_dev_attributes;
+	hdmi_dprintk(1, "create hdmi class ok\n");
+	return 0;
+}
+
+subsys_initcall(hdmi_class_init);
+module_exit(hdmi_class_exit);
+
+module_param_named(debug, hdmi_core_debug, int, 0644);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/hdmi-mmp.c b/drivers/video/hdmi-mmp.c
new file mode 100644
index 0000000..f71f9fa
--- /dev/null
+++ b/drivers/video/hdmi-mmp.c
@@ -0,0 +1,445 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/freezer.h>
+#include <linux/gpio.h>
+#include <linux/hdmi.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/lcd.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <mach/mmp_hdmi.h>
+#include "hdmi-mmp.h"
+
+struct hdmi_mmp_dev {
+	struct hdmi_dev hdmi_dev;
+	struct clk *clk;
+	void *base;
+	void *sspa1_reg_base;
+	unsigned int gpio;
+	unsigned int irq;
+};
+
+static void hdmi_direct_write(void *base, unsigned addr, unsigned data)
+{
+	__raw_writel(data, base + BASE_OFFSET + addr);
+}
+
+static unsigned hdmi_direct_read(void *base, unsigned addr)
+{
+	return __raw_readl(base + BASE_OFFSET + addr);
+}
+
+static unsigned hdmi_read(void *base, unsigned addr)
+{
+	__raw_writel(addr | 1 << 30, base + BASE_OFFSET + HDMI_ADDR);
+	return __raw_readl((base + BASE_OFFSET + HDMI_DATA)) & 0xff;
+}
+
+static void hdmi_write(void *base, unsigned addr, unsigned data)
+{
+	__raw_writel(data & 0xff, base + BASE_OFFSET + HDMI_DATA);
+	__raw_writel(addr | 1 << 31, base + BASE_OFFSET + HDMI_ADDR);
+}
+
+static void hdmi_write_multi(struct hdmi_mmp_dev *md, u32 addr, u8 *buf,
+		u32 length)
+{
+	u32 i;
+	for (i = 0; i < length; i++)
+		hdmi_write(md->base, addr + i, *(buf + i));
+}
+
+static int hdmi_mmp_init_controller(struct hdmi_dev *dev)
+{
+	struct hdmi_mmp_dev *md = (struct hdmi_mmp_dev *)dev;
+	u32 tmp;
+
+	printk(KERN_DEBUG "Init mmp hdmi ctroller...\n");
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_2, 1<<27);
+
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_0, 0X00249b6d);
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_1, 0X0492eeee);
+	/* hdmi_direct_write(md->base, HDMI_PHY_CFG_2, 0X00003c30); */
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_2, 0X00003c10);
+	tmp = hdmi_direct_read(md->base, HDMI_PHY_CFG_3);
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_3, (tmp | 0X0000001));
+	msleep(50);
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_3, (tmp & (~0X0000001)));
+	/* temporatyly set the aduio cfg */
+	/* hdmi_direct_write(md->base, HDMI_AUDIO_CFG, 0x869); */
+
+	hdmi_write(md->base, HDTX_HST_PKT_CTRL0, 0);
+	hdmi_write(md->base, HDTX_HST_PKT_CTRL1, 0);
+
+	return 0;
+}
+
+static int hdmi_mmp_set_freq(struct hdmi_mmp_dev *md)
+{
+	int ret = 0;
+
+	/* Fix the pll2refdiv to 1(+2), to get 8.66MHz ref clk
+	 * Stable val recomended between 8-12MHz. To get the reqd
+	 * freq val, just program the fbdiv
+	 * freq takes effect during a fc req
+	 */
+	u32 residual;
+	volatile unsigned int temp = 0;
+	u32 freq;
+	unsigned int postdiv;
+	unsigned int freq_offset_inner;
+	unsigned int hdmi_pll_fbdiv;
+	unsigned int hdmi_pll_refdiv;
+	unsigned int kvco;
+	unsigned int freq_offset_inner_16;
+	unsigned int VPLL_CALCLK_DIV = 1;
+	unsigned int VDDM = 1;
+	unsigned int VDDL = 0x9;
+	unsigned int ICP = 0x9;
+	unsigned int VREG_IVREF = 2;
+	unsigned int INTPI = 5;
+	unsigned int VTH_VPLL_CA = 2;
+	int count = 0x10000;
+
+	ret = hdmi_get_freq ((struct hdmi_dev *)md, &freq);
+	if (ret)
+		return ret;
+
+	freq /= 1000;
+	/* round to freq = N*100k Hz */
+	residual = freq % 100;
+	freq = residual? (freq + 100 - residual) : freq;
+	freq /= 1000;
+
+	switch (freq) {
+	case 25:
+		postdiv = 0x3;
+		freq_offset_inner = 0x1C47;
+		freq_offset_inner_16 = 1;
+		hdmi_pll_fbdiv = 39;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	case 27:
+		postdiv = 0x3;
+		freq_offset_inner = 0x2d03;
+		freq_offset_inner_16 = 1;
+		hdmi_pll_fbdiv = 42;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	case 54:
+		postdiv = 0x2;
+		freq_offset_inner = 0x2d03;
+		freq_offset_inner_16 = 1;
+		hdmi_pll_fbdiv = 42;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	case 74:
+		postdiv = 0x2;
+		freq_offset_inner = 0x084B;
+		freq_offset_inner_16 = 0;
+		hdmi_pll_fbdiv = 57;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	case 108:
+		postdiv = 0x1;
+		freq_offset_inner = 0x2d03;
+		freq_offset_inner_16 = 1;
+		hdmi_pll_fbdiv = 42;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	case 148:
+		postdiv = 0x1;
+		freq_offset_inner = 0x084B;
+		freq_offset_inner_16 = 0;
+		hdmi_pll_fbdiv = 57;
+		hdmi_pll_refdiv = 0;
+		kvco = 0x4;
+		break;
+	default:
+		printk(KERN_ERR "not supported freq %d\n", freq);
+		return -EINVAL;
+	}
+
+	hdmi_direct_write(md->base, HDMI_CLOCK_CFG, 1|1<<2|1<<4|4<<5|5<<9|5<<13);
+	//hdmi_direct_write(md->base, HDMI_CLOCK_CFG, 1|1<<2|4<<5|5<<9|5<<13);
+
+	/* power up the pll */
+	temp |= HDMI_PLL_CFG_3_HDMI_PLL_ON;
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_3, temp);
+
+	temp = ((INTPI << HDMI_PLL_CFG_0_INTPI_BASE)	|
+			(HDMI_PLL_CFG_0_CLK_DET_EN)	|
+			(VDDM << HDMI_PLL_CFG_0_VDDM_BASE)	|
+			(VDDL << HDMI_PLL_CFG_0_VDDL_BASE)	|
+			(ICP << HDMI_PLL_CFG_0_ICP_BASE)	|
+			(kvco << HDMI_PLL_CFG_0_KVCO_BASE)	|
+			(VREG_IVREF << HDMI_PLL_CFG_0_VREG_IVREF_BASE)	|
+			(VPLL_CALCLK_DIV << HDMI_PLL_CFG_0_VPLL_CALCLK_DIV_BASE) |
+			(postdiv << HDMI_PLL_CFG_0_POSTDIV_BASE)	|
+			(ICP  << HDMI_PLL_CFG_0_ICP_BASE));
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_0, temp);
+
+	temp = ((HDMI_PLL_CFG_1_MODE) |
+			(HDMI_PLL_CFG_1_EN_PANNEL)|
+			(HDMI_PLL_CFG_1_EN_HDMI)|
+			(VTH_VPLL_CA << HDMI_PLL_CFG_1_VTH_VPLL_CA_BASE)|
+			(freq_offset_inner << HDMI_PLL_CFG_1_FREQ_OFFSET_INNER_BASE)|
+			(freq_offset_inner_16 << 20));
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_1, temp);
+
+	temp = 0;
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_2, temp);
+
+	/* Power Down the pll and set the divider ratios*/
+	temp = (hdmi_pll_fbdiv << HDMI_PLL_CFG_3_HDMI_PLL_FBDIV_BASE)|
+		(hdmi_pll_refdiv << HDMI_PLL_CFG_3_HDMI_PLL_REFDIV_BASE);
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_3, temp);
+
+	/* power up the pll */
+	temp |= HDMI_PLL_CFG_3_HDMI_PLL_ON;
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_3, temp);
+
+	/*wait 10us : just an estimate*/
+	udelay(100);
+
+	/* release the pll out of reset*/
+	temp |= HDMI_PLL_CFG_3_HDMI_PLL_RSTB;
+	hdmi_direct_write(md->base, HDMI_PLL_CFG_3, temp);
+
+	/* PLL_LOCK should be 1, */
+	temp = hdmi_direct_read(md->base, HDMI_PLL_CFG_3);
+	temp &= 0x400000;
+	while ( !temp )	{
+		temp = hdmi_direct_read(md->base, HDMI_PLL_CFG_3);
+		temp &= 0x400000;
+		udelay(10);
+		count--;
+		if (count <= 0) {
+			printk(KERN_ERR "%s PLL lock error, PLL_CFG_3 %x\n",
+				__func__, temp);
+			return -EIO;
+		}
+	}
+	/* pll stablize in 10ms */
+	msleep(10);
+	return ret;
+}
+
+static irqreturn_t hdmi_mmp_hpd(int irq, void *data)
+{
+	printk(KERN_INFO "gpio hpd detected\n");
+
+	hdmi_event_signal((struct hdmi_dev *)data, HDMI_EV_PLUG);
+	return IRQ_HANDLED;
+}
+
+static int hdmi_mmp_get_hpd_status (struct hdmi_dev *dev)
+{
+	struct hdmi_mmp_dev *mh = (struct hdmi_mmp_dev *)dev;
+
+	return ! gpio_get_value(mh->gpio);
+}
+
+static int hdmi_send_packet (struct hdmi_mmp_dev *md, char *buf, int idx)
+{
+	u32 v;
+
+	hdmi_write_multi (md, HDTX_PKT0_BYTE0 + 0x20 * idx, buf, 32);
+
+	v = hdmi_read(md->base, HDTX_HST_PKT_CTRL0);
+	hdmi_write(md->base, HDTX_HST_PKT_CTRL0, v | (1 << idx));
+	/* HW bug */
+	v &= ~(1 << idx);
+	hdmi_write(md->base, HDTX_HST_PKT_CTRL0, v);
+	v = hdmi_read(md->base, HDTX_HST_PKT_CTRL1);
+	hdmi_write(md->base, HDTX_HST_PKT_CTRL1, v | (1 << idx));
+}
+
+static int hdmi_mmp_get_reg (struct hdmi_dev *dev)
+{
+	struct hdmi_mmp_dev *md = (struct hdmi_mmp_dev *)dev;
+	int i;
+
+	printk("************direct register*******************\n");
+	for (i = 0x8; i <= 0x30; i += 4)
+		printk("direct offset 0x%x is 0x%x\n", i, hdmi_direct_read(md->base, i));
+	printk("************indirect register*******************\n");
+	for (i = 0; i < 0x13e; i++)
+		printk("offset 0x%x is 0x%x\n", i, hdmi_read(md->base, i));
+}
+
+static int hdmi_mmp_set_reg (struct hdmi_dev *dev)
+{
+	struct hdmi_mmp_dev *md = (struct hdmi_mmp_dev *)dev;
+
+	return 0;
+}
+
+static int hdmi_mmp_set_mode (struct hdmi_dev *dev, cea_mode_id id)
+{
+	char *buf;
+	u32 v;
+	struct hdmi_mmp_dev *md = (struct hdmi_mmp_dev *)dev;
+
+	dev->mode_id = id;
+	hdmi_mmp_set_freq (md);
+	buf = kzalloc (32, GFP_KERNEL);
+
+	/* get proper avi packet */
+	hdmi_avi_info_frame (dev, buf);
+	/* write avi packet */
+	hdmi_send_packet (dev, buf, 0);
+	memset (buf, 0, 32);
+	hdmi_vender_info_frame (dev, buf);
+	hdmi_send_packet (dev, buf, 1);
+
+	v = hdmi_read(md->base, HDTX_HDMI_CTRL);
+	v &= ~0x78;
+	hdmi_write(md->base, HDTX_HDMI_CTRL, v | 0x1 | (dev->pixel_rept));
+	/* auto detect lcd timing */
+	hdmi_write(md->base, HDTX_VIDEO_CTRL, 0x58);
+	return 0;
+}
+
+static int hdmi_mmp_enable(struct hdmi_dev *dev, int enable)
+{
+	struct hdmi_mmp_dev *md = (struct hdmi_mmp_dev *)dev;
+	u32 v;
+
+	v = hdmi_direct_read(md->base, HDMI_CLOCK_CFG);
+	v = enable ? (v | (1<<4)) : (v & ~(1<<4));
+	hdmi_direct_write(md->base, HDMI_CLOCK_CFG, v);
+
+	/* magic register */
+	hdmi_write(md->base, HDTX_TDATA3_1, 0x83);
+	hdmi_direct_write(md->base, HDMI_PHY_CFG_2, 0x3c10);
+	//hdmi_direct_write(md->base,0x1c, 0xaa95);
+	return 0;
+}
+
+static struct hdmi_ops mmp_hdmi_ops = {
+	.init = hdmi_mmp_init_controller,
+	.get_hpd = hdmi_mmp_get_hpd_status,
+	.set_mode = hdmi_mmp_set_mode,
+	.set_enable = hdmi_mmp_enable,
+	.get_reg = hdmi_mmp_get_reg,
+	.set_reg = hdmi_mmp_set_reg,
+};
+
+static int __devinit hdmi_mmp_probe(struct platform_device *pdev)
+{
+	struct hdmi_mmp_mach_info *pdata;
+	struct hdmi_mmp_dev *mdev;
+	struct resource *res;
+	struct clk *clk;
+	int ret = -ENOMEM;
+
+	clk = clk_get(NULL, "HDMICLK");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get HDMICLK\n");
+		return PTR_ERR(clk);
+	}
+	clk_enable(clk);
+
+	mdev = kzalloc(sizeof(struct hdmi_mmp_dev), GFP_KERNEL);
+	if (!mdev)
+		goto out_mdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdata = pdev->dev.platform_data;
+	if (res == NULL) {
+		printk(KERN_ERR "hdmi_probe: no memory resources given\n");
+		goto out_mdev;
+	}
+
+	mdev->base = ioremap(res->start, res->end - res->start + 1);
+	if (mdev->base == NULL) {
+		printk(KERN_ERR "%s: can't remap resgister area\n", __func__);
+		goto out_mdev;
+	}
+	mdev->gpio = pdata->gpio;
+	mdev->clk = clk;
+
+	ret = gpio_request(pdata->gpio, pdev->name);
+	if (ret < 0)
+		goto out_mdev;
+
+	ret = gpio_direction_input(pdata->gpio);
+	if (ret < 0)
+		goto out_free;
+
+	ret = request_irq(gpio_to_irq(pdata->gpio),
+			hdmi_mmp_hpd, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"HDMI HPD irq", mdev);
+	if(ret < 0)
+		goto free_gpio;
+
+	platform_set_drvdata(pdev, pdata);
+
+	ret = hdmi_dev_register((struct hdmi_dev*)mdev, &pdev->dev,
+		mdev, &mmp_hdmi_ops, pdata->fb_index);
+	if (ret) {
+		printk(KERN_ERR "mmp hdmi_dev_register fail\n");
+		goto irq_free;
+	}
+	return 0;
+
+irq_free:
+	free_irq(gpio_to_irq(pdata->gpio), NULL);
+free_gpio:
+	gpio_free(pdata->gpio);
+out_free:
+out_mdev:
+	kfree(mdev);
+	clk_disable(clk);
+	clk_put(clk);
+	return ret;
+}
+
+static struct platform_driver hdmi_mmp_driver = {
+	.driver         = {
+		.name   = "mmp-hdmi",
+		.owner  = THIS_MODULE,
+	},
+	.probe          = hdmi_mmp_probe,
+	//.remove         = __devexit_p(hdmi_mmp_remove),
+};
+
+static int __devinit hdmi_mmp_init(void)
+{
+	return platform_driver_register(&hdmi_mmp_driver);
+}
+
+module_init(hdmi_mmp_init);
+
+MODULE_AUTHOR("Jun Nie <njun@marvell.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HDMI driver for Marvell MMP");
+MODULE_ALIAS("hdmi-mmp");
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index cb175fe..93f5b6e 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -292,62 +292,63 @@ static const struct fb_videomode modedb[] = {
 };

 #ifdef CONFIG_FB_MODE_HELPERS
-const struct fb_videomode cea_modes[64] = {
+const struct fb_videomode cea_modes[65] = {
 	/* #1: 640x480p@59.94/60Hz */
 	[1] = {
 		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #3: 720x480p@59.94/60Hz */
 	[3] = {
 		NULL, 60, 720, 480, 37037, 60, 16, 30, 9, 62, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #5: 1920x1080i@59.94/60Hz */
 	[5] = {
 		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
+		FB_VMODE_INTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #7: 720(1440)x480iH@59.94/60Hz */
 	[7] = {
 		NULL, 60, 1440, 480, 18554/*37108*/, 114, 38, 15, 4, 124, 3, 0,
-		FB_VMODE_INTERLACED, 0,
+		FB_VMODE_INTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #9: 720(1440)x240pH@59.94/60Hz */
 	[9] = {
 		NULL, 60, 1440, 240, 18554, 114, 38, 16, 4, 124, 3, 0,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #18: 720x576pH@50Hz */
 	[18] = {
 		NULL, 50, 720, 576, 37037, 68, 12, 39, 5, 64, 5, 0,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #19: 1280x720p@50Hz */
 	[19] = {
 		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #20: 1920x1080i@50Hz */
 	[20] = {
 		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
+		FB_VMODE_INTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #32: 1920x1080p@23.98/24Hz */
 	[32] = {
 		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 	/* #35: (2880)x480p4x@59.94/60Hz */
 	[35] = {
 		NULL, 60, 2880, 480, 9250, 240, 64, 30, 9, 248, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
+		FB_VMODE_NONINTERLACED, FB_MODE_IS_CEA,
 	},
 };
+EXPORT_SYMBOL(cea_modes);

 const struct fb_videomode vesa_modes[] = {
 	/* 0 640x350-85 VESA */
@@ -1119,6 +1120,24 @@ finished:
 }
 EXPORT_SYMBOL(fb_find_best_display);

+/**
+ * fb_find_cea_mode_index - find a cea video mode index
+ *
+ * RETURNS:
+ * cea mode index, 0 if none found
+ */
+const int fb_find_cea_mode_index(struct fb_videomode *m)
+{
+	int idx;
+
+	for (idx = 1; idx <= 64; idx ++) {
+		if (fb_mode_is_equal(&cea_modes[idx], m))
+			return idx;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(fb_find_cea_mode_index);
+
 EXPORT_SYMBOL(fb_videomode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6a82748..14672f8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1082,10 +1082,24 @@ extern void fb_bl_default_curve(struct fb_info
*fb_info, u8 off, u8 min, u8 max)
 #define FB_MODE_IS_DETAILED	1
 #define FB_MODE_IS_STANDARD	2
 #define FB_MODE_IS_VESA		4
+#define FB_MODE_IS_CEA		5
 #define FB_MODE_IS_CALCULATED	8
 #define FB_MODE_IS_FIRST	16
 #define FB_MODE_IS_FROM_VAR     32

+typedef enum {
+	CEA_640x480p60 = 1,
+	CEA_720x480p60 = 3,
+	CEA_1920x1080i60 = 5,
+	CEA_720x480i60 = 7,
+	CEA_720x240p60 = 9,
+	CEA_720x576p50 = 18,
+	CEA_1280x720p50 = 19,
+	CEA_1920x1080i50 = 20,
+	CEA_1920x1080p24 = 32,
+	CEA_2880x480p60 =35,
+} cea_mode_id;
+
 extern int fbmon_dpms(const struct fb_info *fb_info);
 extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 		       struct fb_info *info);
@@ -1124,6 +1138,7 @@ extern void fb_videomode_to_modelist(const
struct fb_videomode *modedb, int num,
 				     struct list_head *head);
 extern const struct fb_videomode *fb_find_best_display(const struct
fb_monspecs *specs,
 						       struct list_head *head);
+extern const int fb_find_cea_mode_index(struct fb_videomode *m);

 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
@@ -1155,7 +1170,7 @@ struct fb_videomode {

 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
-extern const struct fb_videomode cea_modes[64];
+extern const struct fb_videomode cea_modes[65];

 struct fb_modelist {
 	struct list_head list;
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
new file mode 100644
index 0000000..d8a3da9
--- /dev/null
+++ b/include/linux/hdmi.h
@@ -0,0 +1,164 @@
+/*
+ * HDMI Control Abstraction
+ *
+ */
+
+#ifndef _LINUX_HDMI_H
+#define _LINUX_HDMI_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+//#include <linux/notifier.h>
+#include <linux/fb.h>
+#include <linux/lcd.h>
+
+/* Notes on locking:
+ *
+ * hdmi_dev->ops_lock is an internal backlight lock protecting the ops
+ * field and no code outside the core should need to touch it.
+ *
+ * Access to set_power() is serialised by the update_lock mutex since
+ * most drivers seem to need this and historically get it wrong.
+ *
+ * Most drivers don't need locking on their get_power() method.
+ * If yours does, you need to implement it in the driver. You can use the
+ * update_lock mutex if appropriate.
+ *
+ * Any other use of the locks below is probably wrong.
+ */
+
+struct hdmi_dev;
+struct fb_info;
+
+struct hdmi_properties {
+	/* source or sink */
+	u16 type;
+};
+
+struct hdmi_ops {
+	int (*init)(struct hdmi_dev *);
+	int (*get_hpd)(struct hdmi_dev *);
+	int (*enable)(struct hdmi_dev *, int);
+	/* Get the LCD panel power status (0: full on, 1..3: controller
+	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
+	int (*get_power)(struct hdmi_dev *);
+	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
+	int (*set_power)(struct hdmi_dev *, int power);
+	/* For debug */
+	int (*get_reg)(struct hdmi_dev *);
+	int (*set_reg)(struct hdmi_dev *, int offset, int v);
+	/* Get the current audio_cfg setting (0-max_audio_cfg) */
+	int (*get_audio_cfg)(struct hdmi_dev *);
+	/* Set LCD panel audio_cfg */
+        int (*set_audio_cfg)(struct hdmi_dev *, int audio_cfg);
+	int (*get_mode)(struct hdmi_dev *, struct fb_videomode *);
+	/* Set LCD panel mode (resolutions ...) */
+	int (*set_mode)(struct hdmi_dev *, cea_mode_id);
+	int (*get_enable)(struct hdmi_dev *);
+	int (*set_enable)(struct hdmi_dev *, int enable);
+	/* Check if given framebuffer device is the one LCD is bound to;
+	   return 0 if not, !=0 if it is. If NULL, hdmi always matches the fb. */
+	int (*check_mode)(struct hdmi_dev *, struct fb_videomode *);
+};
+
+enum hdmi_event_type {
+	/* trigger gpio irq */
+	HDMI_EV_PLUG,
+	HDMI_EV_UNPLUG,
+	/* trigger in gpio irq or from fb change */
+	HDMI_EV_VIDEO,
+	/* trigger in gpio irq or from Asoc change */
+	HDMI_EV_AUDIO,
+	/* trigger from CEC/TV */
+	HDMI_EV_CEC,
+};
+
+struct hdmi_event {
+	enum hdmi_event_type type;
+	struct list_head list;
+};
+
+#define RATIO_16V9_STR "16:9"
+#define RATIO_4V3_STR "4:3"
+#define RATIO_16V9 (0)
+#define RATIO_4V3 (1)
+
+struct hdmi_dev {
+	struct device		*dev;
+	struct hdmi_properties	props;
+	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
+	   registered this device has been unloaded, and if class_get_devdata()
+	   points to something in the body of that driver, it is also invalid. */
+	struct mutex		hdmi_lock;
+	/* Serialise access to set_power method */
+	struct mutex		update_lock;
+	spinlock_t              lock;           /* lock for claim and bus ops */
+	struct list_head	hdmi_evt_list;
+	struct list_head	free_evt_list;
+	struct task_struct	*thread;
+	struct hdmi_event	*evt_ptr;
+	/* If this is NULL, the backing module is unloaded */
+	struct hdmi_ops *ops;
+	/* The framebuffer notifier block */
+	//struct notifier_block fb_notif;
+	struct lcd_device	*lcd;
+	struct fb_info		*fb_info;
+	cea_mode_id		mode_id;
+	//u32			deep_color;
+	u32			enable;
+	u32			pixel_rept;
+	u32			ratio;
+};
+
+struct hdmi_platform_data {
+	/* reset hdmi panel device. */
+	int (*reset)(struct hdmi_dev *ld);
+	/* on or off to hdmi panel. if 'enable' is 0 then
+	   hdmi power off and 1, hdmi power on. */
+	int (*power_on)(struct hdmi_dev *ld, int enable);
+
+	/* it indicates whether hdmi panel was enabled
+	   from bootloader or not. */
+	int hdmi_enabled;
+	/* video, audio, cec, hdcp */
+	unsigned int features;
+	/* it means delay for stable time when it becomes low to high
+	   or high to low that is dependent on whether reset gpio is
+	   low active or high active. */
+	unsigned int reset_delay;
+	/* stable time needing to become hdmi power on. */
+	unsigned int power_on_delay;
+	/* stable time needing to become hdmi power off. */
+	unsigned int power_off_delay;
+
+	/* it could be used for any purpose. */
+	void *pdata;
+};
+
+static inline void hdmi_set_power(struct hdmi_dev *ld, int power)
+{
+	mutex_lock(&ld->update_lock);
+	if (ld->ops && ld->ops->set_power)
+		ld->ops->set_power(ld, power);
+	mutex_unlock(&ld->update_lock);
+}
+
+extern int hdmi_dev_register(struct hdmi_dev *hdmi_dev,
+	struct device *parent, void *devdata, struct hdmi_ops *ops,
+	int fb_index);
+extern void hdmi_dev_unregister(struct hdmi_dev *ld);
+
+#define to_hdmi_dev(obj) container_of(obj, struct hdmi_dev, dev)
+
+static inline void * hdmi_get_data(struct hdmi_dev *ld_dev)
+{
+	return dev_get_drvdata(ld_dev->dev);
+}
+
+
+#endif
+
+int hdmi_get_freq (struct hdmi_dev *hd, u32 *need_freq);
+int hdmi_vender_info_frame (struct hdmi_dev *hd, char buf[]);
+int hdmi_avi_info_frame (struct hdmi_dev *hd, char buf[]);
+void hdmi_event_signal(struct hdmi_dev *dev, enum hdmi_event_type type);
diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 8877123..b09e0f9 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -48,6 +48,8 @@ struct lcd_ops {
         int (*set_contrast)(struct lcd_device *, int contrast);
 	/* Set LCD panel mode (resolutions ...) */
 	int (*set_mode)(struct lcd_device *, struct fb_videomode *);
+	/* Get LCD panel mode (resolutions ...) */
+	int (*get_mode)(struct lcd_device *, struct fb_videomode *);
 	/* Check if given framebuffer device is the one LCD is bound to;
 	   return 0 if not, !=0 if it is. If NULL, lcd always matches the fb. */
 	int (*check_fb)(struct lcd_device *, struct fb_info *);
diff --git a/include/linux/major.h b/include/linux/major.h
index 6a8ca98..e6e46e2 100644
--- a/include/linux/major.h
+++ b/include/linux/major.h
@@ -170,6 +170,7 @@
 #define IBM_FS3270_MAJOR	228

 #define VIOTAPE_MAJOR		230
+#define HDMI_MAJOR		231

 #define BLOCK_EXT_MAJOR		259
 #define SCSI_OSD_MAJOR		260	/* open-osd's OSD scsi device */

--f46d0444016258a5e404b12266ab
Content-Type: text/x-patch; charset=US-ASCII; name="hdmi_draft.diff"
Content-Disposition: attachment; filename="hdmi_draft.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gupa6nlk0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vaGRtaS1tbXAuYyBiL2RyaXZlcnMvdmlkZW8vaGRt
aS1tbXAuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mNzFmOWZhCi0tLSAv
ZGV2L251bGwKKysrIGIvZHJpdmVycy92aWRlby9oZG1pLW1tcC5jCkBAIC0wLDAgKzEsNDQ1IEBA
CisvKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24gdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLgorICoKKyAqICBUaGlzIHBy
b2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwK
KyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3Ig
bW9yZSBkZXRhaWxzLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4KKyNpbmNsdWRlIDxs
aW51eC9jdHlwZS5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgv
ZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVkZSA8bGludXgvZmIuaD4K
KyNpbmNsdWRlIDxsaW51eC9mcmVlemVyLmg+CisjaW5jbHVkZSA8bGludXgvZ3Bpby5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2hkbWkuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8
bGludXgvaW5wdXQuaD4KKyNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+CisjaW5jbHVkZSA8bGlu
dXgvbGNkLmg+CisjaW5jbHVkZSA8bGludXgvbGlzdC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPgorI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4K
KyNpbmNsdWRlIDxsaW51eC9ub3RpZmllci5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNp
bmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgorI2luY2x1ZGUgPG1hY2gvbW1wX2hkbWkuaD4KKyNp
bmNsdWRlICJoZG1pLW1tcC5oIgorCitzdHJ1Y3QgaGRtaV9tbXBfZGV2IHsKKwlzdHJ1Y3QgaGRt
aV9kZXYgaGRtaV9kZXY7CisJc3RydWN0IGNsayAqY2xrOworCXZvaWQgKmJhc2U7CisJdm9pZCAq
c3NwYTFfcmVnX2Jhc2U7CisJdW5zaWduZWQgaW50IGdwaW87CisJdW5zaWduZWQgaW50IGlycTsK
K307CisKK3N0YXRpYyB2b2lkIGhkbWlfZGlyZWN0X3dyaXRlKHZvaWQgKmJhc2UsIHVuc2lnbmVk
IGFkZHIsIHVuc2lnbmVkIGRhdGEpCit7CisJX19yYXdfd3JpdGVsKGRhdGEsIGJhc2UgKyBCQVNF
X09GRlNFVCArIGFkZHIpOworfQorCitzdGF0aWMgdW5zaWduZWQgaGRtaV9kaXJlY3RfcmVhZCh2
b2lkICpiYXNlLCB1bnNpZ25lZCBhZGRyKQoreworCXJldHVybiBfX3Jhd19yZWFkbChiYXNlICsg
QkFTRV9PRkZTRVQgKyBhZGRyKTsKK30KKworc3RhdGljIHVuc2lnbmVkIGhkbWlfcmVhZCh2b2lk
ICpiYXNlLCB1bnNpZ25lZCBhZGRyKQoreworCV9fcmF3X3dyaXRlbChhZGRyIHwgMSA8PCAzMCwg
YmFzZSArIEJBU0VfT0ZGU0VUICsgSERNSV9BRERSKTsKKwlyZXR1cm4gX19yYXdfcmVhZGwoKGJh
c2UgKyBCQVNFX09GRlNFVCArIEhETUlfREFUQSkpICYgMHhmZjsKK30KKworc3RhdGljIHZvaWQg
aGRtaV93cml0ZSh2b2lkICpiYXNlLCB1bnNpZ25lZCBhZGRyLCB1bnNpZ25lZCBkYXRhKQorewor
CV9fcmF3X3dyaXRlbChkYXRhICYgMHhmZiwgYmFzZSArIEJBU0VfT0ZGU0VUICsgSERNSV9EQVRB
KTsKKwlfX3Jhd193cml0ZWwoYWRkciB8IDEgPDwgMzEsIGJhc2UgKyBCQVNFX09GRlNFVCArIEhE
TUlfQUREUik7Cit9CisKK3N0YXRpYyB2b2lkIGhkbWlfd3JpdGVfbXVsdGkoc3RydWN0IGhkbWlf
bW1wX2RldiAqbWQsIHUzMiBhZGRyLCB1OCAqYnVmLAorCQl1MzIgbGVuZ3RoKQoreworCXUzMiBp
OworCWZvciAoaSA9IDA7IGkgPCBsZW5ndGg7IGkrKykKKwkJaGRtaV93cml0ZShtZC0+YmFzZSwg
YWRkciArIGksICooYnVmICsgaSkpOworfQorCitzdGF0aWMgaW50IGhkbWlfbW1wX2luaXRfY29u
dHJvbGxlcihzdHJ1Y3QgaGRtaV9kZXYgKmRldikKK3sKKwlzdHJ1Y3QgaGRtaV9tbXBfZGV2ICpt
ZCA9IChzdHJ1Y3QgaGRtaV9tbXBfZGV2ICopZGV2OworCXUzMiB0bXA7CisKKwlwcmludGsoS0VS
Tl9ERUJVRyAiSW5pdCBtbXAgaGRtaSBjdHJvbGxlci4uLlxuIik7CisJaGRtaV9kaXJlY3Rfd3Jp
dGUobWQtPmJhc2UsIEhETUlfUEhZX0NGR18yLCAxPDwyNyk7CisKKwloZG1pX2RpcmVjdF93cml0
ZShtZC0+YmFzZSwgSERNSV9QSFlfQ0ZHXzAsIDBYMDAyNDliNmQpOworCWhkbWlfZGlyZWN0X3dy
aXRlKG1kLT5iYXNlLCBIRE1JX1BIWV9DRkdfMSwgMFgwNDkyZWVlZSk7CisJLyogaGRtaV9kaXJl
Y3Rfd3JpdGUobWQtPmJhc2UsIEhETUlfUEhZX0NGR18yLCAwWDAwMDAzYzMwKTsgKi8KKwloZG1p
X2RpcmVjdF93cml0ZShtZC0+YmFzZSwgSERNSV9QSFlfQ0ZHXzIsIDBYMDAwMDNjMTApOworCXRt
cCA9IGhkbWlfZGlyZWN0X3JlYWQobWQtPmJhc2UsIEhETUlfUEhZX0NGR18zKTsKKwloZG1pX2Rp
cmVjdF93cml0ZShtZC0+YmFzZSwgSERNSV9QSFlfQ0ZHXzMsICh0bXAgfCAwWDAwMDAwMDEpKTsK
Kwltc2xlZXAoNTApOworCWhkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1JX1BIWV9DRkdf
MywgKHRtcCAmICh+MFgwMDAwMDAxKSkpOworCS8qIHRlbXBvcmF0eWx5IHNldCB0aGUgYWR1aW8g
Y2ZnICovCisJLyogaGRtaV9kaXJlY3Rfd3JpdGUobWQtPmJhc2UsIEhETUlfQVVESU9fQ0ZHLCAw
eDg2OSk7ICovCisKKwloZG1pX3dyaXRlKG1kLT5iYXNlLCBIRFRYX0hTVF9QS1RfQ1RSTDAsIDAp
OworCWhkbWlfd3JpdGUobWQtPmJhc2UsIEhEVFhfSFNUX1BLVF9DVFJMMSwgMCk7CisKKwlyZXR1
cm4gMDsKK30KKworc3RhdGljIGludCBoZG1pX21tcF9zZXRfZnJlcShzdHJ1Y3QgaGRtaV9tbXBf
ZGV2ICptZCkKK3sKKwlpbnQgcmV0ID0gMDsKKworCS8qIEZpeCB0aGUgcGxsMnJlZmRpdiB0byAx
KCsyKSwgdG8gZ2V0IDguNjZNSHogcmVmIGNsaworCSAqIFN0YWJsZSB2YWwgcmVjb21lbmRlZCBi
ZXR3ZWVuIDgtMTJNSHouIFRvIGdldCB0aGUgcmVxZAorCSAqIGZyZXEgdmFsLCBqdXN0IHByb2dy
YW0gdGhlIGZiZGl2CisJICogZnJlcSB0YWtlcyBlZmZlY3QgZHVyaW5nIGEgZmMgcmVxCisJICov
CisJdTMyIHJlc2lkdWFsOworCXZvbGF0aWxlIHVuc2lnbmVkIGludCB0ZW1wID0gMDsKKwl1MzIg
ZnJlcTsKKwl1bnNpZ25lZCBpbnQgcG9zdGRpdjsKKwl1bnNpZ25lZCBpbnQgZnJlcV9vZmZzZXRf
aW5uZXI7CisJdW5zaWduZWQgaW50IGhkbWlfcGxsX2ZiZGl2OworCXVuc2lnbmVkIGludCBoZG1p
X3BsbF9yZWZkaXY7CisJdW5zaWduZWQgaW50IGt2Y287CisJdW5zaWduZWQgaW50IGZyZXFfb2Zm
c2V0X2lubmVyXzE2OworCXVuc2lnbmVkIGludCBWUExMX0NBTENMS19ESVYgPSAxOworCXVuc2ln
bmVkIGludCBWRERNID0gMTsKKwl1bnNpZ25lZCBpbnQgVkRETCA9IDB4OTsKKwl1bnNpZ25lZCBp
bnQgSUNQID0gMHg5OworCXVuc2lnbmVkIGludCBWUkVHX0lWUkVGID0gMjsKKwl1bnNpZ25lZCBp
bnQgSU5UUEkgPSA1OworCXVuc2lnbmVkIGludCBWVEhfVlBMTF9DQSA9IDI7CisJaW50IGNvdW50
ID0gMHgxMDAwMDsKKworCXJldCA9IGhkbWlfZ2V0X2ZyZXEgKChzdHJ1Y3QgaGRtaV9kZXYgKilt
ZCwgJmZyZXEpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlmcmVxIC89IDEwMDA7CisJ
Lyogcm91bmQgdG8gZnJlcSA9IE4qMTAwayBIeiAqLworCXJlc2lkdWFsID0gZnJlcSAlIDEwMDsK
KwlmcmVxID0gcmVzaWR1YWw/IChmcmVxICsgMTAwIC0gcmVzaWR1YWwpIDogZnJlcTsKKwlmcmVx
IC89IDEwMDA7CisKKwlzd2l0Y2ggKGZyZXEpIHsKKwljYXNlIDI1OgorCQlwb3N0ZGl2ID0gMHgz
OworCQlmcmVxX29mZnNldF9pbm5lciA9IDB4MUM0NzsKKwkJZnJlcV9vZmZzZXRfaW5uZXJfMTYg
PSAxOworCQloZG1pX3BsbF9mYmRpdiA9IDM5OworCQloZG1pX3BsbF9yZWZkaXYgPSAwOworCQlr
dmNvID0gMHg0OworCQlicmVhazsKKwljYXNlIDI3OgorCQlwb3N0ZGl2ID0gMHgzOworCQlmcmVx
X29mZnNldF9pbm5lciA9IDB4MmQwMzsKKwkJZnJlcV9vZmZzZXRfaW5uZXJfMTYgPSAxOworCQlo
ZG1pX3BsbF9mYmRpdiA9IDQyOworCQloZG1pX3BsbF9yZWZkaXYgPSAwOworCQlrdmNvID0gMHg0
OworCQlicmVhazsKKwljYXNlIDU0OgorCQlwb3N0ZGl2ID0gMHgyOworCQlmcmVxX29mZnNldF9p
bm5lciA9IDB4MmQwMzsKKwkJZnJlcV9vZmZzZXRfaW5uZXJfMTYgPSAxOworCQloZG1pX3BsbF9m
YmRpdiA9IDQyOworCQloZG1pX3BsbF9yZWZkaXYgPSAwOworCQlrdmNvID0gMHg0OworCQlicmVh
azsKKwljYXNlIDc0OgorCQlwb3N0ZGl2ID0gMHgyOworCQlmcmVxX29mZnNldF9pbm5lciA9IDB4
MDg0QjsKKwkJZnJlcV9vZmZzZXRfaW5uZXJfMTYgPSAwOworCQloZG1pX3BsbF9mYmRpdiA9IDU3
OworCQloZG1pX3BsbF9yZWZkaXYgPSAwOworCQlrdmNvID0gMHg0OworCQlicmVhazsKKwljYXNl
IDEwODoKKwkJcG9zdGRpdiA9IDB4MTsKKwkJZnJlcV9vZmZzZXRfaW5uZXIgPSAweDJkMDM7CisJ
CWZyZXFfb2Zmc2V0X2lubmVyXzE2ID0gMTsKKwkJaGRtaV9wbGxfZmJkaXYgPSA0MjsKKwkJaGRt
aV9wbGxfcmVmZGl2ID0gMDsKKwkJa3ZjbyA9IDB4NDsKKwkJYnJlYWs7CisJY2FzZSAxNDg6CisJ
CXBvc3RkaXYgPSAweDE7CisJCWZyZXFfb2Zmc2V0X2lubmVyID0gMHgwODRCOworCQlmcmVxX29m
ZnNldF9pbm5lcl8xNiA9IDA7CisJCWhkbWlfcGxsX2ZiZGl2ID0gNTc7CisJCWhkbWlfcGxsX3Jl
ZmRpdiA9IDA7CisJCWt2Y28gPSAweDQ7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXByaW50ayhL
RVJOX0VSUiAibm90IHN1cHBvcnRlZCBmcmVxICVkXG4iLCBmcmVxKTsKKwkJcmV0dXJuIC1FSU5W
QUw7CisJfQorCisJaGRtaV9kaXJlY3Rfd3JpdGUobWQtPmJhc2UsIEhETUlfQ0xPQ0tfQ0ZHLCAx
fDE8PDJ8MTw8NHw0PDw1fDU8PDl8NTw8MTMpOworCS8vaGRtaV9kaXJlY3Rfd3JpdGUobWQtPmJh
c2UsIEhETUlfQ0xPQ0tfQ0ZHLCAxfDE8PDJ8NDw8NXw1PDw5fDU8PDEzKTsKKworCS8qIHBvd2Vy
IHVwIHRoZSBwbGwgKi8KKwl0ZW1wIHw9IEhETUlfUExMX0NGR18zX0hETUlfUExMX09OOworCWhk
bWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1JX1BMTF9DRkdfMywgdGVtcCk7CisKKwl0ZW1w
ID0gKChJTlRQSSA8PCBIRE1JX1BMTF9DRkdfMF9JTlRQSV9CQVNFKQl8CisJCQkoSERNSV9QTExf
Q0ZHXzBfQ0xLX0RFVF9FTikJfAorCQkJKFZERE0gPDwgSERNSV9QTExfQ0ZHXzBfVkRETV9CQVNF
KQl8CisJCQkoVkRETCA8PCBIRE1JX1BMTF9DRkdfMF9WRERMX0JBU0UpCXwKKwkJCShJQ1AgPDwg
SERNSV9QTExfQ0ZHXzBfSUNQX0JBU0UpCXwKKwkJCShrdmNvIDw8IEhETUlfUExMX0NGR18wX0tW
Q09fQkFTRSkJfAorCQkJKFZSRUdfSVZSRUYgPDwgSERNSV9QTExfQ0ZHXzBfVlJFR19JVlJFRl9C
QVNFKQl8CisJCQkoVlBMTF9DQUxDTEtfRElWIDw8IEhETUlfUExMX0NGR18wX1ZQTExfQ0FMQ0xL
X0RJVl9CQVNFKSB8CisJCQkocG9zdGRpdiA8PCBIRE1JX1BMTF9DRkdfMF9QT1NURElWX0JBU0Up
CXwKKwkJCShJQ1AgIDw8IEhETUlfUExMX0NGR18wX0lDUF9CQVNFKSk7CisJaGRtaV9kaXJlY3Rf
d3JpdGUobWQtPmJhc2UsIEhETUlfUExMX0NGR18wLCB0ZW1wKTsKKworCXRlbXAgPSAoKEhETUlf
UExMX0NGR18xX01PREUpIHwKKwkJCShIRE1JX1BMTF9DRkdfMV9FTl9QQU5ORUwpfAorCQkJKEhE
TUlfUExMX0NGR18xX0VOX0hETUkpfAorCQkJKFZUSF9WUExMX0NBIDw8IEhETUlfUExMX0NGR18x
X1ZUSF9WUExMX0NBX0JBU0UpfAorCQkJKGZyZXFfb2Zmc2V0X2lubmVyIDw8IEhETUlfUExMX0NG
R18xX0ZSRVFfT0ZGU0VUX0lOTkVSX0JBU0UpfAorCQkJKGZyZXFfb2Zmc2V0X2lubmVyXzE2IDw8
IDIwKSk7CisJaGRtaV9kaXJlY3Rfd3JpdGUobWQtPmJhc2UsIEhETUlfUExMX0NGR18xLCB0ZW1w
KTsKKworCXRlbXAgPSAwOworCWhkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1JX1BMTF9D
RkdfMiwgdGVtcCk7CisKKwkvKiBQb3dlciBEb3duIHRoZSBwbGwgYW5kIHNldCB0aGUgZGl2aWRl
ciByYXRpb3MqLworCXRlbXAgPSAoaGRtaV9wbGxfZmJkaXYgPDwgSERNSV9QTExfQ0ZHXzNfSERN
SV9QTExfRkJESVZfQkFTRSl8CisJCShoZG1pX3BsbF9yZWZkaXYgPDwgSERNSV9QTExfQ0ZHXzNf
SERNSV9QTExfUkVGRElWX0JBU0UpOworCWhkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1J
X1BMTF9DRkdfMywgdGVtcCk7CisKKwkvKiBwb3dlciB1cCB0aGUgcGxsICovCisJdGVtcCB8PSBI
RE1JX1BMTF9DRkdfM19IRE1JX1BMTF9PTjsKKwloZG1pX2RpcmVjdF93cml0ZShtZC0+YmFzZSwg
SERNSV9QTExfQ0ZHXzMsIHRlbXApOworCisJLyp3YWl0IDEwdXMgOiBqdXN0IGFuIGVzdGltYXRl
Ki8KKwl1ZGVsYXkoMTAwKTsKKworCS8qIHJlbGVhc2UgdGhlIHBsbCBvdXQgb2YgcmVzZXQqLwor
CXRlbXAgfD0gSERNSV9QTExfQ0ZHXzNfSERNSV9QTExfUlNUQjsKKwloZG1pX2RpcmVjdF93cml0
ZShtZC0+YmFzZSwgSERNSV9QTExfQ0ZHXzMsIHRlbXApOworCisJLyogUExMX0xPQ0sgc2hvdWxk
IGJlIDEsICovCisJdGVtcCA9IGhkbWlfZGlyZWN0X3JlYWQobWQtPmJhc2UsIEhETUlfUExMX0NG
R18zKTsKKwl0ZW1wICY9IDB4NDAwMDAwOworCXdoaWxlICggIXRlbXAgKQl7CisJCXRlbXAgPSBo
ZG1pX2RpcmVjdF9yZWFkKG1kLT5iYXNlLCBIRE1JX1BMTF9DRkdfMyk7CisJCXRlbXAgJj0gMHg0
MDAwMDA7CisJCXVkZWxheSgxMCk7CisJCWNvdW50LS07CisJCWlmIChjb3VudCA8PSAwKSB7CisJ
CQlwcmludGsoS0VSTl9FUlIgIiVzIFBMTCBsb2NrIGVycm9yLCBQTExfQ0ZHXzMgJXhcbiIsCisJ
CQkJX19mdW5jX18sIHRlbXApOworCQkJcmV0dXJuIC1FSU87CisJCX0KKwl9CisJLyogcGxsIHN0
YWJsaXplIGluIDEwbXMgKi8KKwltc2xlZXAoMTApOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRp
YyBpcnFyZXR1cm5fdCBoZG1pX21tcF9ocGQoaW50IGlycSwgdm9pZCAqZGF0YSkKK3sKKwlwcmlu
dGsoS0VSTl9JTkZPICJncGlvIGhwZCBkZXRlY3RlZFxuIik7CisKKwloZG1pX2V2ZW50X3NpZ25h
bCgoc3RydWN0IGhkbWlfZGV2ICopZGF0YSwgSERNSV9FVl9QTFVHKTsKKwlyZXR1cm4gSVJRX0hB
TkRMRUQ7Cit9CisKK3N0YXRpYyBpbnQgaGRtaV9tbXBfZ2V0X2hwZF9zdGF0dXMgKHN0cnVjdCBo
ZG1pX2RldiAqZGV2KQoreworCXN0cnVjdCBoZG1pX21tcF9kZXYgKm1oID0gKHN0cnVjdCBoZG1p
X21tcF9kZXYgKilkZXY7CisKKwlyZXR1cm4gISBncGlvX2dldF92YWx1ZShtaC0+Z3Bpbyk7Cit9
CisKK3N0YXRpYyBpbnQgaGRtaV9zZW5kX3BhY2tldCAoc3RydWN0IGhkbWlfbW1wX2RldiAqbWQs
IGNoYXIgKmJ1ZiwgaW50IGlkeCkKK3sKKwl1MzIgdjsKKworCWhkbWlfd3JpdGVfbXVsdGkgKG1k
LCBIRFRYX1BLVDBfQllURTAgKyAweDIwICogaWR4LCBidWYsIDMyKTsKKworCXYgPSBoZG1pX3Jl
YWQobWQtPmJhc2UsIEhEVFhfSFNUX1BLVF9DVFJMMCk7CisJaGRtaV93cml0ZShtZC0+YmFzZSwg
SERUWF9IU1RfUEtUX0NUUkwwLCB2IHwgKDEgPDwgaWR4KSk7CisJLyogSFcgYnVnICovCisJdiAm
PSB+KDEgPDwgaWR4KTsKKwloZG1pX3dyaXRlKG1kLT5iYXNlLCBIRFRYX0hTVF9QS1RfQ1RSTDAs
IHYpOworCXYgPSBoZG1pX3JlYWQobWQtPmJhc2UsIEhEVFhfSFNUX1BLVF9DVFJMMSk7CisJaGRt
aV93cml0ZShtZC0+YmFzZSwgSERUWF9IU1RfUEtUX0NUUkwxLCB2IHwgKDEgPDwgaWR4KSk7Cit9
CisKK3N0YXRpYyBpbnQgaGRtaV9tbXBfZ2V0X3JlZyAoc3RydWN0IGhkbWlfZGV2ICpkZXYpCit7
CisJc3RydWN0IGhkbWlfbW1wX2RldiAqbWQgPSAoc3RydWN0IGhkbWlfbW1wX2RldiAqKWRldjsK
KwlpbnQgaTsKKworCXByaW50aygiKioqKioqKioqKioqZGlyZWN0IHJlZ2lzdGVyKioqKioqKioq
KioqKioqKioqKlxuIik7CisJZm9yIChpID0gMHg4OyBpIDw9IDB4MzA7IGkgKz0gNCkKKwkJcHJp
bnRrKCJkaXJlY3Qgb2Zmc2V0IDB4JXggaXMgMHgleFxuIiwgaSwgaGRtaV9kaXJlY3RfcmVhZCht
ZC0+YmFzZSwgaSkpOworCXByaW50aygiKioqKioqKioqKioqaW5kaXJlY3QgcmVnaXN0ZXIqKioq
KioqKioqKioqKioqKioqXG4iKTsKKwlmb3IgKGkgPSAwOyBpIDwgMHgxM2U7IGkrKykKKwkJcHJp
bnRrKCJvZmZzZXQgMHgleCBpcyAweCV4XG4iLCBpLCBoZG1pX3JlYWQobWQtPmJhc2UsIGkpKTsK
K30KKworc3RhdGljIGludCBoZG1pX21tcF9zZXRfcmVnIChzdHJ1Y3QgaGRtaV9kZXYgKmRldikK
K3sKKwlzdHJ1Y3QgaGRtaV9tbXBfZGV2ICptZCA9IChzdHJ1Y3QgaGRtaV9tbXBfZGV2ICopZGV2
OworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGRtaV9tbXBfc2V0X21vZGUgKHN0cnVj
dCBoZG1pX2RldiAqZGV2LCBjZWFfbW9kZV9pZCBpZCkKK3sKKwljaGFyICpidWY7CisJdTMyIHY7
CisJc3RydWN0IGhkbWlfbW1wX2RldiAqbWQgPSAoc3RydWN0IGhkbWlfbW1wX2RldiAqKWRldjsK
KworCWRldi0+bW9kZV9pZCA9IGlkOworCWhkbWlfbW1wX3NldF9mcmVxIChtZCk7CisJYnVmID0g
a3phbGxvYyAoMzIsIEdGUF9LRVJORUwpOworCisJLyogZ2V0IHByb3BlciBhdmkgcGFja2V0ICov
CisJaGRtaV9hdmlfaW5mb19mcmFtZSAoZGV2LCBidWYpOworCS8qIHdyaXRlIGF2aSBwYWNrZXQg
Ki8KKwloZG1pX3NlbmRfcGFja2V0IChkZXYsIGJ1ZiwgMCk7CisJbWVtc2V0IChidWYsIDAsIDMy
KTsKKwloZG1pX3ZlbmRlcl9pbmZvX2ZyYW1lIChkZXYsIGJ1Zik7CisJaGRtaV9zZW5kX3BhY2tl
dCAoZGV2LCBidWYsIDEpOworCisJdiA9IGhkbWlfcmVhZChtZC0+YmFzZSwgSERUWF9IRE1JX0NU
UkwpOworCXYgJj0gfjB4Nzg7CisJaGRtaV93cml0ZShtZC0+YmFzZSwgSERUWF9IRE1JX0NUUkws
IHYgfCAweDEgfCAoZGV2LT5waXhlbF9yZXB0KSk7CisJLyogYXV0byBkZXRlY3QgbGNkIHRpbWlu
ZyAqLworCWhkbWlfd3JpdGUobWQtPmJhc2UsIEhEVFhfVklERU9fQ1RSTCwgMHg1OCk7CisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGRtaV9tbXBfZW5hYmxlKHN0cnVjdCBoZG1pX2RldiAq
ZGV2LCBpbnQgZW5hYmxlKQoreworCXN0cnVjdCBoZG1pX21tcF9kZXYgKm1kID0gKHN0cnVjdCBo
ZG1pX21tcF9kZXYgKilkZXY7CisJdTMyIHY7CisKKwl2ID0gaGRtaV9kaXJlY3RfcmVhZChtZC0+
YmFzZSwgSERNSV9DTE9DS19DRkcpOworCXYgPSBlbmFibGUgPyAodiB8ICgxPDw0KSkgOiAodiAm
IH4oMTw8NCkpOworCWhkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1JX0NMT0NLX0NGRywg
dik7CisKKwkvKiBtYWdpYyByZWdpc3RlciAqLworCWhkbWlfd3JpdGUobWQtPmJhc2UsIEhEVFhf
VERBVEEzXzEsIDB4ODMpOworCWhkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLCBIRE1JX1BIWV9D
RkdfMiwgMHgzYzEwKTsKKwkvL2hkbWlfZGlyZWN0X3dyaXRlKG1kLT5iYXNlLDB4MWMsIDB4YWE5
NSk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgaGRtaV9vcHMgbW1wX2hkbWlfb3Bz
ID0geworCS5pbml0ID0gaGRtaV9tbXBfaW5pdF9jb250cm9sbGVyLAorCS5nZXRfaHBkID0gaGRt
aV9tbXBfZ2V0X2hwZF9zdGF0dXMsCisJLnNldF9tb2RlID0gaGRtaV9tbXBfc2V0X21vZGUsCisJ
LnNldF9lbmFibGUgPSBoZG1pX21tcF9lbmFibGUsCisJLmdldF9yZWcgPSBoZG1pX21tcF9nZXRf
cmVnLAorCS5zZXRfcmVnID0gaGRtaV9tbXBfc2V0X3JlZywKK307CisKK3N0YXRpYyBpbnQgX19k
ZXZpbml0IGhkbWlfbW1wX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJ
c3RydWN0IGhkbWlfbW1wX21hY2hfaW5mbyAqcGRhdGE7CisJc3RydWN0IGhkbWlfbW1wX2RldiAq
bWRldjsKKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKKwlzdHJ1Y3QgY2xrICpjbGs7CisJaW50IHJl
dCA9IC1FTk9NRU07CisKKwljbGsgPSBjbGtfZ2V0KE5VTEwsICJIRE1JQ0xLIik7CisJaWYgKElT
X0VSUihjbGspKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgInVuYWJsZSB0byBnZXQgSERNSUNM
S1xuIik7CisJCXJldHVybiBQVFJfRVJSKGNsayk7CisJfQorCWNsa19lbmFibGUoY2xrKTsKKwor
CW1kZXYgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaGRtaV9tbXBfZGV2KSwgR0ZQX0tFUk5FTCk7
CisJaWYgKCFtZGV2KQorCQlnb3RvIG91dF9tZGV2OworCisJcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKKwlwZGF0YSA9IHBkZXYtPmRldi5wbGF0
Zm9ybV9kYXRhOworCWlmIChyZXMgPT0gTlVMTCkgeworCQlwcmludGsoS0VSTl9FUlIgImhkbWlf
cHJvYmU6IG5vIG1lbW9yeSByZXNvdXJjZXMgZ2l2ZW5cbiIpOworCQlnb3RvIG91dF9tZGV2Owor
CX0KKworCW1kZXYtPmJhc2UgPSBpb3JlbWFwKHJlcy0+c3RhcnQsIHJlcy0+ZW5kIC0gcmVzLT5z
dGFydCArIDEpOworCWlmIChtZGV2LT5iYXNlID09IE5VTEwpIHsKKwkJcHJpbnRrKEtFUk5fRVJS
ICIlczogY2FuJ3QgcmVtYXAgcmVzZ2lzdGVyIGFyZWFcbiIsIF9fZnVuY19fKTsKKwkJZ290byBv
dXRfbWRldjsKKwl9CisJbWRldi0+Z3BpbyA9IHBkYXRhLT5ncGlvOworCW1kZXYtPmNsayA9IGNs
azsKKworCXJldCA9IGdwaW9fcmVxdWVzdChwZGF0YS0+Z3BpbywgcGRldi0+bmFtZSk7CisJaWYg
KHJldCA8IDApCisJCWdvdG8gb3V0X21kZXY7CisKKwlyZXQgPSBncGlvX2RpcmVjdGlvbl9pbnB1
dChwZGF0YS0+Z3Bpbyk7CisJaWYgKHJldCA8IDApCisJCWdvdG8gb3V0X2ZyZWU7CisKKwlyZXQg
PSByZXF1ZXN0X2lycShncGlvX3RvX2lycShwZGF0YS0+Z3BpbyksCisJCQloZG1pX21tcF9ocGQs
IElSUUZfVFJJR0dFUl9SSVNJTkcgfCBJUlFGX1RSSUdHRVJfRkFMTElORywKKwkJCSJIRE1JIEhQ
RCBpcnEiLCBtZGV2KTsKKwlpZihyZXQgPCAwKQorCQlnb3RvIGZyZWVfZ3BpbzsKKworCXBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIHBkYXRhKTsKKworCXJldCA9IGhkbWlfZGV2X3JlZ2lzdGVy
KChzdHJ1Y3QgaGRtaV9kZXYqKW1kZXYsICZwZGV2LT5kZXYsCisJCW1kZXYsICZtbXBfaGRtaV9v
cHMsIHBkYXRhLT5mYl9pbmRleCk7CisJaWYgKHJldCkgeworCQlwcmludGsoS0VSTl9FUlIgIm1t
cCBoZG1pX2Rldl9yZWdpc3RlciBmYWlsXG4iKTsKKwkJZ290byBpcnFfZnJlZTsKKwl9CisJcmV0
dXJuIDA7CisKK2lycV9mcmVlOgorCWZyZWVfaXJxKGdwaW9fdG9faXJxKHBkYXRhLT5ncGlvKSwg
TlVMTCk7CitmcmVlX2dwaW86CisJZ3Bpb19mcmVlKHBkYXRhLT5ncGlvKTsKK291dF9mcmVlOgor
b3V0X21kZXY6CisJa2ZyZWUobWRldik7CisJY2xrX2Rpc2FibGUoY2xrKTsKKwljbGtfcHV0KGNs
ayk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaGRt
aV9tbXBfZHJpdmVyID0geworCS5kcml2ZXIgICAgICAgICA9IHsKKwkJLm5hbWUgICA9ICJtbXAt
aGRtaSIsCisJCS5vd25lciAgPSBUSElTX01PRFVMRSwKKwl9LAorCS5wcm9iZSAgICAgICAgICA9
IGhkbWlfbW1wX3Byb2JlLAorCS8vLnJlbW92ZSAgICAgICAgID0gX19kZXZleGl0X3AoaGRtaV9t
bXBfcmVtb3ZlKSwKK307CisKK3N0YXRpYyBpbnQgX19kZXZpbml0IGhkbWlfbW1wX2luaXQodm9p
ZCkKK3sKKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZoZG1pX21tcF9kcml2ZXIp
OworfQorCittb2R1bGVfaW5pdChoZG1pX21tcF9pbml0KTsKKworTU9EVUxFX0FVVEhPUigiSnVu
IE5pZSA8bmp1bkBtYXJ2ZWxsLmNvbT4iKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVM
RV9ERVNDUklQVElPTigiSERNSSBkcml2ZXIgZm9yIE1hcnZlbGwgTU1QIik7CitNT0RVTEVfQUxJ
QVMoImhkbWktbW1wIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2hkbWkuYyBiL2RyaXZl
cnMvdmlkZW8vaGRtaS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmM4NDVk
YzcKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL3ZpZGVvL2hkbWkuYwpAQCAtMCwwICsxLDY3
NSBAQAorLyoKKyAqIEhETUkgQ29udHJvbCBBYnN0cmFjdGlvbgorICoKKyAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uIHZlcnNp
b24gMiBvZiB0aGUgTGljZW5zZS4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
CisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqLwor
CisjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgorI2luY2x1ZGUg
PGxpbnV4L2ZiLmg+CisjaW5jbHVkZSA8bGludXgvZnJlZXplci5oPgorI2luY2x1ZGUgPGxpbnV4
L2hkbWkuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgvaW5wdXQu
aD4KKyNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+CisjaW5jbHVkZSA8bGludXgvbGNkLmg+Cisj
aW5jbHVkZSA8bGludXgvbGlzdC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1
ZGUgPGxpbnV4L211dGV4Lmg+CisjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KKyNpbmNsdWRlIDxs
aW51eC9ub3RpZmllci5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51
eC9zcGlubG9jay5oPgorCisjZGVmaW5lIEhETUlfREVCVUcKK3N0YXRpYyBpbnQgaGRtaV9jb3Jl
X2RlYnVnID0gNTsKKyNkZWZpbmUgaGRtaV9kcHJpbnRrKGxldmVsLCBmbXQsIGFyZy4uLikJaWYg
KGhkbWlfY29yZV9kZWJ1ZyA+PSBsZXZlbCkgXAorCXByaW50ayhLRVJOX0RFQlVHICIlczogIiBm
bXQgLCBfX2Z1bmNfXywgIyMgYXJnKQorCisvKiBEZWZpbmUgdGhlIG1heCBudW1iZXIgb2YgZXZl
bnRzIHRvIGJ1ZmZlciAqLworI2RlZmluZSBNQVhfSERNSV9FVkVOVF9TSVpFICAgICAgMTYKKwor
c3RhdGljIGludCBoZG1pZGV2bm87CisKKy8qID09PT09PT09PT09PT09PT09PT09IGluZm8gZnJh
bWUgdXRpbGl0eSA9PT09PT09PT09PT09PT09PT09PT0gKi8KKworaW50IGhkbWlfdmVuZGVyX2lu
Zm9fZnJhbWUgKHN0cnVjdCBoZG1pX2RldiAqaGQsIGNoYXIgYnVmW10pCit7CisJYnVmWzBdID0g
MHg4NDsKKwlidWZbMV0gPSAweDE7CisJYnVmWzJdID0gMHhhOworCWJ1ZlszXSA9IDB4NzA7CisJ
YnVmWzRdID0gMHgxOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaGRtaV92ZW5kZXJfaW5mb19mcmFt
ZSk7CisKK2ludCBoZG1pX2F2aV9pbmZvX2ZyYW1lIChzdHJ1Y3QgaGRtaV9kZXYgKmhkLCBjaGFy
IGJ1ZltdKQoreworCWludCBjb3VudDsKKwljaGFyIGNoZWNrX3N1bTsKKworCWhkbWlfZHByaW50
aygzLCAicGFjayBhdmkgaW5mb2ZyYW1lXG4iKTsKKwkvKiBwYWNrZXQgaGVhZGVyIGZvciBBVkkg
UGFja2V0IGluIHBrdDEgKi8KKwkvKiBGaXggbWUuIHdlIHNob3VsZCBzZXQgYml0cyBhY2NvcmRp
bmcgdG8gZm9ybWF0ICovCisJYnVmWzBdID0gMHg4MjsgLyogSW5mb0ZyYW1lIFR5cGUsIEFWSSBm
cmFtZSAqLworCWJ1ZlsxXSA9IDB4MjsgIC8qIFZlcnNpb24gPSAwMiAqLworCWJ1ZlsyXSA9IDB4
ZDsgIC8qIExlbmd0aCA9IDEzICovCisJYnVmWzNdID0gMHgwOyAgLyogY2hlY2tzdW0gKi8KKwli
dWZbNF0gPSAweDA7IC8qIEZpeCB0byBSR0IgZm9ybWF0IGN1cnJlbnRseSAqLworCS8qCisJYnVm
WzRdID0gMHgxMDsgLy8gUkdCLCBBY3RpdmUgRm9ybWF0KHIwLHIxLHIyLHIzKSB2YWxpZCwgbm8g
YmFyLCBubyBzY2FuCisJYnVmWzRdID0gMHgzMDsgLy8gSERNSV9ZVVY0MjIsIEFjdGl2ZSBGb3Jt
YXQocjAscjEscjIscjMpIHZhbGlkLCBubyBiYXIsIG5vIHNjYW4KKwlidWZbNF0gPSAweDUwOyAv
LyBIRE1JX1lVVjQ0NCwgQWN0aXZlIEZvcm1hdChyMCxyMSxyMixyMykgdmFsaWQsIG5vIGJhciwg
bm8gc2NhbgorCSovCisKKwlidWZbNV0gPSAweGE4OyAgLyogSVRVLVIgNzA5LCAxNjo5ICovCisJ
YnVmWzZdID0gMHgyMDsKKwkvKiBidWZbNl0gPSAweDA7ICAgLy8gTm8gSVQgY29udGVudCwgeHZZ
Q0M2MDEsIG5vIHNjYWxpbmcgKi8KKwlidWZbN10gPSBoZC0+bW9kZV9pZDsKKwkvKiBsaW1pdGVk
IFlDQyByYW5nZSwgZ3JhcGhpY3MsIG5vIHJlcGVhdCAgUGl4ZWwgcmVwaXRpdGlvbiBmYWN0b3Ig
Ki8KKwlidWZbOF0gPSBoZC0+cGl4ZWxfcmVwdDsKKworCWJ1Zls5XSA9IDB4MDsKKwlidWZbMTBd
ID0gMHgwOworCWJ1ZlsxMV0gPSAweDA7CisJYnVmWzEyXSA9IDB4MDsKKwlidWZbMTNdID0gMHgw
OworCWNoZWNrX3N1bSA9IDA7CisgICAgZm9yIChjb3VudCA9IDA7IGNvdW50IDwgMTQ7IGNvdW50
KyspCisJICAgIGNoZWNrX3N1bSArPSBidWZbY291bnRdOworICAgIGJ1ZlszXSA9IDB4MTAwIC0g
Y2hlY2tfc3VtOworICAgIHJldHVybiAwOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaGRtaV9hdmlf
aW5mb19mcmFtZSk7CisKK2ludCBoZG1pX2dldF9mcmVxIChzdHJ1Y3QgaGRtaV9kZXYgKmhkLCB1
MzIgKm5lZWRfZnJlcSkKK3sKKwl1NjQgZGl2X3Jlc3VsdDsKKwlpbnQgZnJlcTsKKworCS8qIENh
bGMgZGl2aWRlciBhY2NvcmRpbmcgdG8gcGNsayBpbiBwaWNvIHNlY29uZCAqLworCWRpdl9yZXN1
bHQgPSAxMDAwMDAwMDAwMDAwbGw7CisJZG9fZGl2KGRpdl9yZXN1bHQsIGNlYV9tb2Rlc1toZC0+
bW9kZV9pZF0ucGl4Y2xvY2spOworCWZyZXEgPSAodTMyKWRpdl9yZXN1bHQ7CisKKwloZG1pX2Rw
cmludGsoMywgImdldCBiYXNlIHBjbGsgJWRcbiIsIGZyZXEpOworCisJaWYgKEZCX1ZNT0RFX0lO
VEVSTEFDRUQgJiBjZWFfbW9kZXNbaGQtPm1vZGVfaWRdLnZtb2RlKQorCQlmcmVxID4+PSAxOwor
CisJaWYgKDM2ID09IGhkLT5mYl9pbmZvLT52YXIuYml0c19wZXJfcGl4ZWwpCisJCWZyZXEgKz0g
ZnJlcSA+PiAxOworCWVsc2UgaWYgKDMwID09IGhkLT5mYl9pbmZvLT52YXIuYml0c19wZXJfcGl4
ZWwpCisJCWZyZXEgKz0gZnJlcSA+PiAyOworCisJLyogV2Ugb25seSBzdXBwb3J0IHJlcGVhdD0y
LzQgY3VycmVudGx5LiBBZGQgbW9yZSBsYXRlciAqLworCWlmICghKGhkLT5waXhlbF9yZXB0ID09
IDAgfHwgaGQtPnBpeGVsX3JlcHQgPT0gMQorCQkJCXx8IGhkLT5waXhlbF9yZXB0ID09IDMpKSB7
CisJCWhkbWlfZHByaW50aygzLCAiTm90IHN1cHBvcnQgcGl4IHJlcGVhdCAlZFxuIiwgaGQtPnBp
eGVsX3JlcHQpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlpZiAoMSA9PSBoZC0+cGl4ZWxf
cmVwdCkKKwl7CisJCWlmICghKEZCX1ZNT0RFX0lOVEVSTEFDRUQgJiBjZWFfbW9kZXNbaGQtPm1v
ZGVfaWRdLnZtb2RlKSkKKwkJCWZyZXEgPDw9IDE7CisJfSBlbHNlIGlmICgzID09IGhkLT5waXhl
bF9yZXB0KSB7CisJCWlmICghKEZCX1ZNT0RFX0lOVEVSTEFDRUQgJiBjZWFfbW9kZXNbaGQtPm1v
ZGVfaWRdLnZtb2RlKSkKKwkJCWZyZXEgPDw9IDI7CisJCWVsc2UKKwkJCWZyZXEgPDw9IDE7CisJ
fQorCisJaGRtaV9kcHJpbnRrKDMsICJnZXQgaGRtaSBwY2xrICVkXG4iLCBmcmVxKTsKKwkqbmVl
ZF9mcmVxID0gZnJlcTsKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKGhkbWlfZ2V0
X2ZyZXEpOworCisvKiA9PT09PT09PT09PT09PT09PT09PSB2aWRlbyBwYXJ0ID09PT09PT09PT09
PT09PT09PT09PSAqLworaW50IGhkbWlfbGNkX2NoZWNrX2ZiKHN0cnVjdCBsY2RfZGV2aWNlICog
bGQsIHN0cnVjdCBmYl9pbmZvICpmaSkKK3sKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0gbGNkX2dl
dF9kYXRhKGxkKTsKKworCWhkbWlfZHByaW50aygzLCAiaGRtaV9sY2RfY2hlY2tfZmIuLlxuIik7
CisJcmV0dXJuIDE7Cit9CisKKy8qIFdlJ2QgYmV0dGVyIHVwZGF0ZSBtb2RlIGxpc3QgaW4gaG90
IHBsdWcgb3BlcmF0aW9uLgorICAgTENEIGZyYW1ld29yayBkb2VzIG5vdCBpbXBsZW1lbnQgZ2V0
X21vZGUgeWV0ICovCitzdGF0aWMgaW50IGhkbWlfbGNkX2dldF9tb2RlKHN0cnVjdCBsY2RfZGV2
aWNlICpsZCwgc3RydWN0IGZiX3ZpZGVvbW9kZSAqbW9kZSkKK3sKKwlzdHJ1Y3QgaGRtaV9kZXYg
KmhkID0gbGNkX2dldF9kYXRhKGxkKTsKKworCS8qIFRPRE86IHJldHVybiBwYXJzZWQgbW9kZSBs
aXN0ICovCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgaGRtaV9sY2Rfc2V0X21vZGUoc3Ry
dWN0IGxjZF9kZXZpY2UgKmxkLCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICptb2RlKQoreworCS8vc3Ry
dWN0IGhkbWlfbGNkX2RhdGEgKmRhdGEgPSBsY2RfZ2V0X2RhdGEobGNkKTsKKwlzdHJ1Y3QgaGRt
aV9kZXYgKmhkID0gbGNkX2dldF9kYXRhKGxkKTsKKwljZWFfbW9kZV9pZCBtb2RlX2lkOworCisJ
aGRtaV9kcHJpbnRrKDMsICJoZG1pX2xjZF9zZXRfbW9kZSBkZXZcbiIpOworCW1vZGVfaWQgPSBm
Yl9maW5kX2NlYV9tb2RlX2luZGV4KG1vZGUpOworCWlmICghbW9kZV9pZCkgeworCQloZG1pX2Rw
cmludGsoMSwgInVua25vd24gdmlkZW8gbW9kZSAlZFxuIiwgbW9kZV9pZCk7CisJCXJldHVybiAt
RUlOVkFMOworCX0KKwkvKiBJZiBoaWdoIGxldmVsIG9uIGRldGVjdGlvbiBzaWduYWwsIG5vIGNv
bm5lY3Rpb24gKi8KKwlpZighIGhkLT5vcHMtPmdldF9ocGQoaGQpKQorCQlyZXR1cm4gMDsKKwor
CWhkLT5vcHMtPnNldF9tb2RlKGhkLCBtb2RlX2lkKTsKKworCWlmIChoZC0+b3BzICYmIGhkLT5v
cHMtPnNldF9lbmFibGUpCisJCWhkLT5vcHMtPnNldF9lbmFibGUoaGQsIDEpOworfQorCitzdGF0
aWMgc3RydWN0IGxjZF9vcHMgaGRtaV9sY2Rfb3BzID0geworCS5nZXRfbW9kZSA9IGhkbWlfbGNk
X2dldF9tb2RlLAorCS5zZXRfbW9kZSA9IGhkbWlfbGNkX3NldF9tb2RlLAorCS5jaGVja19mYiA9
IGhkbWlfbGNkX2NoZWNrX2ZiLAorfTsKKworc3RhdGljIGludCBoZG1pX3JlZ2lzdGVyX2xjZChz
dHJ1Y3QgaGRtaV9kZXYgKmRldikKK3sKKwlpbnQgcmV0ID0gMDsKKworCWhkbWlfZHByaW50aygz
LCAicmVnaXN0ZXJpbmcgbGNkIGRldmljZS4uLlxuIik7CisJLyogRklYIE1FISBIb3cgdG8gaG9v
ayBleHBlY3RlZCBmYiBpZiBtb3JlIHRoYW4gb25lIGZiIGV4aXN0PyAqLworCWRldi0+bGNkID0g
bGNkX2RldmljZV9yZWdpc3RlcigiaGRtaS1sY2QiLCBkZXYtPmRldiwgZGV2LAorCQkJJmhkbWlf
bGNkX29wcyk7CisKKwlpZiAoSVNfRVJSKGRldi0+bGNkKSkgeworCQlyZXQgPSBQVFJfRVJSKGRl
di0+bGNkKTsKKwkJZGV2LT5sY2QgPSBOVUxMOworCQlyZXR1cm4gcmV0OworCX0KKwloZG1pX2Rw
cmludGsoMywgInJlZ2lzdGVyaW5nIGxjZCBkZXZpY2Ugb2tcbiIpOworCXJldHVybiAwOworfQor
CisvKiA9PT09PT09PT09PT09PT09PT09PSBhdWRpbyBwYXJ0ID09PT09PT09PT09PT09PT09PT09
PSAqLworLyogPT09PT09PT09PT09PT09PT09PT0gY2VjIHBhcnQgPT09PT09PT09PT09PT09PT09
PT09ICovCisvKiA9PT09PT09PT09PT09PT09PT09PSBlZGlkIHBhcnQgPT09PT09PT09PT09PT09
PT09PT09ICovCisKKy8qID09PT09PT09PT09PT09PT09PT09IGhvdCBwbHVnIHBhcnQgPT09PT09
PT09PT09PT09PT09PT09ICovCitzdGF0aWMgaW50IGhkbWlfaG90cGx1ZyhzdHJ1Y3QgaGRtaV9k
ZXYgKmhkKQoreworCWludCByZXQ7CisKKwltc2xlZXAoMTAwKTsKKwlyZXQgPSBoZC0+b3BzLT5n
ZXRfaHBkKGhkKTsKKwlpZighcmV0KSB7CisJCWhkbWlfZHByaW50aygzLCAidXBsdWdnZWQuIGRl
diAlcFxuIiwgaGQpOworCQlyZXQgPSBoZC0+b3BzLT5zZXRfZW5hYmxlKGhkLCAwKTsKKwkJbG9j
a19mYl9pbmZvKGhkLT5mYl9pbmZvKTsKKwkJLyogV2Ugc2hvdWxkIGNsZWFyIG1vZGUgbGlzdCBo
ZXJlICovCisJCS8qIC4uLiAqLworCQl1bmxvY2tfZmJfaW5mbyhoZC0+ZmJfaW5mbyk7CisJCXJl
dHVybiAwOworCX0KKworCXJldCA9IGhkLT5vcHMtPmluaXQoaGQpOworCWlmIChyZXQpIHsKKwkJ
aGRtaV9kcHJpbnRrKDEsICJpbml0IGZhaWxcbiIpOworCX0KKworCWlmKGhkLT5mYl9pbmZvICYm
IGhkLT5mYl9pbmZvLT5tb2RlKSB7CisJCWxvY2tfZmJfaW5mbyhoZC0+ZmJfaW5mbyk7CisJCS8q
IEZpeCBtZSEgV2Ugc2hvdWxkIGdldCBFRElEIGFuZCBwYXJzZSBtb2RlIGxpc3QgaGVyZSAqLwor
CQkvKiBCdXQgbm93IHdlIHVzZSBmaXggbW9kZSBsaXN0IGZpcnN0IGJlZm9yZSBFRElEIHV0aWwg
aXMgcmVhZHkgKi8KKwkJLyogLi4uICovCisJCXVubG9ja19mYl9pbmZvKGhkLT5mYl9pbmZvKTsK
KworCQlyZXQgPSBoZG1pX2xjZF9zZXRfbW9kZShoZC0+bGNkLCBoZC0+ZmJfaW5mby0+bW9kZSk7
CisJCWlmIChyZXQpIHsKKwkJCWhkbWlfZHByaW50aygxLCAiZmFpbCB0byBzZXQgdmlkZW8gbW9k
ZVxuIik7CisJCX0KKwl9IGVsc2UgeworCQloZG1pX2RwcmludGsoMywgIm5vIGF2YWxpYWJsZSB2
aWRlbyBtb2RlXG4iKTsKKwl9CisKKwlpZiAoaGQtPmVuYWJsZSkKKwkJcmV0ID0gaGQtPm9wcy0+
c2V0X2VuYWJsZShoZCwgMSk7CisJcmV0dXJuIHJldDsKK30KKworLyogSGFuZGxpbmcgaG90IHBs
dWcgSERDUCBhbmQgQ0VDICovCitzdGF0aWMgaW50IGhkbWlfZXZlbnRfdGhyZWFkKHZvaWQgKmRh
dGEpCit7CisJc3RydWN0IGhkbWlfZGV2ICpkZXYgPSAoc3RydWN0IGhkbWlfZGV2ICopZGF0YTsK
KwlzdHJ1Y3QgaGRtaV9ldmVudCAqZXZ0OworCisJd2hpbGUgKCFrdGhyZWFkX3Nob3VsZF9zdG9w
KCkpIHsKKworCQlzcGluX2xvY2tfaXJxKCZkZXYtPmxvY2spOworCQlpZiAobGlzdF9lbXB0eSgm
ZGV2LT5oZG1pX2V2dF9saXN0KSkgeworCQkJc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRFUlJV
UFRJQkxFKTsKKworCQkJaWYgKGt0aHJlYWRfc2hvdWxkX3N0b3AoKSkKKwkJCQlzZXRfY3VycmVu
dF9zdGF0ZShUQVNLX1JVTk5JTkcpOworCisJCQlzcGluX3VubG9ja19pcnEoJmRldi0+bG9jayk7
CisJCQlzY2hlZHVsZSgpOworCQkJY29udGludWU7CisJCX0KKworCQlldnQgPSBsaXN0X2VudHJ5
KGRldi0+aGRtaV9ldnRfbGlzdC5uZXh0LCB0eXBlb2YoKmV2dCksIGxpc3QpOworCQlsaXN0X2Rl
bCgmZXZ0LT5saXN0KTsKKwkJc3Bpbl91bmxvY2tfaXJxKCZkZXYtPmxvY2spOworCQloZG1pX2Rw
cmludGsoMSwgIlJlY2VpdmUgZXZ0IHR5cGUgJWRcbiIsIGV2dC0+dHlwZSk7CisKKwkJbXV0ZXhf
bG9jaygmZGV2LT5oZG1pX2xvY2spOworCQlzd2l0Y2ggKGV2dC0+dHlwZSkgeworCQkJLyogdHJp
Z2dlciBncGlvIGlycSAqLworCQkJY2FzZSBIRE1JX0VWX1BMVUc6CisJCQkJaGRtaV9ob3RwbHVn
KGRldik7CisJCQkJYnJlYWs7CisJCQkvKiB0cmlnZ2VyIGZyb20gVFYvQ0VDICovCisJCQljYXNl
IEhETUlfRVZfQ0VDOgorCQkJCWJyZWFrOworCQkJZGVmYXVsdDoKKwkJCQloZG1pX2RwcmludGso
MSwgIkludmFsaWQgZXZlbnQgdHlwZSAlZFxuIiwgZXZ0LT50eXBlKTsKKwkJCQlicmVhazsKKwkJ
fQorCQltdXRleF91bmxvY2soJmRldi0+aGRtaV9sb2NrKTsKKwl9CisKKwlyZXR1cm4gMDsKK30K
KworLyoqCisgKiBoZG1pX2V2ZW50X3NpZ25hbCgpIC0gc2NoZWR1bGVzIHRoZSBoZG1pIGV2ZW50
IHRocmVhZAorICogQGRldjoJdGhlIHN0cnVjdCBoZG1pX2RldiBkZXZpY2UKKyAqCisgKiBUaGlz
IHJvdXRpbmUgd2lsbCB0ZWxsIGhkbWktY29yZSB0byBzdGFydCBkZWNvZGluZyBzdG9yZWQgaXIg
ZGF0YS4KKyAqLwordm9pZCBoZG1pX2V2ZW50X3NpZ25hbChzdHJ1Y3QgaGRtaV9kZXYgKmRldiwg
ZW51bSBoZG1pX2V2ZW50X3R5cGUgdHlwZSkKK3sKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCXN0
cnVjdCBoZG1pX2V2ZW50ICpldnQ7CisKKwloZG1pX2RwcmludGsoMSwgImhkbWkgZXZlbnQgJWQg
c3RvcmVkLCBkZXYgJXBcbiIsIHR5cGUsIGRldik7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmZGV2
LT5sb2NrLCBmbGFncyk7CisJaWYoSERNSV9FVl9QTFVHID09IHR5cGUpIHsKKwkJbGlzdF9mb3Jf
ZWFjaF9lbnRyeShldnQsICZkZXYtPmhkbWlfZXZ0X2xpc3QsIGxpc3QpIHsKKwkJCWlmIChIRE1J
X0VWX1BMVUcgPT0gZXZ0LT50eXBlKSB7CisJCQkJaGRtaV9kcHJpbnRrKDEsICJwZW5kaW5nIGhv
dHBsdWcgZXZlbnQsIGlnbm9yZSBuZXcgb25lc1xuIik7CisJCQkJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7CisJCQkJcmV0dXJuOworCQkJfQorCQl9CisJfQorCWV2
dCA9IGxpc3RfZW50cnkoZGV2LT5mcmVlX2V2dF9saXN0Lm5leHQsIHN0cnVjdCBoZG1pX2V2ZW50
LCBsaXN0KTsKKwlldnQtPnR5cGUgPSB0eXBlOworCWxpc3RfbW92ZV90YWlsKCZldnQtPmxpc3Qs
ICZkZXYtPmhkbWlfZXZ0X2xpc3QpOworCXdha2VfdXBfcHJvY2VzcyhkZXYtPnRocmVhZCk7CisJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7Cit9CitFWFBPUlRfU1lN
Qk9MX0dQTChoZG1pX2V2ZW50X3NpZ25hbCk7CisKKy8qID09PT09PT09PT09PT09PT09PT09IHN5
cyBmcyBwYXJ0ID09PT09PT09PT09PT09PT09PT09PSAqLworI2lmZGVmIEhETUlfREVCVUcKK3N0
YXRpYyBzc2l6ZV90IGhkbWlfc2hvd19yZWcoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwKKwkJY2hhciAqYnVmKQoreworCWludCByYzsKKwlzdHJ1Y3Qg
aGRtaV9kZXYgKmhkID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisKKwltdXRleF9sb2NrKCZoZC0+
dXBkYXRlX2xvY2spOworCWlmIChoZC0+b3BzICYmIGhkLT5vcHMtPmdldF9yZWcpCisJCXJjID0g
c3ByaW50ZihidWYsICIlZFxuIiwgaGQtPm9wcy0+Z2V0X3JlZyhoZCkpOworCWVsc2UKKwkJcmMg
PSAtRU5YSU87CisJbXV0ZXhfdW5sb2NrKCZoZC0+dXBkYXRlX2xvY2spOworCisJcmV0dXJuIHJj
OworfQorCitzdGF0aWMgc3NpemVfdCBoZG1pX3N0b3JlX3JlZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
CisJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVf
dCBjb3VudCkKK3sKKwlpbnQgcmMgPSAtRU5YSU87CisJY2hhciAqZW5kcDsKKwlzdHJ1Y3QgaGRt
aV9kZXYgKmhkID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJaW50IHBvd2VyID0gc2ltcGxlX3N0
cnRvdWwoYnVmLCAmZW5kcCwgMCk7CisJc2l6ZV90IHNpemUgPSBlbmRwIC0gYnVmOworCisJbXV0
ZXhfbG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAoaGQtPm9wcyAmJiBoZC0+b3BzLT5zZXRf
cmVnKSB7CisJCWhkLT5vcHMtPnNldF9yZWcoaGQsIHBvd2VyLCBwb3dlcik7CisJCXJjID0gY291
bnQ7CisJfQorCW11dGV4X3VubG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKworCXJldHVybiByYzsK
K30KKworc3RhdGljIHNzaXplX3QgaGRtaV9zaG93X3JlZ19hZGRyKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCWNoYXIgKmJ1ZikKK3sKKwlpbnQg
cmM7CisJc3RydWN0IGhkbWlfZGV2ICpoZCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCisJbXV0
ZXhfbG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAoaGQtPm9wcyAmJiBoZC0+b3BzLT5nZXRf
cmVnKQorCQlyYyA9IHNwcmludGYoYnVmLCAiJWRcbiIsIGhkLT5vcHMtPmdldF9yZWcoaGQpKTsK
KwllbHNlCisJCXJjID0gLUVOWElPOworCW11dGV4X3VubG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsK
KworCXJldHVybiByYzsKK30KKworc3RhdGljIHNzaXplX3QgaGRtaV9zdG9yZV9yZWdfYWRkcihz
dHJ1Y3QgZGV2aWNlICpkZXYsCisJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25z
dCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKK3sKKwlpbnQgcmMgPSAtRU5YSU87CisJY2hhciAq
ZW5kcDsKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJaW50
IHBvd2VyID0gc2ltcGxlX3N0cnRvdWwoYnVmLCAmZW5kcCwgMCk7CisJc2l6ZV90IHNpemUgPSBl
bmRwIC0gYnVmOworCisJbXV0ZXhfbG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAoaGQtPm9w
cyAmJiBoZC0+b3BzLT5zZXRfcmVnKSB7CisJCWhkLT5vcHMtPnNldF9yZWcoaGQsIHBvd2VyLCBw
b3dlcik7CisJCXJjID0gY291bnQ7CisJfQorCW11dGV4X3VubG9jaygmaGQtPnVwZGF0ZV9sb2Nr
KTsKKworCXJldHVybiByYzsKK30KKyNlbmRpZgorCitzdGF0aWMgc3NpemVfdCBoZG1pX3Nob3df
cmF0aW8oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwK
KwkJY2hhciAqYnVmKQoreworCWludCByYzsKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7CisKKwltdXRleF9sb2NrKCZoZC0+dXBkYXRlX2xvY2spOworCWlmICho
ZC0+cmF0aW8gPT0gUkFUSU9fMTZWOSkKKwkJcmMgPSBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBSQVRJ
T18xNlY5X1NUUik7CisJZWxzZSBpZiAoaGQtPnJhdGlvID09IFJBVElPXzRWMykKKwkJcmMgPSBz
cHJpbnRmKGJ1ZiwgIiVzXG4iLCBSQVRJT180VjNfU1RSKTsKKwllbHNlCisJCXJjID0gLUVOWElP
OworCW11dGV4X3VubG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKworCXJldHVybiByYzsKK30KKwor
c3RhdGljIHNzaXplX3QgaGRtaV9zdG9yZV9yYXRpbyhzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCXN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCkKK3sKKwlpbnQgcmMgPSAtRU5YSU87CisJc3RydWN0IGhkbWlfZGV2ICpoZCA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOworCisJbXV0ZXhfbG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAoc3lz
ZnNfc3RyZXEoYnVmLCBSQVRJT18xNlY5X1NUUikpIHsKKwkJaGQtPnJhdGlvID0gUkFUSU9fMTZW
OTsKKwl9IGVsc2UgaWYgKHN5c2ZzX3N0cmVxKGJ1ZiwgUkFUSU9fNFYzX1NUUikpIHsKKwkJaGQt
PnJhdGlvID0gUkFUSU9fNFYzOworCX0KKwltdXRleF91bmxvY2soJmhkLT51cGRhdGVfbG9jayk7
CisKKwlyZXR1cm4gcmM7Cit9CisKK3N0YXRpYyBzc2l6ZV90IGhkbWlfc2hvd19wb3dlcihzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAorCQljaGFyICpi
dWYpCit7CisJaW50IHJjOworCXN0cnVjdCBoZG1pX2RldiAqaGQgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsKKworCW11dGV4X2xvY2soJmhkLT51cGRhdGVfbG9jayk7CisJaWYgKGhkLT5vcHMgJiYg
aGQtPm9wcy0+Z2V0X3Bvd2VyKSB7CisJCWhkLT5vcHMtPmdldF9wb3dlcihoZCk7CisJCXJjID0g
c3ByaW50ZihidWYsICIlZFxuIiwgaGQtPm9wcy0+Z2V0X3Bvd2VyKGhkKSk7CisJfQorCW11dGV4
X3VubG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKworCXJldHVybiByYzsKK30KKworc3RhdGljIHNz
aXplX3QgaGRtaV9zdG9yZV9wb3dlcihzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCXN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKK3sKKwlp
bnQgcmMgPSAtRU5YSU87CisJY2hhciAqZW5kcDsKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0gZGV2
X2dldF9kcnZkYXRhKGRldik7CisJaW50IHBvd2VyID0gc2ltcGxlX3N0cnRvdWwoYnVmLCAmZW5k
cCwgMCk7CisJc2l6ZV90IHNpemUgPSBlbmRwIC0gYnVmOworCisJaWYgKGlzc3BhY2UoKmVuZHAp
KQorCQlzaXplKys7CisJaWYgKHNpemUgIT0gY291bnQpCisJCXJldHVybiAtRUlOVkFMOworCisJ
bXV0ZXhfbG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAoaGQtPm9wcyAmJiBoZC0+b3BzLT5z
ZXRfcG93ZXIpIHsKKwkJaGRtaV9kcHJpbnRrKDMsICJoZG1pOiBzZXQgcG93ZXIgdG8gJWRcbiIs
IHBvd2VyKTsKKwkJaGQtPm9wcy0+c2V0X3Bvd2VyKGhkLCBwb3dlcik7CisJCXJjID0gY291bnQ7
CisJfQorCW11dGV4X3VubG9jaygmaGQtPnVwZGF0ZV9sb2NrKTsKKworCXJldHVybiByYzsKK30K
Kworc3RhdGljIHNzaXplX3QgaGRtaV9zaG93X2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJ
CXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCit7CisJaW50IHJjID0g
LUVOWElPOworCXN0cnVjdCBoZG1pX2RldiAqaGQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwor
CW11dGV4X2xvY2soJmhkLT51cGRhdGVfbG9jayk7CisJaWYgKGhkLT5vcHMgJiYgaGQtPm9wcy0+
Z2V0X2VuYWJsZSkKKwkJcmMgPSBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBoZC0+b3BzLT5nZXRfZW5h
YmxlKGhkKSk7CisJbXV0ZXhfdW5sb2NrKCZoZC0+dXBkYXRlX2xvY2spOworCisJcmV0dXJuIHJj
OworfQorCitzdGF0aWMgc3NpemVfdCBoZG1pX3N0b3JlX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsCisJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNp
emVfdCBjb3VudCkKK3sKKwlpbnQgcmMgPSAtRU5YSU87CisJY2hhciAqZW5kcDsKKwlzdHJ1Y3Qg
aGRtaV9kZXYgKmhkID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJaW50IGVuYWJsZSA9IHNpbXBs
ZV9zdHJ0b3VsKGJ1ZiwgJmVuZHAsIDApOworCXNpemVfdCBzaXplID0gZW5kcCAtIGJ1ZjsKKwor
CWlmIChpc3NwYWNlKCplbmRwKSkKKwkJc2l6ZSsrOworCWlmIChzaXplICE9IGNvdW50KQorCQly
ZXR1cm4gLUVJTlZBTDsKKworCW11dGV4X2xvY2soJmhkLT51cGRhdGVfbG9jayk7CisJaGQtPmVu
YWJsZSA9IGVuYWJsZTsKKwlpZiAoaGQtPm9wcyAmJiBoZC0+b3BzLT5zZXRfZW5hYmxlKSB7CisJ
CWhkbWlfZHByaW50aygzLCAiaGRtaTogc2V0IGVuYWJsZSB0byAlZFxuIiwgZW5hYmxlKTsKKwkJ
aGQtPm9wcy0+c2V0X2VuYWJsZShoZCwgZW5hYmxlKTsKKwkJcmMgPSBjb3VudDsKKwl9CisJbXV0
ZXhfdW5sb2NrKCZoZC0+dXBkYXRlX2xvY2spOworCisJcmV0dXJuIHJjOworfQorCitzdGF0aWMg
c3NpemVfdCBoZG1pX3Nob3dfaG90cGx1ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCXN0cnVjdCBk
ZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKK3sK
KwlpbnQgcmMgPSAtRU5YSU87CisJY2hhciAqZW5kcDsKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7CisKKwltdXRleF9sb2NrKCZoZC0+dXBkYXRlX2xvY2spOwor
CWlmIChoZC0+b3BzICYmIGhkLT5vcHMtPmdldF9ocGQpIHsKKwkJcmMgPSBzcHJpbnRmKGJ1Ziwg
IiVkXG4iLCAhIGhkLT5vcHMtPmdldF9ocGQoaGQpKTsKKwl9CisJbXV0ZXhfdW5sb2NrKCZoZC0+
dXBkYXRlX2xvY2spOworCisJcmV0dXJuIHJjOworfQorCitzdGF0aWMgc3RydWN0IGNsYXNzICpo
ZG1pX2NsYXNzOworCitzdGF0aWMgdm9pZCBoZG1pX2Rldl9yZWxlYXNlKHN0cnVjdCBkZXZpY2Ug
KmRldikKK3sKKwlzdHJ1Y3QgaGRtaV9kZXYgKmhkID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJ
a2ZyZWUoaGQpOworfQorCitzdGF0aWMgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgaGRtaV9kZXZf
YXR0cmlidXRlc1tdID0geworCV9fQVRUUihwb3dlciwgMDY0NCwgaGRtaV9zaG93X3Bvd2VyLCBo
ZG1pX3N0b3JlX3Bvd2VyKSwKKwlfX0FUVFIocmF0aW8sIDA2NDQsIGhkbWlfc2hvd19yYXRpbywg
aGRtaV9zdG9yZV9yYXRpbyksCisjaWZkZWYgSERNSV9ERUJVRworCV9fQVRUUihyZWdfdmFsLCAw
NjQ0LCBoZG1pX3Nob3dfcmVnLCBoZG1pX3N0b3JlX3JlZyksCisJX19BVFRSKHJlZ19hZGRyLCAw
NjQ0LCBoZG1pX3Nob3dfcmVnX2FkZHIsIGhkbWlfc3RvcmVfcmVnX2FkZHIpLAorI2VuZGlmCisJ
X19BVFRSKGVuYWJsZSwgMDY0NCwgaGRtaV9zaG93X2VuYWJsZSwgaGRtaV9zdG9yZV9lbmFibGUp
LAorCV9fQVRUUihob3RwbHVnLCAwNjQ0LCBoZG1pX3Nob3dfaG90cGx1ZywgTlVMTCksCisJX19B
VFRSX05VTEwsCit9OworCisvKioKKyAqIGhkbWlfZGV2X3JlZ2lzdGVyIC0gcmVnaXN0ZXIgYSBu
ZXcgb2JqZWN0IG9mIGhkbWlfZGV2IGNsYXNzLgorICogQG5hbWU6IHRoZSBuYW1lIG9mIHRoZSBu
ZXcgb2JqZWN0KG11c3QgYmUgdGhlIHNhbWUgYXMgdGhlIG5hbWUgb2YgdGhlCisgKiAgIHJlc3Bl
Y3RpdmUgZnJhbWVidWZmZXIgZGV2aWNlKS4KKyAqIEBkZXZkYXRhOiBhbiBvcHRpb25hbCBwb2lu
dGVyIHRvIGJlIHN0b3JlZCBpbiB0aGUgZGV2aWNlLiBUaGUKKyAqICAgbWV0aG9kcyBtYXkgcmV0
cmlldmUgaXQgYnkgdXNpbmcgaGRtaV9nZXRfZGF0YShoZCkuCisgKiBAb3BzOiB0aGUgaGRtaSBv
cGVyYXRpb25zIHN0cnVjdHVyZS4KKyAqCisgKiBDcmVhdGVzIGFuZCByZWdpc3RlcnMgYSBuZXcg
aGRtaSBkZXZpY2UuIFJldHVybnMgZWl0aGVyIGFuIEVSUl9QVFIoKQorICogb3IgYSBwb2ludGVy
IHRvIHRoZSBuZXdseSBhbGxvY2F0ZWQgZGV2aWNlLgorICovCitpbnQgaGRtaV9kZXZfcmVnaXN0
ZXIoc3RydWN0IGhkbWlfZGV2ICpoZCwgc3RydWN0IGRldmljZSAqcGFyZW50LAorCQl2b2lkICpk
ZXZkYXRhLCBzdHJ1Y3QgaGRtaV9vcHMgKm9wcywgaW50IGZiX2luZGV4KQoreworCXN0cnVjdCBo
ZG1pX2V2ZW50ICpldnRfbGlzdDsKKwlpbnQgaTsKKwlpbnQgcmM7CisKKwloZC0+ZGV2ID0gZGV2
aWNlX2NyZWF0ZShoZG1pX2NsYXNzLCBwYXJlbnQsCisJCQlNS0RFVihIRE1JX01BSk9SLCBoZG1p
ZGV2bm8pLCBoZCwgImhkbWklZCIsIGhkbWlkZXZubyk7CisJaWYgKElTX0VSUihoZC0+ZGV2KSkg
eworCQkvKiBOb3QgZmF0YWwgKi8KKwkJaGRtaV9kcHJpbnRrKDEsICJVbmFibGUgdG8gY3JlYXRl
IGRldmljZSBmb3IgaGRtaSAlZDsgZXJybm8gPSAlbGRcbiIsCisJCQloZG1pZGV2bm8sIFBUUl9F
UlIoaGQtPmRldikpOworCQloZC0+ZGV2ID0gTlVMTDsKKwl9CisKKwlzcGluX2xvY2tfaW5pdCgm
aGQtPmxvY2spOworCW11dGV4X2luaXQoJmhkLT5oZG1pX2xvY2spOworCW11dGV4X2luaXQoJmhk
LT51cGRhdGVfbG9jayk7CisKKwlJTklUX0xJU1RfSEVBRCgmaGQtPmhkbWlfZXZ0X2xpc3QpOwor
CUlOSVRfTElTVF9IRUFEKCZoZC0+ZnJlZV9ldnRfbGlzdCk7CisJaGQtPmV2dF9wdHIgPSBldnRf
bGlzdCA9CisJCWt6YWxsb2MoTUFYX0hETUlfRVZFTlRfU0laRSAqIHNpemVvZihzdHJ1Y3QgaGRt
aV9ldmVudCksIEdGUF9LRVJORUwpOworCWZvciAoaSA9IDA7IGkgPCBNQVhfSERNSV9FVkVOVF9T
SVpFOyBpKyspIHsKKwkJbGlzdF9hZGQoJmV2dF9saXN0LT5saXN0LCAmaGQtPmZyZWVfZXZ0X2xp
c3QpOworCQlldnRfbGlzdCArKzsKKwl9CisKKwlyYyA9IGhkbWlfcmVnaXN0ZXJfbGNkKGhkKTsK
KwlpZiAocmMpIHsKKwkJZGV2aWNlX3VucmVnaXN0ZXIoaGQtPmRldik7CisJCWhkbWlfZHByaW50
aygxLCAiVW5hYmxlIHRvIGNyZWF0ZSBsY2QgZGV2aWNlIGZvciBoZG1pXG4iKTsKKwkJZ290byBk
ZXZfb3V0OworCX0KKworCWhkLT5vcHMgPSBvcHM7CisJaGQtPmZiX2luZm8gPSByZWdpc3RlcmVk
X2ZiW2ZiX2luZGV4XTsKKwlpZiAoISBoZC0+ZmJfaW5mbykgeworCQloZG1pX2RwcmludGsoMSwg
IkludmFsaWQgYXNzb2NpYXRlZCBmYlxuIik7CisJCWdvdG8gZGV2X291dDsKKwl9CisKKwkvKiBS
ZWdpc3RlciBDRUMgaW5wdXQgZGV2aWNlIGhlcmUgKi8KKwkvKiBSZWdpc3RlciBhdWRpbyBBc29j
IGRldmljZSBoZXJlICovCisJLyogSW5pdCBob3QgcGx1ZyB1ZXZlbnQgaGVyZSAqLworCS8qIElu
aXQgSERDUCBoZXJlICovCisKKwloZC0+dGhyZWFkID0ga3RocmVhZF9ydW4oaGRtaV9ldmVudF90
aHJlYWQsIGhkLAorCQkJCSAgICAgICAiaGRtaSVkIiwgaGRtaWRldm5vKyspOworCisJaWYgKElT
X0VSUihoZC0+dGhyZWFkKSkgeworCQlyYyA9IFBUUl9FUlIoaGQtPnRocmVhZCk7CisJCWhkbWlf
ZHByaW50aygxLCAiVW5hYmxlIHRvIGNyZWF0ZSBpbnRlcm5hbCB0aHJlYWQgZm9yIGhkbWlcbiIp
OworCQlnb3RvIGxjZF9vdXQ7CisJfQorCisJcmV0dXJuIDA7CisKKwlrdGhyZWFkX3N0b3AoaGQt
PnRocmVhZCk7CitsY2Rfb3V0OgorCWxjZF9kZXZpY2VfdW5yZWdpc3RlcihoZC0+bGNkKTsKK2Rl
dl9vdXQ6CisJZGV2aWNlX3VucmVnaXN0ZXIoaGQtPmRldik7CisJaGRtaV9kcHJpbnRrKDEsICJG
YWlsIHRvIHJlZ2lzdGVyIGhkbWkgZGV2XG4iKTsKKwlyZXR1cm4gcmM7Cit9CitFWFBPUlRfU1lN
Qk9MKGhkbWlfZGV2X3JlZ2lzdGVyKTsKKworLyoqCisgKiBoZG1pX2Rldl91bnJlZ2lzdGVyIC0g
dW5yZWdpc3RlcnMgYSBvYmplY3Qgb2YgaGRtaV9kZXYgY2xhc3MuCisgKiBAaGQ6IHRoZSBoZG1p
IGRldmljZSBvYmplY3QgdG8gYmUgdW5yZWdpc3RlcmVkIGFuZCBmcmVlZC4KKyAqCisgKiBVbnJl
Z2lzdGVycyBhIHByZXZpb3VzbHkgcmVnaXN0ZXJlZCB2aWEgaGRtaV9kZXZfcmVnaXN0ZXIgb2Jq
ZWN0LgorICovCit2b2lkIGhkbWlfZGV2X3VucmVnaXN0ZXIoc3RydWN0IGhkbWlfZGV2ICpoZCkK
K3sKKwlpZiAoIWhkKQorCQlyZXR1cm47CisKKwltdXRleF9sb2NrKCZoZC0+aGRtaV9sb2NrKTsK
KwloZC0+b3BzID0gTlVMTDsKKwltdXRleF91bmxvY2soJmhkLT5oZG1pX2xvY2spOworCWxjZF9k
ZXZpY2VfdW5yZWdpc3RlcihoZC0+bGNkKTsKKworCWt0aHJlYWRfc3RvcChoZC0+dGhyZWFkKTsK
KwlkZXZpY2VfdW5yZWdpc3RlcihoZC0+ZGV2KTsKK30KK0VYUE9SVF9TWU1CT0woaGRtaV9kZXZf
dW5yZWdpc3Rlcik7CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBoZG1pX2NsYXNzX2V4aXQodm9pZCkK
K3sKKwljbGFzc19kZXN0cm95KGhkbWlfY2xhc3MpOworfQorCitzdGF0aWMgaW50IF9faW5pdCBo
ZG1pX2NsYXNzX2luaXQodm9pZCkKK3sKKwloZG1pX2RwcmludGsoMSwgImNyZWF0ZSBoZG1pIGNs
YXNzLi4uXG4iKTsKKwloZG1pX2NsYXNzID0gY2xhc3NfY3JlYXRlKFRISVNfTU9EVUxFLCAiaGRt
aSIpOworCWlmIChJU19FUlIoaGRtaV9jbGFzcykpIHsKKwkJaGRtaV9kcHJpbnRrKDEsICJVbmFi
bGUgdG8gY3JlYXRlIGhkbWkgY2xhc3M7IGVycm5vID0gJWxkXG4iLAorCQkJCVBUUl9FUlIoaGRt
aV9jbGFzcykpOworCQlyZXR1cm4gUFRSX0VSUihoZG1pX2NsYXNzKTsKKwl9CisKKwloZG1pX2Ns
YXNzLT5kZXZfYXR0cnMgPSBoZG1pX2Rldl9hdHRyaWJ1dGVzOworCWhkbWlfZHByaW50aygxLCAi
Y3JlYXRlIGhkbWkgY2xhc3Mgb2tcbiIpOworCXJldHVybiAwOworfQorCitzdWJzeXNfaW5pdGNh
bGwoaGRtaV9jbGFzc19pbml0KTsKK21vZHVsZV9leGl0KGhkbWlfY2xhc3NfZXhpdCk7CisKK21v
ZHVsZV9wYXJhbV9uYW1lZChkZWJ1ZywgaGRtaV9jb3JlX2RlYnVnLCBpbnQsIDA2NDQpOworCitN
T0RVTEVfTElDRU5TRSgiR1BMIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL21vZGVkYi5j
IGIvZHJpdmVycy92aWRlby9tb2RlZGIuYwppbmRleCBjYjE3NWZlLi45M2Y1YjZlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL3ZpZGVvL21vZGVkYi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vbW9kZWRiLmMK
QEAgLTI5Miw2MiArMjkyLDYzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmJfdmlkZW9tb2RlIG1v
ZGVkYltdID0gewogfTsKIAogI2lmZGVmIENPTkZJR19GQl9NT0RFX0hFTFBFUlMKLWNvbnN0IHN0
cnVjdCBmYl92aWRlb21vZGUgY2VhX21vZGVzWzY0XSA9IHsKK2NvbnN0IHN0cnVjdCBmYl92aWRl
b21vZGUgY2VhX21vZGVzWzY1XSA9IHsKIAkvKiAjMTogNjQweDQ4MHBANTkuOTQvNjBIeiAqLwog
CVsxXSA9IHsKIAkJTlVMTCwgNjAsIDY0MCwgNDgwLCAzOTcyMiwgNDgsIDE2LCAzMywgMTAsIDk2
LCAyLCAwLAotCQlGQl9WTU9ERV9OT05JTlRFUkxBQ0VELCAwLAorCQlGQl9WTU9ERV9OT05JTlRF
UkxBQ0VELCBGQl9NT0RFX0lTX0NFQSwKIAl9LAogCS8qICMzOiA3MjB4NDgwcEA1OS45NC82MEh6
ICovCiAJWzNdID0gewogCQlOVUxMLCA2MCwgNzIwLCA0ODAsIDM3MDM3LCA2MCwgMTYsIDMwLCA5
LCA2MiwgNiwgMCwKLQkJRkJfVk1PREVfTk9OSU5URVJMQUNFRCwgMCwKKwkJRkJfVk1PREVfTk9O
SU5URVJMQUNFRCwgRkJfTU9ERV9JU19DRUEsCiAJfSwKIAkvKiAjNTogMTkyMHgxMDgwaUA1OS45
NC82MEh6ICovCiAJWzVdID0gewogCQlOVUxMLCA2MCwgMTkyMCwgMTA4MCwgMTM3NjMsIDE0OCwg
ODgsIDE1LCAyLCA0NCwgNSwKIAkJRkJfU1lOQ19IT1JfSElHSF9BQ1QgfCBGQl9TWU5DX1ZFUlRf
SElHSF9BQ1QsCi0JCUZCX1ZNT0RFX0lOVEVSTEFDRUQsIDAsCisJCUZCX1ZNT0RFX0lOVEVSTEFD
RUQsIEZCX01PREVfSVNfQ0VBLAogCX0sCiAJLyogIzc6IDcyMCgxNDQwKXg0ODBpSEA1OS45NC82
MEh6ICovCiAJWzddID0gewogCQlOVUxMLCA2MCwgMTQ0MCwgNDgwLCAxODU1NC8qMzcxMDgqLywg
MTE0LCAzOCwgMTUsIDQsIDEyNCwgMywgMCwKLQkJRkJfVk1PREVfSU5URVJMQUNFRCwgMCwKKwkJ
RkJfVk1PREVfSU5URVJMQUNFRCwgRkJfTU9ERV9JU19DRUEsCiAJfSwKIAkvKiAjOTogNzIwKDE0
NDApeDI0MHBIQDU5Ljk0LzYwSHogKi8KIAlbOV0gPSB7CiAJCU5VTEwsIDYwLCAxNDQwLCAyNDAs
IDE4NTU0LCAxMTQsIDM4LCAxNiwgNCwgMTI0LCAzLCAwLAotCQlGQl9WTU9ERV9OT05JTlRFUkxB
Q0VELCAwLAorCQlGQl9WTU9ERV9OT05JTlRFUkxBQ0VELCBGQl9NT0RFX0lTX0NFQSwKIAl9LAog
CS8qICMxODogNzIweDU3NnBIQDUwSHogKi8KIAlbMThdID0gewogCQlOVUxMLCA1MCwgNzIwLCA1
NzYsIDM3MDM3LCA2OCwgMTIsIDM5LCA1LCA2NCwgNSwgMCwKLQkJRkJfVk1PREVfTk9OSU5URVJM
QUNFRCwgMCwKKwkJRkJfVk1PREVfTk9OSU5URVJMQUNFRCwgRkJfTU9ERV9JU19DRUEsCiAJfSwK
IAkvKiAjMTk6IDEyODB4NzIwcEA1MEh6ICovCiAJWzE5XSA9IHsKIAkJTlVMTCwgNTAsIDEyODAs
IDcyMCwgMTM0NjgsIDIyMCwgNDQwLCAyMCwgNSwgNDAsIDUsCiAJCUZCX1NZTkNfSE9SX0hJR0hf
QUNUIHwgRkJfU1lOQ19WRVJUX0hJR0hfQUNULAotCQlGQl9WTU9ERV9OT05JTlRFUkxBQ0VELCAw
LAorCQlGQl9WTU9ERV9OT05JTlRFUkxBQ0VELCBGQl9NT0RFX0lTX0NFQSwKIAl9LAogCS8qICMy
MDogMTkyMHgxMDgwaUA1MEh6ICovCiAJWzIwXSA9IHsKIAkJTlVMTCwgNTAsIDE5MjAsIDEwODAs
IDEzNDgwLCAxNDgsIDUyOCwgMTUsIDUsIDUyOCwgNSwKIAkJRkJfU1lOQ19IT1JfSElHSF9BQ1Qg
fCBGQl9TWU5DX1ZFUlRfSElHSF9BQ1QsCi0JCUZCX1ZNT0RFX0lOVEVSTEFDRUQsIDAsCisJCUZC
X1ZNT0RFX0lOVEVSTEFDRUQsIEZCX01PREVfSVNfQ0VBLAogCX0sCiAJLyogIzMyOiAxOTIweDEw
ODBwQDIzLjk4LzI0SHogKi8KIAlbMzJdID0gewogCQlOVUxMLCAyNCwgMTkyMCwgMTA4MCwgMTM0
NjgsIDE0OCwgNjM4LCAzNiwgNCwgNDQsIDUsCiAJCUZCX1NZTkNfSE9SX0hJR0hfQUNUIHwgRkJf
U1lOQ19WRVJUX0hJR0hfQUNULAotCQlGQl9WTU9ERV9OT05JTlRFUkxBQ0VELCAwLAorCQlGQl9W
TU9ERV9OT05JTlRFUkxBQ0VELCBGQl9NT0RFX0lTX0NFQSwKIAl9LAogCS8qICMzNTogKDI4ODAp
eDQ4MHA0eEA1OS45NC82MEh6ICovCiAJWzM1XSA9IHsKIAkJTlVMTCwgNjAsIDI4ODAsIDQ4MCwg
OTI1MCwgMjQwLCA2NCwgMzAsIDksIDI0OCwgNiwgMCwKLQkJRkJfVk1PREVfTk9OSU5URVJMQUNF
RCwgMCwKKwkJRkJfVk1PREVfTk9OSU5URVJMQUNFRCwgRkJfTU9ERV9JU19DRUEsCiAJfSwKIH07
CitFWFBPUlRfU1lNQk9MKGNlYV9tb2Rlcyk7CiAKIGNvbnN0IHN0cnVjdCBmYl92aWRlb21vZGUg
dmVzYV9tb2Rlc1tdID0gewogCS8qIDAgNjQweDM1MC04NSBWRVNBICovCkBAIC0xMTE5LDYgKzEx
MjAsMjQgQEAgZmluaXNoZWQ6CiB9CiBFWFBPUlRfU1lNQk9MKGZiX2ZpbmRfYmVzdF9kaXNwbGF5
KTsKIAorLyoqCisgKiBmYl9maW5kX2NlYV9tb2RlX2luZGV4IC0gZmluZCBhIGNlYSB2aWRlbyBt
b2RlIGluZGV4CisgKgorICogUkVUVVJOUzoKKyAqIGNlYSBtb2RlIGluZGV4LCAwIGlmIG5vbmUg
Zm91bmQKKyAqLworY29uc3QgaW50IGZiX2ZpbmRfY2VhX21vZGVfaW5kZXgoc3RydWN0IGZiX3Zp
ZGVvbW9kZSAqbSkKK3sKKwlpbnQgaWR4OworCisJZm9yIChpZHggPSAxOyBpZHggPD0gNjQ7IGlk
eCArKykgeworCQlpZiAoZmJfbW9kZV9pc19lcXVhbCgmY2VhX21vZGVzW2lkeF0sIG0pKQorCQkJ
cmV0dXJuIGlkeDsKKwl9CisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGZiX2ZpbmRfY2Vh
X21vZGVfaW5kZXgpOworCiBFWFBPUlRfU1lNQk9MKGZiX3ZpZGVvbW9kZV90b192YXIpOwogRVhQ
T1JUX1NZTUJPTChmYl92YXJfdG9fdmlkZW9tb2RlKTsKIEVYUE9SVF9TWU1CT0woZmJfbW9kZV9p
c19lcXVhbCk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZiLmggYi9pbmNsdWRlL2xpbnV4
L2ZiLmgKaW5kZXggNmE4Mjc0OC4uMTQ2NzJmOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9m
Yi5oCisrKyBiL2luY2x1ZGUvbGludXgvZmIuaApAQCAtMTA4MiwxMCArMTA4MiwyNCBAQCBleHRl
cm4gdm9pZCBmYl9ibF9kZWZhdWx0X2N1cnZlKHN0cnVjdCBmYl9pbmZvICpmYl9pbmZvLCB1OCBv
ZmYsIHU4IG1pbiwgdTggbWF4KQogI2RlZmluZSBGQl9NT0RFX0lTX0RFVEFJTEVECTEKICNkZWZp
bmUgRkJfTU9ERV9JU19TVEFOREFSRAkyCiAjZGVmaW5lIEZCX01PREVfSVNfVkVTQQkJNAorI2Rl
ZmluZSBGQl9NT0RFX0lTX0NFQQkJNQogI2RlZmluZSBGQl9NT0RFX0lTX0NBTENVTEFURUQJOAog
I2RlZmluZSBGQl9NT0RFX0lTX0ZJUlNUCTE2CiAjZGVmaW5lIEZCX01PREVfSVNfRlJPTV9WQVIg
ICAgIDMyCiAKK3R5cGVkZWYgZW51bSB7CisJQ0VBXzY0MHg0ODBwNjAgPSAxLAorCUNFQV83MjB4
NDgwcDYwID0gMywKKwlDRUFfMTkyMHgxMDgwaTYwID0gNSwKKwlDRUFfNzIweDQ4MGk2MCA9IDcs
CisJQ0VBXzcyMHgyNDBwNjAgPSA5LAorCUNFQV83MjB4NTc2cDUwID0gMTgsCisJQ0VBXzEyODB4
NzIwcDUwID0gMTksCisJQ0VBXzE5MjB4MTA4MGk1MCA9IDIwLAorCUNFQV8xOTIweDEwODBwMjQg
PSAzMiwKKwlDRUFfMjg4MHg0ODBwNjAgPTM1LAorfSBjZWFfbW9kZV9pZDsKKwogZXh0ZXJuIGlu
dCBmYm1vbl9kcG1zKGNvbnN0IHN0cnVjdCBmYl9pbmZvICpmYl9pbmZvKTsKIGV4dGVybiBpbnQg
ZmJfZ2V0X21vZGUoaW50IGZsYWdzLCB1MzIgdmFsLCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8g
KnZhciwKIAkJICAgICAgIHN0cnVjdCBmYl9pbmZvICppbmZvKTsKQEAgLTExMjQsNiArMTEzOCw3
IEBAIGV4dGVybiB2b2lkIGZiX3ZpZGVvbW9kZV90b19tb2RlbGlzdChjb25zdCBzdHJ1Y3QgZmJf
dmlkZW9tb2RlICptb2RlZGIsIGludCBudW0sCiAJCQkJICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpo
ZWFkKTsKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICpmYl9maW5kX2Jlc3RfZGlz
cGxheShjb25zdCBzdHJ1Y3QgZmJfbW9uc3BlY3MgKnNwZWNzLAogCQkJCQkJICAgICAgIHN0cnVj
dCBsaXN0X2hlYWQgKmhlYWQpOworZXh0ZXJuIGNvbnN0IGludCBmYl9maW5kX2NlYV9tb2RlX2lu
ZGV4KHN0cnVjdCBmYl92aWRlb21vZGUgKm0pOwogCiAvKiBkcml2ZXJzL3ZpZGVvL2ZiY21hcC5j
ICovCiBleHRlcm4gaW50IGZiX2FsbG9jX2NtYXAoc3RydWN0IGZiX2NtYXAgKmNtYXAsIGludCBs
ZW4sIGludCB0cmFuc3ApOwpAQCAtMTE1NSw3ICsxMTcwLDcgQEAgc3RydWN0IGZiX3ZpZGVvbW9k
ZSB7CiAKIGV4dGVybiBjb25zdCBjaGFyICpmYl9tb2RlX29wdGlvbjsKIGV4dGVybiBjb25zdCBz
dHJ1Y3QgZmJfdmlkZW9tb2RlIHZlc2FfbW9kZXNbXTsKLWV4dGVybiBjb25zdCBzdHJ1Y3QgZmJf
dmlkZW9tb2RlIGNlYV9tb2Rlc1s2NF07CitleHRlcm4gY29uc3Qgc3RydWN0IGZiX3ZpZGVvbW9k
ZSBjZWFfbW9kZXNbNjVdOwogCiBzdHJ1Y3QgZmJfbW9kZWxpc3QgewogCXN0cnVjdCBsaXN0X2hl
YWQgbGlzdDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaGRtaS5oIGIvaW5jbHVkZS9saW51
eC9oZG1pLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZDhhM2RhOQotLS0g
L2Rldi9udWxsCisrKyBiL2luY2x1ZGUvbGludXgvaGRtaS5oCkBAIC0wLDAgKzEsMTY0IEBACisv
KgorICogSERNSSBDb250cm9sIEFic3RyYWN0aW9uCisgKgorICovCisKKyNpZm5kZWYgX0xJTlVY
X0hETUlfSAorI2RlZmluZSBfTElOVVhfSERNSV9ICisKKyNpbmNsdWRlIDxsaW51eC9kZXZpY2Uu
aD4KKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgorLy8jaW5jbHVkZSA8bGludXgvbm90aWZpZXIu
aD4KKyNpbmNsdWRlIDxsaW51eC9mYi5oPgorI2luY2x1ZGUgPGxpbnV4L2xjZC5oPgorCisvKiBO
b3RlcyBvbiBsb2NraW5nOgorICoKKyAqIGhkbWlfZGV2LT5vcHNfbG9jayBpcyBhbiBpbnRlcm5h
bCBiYWNrbGlnaHQgbG9jayBwcm90ZWN0aW5nIHRoZSBvcHMKKyAqIGZpZWxkIGFuZCBubyBjb2Rl
IG91dHNpZGUgdGhlIGNvcmUgc2hvdWxkIG5lZWQgdG8gdG91Y2ggaXQuCisgKgorICogQWNjZXNz
IHRvIHNldF9wb3dlcigpIGlzIHNlcmlhbGlzZWQgYnkgdGhlIHVwZGF0ZV9sb2NrIG11dGV4IHNp
bmNlCisgKiBtb3N0IGRyaXZlcnMgc2VlbSB0byBuZWVkIHRoaXMgYW5kIGhpc3RvcmljYWxseSBn
ZXQgaXQgd3JvbmcuCisgKgorICogTW9zdCBkcml2ZXJzIGRvbid0IG5lZWQgbG9ja2luZyBvbiB0
aGVpciBnZXRfcG93ZXIoKSBtZXRob2QuCisgKiBJZiB5b3VycyBkb2VzLCB5b3UgbmVlZCB0byBp
bXBsZW1lbnQgaXQgaW4gdGhlIGRyaXZlci4gWW91IGNhbiB1c2UgdGhlCisgKiB1cGRhdGVfbG9j
ayBtdXRleCBpZiBhcHByb3ByaWF0ZS4KKyAqCisgKiBBbnkgb3RoZXIgdXNlIG9mIHRoZSBsb2Nr
cyBiZWxvdyBpcyBwcm9iYWJseSB3cm9uZy4KKyAqLworCitzdHJ1Y3QgaGRtaV9kZXY7CitzdHJ1
Y3QgZmJfaW5mbzsKKworc3RydWN0IGhkbWlfcHJvcGVydGllcyB7CisJLyogc291cmNlIG9yIHNp
bmsgKi8KKwl1MTYgdHlwZTsKK307CisKK3N0cnVjdCBoZG1pX29wcyB7CisJaW50ICgqaW5pdCko
c3RydWN0IGhkbWlfZGV2ICopOworCWludCAoKmdldF9ocGQpKHN0cnVjdCBoZG1pX2RldiAqKTsK
KwlpbnQgKCplbmFibGUpKHN0cnVjdCBoZG1pX2RldiAqLCBpbnQpOworCS8qIEdldCB0aGUgTENE
IHBhbmVsIHBvd2VyIHN0YXR1cyAoMDogZnVsbCBvbiwgMS4uMzogY29udHJvbGxlcgorCSAgIHBv
d2VyIG9uLCBmbGF0IHBhbmVsIHBvd2VyIG9mZiwgNDogZnVsbCBvZmYpLCBzZWUgRkJfQkxBTktf
WFhYICovCisJaW50ICgqZ2V0X3Bvd2VyKShzdHJ1Y3QgaGRtaV9kZXYgKik7CisJLyogRW5hYmxl
IG9yIGRpc2FibGUgcG93ZXIgdG8gdGhlIExDRCAoMDogb247IDQ6IG9mZiwgc2VlIEZCX0JMQU5L
X1hYWCkgKi8KKwlpbnQgKCpzZXRfcG93ZXIpKHN0cnVjdCBoZG1pX2RldiAqLCBpbnQgcG93ZXIp
OworCS8qIEZvciBkZWJ1ZyAqLworCWludCAoKmdldF9yZWcpKHN0cnVjdCBoZG1pX2RldiAqKTsK
KwlpbnQgKCpzZXRfcmVnKShzdHJ1Y3QgaGRtaV9kZXYgKiwgaW50IG9mZnNldCwgaW50IHYpOwor
CS8qIEdldCB0aGUgY3VycmVudCBhdWRpb19jZmcgc2V0dGluZyAoMC1tYXhfYXVkaW9fY2ZnKSAq
LworCWludCAoKmdldF9hdWRpb19jZmcpKHN0cnVjdCBoZG1pX2RldiAqKTsKKwkvKiBTZXQgTENE
IHBhbmVsIGF1ZGlvX2NmZyAqLworICAgICAgICBpbnQgKCpzZXRfYXVkaW9fY2ZnKShzdHJ1Y3Qg
aGRtaV9kZXYgKiwgaW50IGF1ZGlvX2NmZyk7CisJaW50ICgqZ2V0X21vZGUpKHN0cnVjdCBoZG1p
X2RldiAqLCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICopOworCS8qIFNldCBMQ0QgcGFuZWwgbW9kZSAo
cmVzb2x1dGlvbnMgLi4uKSAqLworCWludCAoKnNldF9tb2RlKShzdHJ1Y3QgaGRtaV9kZXYgKiwg
Y2VhX21vZGVfaWQpOworCWludCAoKmdldF9lbmFibGUpKHN0cnVjdCBoZG1pX2RldiAqKTsKKwlp
bnQgKCpzZXRfZW5hYmxlKShzdHJ1Y3QgaGRtaV9kZXYgKiwgaW50IGVuYWJsZSk7CisJLyogQ2hl
Y2sgaWYgZ2l2ZW4gZnJhbWVidWZmZXIgZGV2aWNlIGlzIHRoZSBvbmUgTENEIGlzIGJvdW5kIHRv
OworCSAgIHJldHVybiAwIGlmIG5vdCwgIT0wIGlmIGl0IGlzLiBJZiBOVUxMLCBoZG1pIGFsd2F5
cyBtYXRjaGVzIHRoZSBmYi4gKi8KKwlpbnQgKCpjaGVja19tb2RlKShzdHJ1Y3QgaGRtaV9kZXYg
Kiwgc3RydWN0IGZiX3ZpZGVvbW9kZSAqKTsKK307CisKK2VudW0gaGRtaV9ldmVudF90eXBlIHsK
KwkvKiB0cmlnZ2VyIGdwaW8gaXJxICovCisJSERNSV9FVl9QTFVHLAorCUhETUlfRVZfVU5QTFVH
LAorCS8qIHRyaWdnZXIgaW4gZ3BpbyBpcnEgb3IgZnJvbSBmYiBjaGFuZ2UgKi8KKwlIRE1JX0VW
X1ZJREVPLAorCS8qIHRyaWdnZXIgaW4gZ3BpbyBpcnEgb3IgZnJvbSBBc29jIGNoYW5nZSAqLwor
CUhETUlfRVZfQVVESU8sCisJLyogdHJpZ2dlciBmcm9tIENFQy9UViAqLworCUhETUlfRVZfQ0VD
LAorfTsKKworc3RydWN0IGhkbWlfZXZlbnQgeworCWVudW0gaGRtaV9ldmVudF90eXBlIHR5cGU7
CisJc3RydWN0IGxpc3RfaGVhZCBsaXN0OworfTsKKworI2RlZmluZSBSQVRJT18xNlY5X1NUUiAi
MTY6OSIKKyNkZWZpbmUgUkFUSU9fNFYzX1NUUiAiNDozIgorI2RlZmluZSBSQVRJT18xNlY5ICgw
KQorI2RlZmluZSBSQVRJT180VjMgKDEpCisKK3N0cnVjdCBoZG1pX2RldiB7CisJc3RydWN0IGRl
dmljZQkJKmRldjsKKwlzdHJ1Y3QgaGRtaV9wcm9wZXJ0aWVzCXByb3BzOworCS8qIFRoaXMgcHJv
dGVjdHMgdGhlICdvcHMnIGZpZWxkLiBJZiAnb3BzJyBpcyBOVUxMLCB0aGUgZHJpdmVyIHRoYXQK
KwkgICByZWdpc3RlcmVkIHRoaXMgZGV2aWNlIGhhcyBiZWVuIHVubG9hZGVkLCBhbmQgaWYgY2xh
c3NfZ2V0X2RldmRhdGEoKQorCSAgIHBvaW50cyB0byBzb21ldGhpbmcgaW4gdGhlIGJvZHkgb2Yg
dGhhdCBkcml2ZXIsIGl0IGlzIGFsc28gaW52YWxpZC4gKi8KKwlzdHJ1Y3QgbXV0ZXgJCWhkbWlf
bG9jazsKKwkvKiBTZXJpYWxpc2UgYWNjZXNzIHRvIHNldF9wb3dlciBtZXRob2QgKi8KKwlzdHJ1
Y3QgbXV0ZXgJCXVwZGF0ZV9sb2NrOworCXNwaW5sb2NrX3QgICAgICAgICAgICAgIGxvY2s7ICAg
ICAgICAgICAvKiBsb2NrIGZvciBjbGFpbSBhbmQgYnVzIG9wcyAqLworCXN0cnVjdCBsaXN0X2hl
YWQJaGRtaV9ldnRfbGlzdDsKKwlzdHJ1Y3QgbGlzdF9oZWFkCWZyZWVfZXZ0X2xpc3Q7CisJc3Ry
dWN0IHRhc2tfc3RydWN0CSp0aHJlYWQ7CisJc3RydWN0IGhkbWlfZXZlbnQJKmV2dF9wdHI7CisJ
LyogSWYgdGhpcyBpcyBOVUxMLCB0aGUgYmFja2luZyBtb2R1bGUgaXMgdW5sb2FkZWQgKi8KKwlz
dHJ1Y3QgaGRtaV9vcHMgKm9wczsKKwkvKiBUaGUgZnJhbWVidWZmZXIgbm90aWZpZXIgYmxvY2sg
Ki8KKwkvL3N0cnVjdCBub3RpZmllcl9ibG9jayBmYl9ub3RpZjsKKwlzdHJ1Y3QgbGNkX2Rldmlj
ZQkqbGNkOworCXN0cnVjdCBmYl9pbmZvCQkqZmJfaW5mbzsKKwljZWFfbW9kZV9pZAkJbW9kZV9p
ZDsKKwkvL3UzMgkJCWRlZXBfY29sb3I7CisJdTMyCQkJZW5hYmxlOworCXUzMgkJCXBpeGVsX3Jl
cHQ7CisJdTMyCQkJcmF0aW87Cit9OworCitzdHJ1Y3QgaGRtaV9wbGF0Zm9ybV9kYXRhIHsKKwkv
KiByZXNldCBoZG1pIHBhbmVsIGRldmljZS4gKi8KKwlpbnQgKCpyZXNldCkoc3RydWN0IGhkbWlf
ZGV2ICpsZCk7CisJLyogb24gb3Igb2ZmIHRvIGhkbWkgcGFuZWwuIGlmICdlbmFibGUnIGlzIDAg
dGhlbgorCSAgIGhkbWkgcG93ZXIgb2ZmIGFuZCAxLCBoZG1pIHBvd2VyIG9uLiAqLworCWludCAo
KnBvd2VyX29uKShzdHJ1Y3QgaGRtaV9kZXYgKmxkLCBpbnQgZW5hYmxlKTsKKworCS8qIGl0IGlu
ZGljYXRlcyB3aGV0aGVyIGhkbWkgcGFuZWwgd2FzIGVuYWJsZWQKKwkgICBmcm9tIGJvb3Rsb2Fk
ZXIgb3Igbm90LiAqLworCWludCBoZG1pX2VuYWJsZWQ7CisJLyogdmlkZW8sIGF1ZGlvLCBjZWMs
IGhkY3AgKi8KKwl1bnNpZ25lZCBpbnQgZmVhdHVyZXM7CisJLyogaXQgbWVhbnMgZGVsYXkgZm9y
IHN0YWJsZSB0aW1lIHdoZW4gaXQgYmVjb21lcyBsb3cgdG8gaGlnaAorCSAgIG9yIGhpZ2ggdG8g
bG93IHRoYXQgaXMgZGVwZW5kZW50IG9uIHdoZXRoZXIgcmVzZXQgZ3BpbyBpcworCSAgIGxvdyBh
Y3RpdmUgb3IgaGlnaCBhY3RpdmUuICovCisJdW5zaWduZWQgaW50IHJlc2V0X2RlbGF5OworCS8q
IHN0YWJsZSB0aW1lIG5lZWRpbmcgdG8gYmVjb21lIGhkbWkgcG93ZXIgb24uICovCisJdW5zaWdu
ZWQgaW50IHBvd2VyX29uX2RlbGF5OworCS8qIHN0YWJsZSB0aW1lIG5lZWRpbmcgdG8gYmVjb21l
IGhkbWkgcG93ZXIgb2ZmLiAqLworCXVuc2lnbmVkIGludCBwb3dlcl9vZmZfZGVsYXk7CisKKwkv
KiBpdCBjb3VsZCBiZSB1c2VkIGZvciBhbnkgcHVycG9zZS4gKi8KKwl2b2lkICpwZGF0YTsKK307
CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBoZG1pX3NldF9wb3dlcihzdHJ1Y3QgaGRtaV9kZXYgKmxk
LCBpbnQgcG93ZXIpCit7CisJbXV0ZXhfbG9jaygmbGQtPnVwZGF0ZV9sb2NrKTsKKwlpZiAobGQt
Pm9wcyAmJiBsZC0+b3BzLT5zZXRfcG93ZXIpCisJCWxkLT5vcHMtPnNldF9wb3dlcihsZCwgcG93
ZXIpOworCW11dGV4X3VubG9jaygmbGQtPnVwZGF0ZV9sb2NrKTsKK30KKworZXh0ZXJuIGludCBo
ZG1pX2Rldl9yZWdpc3RlcihzdHJ1Y3QgaGRtaV9kZXYgKmhkbWlfZGV2LAorCXN0cnVjdCBkZXZp
Y2UgKnBhcmVudCwgdm9pZCAqZGV2ZGF0YSwgc3RydWN0IGhkbWlfb3BzICpvcHMsCisJaW50IGZi
X2luZGV4KTsKK2V4dGVybiB2b2lkIGhkbWlfZGV2X3VucmVnaXN0ZXIoc3RydWN0IGhkbWlfZGV2
ICpsZCk7CisKKyNkZWZpbmUgdG9faGRtaV9kZXYob2JqKSBjb250YWluZXJfb2Yob2JqLCBzdHJ1
Y3QgaGRtaV9kZXYsIGRldikKKworc3RhdGljIGlubGluZSB2b2lkICogaGRtaV9nZXRfZGF0YShz
dHJ1Y3QgaGRtaV9kZXYgKmxkX2RldikKK3sKKwlyZXR1cm4gZGV2X2dldF9kcnZkYXRhKGxkX2Rl
di0+ZGV2KTsKK30KKworCisjZW5kaWYKKworaW50IGhkbWlfZ2V0X2ZyZXEgKHN0cnVjdCBoZG1p
X2RldiAqaGQsIHUzMiAqbmVlZF9mcmVxKTsKK2ludCBoZG1pX3ZlbmRlcl9pbmZvX2ZyYW1lIChz
dHJ1Y3QgaGRtaV9kZXYgKmhkLCBjaGFyIGJ1ZltdKTsKK2ludCBoZG1pX2F2aV9pbmZvX2ZyYW1l
IChzdHJ1Y3QgaGRtaV9kZXYgKmhkLCBjaGFyIGJ1ZltdKTsKK3ZvaWQgaGRtaV9ldmVudF9zaWdu
YWwoc3RydWN0IGhkbWlfZGV2ICpkZXYsIGVudW0gaGRtaV9ldmVudF90eXBlIHR5cGUpOwpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9sY2QuaCBiL2luY2x1ZGUvbGludXgvbGNkLmgKaW5kZXgg
ODg3NzEyMy4uYjA5ZTBmOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9sY2QuaAorKysgYi9p
bmNsdWRlL2xpbnV4L2xjZC5oCkBAIC00OCw2ICs0OCw4IEBAIHN0cnVjdCBsY2Rfb3BzIHsKICAg
ICAgICAgaW50ICgqc2V0X2NvbnRyYXN0KShzdHJ1Y3QgbGNkX2RldmljZSAqLCBpbnQgY29udHJh
c3QpOwogCS8qIFNldCBMQ0QgcGFuZWwgbW9kZSAocmVzb2x1dGlvbnMgLi4uKSAqLwogCWludCAo
KnNldF9tb2RlKShzdHJ1Y3QgbGNkX2RldmljZSAqLCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICopOwor
CS8qIEdldCBMQ0QgcGFuZWwgbW9kZSAocmVzb2x1dGlvbnMgLi4uKSAqLworCWludCAoKmdldF9t
b2RlKShzdHJ1Y3QgbGNkX2RldmljZSAqLCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICopOwogCS8qIENo
ZWNrIGlmIGdpdmVuIGZyYW1lYnVmZmVyIGRldmljZSBpcyB0aGUgb25lIExDRCBpcyBib3VuZCB0
bzsKIAkgICByZXR1cm4gMCBpZiBub3QsICE9MCBpZiBpdCBpcy4gSWYgTlVMTCwgbGNkIGFsd2F5
cyBtYXRjaGVzIHRoZSBmYi4gKi8KIAlpbnQgKCpjaGVja19mYikoc3RydWN0IGxjZF9kZXZpY2Ug
Kiwgc3RydWN0IGZiX2luZm8gKik7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21ham9yLmgg
Yi9pbmNsdWRlL2xpbnV4L21ham9yLmgKaW5kZXggNmE4Y2E5OC4uZTZlNDZlMiAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9tYWpvci5oCisrKyBiL2luY2x1ZGUvbGludXgvbWFqb3IuaApAQCAt
MTcwLDYgKzE3MCw3IEBACiAjZGVmaW5lIElCTV9GUzMyNzBfTUFKT1IJMjI4CiAKICNkZWZpbmUg
VklPVEFQRV9NQUpPUgkJMjMwCisjZGVmaW5lIEhETUlfTUFKT1IJCTIzMSAKIAogI2RlZmluZSBC
TE9DS19FWFRfTUFKT1IJCTI1OQogI2RlZmluZSBTQ1NJX09TRF9NQUpPUgkJMjYwCS8qIG9wZW4t
b3NkJ3MgT1NEIHNjc2kgZGV2aWNlICovCg==
--f46d0444016258a5e404b12266ab--
