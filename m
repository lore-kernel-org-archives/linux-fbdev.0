From: Jun Nie <niej0001@gmail.com>
Date: Sat, 29 Sep 2012 05:29:17 +0000
Subject: [PATCH] fb: only enable console lock in fb for VGA console
Message-Id: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="e89a8ff1cb4622a14b04cad07484"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--e89a8ff1cb4622a14b04cad07484
Content-Type: text/plain; charset=ISO-8859-1

If VGA console is not enable, we do not have to
involve console lock/unlock in FB framework to avoid
hold the lock unnecessarily. Otherwise, UART console
output may be blocked by FB pan_display etc operations,
which hold the console lock. This may block the
panic log out on UART, where the lock may never be
released by FB.

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/arkfb.c                  |   11 +++++------
 drivers/video/aty/aty128fb.c           |   11 +++++------
 drivers/video/aty/atyfb_base.c         |   11 +++++------
 drivers/video/aty/radeon_pm.c          |    9 ++++-----
 drivers/video/chipsfb.c                |    8 ++++----
 drivers/video/da8xx-fb.c               |    9 ++++-----
 drivers/video/fb-puv3.c                |    9 ++++-----
 drivers/video/fbmem.c                  |   28 ++++++++++++++++++++++------
 drivers/video/fbsysfs.c                |   21 ++++++++++-----------
 drivers/video/geode/gxfb_core.c        |    9 ++++-----
 drivers/video/geode/lxfb_core.c        |    8 ++++----
 drivers/video/i740fb.c                 |   11 +++++------
 drivers/video/i810/i810_main.c         |    9 ++++-----
 drivers/video/jz4740_fb.c              |    9 ++++-----
 drivers/video/mx3fb.c                  |    9 ++++-----
 drivers/video/nvidia/nvidia.c          |    9 ++++-----
 drivers/video/ps3fb.c                  |   15 +++++++--------
 drivers/video/pxafb.c                  |    5 ++---
 drivers/video/s3fb.c                   |   15 +++++++--------
 drivers/video/savage/savagefb_driver.c |    9 ++++-----
 drivers/video/sh_mobile_lcdcfb.c       |   13 ++++++-------
 drivers/video/sm501fb.c                |    9 ++++-----
 drivers/video/tmiofb.c                 |   11 +++++------
 drivers/video/via/viafbdev.c           |    8 ++++----
 drivers/video/vt8623fb.c               |   11 +++++------
 drivers/video/xen-fbfront.c            |    5 ++---
 include/linux/fb.h                     |    2 ++
 27 files changed, 140 insertions(+), 144 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 555dd4c..774d902 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -23,7 +23,6 @@
 #include <linux/svga.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/console.h> /* Why should fb driver call console
functions? because console_lock() */
 #include <video/vga.h>

 #ifdef CONFIG_MTRR
@@ -1124,12 +1123,12 @@ static int ark_pci_suspend (struct pci_dev*
dev, pm_message_t state)

 	dev_info(info->device, "suspend\n");

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		return 0;
 	}

@@ -1140,7 +1139,7 @@ static int ark_pci_suspend (struct pci_dev* dev,
pm_message_t state)
 	pci_set_power_state(dev, pci_choose_state(dev, state));

 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -1155,7 +1154,7 @@ static int ark_pci_resume (struct pci_dev* dev)

 	dev_info(info->device, "resume\n");

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if (par->ref_count == 0)
@@ -1174,7 +1173,7 @@ static int ark_pci_resume (struct pci_dev* dev)

 fail:
 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 #else
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 747442d..1c6b80b 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -60,7 +60,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
-#include <linux/console.h>
 #include <linux/backlight.h>
 #include <asm/io.h>

@@ -1884,7 +1883,7 @@ static void aty128_early_resume(void *data)
 		return;
 	pci_restore_state(par->pdev);
 	aty128_do_resume(par->pdev);
-	console_unlock();
+	fb_console_unlock();
 }
 #endif /* CONFIG_PPC_PMAC */

@@ -2461,7 +2460,7 @@ static int aty128_pci_suspend(struct pci_dev
*pdev, pm_message_t state)

 	printk(KERN_DEBUG "aty128fb: suspending...\n");
 	
-	console_lock();
+	fb_console_lock();

 	fb_set_suspend(info, 1);

@@ -2493,7 +2492,7 @@ static int aty128_pci_suspend(struct pci_dev
*pdev, pm_message_t state)
 	if (state.event != PM_EVENT_ON)
 		aty128_set_suspend(par, 1);

-	console_unlock();
+	fb_console_unlock();

 	pdev->dev.power.power_state = state;

@@ -2550,9 +2549,9 @@ static int aty128_pci_resume(struct pci_dev *pdev)
 {
 	int rc;

-	console_lock();
+	fb_console_lock();
 	rc = aty128_do_resume(pdev);
-	console_unlock();
+	fb_console_unlock();

 	return rc;
 }
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 3f2e8c1..9bb15ab 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -58,7 +58,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <linux/console.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -2065,7 +2064,7 @@ static int atyfb_pci_suspend(struct pci_dev
*pdev, pm_message_t state)
 	if (state.event == pdev->dev.power.power_state.event)
 		return 0;

-	console_lock();
+	fb_console_lock();

 	fb_set_suspend(info, 1);

@@ -2093,14 +2092,14 @@ static int atyfb_pci_suspend(struct pci_dev
*pdev, pm_message_t state)
 		par->lock_blank = 0;
 		atyfb_blank(FB_BLANK_UNBLANK, info);
 		fb_set_suspend(info, 0);
-		console_unlock();
+		fb_console_unlock();
 		return -EIO;
 	}
 #else
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif

-	console_unlock();
+	fb_console_unlock();

 	pdev->dev.power.power_state = state;

@@ -2129,7 +2128,7 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
 	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;

-	console_lock();
+	fb_console_lock();

 	/*
 	 * PCI state will have been restored by the core, so
@@ -2157,7 +2156,7 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
 	par->lock_blank = 0;
 	atyfb_blank(FB_BLANK_UNBLANK, info);

-	console_unlock();
+	fb_console_unlock();

 	pdev->dev.power.power_state = PMSG_ON;

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 92bda58..a2f07da 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -16,7 +16,6 @@

 #include "radeonfb.h"

-#include <linux/console.h>
 #include <linux/agp_backend.h>

 #ifdef CONFIG_PPC_PMAC
@@ -2626,7 +2625,7 @@ int radeonfb_pci_suspend(struct pci_dev *pdev,
pm_message_t mesg)
 		goto done;
 	}

-	console_lock();
+	fb_console_lock();

 	fb_set_suspend(info, 1);

@@ -2690,7 +2689,7 @@ int radeonfb_pci_suspend(struct pci_dev *pdev,
pm_message_t mesg)
 	if (rinfo->pm_mode & radeon_pm_d2)
 		radeon_set_suspend(rinfo, 1);

-	console_unlock();
+	fb_console_unlock();

  done:
 	pdev->dev.power.power_state = mesg;
@@ -2718,7 +2717,7 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
 		if (!console_trylock())
 			return 0;
 	} else
-		console_lock();
+		fb_console_lock();

 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
 	       pci_name(pdev), pdev->dev.power.power_state.event);
@@ -2783,7 +2782,7 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
 	pdev->dev.power.power_state = PMSG_ON;

  bail:
-	console_unlock();
+	fb_console_unlock();

 	return rc;
 }
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index cff742a..d50fa6b 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -460,10 +460,10 @@ static int chipsfb_pci_suspend(struct pci_dev
*pdev, pm_message_t state)
 	if (!(state.event & PM_EVENT_SLEEP))
 		goto done;

-	console_lock();
+	fb_console_lock();
 	chipsfb_blank(1, p);
 	fb_set_suspend(p, 1);
-	console_unlock();
+	fb_console_unlock();
  done:
 	pdev->dev.power.power_state = state;
 	return 0;
@@ -473,10 +473,10 @@ static int chipsfb_pci_resume(struct pci_dev *pdev)
 {
         struct fb_info *p = pci_get_drvdata(pdev);

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(p, 0);
 	chipsfb_blank(0, p);
-	console_unlock();
+	fb_console_unlock();

 	pdev->dev.power.power_state = PMSG_ON;
 	return 0;
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..9a36bbc 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
-#include <linux/console.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -1406,14 +1405,14 @@ static int fb_suspend(struct platform_device
*dev, pm_message_t state)
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;

-	console_lock();
+	fb_console_lock();
 	if (par->panel_power_ctrl)
 		par->panel_power_ctrl(0);

 	fb_set_suspend(info, 1);
 	lcd_disable_raster();
 	clk_disable(par->lcdc_clk);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -1422,7 +1421,7 @@ static int fb_resume(struct platform_device *dev)
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;

-	console_lock();
+	fb_console_lock();
 	clk_enable(par->lcdc_clk);
 	lcd_enable_raster();

@@ -1430,7 +1429,7 @@ static int fb_resume(struct platform_device *dev)
 		par->panel_power_ctrl(1);

 	fb_set_suspend(info, 0);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/fb-puv3.c b/drivers/video/fb-puv3.c
index 60a787f..87c8c4e 100644
--- a/drivers/video/fb-puv3.c
+++ b/drivers/video/fb-puv3.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/console.h>

 #include <asm/sizes.h>
 #include <mach/hardware.h>
@@ -759,7 +758,7 @@ static int unifb_resume(struct platform_device *dev)
 	if (dev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;

-	console_lock();
+	fb_console_lock();

 	if (dev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		writel(unifb_regs[0], UDE_FSA);
@@ -775,7 +774,7 @@ static int unifb_resume(struct platform_device *dev)
 	}
 	dev->dev.power.power_state = PMSG_ON;

-	console_unlock();
+	fb_console_unlock();

 	return rc;
 }
@@ -804,11 +803,11 @@ static int unifb_suspend(struct platform_device
*dev, pm_message_t mesg)
 		goto done;
 	}

-	console_lock();
+	fb_console_lock();

 	/* do nothing... */

-	console_unlock();
+	fb_console_unlock();

 done:
 	dev->dev.power.power_state = mesg;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 0dff12a..c2d4627 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -85,6 +85,22 @@ EXPORT_SYMBOL(lock_fb_info);
  * Helpers
  */

+void fb_console_lock(void)
+{
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
+	console_lock();
+#endif
+}
+EXPORT_SYMBOL(fb_console_lock);
+
+void fb_console_unlock(void)
+{
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
+	console_unlock();
+#endif
+}
+EXPORT_SYMBOL(fb_console_unlock);
+
 int fb_get_color_depth(struct fb_var_screeninfo *var,
 		       struct fb_fix_screeninfo *fix)
 {
@@ -1101,11 +1117,11 @@ static long do_fb_ioctl(struct fb_info *info,
unsigned int cmd,
 			return -EFAULT;
 		if (!lock_fb_info(info))
 			return -ENODEV;
-		console_lock();
+		fb_console_lock();
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_set_var(info, &var);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
-		console_unlock();
+		fb_console_unlock();
 		unlock_fb_info(info);
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
 			ret = -EFAULT;
@@ -1137,9 +1153,9 @@ static long do_fb_ioctl(struct fb_info *info,
unsigned int cmd,
 			return -EFAULT;
 		if (!lock_fb_info(info))
 			return -ENODEV;
-		console_lock();
+		fb_console_lock();
 		ret = fb_pan_display(info, &var);
-		console_unlock();
+		fb_console_unlock();
 		unlock_fb_info(info);
 		if (ret == 0 && copy_to_user(argp, &var, sizeof(var)))
 			return -EFAULT;
@@ -1184,11 +1200,11 @@ static long do_fb_ioctl(struct fb_info *info,
unsigned int cmd,
 	case FBIOBLANK:
 		if (!lock_fb_info(info))
 			return -ENODEV;
-		console_lock();
+		fb_console_lock();
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
-		console_unlock();
+		fb_console_unlock();
 		unlock_fb_info(info);
 		break;
 	default:
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index a55e366..976d8f5 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -18,7 +18,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
-#include <linux/console.h>
 #include <linux/module.h>

 #define FB_SYSFS_FLAG_ATTR 1
@@ -92,11 +91,11 @@ static int activate(struct fb_info *fb_info,
struct fb_var_screeninfo *var)
 	int err;

 	var->activate |= FB_ACTIVATE_FORCE;
-	console_lock();
+	fb_console_lock();
 	fb_info->flags |= FBINFO_MISC_USEREVENT;
 	err = fb_set_var(fb_info, var);
 	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
-	console_unlock();
+	fb_console_unlock();
 	if (err)
 		return err;
 	return 0;
@@ -177,7 +176,7 @@ static ssize_t store_modes(struct device *device,
 	if (i * sizeof(struct fb_videomode) != count)
 		return -EINVAL;

-	console_lock();
+	fb_console_lock();
 	list_splice(&fb_info->modelist, &old_list);
 	fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
 				 &fb_info->modelist);
@@ -187,7 +186,7 @@ static ssize_t store_modes(struct device *device,
 	} else
 		fb_destroy_modelist(&old_list);

-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -303,11 +302,11 @@ static ssize_t store_blank(struct device *device,
 	char *last = NULL;
 	int err;

-	console_lock();
+	fb_console_lock();
 	fb_info->flags |= FBINFO_MISC_USEREVENT;
 	err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
 	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
-	console_unlock();
+	fb_console_unlock();
 	if (err < 0)
 		return err;
 	return count;
@@ -366,9 +365,9 @@ static ssize_t store_pan(struct device *device,
 		return -EINVAL;
 	var.yoffset = simple_strtoul(last, &last, 0);

-	console_lock();
+	fb_console_lock();
 	err = fb_pan_display(fb_info, &var);
-	console_unlock();
+	fb_console_unlock();

 	if (err < 0)
 		return err;
@@ -403,9 +402,9 @@ static ssize_t store_fbstate(struct device *device,

 	if (!lock_fb_info(fb_info))
 		return -ENODEV;
-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(fb_info, (int)state);
-	console_unlock();
+	fb_console_unlock();
 	unlock_fb_info(fb_info);

 	return count;
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index b4f19db..ba7dd0a 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -27,7 +27,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/console.h>
 #include <linux/suspend.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -344,10 +343,10 @@ static int gxfb_suspend(struct pci_dev *pdev,
pm_message_t state)
 	struct fb_info *info = pci_get_drvdata(pdev);

 	if (state.event == PM_EVENT_SUSPEND) {
-		console_lock();
+		fb_console_lock();
 		gx_powerdown(info);
 		fb_set_suspend(info, 1);
-		console_unlock();
+		fb_console_unlock();
 	}

 	/* there's no point in setting PCI states; we emulate PCI, so
@@ -361,7 +360,7 @@ static int gxfb_resume(struct pci_dev *pdev)
 	struct fb_info *info = pci_get_drvdata(pdev);
 	int ret;

-	console_lock();
+	fb_console_lock();
 	ret = gx_powerup(info);
 	if (ret) {
 		printk(KERN_ERR "gxfb:  power up failed!\n");
@@ -369,7 +368,7 @@ static int gxfb_resume(struct pci_dev *pdev)
 	}

 	fb_set_suspend(info, 0);
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 #endif
diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
index 416851c..5341bf1 100644
--- a/drivers/video/geode/lxfb_core.c
+++ b/drivers/video/geode/lxfb_core.c
@@ -465,10 +465,10 @@ static int lxfb_suspend(struct pci_dev *pdev,
pm_message_t state)
 	struct fb_info *info = pci_get_drvdata(pdev);

 	if (state.event == PM_EVENT_SUSPEND) {
-		console_lock();
+		fb_console_lock();
 		lx_powerdown(info);
 		fb_set_suspend(info, 1);
-		console_unlock();
+		fb_console_unlock();
 	}

 	/* there's no point in setting PCI states; we emulate PCI, so
@@ -482,7 +482,7 @@ static int lxfb_resume(struct pci_dev *pdev)
 	struct fb_info *info = pci_get_drvdata(pdev);
 	int ret;

-	console_lock();
+	fb_console_lock();
 	ret = lx_powerup(info);
 	if (ret) {
 		printk(KERN_ERR "lxfb:  power up failed!\n");
@@ -490,7 +490,7 @@ static int lxfb_resume(struct pci_dev *pdev)
 	}

 	fb_set_suspend(info, 0);
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 #else
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index ff3f880..b3fe538 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -24,7 +24,6 @@
 #include <linux/pci_ids.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
-#include <linux/console.h>
 #include <video/vga.h>

 #ifdef CONFIG_MTRR
@@ -1210,13 +1209,13 @@ static int i740fb_suspend(struct pci_dev *dev,
pm_message_t state)
 	if (state.event == PM_EVENT_FREEZE || state.event == PM_EVENT_PRETHAW)
 		return 0;

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	/* do nothing if framebuffer is not active */
 	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		return 0;
 	}

@@ -1227,7 +1226,7 @@ static int i740fb_suspend(struct pci_dev *dev,
pm_message_t state)
 	pci_set_power_state(dev, pci_choose_state(dev, state));

 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -1237,7 +1236,7 @@ static int i740fb_resume(struct pci_dev *dev)
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i740fb_par *par = info->par;

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if (par->ref_count == 0)
@@ -1253,7 +1252,7 @@ static int i740fb_resume(struct pci_dev *dev)

 fail:
 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 #else
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index b83f361..84fe1ed 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -40,7 +40,6 @@
 #include <linux/pci_ids.h>
 #include <linux/resource.h>
 #include <linux/unistd.h>
-#include <linux/console.h>

 #include <asm/io.h>
 #include <asm/div64.h>
@@ -1574,7 +1573,7 @@ static int i810fb_suspend(struct pci_dev *dev,
pm_message_t mesg)
 		return 0;
 	}

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(info, 1);

 	if (info->fbops->fb_sync)
@@ -1587,7 +1586,7 @@ static int i810fb_suspend(struct pci_dev *dev,
pm_message_t mesg)
 	pci_save_state(dev);
 	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, mesg));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -1605,7 +1604,7 @@ static int i810fb_resume(struct pci_dev *dev)
 		return 0;
 	}

-	console_lock();
+	fb_console_lock();
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);

@@ -1621,7 +1620,7 @@ static int i810fb_resume(struct pci_dev *dev)
 	fb_set_suspend (info, 0);
 	info->fbops->fb_blank(VESA_NO_BLANKING, info);
 fail:
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 /***********************************************************************
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index de36693..7e9301a 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>

-#include <linux/console.h>
 #include <linux/fb.h>

 #include <linux/dma-mapping.h>
@@ -778,9 +777,9 @@ static int jzfb_suspend(struct device *dev)
 {
 	struct jzfb *jzfb = dev_get_drvdata(dev);

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(jzfb->fb, 1);
-	console_unlock();
+	fb_console_unlock();

 	mutex_lock(&jzfb->lock);
 	if (jzfb->is_enabled)
@@ -800,9 +799,9 @@ static int jzfb_resume(struct device *dev)
 		jzfb_enable(jzfb);
 	mutex_unlock(&jzfb->lock);

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(jzfb->fb, 0);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index c89f8a8..da25fa1 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -23,7 +23,6 @@
 #include <linux/ioport.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/console.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>

@@ -1204,9 +1203,9 @@ static int mx3fb_suspend(struct platform_device
*pdev, pm_message_t state)
 	struct mx3fb_data *mx3fb = platform_get_drvdata(pdev);
 	struct mx3fb_info *mx3_fbi = mx3fb->fbi->par;

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(mx3fb->fbi, 1);
-	console_unlock();
+	fb_console_unlock();

 	if (mx3_fbi->blank == FB_BLANK_UNBLANK) {
 		sdc_disable_channel(mx3_fbi);
@@ -1229,9 +1228,9 @@ static int mx3fb_resume(struct platform_device *pdev)
 		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
 	}

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(mx3fb->fbi, 0);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index fe13ac5..f47eb2a 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -19,7 +19,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/console.h>
 #include <linux/backlight.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
@@ -1057,7 +1056,7 @@ static int nvidiafb_suspend(struct pci_dev *dev,
pm_message_t mesg)

 	if (mesg.event == PM_EVENT_PRETHAW)
 		mesg.event = PM_EVENT_FREEZE;
-	console_lock();
+	fb_console_lock();
 	par->pm_state = mesg.event;

 	if (mesg.event & PM_EVENT_SLEEP) {
@@ -1070,7 +1069,7 @@ static int nvidiafb_suspend(struct pci_dev *dev,
pm_message_t mesg)
 	}
 	dev->dev.power.power_state = mesg;

-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }

@@ -1079,7 +1078,7 @@ static int nvidiafb_resume(struct pci_dev *dev)
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct nvidia_par *par = info->par;

-	console_lock();
+	fb_console_lock();
 	pci_set_power_state(dev, PCI_D0);

 	if (par->pm_state != PM_EVENT_FREEZE) {
@@ -1097,7 +1096,7 @@ static int nvidiafb_resume(struct pci_dev *dev)
 	nvidiafb_blank(FB_BLANK_UNBLANK, info);

 fail:
-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }
 #else
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 213fbbc..cb2e174 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -23,7 +23,6 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/console.h>
 #include <linux/ioctl.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -515,7 +514,7 @@ static int ps3fb_release(struct fb_info *info, int user)
 			atomic_set(&ps3fb.ext_flip, 0);
 			if (console_trylock()) {
 				ps3fb_sync(info, 0);	/* single buffer */
-				console_unlock();
+				fb_console_unlock();
 			}
 		}
 	}
@@ -830,14 +829,14 @@ static int ps3fb_ioctl(struct fb_info *info,
unsigned int cmd,
 			if (vmode) {
 				var = info->var;
 				fb_videomode_to_var(&var, vmode);
-				console_lock();
+				fb_console_lock();
 				info->flags |= FBINFO_MISC_USEREVENT;
 				/* Force, in case only special bits changed */
 				var.activate |= FB_ACTIVATE_FORCE;
 				par->new_mode_id = val;
 				retval = fb_set_var(info, &var);
 				info->flags &= ~FBINFO_MISC_USEREVENT;
-				console_unlock();
+				fb_console_unlock();
 			}
 			break;
 		}
@@ -881,9 +880,9 @@ static int ps3fb_ioctl(struct fb_info *info,
unsigned int cmd,
 			break;

 		dev_dbg(info->device, "PS3FB_IOCTL_FSEL:%d\n", val);
-		console_lock();
+		fb_console_lock();
 		retval = ps3fb_sync(info, val);
-		console_unlock();
+		fb_console_unlock();
 		break;

 	default:
@@ -903,9 +902,9 @@ static int ps3fbd(void *arg)
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (ps3fb.is_kicked) {
 			ps3fb.is_kicked = 0;
-			console_lock();
+			fb_console_lock();
 			ps3fb_sync(info, 0);	/* single buffer */
-			console_unlock();
+			fb_console_unlock();
 		}
 		schedule();
 	}
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3f90255..a1af212 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -54,7 +54,6 @@
 #include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
-#include <linux/console.h>

 #include <mach/hardware.h>
 #include <asm/io.h>
@@ -733,9 +732,9 @@ static int overlayfb_open(struct fb_info *info, int user)

 	if (ofb->usage++ == 0) {
 		/* unblank the base framebuffer */
-		console_lock();
+		fb_console_lock();
 		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
-		console_unlock();
+		fb_console_unlock();
 	}

 	return 0;
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 1d00736..7759c82 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -22,7 +22,6 @@
 #include <linux/svga.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/console.h> /* Why should fb driver call console
functions? because console_lock() */
 #include <video/vga.h>

 #include <linux/i2c.h>
@@ -1445,12 +1444,12 @@ static int s3_pci_suspend(struct pci_dev* dev,
pm_message_t state)

 	dev_info(info->device, "suspend\n");

-	console_lock();
+	fb_fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		return 0;
 	}

@@ -1461,7 +1460,7 @@ static int s3_pci_suspend(struct pci_dev* dev,
pm_message_t state)
 	pci_set_power_state(dev, pci_choose_state(dev, state));

 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -1477,12 +1476,12 @@ static int s3_pci_resume(struct pci_dev* dev)

 	dev_info(info->device, "resume\n");

-	console_lock();
+	fb_fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		return 0;
 	}

@@ -1491,7 +1490,7 @@ static int s3_pci_resume(struct pci_dev* dev)
 	err = pci_enable_device(dev);
 	if (err) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		dev_err(info->device, "error %d enabling device for resume\n", err);
 		return err;
 	}
@@ -1501,7 +1500,7 @@ static int s3_pci_resume(struct pci_dev* dev)
 	fb_set_suspend(info, 0);

 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/savage/savagefb_driver.c
b/drivers/video/savage/savagefb_driver.c
index 0d0f52c..bf64221 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -51,7 +51,6 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/console.h>

 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2391,7 +2390,7 @@ static int savagefb_suspend(struct pci_dev *dev,
pm_message_t mesg)
 	if (mesg.event == PM_EVENT_FREEZE)
 		return 0;

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(info, 1);

 	if (info->fbops->fb_sync)
@@ -2403,7 +2402,7 @@ static int savagefb_suspend(struct pci_dev *dev,
pm_message_t mesg)
 	pci_save_state(dev);
 	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, mesg));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -2427,7 +2426,7 @@ static int savagefb_resume(struct pci_dev* dev)
 		return 0;
 	}

-	console_lock();
+	fb_console_lock();

 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -2441,7 +2440,7 @@ static int savagefb_resume(struct pci_dev* dev)
 	savagefb_set_par(info);
 	fb_set_suspend(info, 0);
 	savagefb_blank(FB_BLANK_UNBLANK, info);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 699487c..2bc1119 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -11,7 +11,6 @@
 #include <linux/atomic.h>
 #include <linux/backlight.h>
 #include <linux/clk.h>
-#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
@@ -575,7 +574,7 @@ static int sh_mobile_lcdc_display_notify(struct
sh_mobile_lcdc_chan *ch,
 	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
 		/* HDMI plug in */
 		if (lock_fb_info(info)) {
-			console_lock();
+			fb_console_lock();

 			ch->display.width = monspec->max_x * 10;
 			ch->display.height = monspec->max_y * 10;
@@ -594,7 +593,7 @@ static int sh_mobile_lcdc_display_notify(struct
sh_mobile_lcdc_chan *ch,
 				fb_set_suspend(info, 0);
 			}

-			console_unlock();
+			fb_console_unlock();
 			unlock_fb_info(info);
 		}
 		break;
@@ -602,9 +601,9 @@ static int sh_mobile_lcdc_display_notify(struct
sh_mobile_lcdc_chan *ch,
 	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
 		/* HDMI disconnect */
 		if (lock_fb_info(info)) {
-			console_lock();
+			fb_console_lock();
 			fb_set_suspend(info, 1);
-			console_unlock();
+			fb_console_unlock();
 			unlock_fb_info(info);
 		}
 		break;
@@ -1934,9 +1933,9 @@ static int sh_mobile_lcdc_release(struct fb_info
*info, int user)

 	/* Nothing to reconfigure, when called from fbcon */
 	if (user) {
-		console_lock();
+		fb_console_lock();
 		sh_mobile_fb_reconfig(info);
-		console_unlock();
+		fb_console_unlock();
 	}

 	mutex_unlock(&ch->open_lock);
diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 3690eff..536f922 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -28,7 +28,6 @@
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/console.h>
 #include <linux/io.h>

 #include <asm/uaccess.h>
@@ -2104,9 +2103,9 @@ static int sm501fb_suspend_fb(struct sm501fb_info *info,

 	/* tell console/fb driver we are suspending */

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(fbi, 1);
-	console_unlock();
+	fb_console_unlock();

 	/* backup copies in case chip is powered down over suspend */

@@ -2163,9 +2162,9 @@ static void sm501fb_resume_fb(struct sm501fb_info *info,
 		memcpy_toio(par->cursor.k_addr, par->store_cursor,
 			    par->cursor.size);

-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(fbi, 0);
-	console_unlock();
+	fb_console_unlock();

 	vfree(par->store_fb);
 	vfree(par->store_cursor);
diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index 8e4a446..e266b6b 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -25,8 +25,7 @@
 #include <linux/fb.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-/* Why should fb driver call console functions? because console_lock() */
-#include <linux/console.h>
+/* Why should fb driver call console functions? because fb_console_lock() */
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/uaccess.h>
@@ -938,7 +937,7 @@ static int tmiofb_suspend(struct platform_device
*dev, pm_message_t state)
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	int retval = 0;

-	console_lock();
+	fb_console_lock();

 	fb_set_suspend(info, 1);

@@ -959,7 +958,7 @@ static int tmiofb_suspend(struct platform_device
*dev, pm_message_t state)
 	if (cell->suspend)
 		retval = cell->suspend(dev);

-	console_unlock();
+	fb_fb_console_unlock();

 	return retval;
 }
@@ -970,7 +969,7 @@ static int tmiofb_resume(struct platform_device *dev)
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	int retval = 0;

-	console_lock();
+	fb_console_lock();

 	if (cell->resume) {
 		retval = cell->resume(dev);
@@ -986,7 +985,7 @@ static int tmiofb_resume(struct platform_device *dev)

 	fb_set_suspend(info, 0);
 out:
-	console_unlock();
+	fb_fb_console_unlock();
 	return retval;
 }
 #else
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index c80e770..d36b173 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1698,17 +1698,17 @@ static int parse_mode(const char *str, u32
devices, u32 *xres, u32 *yres)
 #ifdef CONFIG_PM
 static int viafb_suspend(void *unused)
 {
-	console_lock();
+	fb_console_lock();
 	fb_set_suspend(viafbinfo, 1);
 	viafb_sync(viafbinfo);
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }

 static int viafb_resume(void *unused)
 {
-	console_lock();
+	fb_console_lock();
 	if (viaparinfo->shared->vdev->engine_mmio)
 		viafb_reset_engine(viaparinfo);
 	viafb_set_par(viafbinfo);
@@ -1716,7 +1716,7 @@ static int viafb_resume(void *unused)
 		viafb_set_par(viafbinfo1);
 	fb_set_suspend(viafbinfo, 0);

-	console_unlock();
+	fb_console_unlock();
 	return 0;
 }

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 4e74d26..cb48d4d 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -23,7 +23,6 @@
 #include <linux/svga.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/console.h> /* Why should fb driver call console
functions? because console_lock() */
 #include <video/vga.h>

 #ifdef CONFIG_MTRR
@@ -845,12 +844,12 @@ static int vt8623_pci_suspend(struct pci_dev*
dev, pm_message_t state)

 	dev_info(info->device, "suspend\n");

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
 		mutex_unlock(&(par->open_lock));
-		console_unlock();
+		fb_console_unlock();
 		return 0;
 	}

@@ -861,7 +860,7 @@ static int vt8623_pci_suspend(struct pci_dev* dev,
pm_message_t state)
 	pci_set_power_state(dev, pci_choose_state(dev, state));

 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
@@ -876,7 +875,7 @@ static int vt8623_pci_resume(struct pci_dev* dev)

 	dev_info(info->device, "resume\n");

-	console_lock();
+	fb_console_lock();
 	mutex_lock(&(par->open_lock));

 	if (par->ref_count == 0)
@@ -895,7 +894,7 @@ static int vt8623_pci_resume(struct pci_dev* dev)

 fail:
 	mutex_unlock(&(par->open_lock));
-	console_unlock();
+	fb_console_unlock();

 	return 0;
 }
diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index b7f5173..770397e7 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -18,7 +18,6 @@
  * frame buffer.
  */

-#include <linux/console.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/fb.h>
@@ -495,12 +494,12 @@ xenfb_make_preferred_console(void)
 	if (console_set_on_cmdline)
 		return;

-	console_lock();
+	fb_console_lock();
 	for_each_console(c) {
 		if (!strcmp(c->name, "tty") && c->index == 0)
 			break;
 	}
-	console_unlock();
+	fb_console_unlock();
 	if (c) {
 		unregister_console(c);
 		c->flags |= CON_CONSDEV;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ac3f1c6..7ae96ad 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1021,6 +1021,8 @@ extern int fb_get_color_depth(struct
fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
+extern void fb_console_unlock(void);
+extern void fb_console_lock(void);

 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
-- 
1.7.9.5

--e89a8ff1cb4622a14b04cad07484
Content-Type: application/octet-stream; 
	name="0001-fb-only-enable-console-lock-in-fb-for-VGA-console.patch"
Content-Disposition: attachment; 
	filename="0001-fb-only-enable-console-lock-in-fb-for-VGA-console.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7o9uihj0

RnJvbSA0ZjQ2ZmQzZDk4ZWZhNTdmMzczNTc2MTg5ODZlMjM4MmE1NmM2ZjRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBTYXQs
IDI5IFNlcCAyMDEyIDEzOjA0OjE3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZmI6IG9ubHkgZW5h
YmxlIGNvbnNvbGUgbG9jayBpbiBmYiBmb3IgVkdBIGNvbnNvbGUKCklmIFZHQSBjb25zb2xlIGlz
IG5vdCBlbmFibGUsIHdlIGRvIG5vdCBoYXZlIHRvCmludm9sdmUgY29uc29sZSBsb2NrL3VubG9j
ayBpbiBGQiBmcmFtZXdvcmsgdG8gYXZvaWQKaG9sZCB0aGUgbG9jayB1bm5lY2Vzc2FyaWx5LiBP
dGhlcndpc2UsIFVBUlQgY29uc29sZQpvdXRwdXQgbWF5IGJlIGJsb2NrZWQgYnkgRkIgcGFuX2Rp
c3BsYXkgZXRjIG9wZXJhdGlvbnMsCndoaWNoIGhvbGQgdGhlIGNvbnNvbGUgbG9jay4gVGhpcyBt
YXkgYmxvY2sgdGhlCnBhbmljIGxvZyBvdXQgb24gVUFSVCwgd2hlcmUgdGhlIGxvY2sgbWF5IG5l
dmVyIGJlCnJlbGVhc2VkIGJ5IEZCLgoKU2lnbmVkLW9mZi1ieTogSnVuIE5pZSA8bmp1bkBtYXJ2
ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL3ZpZGVvL2Fya2ZiLmMgICAgICAgICAgICAgICAgICB8ICAg
MTEgKysrKystLS0tLS0KIGRyaXZlcnMvdmlkZW8vYXR5L2F0eTEyOGZiLmMgICAgICAgICAgIHwg
ICAxMSArKysrKy0tLS0tLQogZHJpdmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jICAgICAgICAg
fCAgIDExICsrKysrLS0tLS0tCiBkcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fcG0uYyAgICAgICAg
ICB8ICAgIDkgKysrKy0tLS0tCiBkcml2ZXJzL3ZpZGVvL2NoaXBzZmIuYyAgICAgICAgICAgICAg
ICB8ICAgIDggKysrKy0tLS0KIGRyaXZlcnMvdmlkZW8vZGE4eHgtZmIuYyAgICAgICAgICAgICAg
IHwgICAgOSArKysrLS0tLS0KIGRyaXZlcnMvdmlkZW8vZmItcHV2My5jICAgICAgICAgICAgICAg
IHwgICAgOSArKysrLS0tLS0KIGRyaXZlcnMvdmlkZW8vZmJtZW0uYyAgICAgICAgICAgICAgICAg
IHwgICAyOCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiBkcml2ZXJzL3ZpZGVvL2Zic3lz
ZnMuYyAgICAgICAgICAgICAgICB8ICAgMjEgKysrKysrKysrKy0tLS0tLS0tLS0tCiBkcml2ZXJz
L3ZpZGVvL2dlb2RlL2d4ZmJfY29yZS5jICAgICAgICB8ICAgIDkgKysrKy0tLS0tCiBkcml2ZXJz
L3ZpZGVvL2dlb2RlL2x4ZmJfY29yZS5jICAgICAgICB8ICAgIDggKysrKy0tLS0KIGRyaXZlcnMv
dmlkZW8vaTc0MGZiLmMgICAgICAgICAgICAgICAgIHwgICAxMSArKysrKy0tLS0tLQogZHJpdmVy
cy92aWRlby9pODEwL2k4MTBfbWFpbi5jICAgICAgICAgfCAgICA5ICsrKystLS0tLQogZHJpdmVy
cy92aWRlby9qejQ3NDBfZmIuYyAgICAgICAgICAgICAgfCAgICA5ICsrKystLS0tLQogZHJpdmVy
cy92aWRlby9teDNmYi5jICAgICAgICAgICAgICAgICAgfCAgICA5ICsrKystLS0tLQogZHJpdmVy
cy92aWRlby9udmlkaWEvbnZpZGlhLmMgICAgICAgICAgfCAgICA5ICsrKystLS0tLQogZHJpdmVy
cy92aWRlby9wczNmYi5jICAgICAgICAgICAgICAgICAgfCAgIDE1ICsrKysrKystLS0tLS0tLQog
ZHJpdmVycy92aWRlby9weGFmYi5jICAgICAgICAgICAgICAgICAgfCAgICA1ICsrLS0tCiBkcml2
ZXJzL3ZpZGVvL3MzZmIuYyAgICAgICAgICAgICAgICAgICB8ICAgMTUgKysrKysrKy0tLS0tLS0t
CiBkcml2ZXJzL3ZpZGVvL3NhdmFnZS9zYXZhZ2VmYl9kcml2ZXIuYyB8ICAgIDkgKysrKy0tLS0t
CiBkcml2ZXJzL3ZpZGVvL3NoX21vYmlsZV9sY2RjZmIuYyAgICAgICB8ICAgMTMgKysrKysrLS0t
LS0tLQogZHJpdmVycy92aWRlby9zbTUwMWZiLmMgICAgICAgICAgICAgICAgfCAgICA5ICsrKyst
LS0tLQogZHJpdmVycy92aWRlby90bWlvZmIuYyAgICAgICAgICAgICAgICAgfCAgIDExICsrKysr
LS0tLS0tCiBkcml2ZXJzL3ZpZGVvL3ZpYS92aWFmYmRldi5jICAgICAgICAgICB8ICAgIDggKysr
Ky0tLS0KIGRyaXZlcnMvdmlkZW8vdnQ4NjIzZmIuYyAgICAgICAgICAgICAgIHwgICAxMSArKysr
Ky0tLS0tLQogZHJpdmVycy92aWRlby94ZW4tZmJmcm9udC5jICAgICAgICAgICAgfCAgICA1ICsr
LS0tCiBpbmNsdWRlL2xpbnV4L2ZiLmggICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKysKIDI3
IGZpbGVzIGNoYW5nZWQsIDE0MCBpbnNlcnRpb25zKCspLCAxNDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aWRlby9hcmtmYi5jIGIvZHJpdmVycy92aWRlby9hcmtmYi5jCmlu
ZGV4IDU1NWRkNGMuLjc3NGQ5MDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vYXJrZmIuYwor
KysgYi9kcml2ZXJzL3ZpZGVvL2Fya2ZiLmMKQEAgLTIzLDcgKzIzLDYgQEAKICNpbmNsdWRlIDxs
aW51eC9zdmdhLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L3Bj
aS5oPgotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4gLyogV2h5IHNob3VsZCBmYiBkcml2ZXIg
Y2FsbCBjb25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBjb25zb2xlX2xvY2soKSAqLwogI2luY2x1
ZGUgPHZpZGVvL3ZnYS5oPgogCiAjaWZkZWYgQ09ORklHX01UUlIKQEAgLTExMjQsMTIgKzExMjMs
MTIgQEAgc3RhdGljIGludCBhcmtfcGNpX3N1c3BlbmQgKHN0cnVjdCBwY2lfZGV2KiBkZXYsIHBt
X21lc3NhZ2VfdCBzdGF0ZSkKIAogCWRldl9pbmZvKGluZm8tPmRldmljZSwgInN1c3BlbmRcbiIp
OwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJbXV0ZXhfbG9jaygm
KHBhci0+b3Blbl9sb2NrKSk7CiAKIAlpZiAoKHN0YXRlLmV2ZW50ID09IFBNX0VWRU5UX0ZSRUVa
RSkgfHwgKHBhci0+cmVmX2NvdW50ID09IDApKSB7CiAJCW11dGV4X3VubG9jaygmKHBhci0+b3Bl
bl9sb2NrKSk7Ci0JCWNvbnNvbGVfdW5sb2NrKCk7CisJCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJ
CXJldHVybiAwOwogCX0KIApAQCAtMTE0MCw3ICsxMTM5LDcgQEAgc3RhdGljIGludCBhcmtfcGNp
X3N1c3BlbmQgKHN0cnVjdCBwY2lfZGV2KiBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAlwY2lf
c2V0X3Bvd2VyX3N0YXRlKGRldiwgcGNpX2Nob29zZV9zdGF0ZShkZXYsIHN0YXRlKSk7CiAKIAlt
dXRleF91bmxvY2soJihwYXItPm9wZW5fbG9jaykpOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJf
Y29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpAQCAtMTE1NSw3ICsxMTU0LDcgQEAg
c3RhdGljIGludCBhcmtfcGNpX3Jlc3VtZSAoc3RydWN0IHBjaV9kZXYqIGRldikKIAogCWRldl9p
bmZvKGluZm8tPmRldmljZSwgInJlc3VtZVxuIik7CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9j
b25zb2xlX2xvY2soKTsKIAltdXRleF9sb2NrKCYocGFyLT5vcGVuX2xvY2spKTsKIAogCWlmIChw
YXItPnJlZl9jb3VudCA9PSAwKQpAQCAtMTE3NCw3ICsxMTczLDcgQEAgc3RhdGljIGludCBhcmtf
cGNpX3Jlc3VtZSAoc3RydWN0IHBjaV9kZXYqIGRldikKIAogZmFpbDoKIAltdXRleF91bmxvY2so
JihwYXItPm9wZW5fbG9jaykpOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxv
Y2soKTsKIAlyZXR1cm4gMDsKIH0KICNlbHNlCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2F0
eS9hdHkxMjhmYi5jIGIvZHJpdmVycy92aWRlby9hdHkvYXR5MTI4ZmIuYwppbmRleCA3NDc0NDJk
Li4xYzZiODBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2F0eS9hdHkxMjhmYi5jCisrKyBi
L2RyaXZlcnMvdmlkZW8vYXR5L2F0eTEyOGZiLmMKQEAgLTYwLDcgKzYwLDYgQEAKICNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvcGNpLmg+CiAjaW5jbHVkZSA8bGludXgv
aW9wb3J0Lmg+Ci0jaW5jbHVkZSA8bGludXgvY29uc29sZS5oPgogI2luY2x1ZGUgPGxpbnV4L2Jh
Y2tsaWdodC5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgogCkBAIC0xODg0LDcgKzE4ODMsNyBAQCBz
dGF0aWMgdm9pZCBhdHkxMjhfZWFybHlfcmVzdW1lKHZvaWQgKmRhdGEpCiAJCXJldHVybjsKIAlw
Y2lfcmVzdG9yZV9zdGF0ZShwYXItPnBkZXYpOwogCWF0eTEyOF9kb19yZXN1bWUocGFyLT5wZGV2
KTsKLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiB9CiAjZW5kaWYg
LyogQ09ORklHX1BQQ19QTUFDICovCiAKQEAgLTI0NjEsNyArMjQ2MCw3IEBAIHN0YXRpYyBpbnQg
YXR5MTI4X3BjaV9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwbV9tZXNzYWdlX3Qgc3Rh
dGUpCiAKIAlwcmludGsoS0VSTl9ERUJVRyAiYXR5MTI4ZmI6IHN1c3BlbmRpbmcuLi5cbiIpOwog
CQotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCiAJZmJfc2V0X3N1c3Bl
bmQoaW5mbywgMSk7CiAKQEAgLTI0OTMsNyArMjQ5Miw3IEBAIHN0YXRpYyBpbnQgYXR5MTI4X3Bj
aV9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCiAJaWYg
KHN0YXRlLmV2ZW50ICE9IFBNX0VWRU5UX09OKQogCQlhdHkxMjhfc2V0X3N1c3BlbmQocGFyLCAx
KTsKIAotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXBkZXYt
PmRldi5wb3dlci5wb3dlcl9zdGF0ZSA9IHN0YXRlOwogCkBAIC0yNTUwLDkgKzI1NDksOSBAQCBz
dGF0aWMgaW50IGF0eTEyOF9wY2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogewogCWlu
dCByYzsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCXJjID0gYXR5
MTI4X2RvX3Jlc3VtZShwZGV2KTsKLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5s
b2NrKCk7CiAKIAlyZXR1cm4gcmM7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2F0eS9h
dHlmYl9iYXNlLmMgYi9kcml2ZXJzL3ZpZGVvL2F0eS9hdHlmYl9iYXNlLmMKaW5kZXggM2YyZThj
MS4uOWJiMTVhYiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jCisr
KyBiL2RyaXZlcnMvdmlkZW8vYXR5L2F0eWZiX2Jhc2UuYwpAQCAtNTgsNyArNTgsNiBAQAogI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+CiAjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAjaW5jbHVkZSA8
bGludXgvZmIuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvcGNp
Lmg+CkBAIC0yMDY1LDcgKzIwNjQsNyBAQCBzdGF0aWMgaW50IGF0eWZiX3BjaV9zdXNwZW5kKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCiAJaWYgKHN0YXRlLmV2ZW50
ID09IHBkZXYtPmRldi5wb3dlci5wb3dlcl9zdGF0ZS5ldmVudCkKIAkJcmV0dXJuIDA7CiAKLQlj
b25zb2xlX2xvY2soKTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAogCWZiX3NldF9zdXNwZW5kKGlu
Zm8sIDEpOwogCkBAIC0yMDkzLDE0ICsyMDkyLDE0IEBAIHN0YXRpYyBpbnQgYXR5ZmJfcGNpX3N1
c3BlbmQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAkJcGFyLT5s
b2NrX2JsYW5rID0gMDsKIAkJYXR5ZmJfYmxhbmsoRkJfQkxBTktfVU5CTEFOSywgaW5mbyk7CiAJ
CWZiX3NldF9zdXNwZW5kKGluZm8sIDApOwotCQljb25zb2xlX3VubG9jaygpOworCQlmYl9jb25z
b2xlX3VubG9jaygpOwogCQlyZXR1cm4gLUVJTzsKIAl9CiAjZWxzZQogCXBjaV9zZXRfcG93ZXJf
c3RhdGUocGRldiwgcGNpX2Nob29zZV9zdGF0ZShwZGV2LCBzdGF0ZSkpOwogI2VuZGlmCiAKLQlj
b25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAlwZGV2LT5kZXYucG93
ZXIucG93ZXJfc3RhdGUgPSBzdGF0ZTsKIApAQCAtMjEyOSw3ICsyMTI4LDcgQEAgc3RhdGljIGlu
dCBhdHlmYl9wY2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogCWlmIChwZGV2LT5kZXYu
cG93ZXIucG93ZXJfc3RhdGUuZXZlbnQgPT0gUE1fRVZFTlRfT04pCiAJCXJldHVybiAwOwogCi0J
Y29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAKIAkvKgogCSAqIFBDSSBzdGF0
ZSB3aWxsIGhhdmUgYmVlbiByZXN0b3JlZCBieSB0aGUgY29yZSwgc28KQEAgLTIxNTcsNyArMjE1
Niw3IEBAIHN0YXRpYyBpbnQgYXR5ZmJfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikK
IAlwYXItPmxvY2tfYmxhbmsgPSAwOwogCWF0eWZiX2JsYW5rKEZCX0JMQU5LX1VOQkxBTkssIGlu
Zm8pOwogCi0JY29uc29sZV91bmxvY2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCiAJcGRl
di0+ZGV2LnBvd2VyLnBvd2VyX3N0YXRlID0gUE1TR19PTjsKIApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aWRlby9hdHkvcmFkZW9uX3BtLmMgYi9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fcG0uYwpp
bmRleCA5MmJkYTU4Li5hMmYwN2RhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRl
b25fcG0uYworKysgYi9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fcG0uYwpAQCAtMTYsNyArMTYs
NiBAQAogCiAjaW5jbHVkZSAicmFkZW9uZmIuaCIKIAotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUu
aD4KICNpbmNsdWRlIDxsaW51eC9hZ3BfYmFja2VuZC5oPgogCiAjaWZkZWYgQ09ORklHX1BQQ19Q
TUFDCkBAIC0yNjI2LDcgKzI2MjUsNyBAQCBpbnQgcmFkZW9uZmJfcGNpX3N1c3BlbmQoc3RydWN0
IHBjaV9kZXYgKnBkZXYsIHBtX21lc3NhZ2VfdCBtZXNnKQogCQlnb3RvIGRvbmU7CiAJfQogCi0J
Y29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAKIAlmYl9zZXRfc3VzcGVuZChp
bmZvLCAxKTsKIApAQCAtMjY5MCw3ICsyNjg5LDcgQEAgaW50IHJhZGVvbmZiX3BjaV9zdXNwZW5k
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwbV9tZXNzYWdlX3QgbWVzZykKIAlpZiAocmluZm8tPnBt
X21vZGUgJiByYWRlb25fcG1fZDIpCiAJCXJhZGVvbl9zZXRfc3VzcGVuZChyaW5mbywgMSk7CiAK
LQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKICBkb25lOgogCXBk
ZXYtPmRldi5wb3dlci5wb3dlcl9zdGF0ZSA9IG1lc2c7CkBAIC0yNzE4LDcgKzI3MTcsNyBAQCBp
bnQgcmFkZW9uZmJfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIAkJaWYgKCFjb25z
b2xlX3RyeWxvY2soKSkKIAkJCXJldHVybiAwOwogCX0gZWxzZQotCQljb25zb2xlX2xvY2soKTsK
KwkJZmJfY29uc29sZV9sb2NrKCk7CiAKIAlwcmludGsoS0VSTl9ERUJVRyAicmFkZW9uZmIgKCVz
KTogcmVzdW1pbmcgZnJvbSBzdGF0ZTogJWQuLi5cbiIsCiAJICAgICAgIHBjaV9uYW1lKHBkZXYp
LCBwZGV2LT5kZXYucG93ZXIucG93ZXJfc3RhdGUuZXZlbnQpOwpAQCAtMjc4Myw3ICsyNzgyLDcg
QEAgaW50IHJhZGVvbmZiX3BjaV9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJcGRldi0+
ZGV2LnBvd2VyLnBvd2VyX3N0YXRlID0gUE1TR19PTjsKIAogIGJhaWw6Ci0JY29uc29sZV91bmxv
Y2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCiAJcmV0dXJuIHJjOwogfQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aWRlby9jaGlwc2ZiLmMgYi9kcml2ZXJzL3ZpZGVvL2NoaXBzZmIuYwppbmRl
eCBjZmY3NDJhLi5kNTBmYTZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2NoaXBzZmIuYwor
KysgYi9kcml2ZXJzL3ZpZGVvL2NoaXBzZmIuYwpAQCAtNDYwLDEwICs0NjAsMTAgQEAgc3RhdGlj
IGludCBjaGlwc2ZiX3BjaV9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwbV9tZXNzYWdl
X3Qgc3RhdGUpCiAJaWYgKCEoc3RhdGUuZXZlbnQgJiBQTV9FVkVOVF9TTEVFUCkpCiAJCWdvdG8g
ZG9uZTsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWNoaXBzZmJf
YmxhbmsoMSwgcCk7CiAJZmJfc2V0X3N1c3BlbmQocCwgMSk7Ci0JY29uc29sZV91bmxvY2soKTsK
KwlmYl9jb25zb2xlX3VubG9jaygpOwogIGRvbmU6CiAJcGRldi0+ZGV2LnBvd2VyLnBvd2VyX3N0
YXRlID0gc3RhdGU7CiAJcmV0dXJuIDA7CkBAIC00NzMsMTAgKzQ3MywxMCBAQCBzdGF0aWMgaW50
IGNoaXBzZmJfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHsKICAgICAgICAgc3Ry
dWN0IGZiX2luZm8gKnAgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CiAKLQljb25zb2xlX2xvY2so
KTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAlmYl9zZXRfc3VzcGVuZChwLCAwKTsKIAljaGlwc2Zi
X2JsYW5rKDAsIHApOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2soKTsK
IAogCXBkZXYtPmRldi5wb3dlci5wb3dlcl9zdGF0ZSA9IFBNU0dfT047CiAJcmV0dXJuIDA7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2RhOHh4LWZiLmMgYi9kcml2ZXJzL3ZpZGVvL2RhOHh4
LWZiLmMKaW5kZXggN2FlOWQ1My4uOWEzNmJiYyAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9k
YTh4eC1mYi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vZGE4eHgtZmIuYwpAQCAtMjksNyArMjksNiBA
QAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgog
I2luY2x1ZGUgPGxpbnV4L2NwdWZyZXEuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAj
aW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4KQEAgLTE0MDYsMTQgKzE0MDUsMTQgQEAgc3RhdGljIGludCBm
Yl9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IHN0YXRl
KQogCXN0cnVjdCBmYl9pbmZvICppbmZvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKIAlz
dHJ1Y3QgZGE4eHhfZmJfcGFyICpwYXIgPSBpbmZvLT5wYXI7CiAKLQljb25zb2xlX2xvY2soKTsK
KwlmYl9jb25zb2xlX2xvY2soKTsKIAlpZiAocGFyLT5wYW5lbF9wb3dlcl9jdHJsKQogCQlwYXIt
PnBhbmVsX3Bvd2VyX2N0cmwoMCk7CiAKIAlmYl9zZXRfc3VzcGVuZChpbmZvLCAxKTsKIAlsY2Rf
ZGlzYWJsZV9yYXN0ZXIoKTsKIAljbGtfZGlzYWJsZShwYXItPmxjZGNfY2xrKTsKLQljb25zb2xl
X3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTE0
MjIsNyArMTQyMSw3IEBAIHN0YXRpYyBpbnQgZmJfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKmRldikKIAlzdHJ1Y3QgZmJfaW5mbyAqaW5mbyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGRl
dik7CiAJc3RydWN0IGRhOHh4X2ZiX3BhciAqcGFyID0gaW5mby0+cGFyOwogCi0JY29uc29sZV9s
b2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJY2xrX2VuYWJsZShwYXItPmxjZGNfY2xrKTsK
IAlsY2RfZW5hYmxlX3Jhc3RlcigpOwogCkBAIC0xNDMwLDcgKzE0MjksNyBAQCBzdGF0aWMgaW50
IGZiX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiAJCXBhci0+cGFuZWxfcG93
ZXJfY3RybCgxKTsKIAogCWZiX3NldF9zdXNwZW5kKGluZm8sIDApOwotCWNvbnNvbGVfdW5sb2Nr
KCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aWRlby9mYi1wdXYzLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiLXB1djMuYwppbmRleCA2
MGE3ODdmLi44N2M4YzRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiLXB1djMuYworKysg
Yi9kcml2ZXJzL3ZpZGVvL2ZiLXB1djMuYwpAQCAtMTcsNyArMTcsNiBAQAogI2luY2x1ZGUgPGxp
bnV4L2Nsay5oPgogI2luY2x1ZGUgPGxpbnV4L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
PgotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4KIAogI2luY2x1ZGUgPGFzbS9zaXplcy5oPgog
I2luY2x1ZGUgPG1hY2gvaGFyZHdhcmUuaD4KQEAgLTc1OSw3ICs3NTgsNyBAQCBzdGF0aWMgaW50
IHVuaWZiX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiAJaWYgKGRldi0+ZGV2
LnBvd2VyLnBvd2VyX3N0YXRlLmV2ZW50ID09IFBNX0VWRU5UX09OKQogCQlyZXR1cm4gMDsKIAot
CWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCiAJaWYgKGRldi0+ZGV2LnBv
d2VyLnBvd2VyX3N0YXRlLmV2ZW50ID09IFBNX0VWRU5UX1NVU1BFTkQpIHsKIAkJd3JpdGVsKHVu
aWZiX3JlZ3NbMF0sIFVERV9GU0EpOwpAQCAtNzc1LDcgKzc3NCw3IEBAIHN0YXRpYyBpbnQgdW5p
ZmJfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKIAl9CiAJZGV2LT5kZXYucG93
ZXIucG93ZXJfc3RhdGUgPSBQTVNHX09OOwogCi0JY29uc29sZV91bmxvY2soKTsKKwlmYl9jb25z
b2xlX3VubG9jaygpOwogCiAJcmV0dXJuIHJjOwogfQpAQCAtODA0LDExICs4MDMsMTEgQEAgc3Rh
dGljIGludCB1bmlmYl9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwgcG1fbWVz
c2FnZV90IG1lc2cpCiAJCWdvdG8gZG9uZTsKIAl9CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9j
b25zb2xlX2xvY2soKTsKIAogCS8qIGRvIG5vdGhpbmcuLi4gKi8KIAotCWNvbnNvbGVfdW5sb2Nr
KCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogZG9uZToKIAlkZXYtPmRldi5wb3dlci5wb3dl
cl9zdGF0ZSA9IG1lc2c7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZibWVtLmMgYi9kcml2
ZXJzL3ZpZGVvL2ZibWVtLmMKaW5kZXggMGRmZjEyYS4uYzJkNDYyNyAxMDA2NDQKLS0tIGEvZHJp
dmVycy92aWRlby9mYm1lbS5jCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJtZW0uYwpAQCAtODUsNiAr
ODUsMjIgQEAgRVhQT1JUX1NZTUJPTChsb2NrX2ZiX2luZm8pOwogICogSGVscGVycwogICovCiAK
K3ZvaWQgZmJfY29uc29sZV9sb2NrKHZvaWQpCit7CisjaWZkZWYgQ09ORklHX0ZSQU1FQlVGRkVS
X0NPTlNPTEUKKwljb25zb2xlX2xvY2soKTsKKyNlbmRpZgorfQorRVhQT1JUX1NZTUJPTChmYl9j
b25zb2xlX2xvY2spOworCit2b2lkIGZiX2NvbnNvbGVfdW5sb2NrKHZvaWQpCit7CisjaWZkZWYg
Q09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEUKKwljb25zb2xlX3VubG9jaygpOworI2VuZGlmCit9
CitFWFBPUlRfU1lNQk9MKGZiX2NvbnNvbGVfdW5sb2NrKTsKKwogaW50IGZiX2dldF9jb2xvcl9k
ZXB0aChzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwKIAkJICAgICAgIHN0cnVjdCBmYl9m
aXhfc2NyZWVuaW5mbyAqZml4KQogewpAQCAtMTEwMSwxMSArMTExNywxMSBAQCBzdGF0aWMgbG9u
ZyBkb19mYl9pb2N0bChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgdW5zaWduZWQgaW50IGNtZCwKIAkJ
CXJldHVybiAtRUZBVUxUOwogCQlpZiAoIWxvY2tfZmJfaW5mbyhpbmZvKSkKIAkJCXJldHVybiAt
RU5PREVWOwotCQljb25zb2xlX2xvY2soKTsKKwkJZmJfY29uc29sZV9sb2NrKCk7CiAJCWluZm8t
PmZsYWdzIHw9IEZCSU5GT19NSVNDX1VTRVJFVkVOVDsKIAkJcmV0ID0gZmJfc2V0X3ZhcihpbmZv
LCAmdmFyKTsKIAkJaW5mby0+ZmxhZ3MgJj0gfkZCSU5GT19NSVNDX1VTRVJFVkVOVDsKLQkJY29u
c29sZV91bmxvY2soKTsKKwkJZmJfY29uc29sZV91bmxvY2soKTsKIAkJdW5sb2NrX2ZiX2luZm8o
aW5mbyk7CiAJCWlmICghcmV0ICYmIGNvcHlfdG9fdXNlcihhcmdwLCAmdmFyLCBzaXplb2YodmFy
KSkpCiAJCQlyZXQgPSAtRUZBVUxUOwpAQCAtMTEzNyw5ICsxMTUzLDkgQEAgc3RhdGljIGxvbmcg
ZG9fZmJfaW9jdGwoc3RydWN0IGZiX2luZm8gKmluZm8sIHVuc2lnbmVkIGludCBjbWQsCiAJCQly
ZXR1cm4gLUVGQVVMVDsKIAkJaWYgKCFsb2NrX2ZiX2luZm8oaW5mbykpCiAJCQlyZXR1cm4gLUVO
T0RFVjsKLQkJY29uc29sZV9sb2NrKCk7CisJCWZiX2NvbnNvbGVfbG9jaygpOwogCQlyZXQgPSBm
Yl9wYW5fZGlzcGxheShpbmZvLCAmdmFyKTsKLQkJY29uc29sZV91bmxvY2soKTsKKwkJZmJfY29u
c29sZV91bmxvY2soKTsKIAkJdW5sb2NrX2ZiX2luZm8oaW5mbyk7CiAJCWlmIChyZXQgPT0gMCAm
JiBjb3B5X3RvX3VzZXIoYXJncCwgJnZhciwgc2l6ZW9mKHZhcikpKQogCQkJcmV0dXJuIC1FRkFV
TFQ7CkBAIC0xMTg0LDExICsxMjAwLDExIEBAIHN0YXRpYyBsb25nIGRvX2ZiX2lvY3RsKHN0cnVj
dCBmYl9pbmZvICppbmZvLCB1bnNpZ25lZCBpbnQgY21kLAogCWNhc2UgRkJJT0JMQU5LOgogCQlp
ZiAoIWxvY2tfZmJfaW5mbyhpbmZvKSkKIAkJCXJldHVybiAtRU5PREVWOwotCQljb25zb2xlX2xv
Y2soKTsKKwkJZmJfY29uc29sZV9sb2NrKCk7CiAJCWluZm8tPmZsYWdzIHw9IEZCSU5GT19NSVND
X1VTRVJFVkVOVDsKIAkJcmV0ID0gZmJfYmxhbmsoaW5mbywgYXJnKTsKIAkJaW5mby0+ZmxhZ3Mg
Jj0gfkZCSU5GT19NSVNDX1VTRVJFVkVOVDsKLQkJY29uc29sZV91bmxvY2soKTsKKwkJZmJfY29u
c29sZV91bmxvY2soKTsKIAkJdW5sb2NrX2ZiX2luZm8oaW5mbyk7CiAJCWJyZWFrOwogCWRlZmF1
bHQ6CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2Zic3lzZnMuYyBiL2RyaXZlcnMvdmlkZW8v
ZmJzeXNmcy5jCmluZGV4IGE1NWUzNjYuLjk3NmQ4ZjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlk
ZW8vZmJzeXNmcy5jCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJzeXNmcy5jCkBAIC0xOCw3ICsxOCw2
IEBACiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgog
I2luY2x1ZGUgPGxpbnV4L2ZiLmg+Ci0jaW5jbHVkZSA8bGludXgvY29uc29sZS5oPgogI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPgogCiAjZGVmaW5lIEZCX1NZU0ZTX0ZMQUdfQVRUUiAxCkBAIC05
MiwxMSArOTEsMTEgQEAgc3RhdGljIGludCBhY3RpdmF0ZShzdHJ1Y3QgZmJfaW5mbyAqZmJfaW5m
bywgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIpCiAJaW50IGVycjsKIAogCXZhci0+YWN0
aXZhdGUgfD0gRkJfQUNUSVZBVEVfRk9SQ0U7Ci0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29s
ZV9sb2NrKCk7CiAJZmJfaW5mby0+ZmxhZ3MgfD0gRkJJTkZPX01JU0NfVVNFUkVWRU5UOwogCWVy
ciA9IGZiX3NldF92YXIoZmJfaW5mbywgdmFyKTsKIAlmYl9pbmZvLT5mbGFncyAmPSB+RkJJTkZP
X01JU0NfVVNFUkVWRU5UOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2so
KTsKIAlpZiAoZXJyKQogCQlyZXR1cm4gZXJyOwogCXJldHVybiAwOwpAQCAtMTc3LDcgKzE3Niw3
IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX21vZGVzKHN0cnVjdCBkZXZpY2UgKmRldmljZSwKIAlp
ZiAoaSAqIHNpemVvZihzdHJ1Y3QgZmJfdmlkZW9tb2RlKSAhPSBjb3VudCkKIAkJcmV0dXJuIC1F
SU5WQUw7CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAlsaXN0X3Nw
bGljZSgmZmJfaW5mby0+bW9kZWxpc3QsICZvbGRfbGlzdCk7CiAJZmJfdmlkZW9tb2RlX3RvX21v
ZGVsaXN0KChjb25zdCBzdHJ1Y3QgZmJfdmlkZW9tb2RlICopYnVmLCBpLAogCQkJCSAmZmJfaW5m
by0+bW9kZWxpc3QpOwpAQCAtMTg3LDcgKzE4Niw3IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX21v
ZGVzKHN0cnVjdCBkZXZpY2UgKmRldmljZSwKIAl9IGVsc2UKIAkJZmJfZGVzdHJveV9tb2RlbGlz
dCgmb2xkX2xpc3QpOwogCi0JY29uc29sZV91bmxvY2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygp
OwogCiAJcmV0dXJuIDA7CiB9CkBAIC0zMDMsMTEgKzMwMiwxMSBAQCBzdGF0aWMgc3NpemVfdCBz
dG9yZV9ibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXZpY2UsCiAJY2hhciAqbGFzdCA9IE5VTEw7CiAJ
aW50IGVycjsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZiX2lu
Zm8tPmZsYWdzIHw9IEZCSU5GT19NSVNDX1VTRVJFVkVOVDsKIAllcnIgPSBmYl9ibGFuayhmYl9p
bmZvLCBzaW1wbGVfc3RydG91bChidWYsICZsYXN0LCAwKSk7CiAJZmJfaW5mby0+ZmxhZ3MgJj0g
fkZCSU5GT19NSVNDX1VTRVJFVkVOVDsKLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVf
dW5sb2NrKCk7CiAJaWYgKGVyciA8IDApCiAJCXJldHVybiBlcnI7CiAJcmV0dXJuIGNvdW50OwpA
QCAtMzY2LDkgKzM2NSw5IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX3BhbihzdHJ1Y3QgZGV2aWNl
ICpkZXZpY2UsCiAJCXJldHVybiAtRUlOVkFMOwogCXZhci55b2Zmc2V0ID0gc2ltcGxlX3N0cnRv
dWwobGFzdCwgJmxhc3QsIDApOwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2Nr
KCk7CiAJZXJyID0gZmJfcGFuX2Rpc3BsYXkoZmJfaW5mbywgJnZhcik7Ci0JY29uc29sZV91bmxv
Y2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCiAJaWYgKGVyciA8IDApCiAJCXJldHVybiBl
cnI7CkBAIC00MDMsOSArNDAyLDkgQEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfZmJzdGF0ZShzdHJ1
Y3QgZGV2aWNlICpkZXZpY2UsCiAKIAlpZiAoIWxvY2tfZmJfaW5mbyhmYl9pbmZvKSkKIAkJcmV0
dXJuIC1FTk9ERVY7Ci0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJZmJf
c2V0X3N1c3BlbmQoZmJfaW5mbywgKGludClzdGF0ZSk7Ci0JY29uc29sZV91bmxvY2soKTsKKwlm
Yl9jb25zb2xlX3VubG9jaygpOwogCXVubG9ja19mYl9pbmZvKGZiX2luZm8pOwogCiAJcmV0dXJu
IGNvdW50OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9nZW9kZS9neGZiX2NvcmUuYyBiL2Ry
aXZlcnMvdmlkZW8vZ2VvZGUvZ3hmYl9jb3JlLmMKaW5kZXggYjRmMTlkYi4uYmE3ZGQwYSAxMDA2
NDQKLS0tIGEvZHJpdmVycy92aWRlby9nZW9kZS9neGZiX2NvcmUuYworKysgYi9kcml2ZXJzL3Zp
ZGVvL2dlb2RlL2d4ZmJfY29yZS5jCkBAIC0yNyw3ICsyNyw2IEBACiAjaW5jbHVkZSA8bGludXgv
bW0uaD4KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L2ZiLmg+Ci0j
aW5jbHVkZSA8bGludXgvY29uc29sZS5oPgogI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4KICNp
bmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvcGNpLmg+CkBAIC0zNDQsMTAg
KzM0MywxMCBAQCBzdGF0aWMgaW50IGd4ZmJfc3VzcGVuZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
cG1fbWVzc2FnZV90IHN0YXRlKQogCXN0cnVjdCBmYl9pbmZvICppbmZvID0gcGNpX2dldF9kcnZk
YXRhKHBkZXYpOwogCiAJaWYgKHN0YXRlLmV2ZW50ID09IFBNX0VWRU5UX1NVU1BFTkQpIHsKLQkJ
Y29uc29sZV9sb2NrKCk7CisJCWZiX2NvbnNvbGVfbG9jaygpOwogCQlneF9wb3dlcmRvd24oaW5m
byk7CiAJCWZiX3NldF9zdXNwZW5kKGluZm8sIDEpOwotCQljb25zb2xlX3VubG9jaygpOworCQlm
Yl9jb25zb2xlX3VubG9jaygpOwogCX0KIAogCS8qIHRoZXJlJ3Mgbm8gcG9pbnQgaW4gc2V0dGlu
ZyBQQ0kgc3RhdGVzOyB3ZSBlbXVsYXRlIFBDSSwgc28KQEAgLTM2MSw3ICszNjAsNyBAQCBzdGF0
aWMgaW50IGd4ZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogCXN0cnVjdCBmYl9pbmZv
ICppbmZvID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwogCWludCByZXQ7CiAKLQljb25zb2xlX2xv
Y2soKTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAlyZXQgPSBneF9wb3dlcnVwKGluZm8pOwogCWlm
IChyZXQpIHsKIAkJcHJpbnRrKEtFUk5fRVJSICJneGZiOiAgcG93ZXIgdXAgZmFpbGVkIVxuIik7
CkBAIC0zNjksNyArMzY4LDcgQEAgc3RhdGljIGludCBneGZiX3Jlc3VtZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKIAl9CiAKIAlmYl9zZXRfc3VzcGVuZChpbmZvLCAwKTsKLQljb25zb2xlX3VubG9j
aygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJcmV0dXJuIDA7CiB9CiAjZW5kaWYKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlkZW8vZ2VvZGUvbHhmYl9jb3JlLmMgYi9kcml2ZXJzL3ZpZGVvL2dl
b2RlL2x4ZmJfY29yZS5jCmluZGV4IDQxNjg1MWMuLjUzNDFiZjEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdmlkZW8vZ2VvZGUvbHhmYl9jb3JlLmMKKysrIGIvZHJpdmVycy92aWRlby9nZW9kZS9seGZi
X2NvcmUuYwpAQCAtNDY1LDEwICs0NjUsMTAgQEAgc3RhdGljIGludCBseGZiX3N1c3BlbmQoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAlzdHJ1Y3QgZmJfaW5mbyAq
aW5mbyA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAogCWlmIChzdGF0ZS5ldmVudCA9PSBQTV9F
VkVOVF9TVVNQRU5EKSB7Ci0JCWNvbnNvbGVfbG9jaygpOworCQlmYl9jb25zb2xlX2xvY2soKTsK
IAkJbHhfcG93ZXJkb3duKGluZm8pOwogCQlmYl9zZXRfc3VzcGVuZChpbmZvLCAxKTsKLQkJY29u
c29sZV91bmxvY2soKTsKKwkJZmJfY29uc29sZV91bmxvY2soKTsKIAl9CiAKIAkvKiB0aGVyZSdz
IG5vIHBvaW50IGluIHNldHRpbmcgUENJIHN0YXRlczsgd2UgZW11bGF0ZSBQQ0ksIHNvCkBAIC00
ODIsNyArNDgyLDcgQEAgc3RhdGljIGludCBseGZiX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRl
dikKIAlzdHJ1Y3QgZmJfaW5mbyAqaW5mbyA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAlpbnQg
cmV0OwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJcmV0ID0gbHhf
cG93ZXJ1cChpbmZvKTsKIAlpZiAocmV0KSB7CiAJCXByaW50ayhLRVJOX0VSUiAibHhmYjogIHBv
d2VyIHVwIGZhaWxlZCFcbiIpOwpAQCAtNDkwLDcgKzQ5MCw3IEBAIHN0YXRpYyBpbnQgbHhmYl9y
ZXN1bWUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJfQogCiAJZmJfc2V0X3N1c3BlbmQoaW5mbywg
MCk7Ci0JY29uc29sZV91bmxvY2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCXJldHVybiAw
OwogfQogI2Vsc2UKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vaTc0MGZiLmMgYi9kcml2ZXJz
L3ZpZGVvL2k3NDBmYi5jCmluZGV4IGZmM2Y4ODAuLmIzZmU1MzggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdmlkZW8vaTc0MGZiLmMKKysrIGIvZHJpdmVycy92aWRlby9pNzQwZmIuYwpAQCAtMjQsNyAr
MjQsNiBAQAogI2luY2x1ZGUgPGxpbnV4L3BjaV9pZHMuaD4KICNpbmNsdWRlIDxsaW51eC9pMmMu
aD4KICNpbmNsdWRlIDxsaW51eC9pMmMtYWxnby1iaXQuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25z
b2xlLmg+CiAjaW5jbHVkZSA8dmlkZW8vdmdhLmg+CiAKICNpZmRlZiBDT05GSUdfTVRSUgpAQCAt
MTIxMCwxMyArMTIwOSwxMyBAQCBzdGF0aWMgaW50IGk3NDBmYl9zdXNwZW5kKHN0cnVjdCBwY2lf
ZGV2ICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAlpZiAoc3RhdGUuZXZlbnQgPT0gUE1fRVZF
TlRfRlJFRVpFIHx8IHN0YXRlLmV2ZW50ID09IFBNX0VWRU5UX1BSRVRIQVcpCiAJCXJldHVybiAw
OwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJbXV0ZXhfbG9jaygm
KHBhci0+b3Blbl9sb2NrKSk7CiAKIAkvKiBkbyBub3RoaW5nIGlmIGZyYW1lYnVmZmVyIGlzIG5v
dCBhY3RpdmUgKi8KIAlpZiAocGFyLT5yZWZfY291bnQgPT0gMCkgewogCQltdXRleF91bmxvY2so
JihwYXItPm9wZW5fbG9jaykpOwotCQljb25zb2xlX3VubG9jaygpOworCQlmYl9jb25zb2xlX3Vu
bG9jaygpOwogCQlyZXR1cm4gMDsKIAl9CiAKQEAgLTEyMjcsNyArMTIyNiw3IEBAIHN0YXRpYyBp
bnQgaTc0MGZiX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKmRldiwgcG1fbWVzc2FnZV90IHN0YXRl
KQogCXBjaV9zZXRfcG93ZXJfc3RhdGUoZGV2LCBwY2lfY2hvb3NlX3N0YXRlKGRldiwgc3RhdGUp
KTsKIAogCW11dGV4X3VubG9jaygmKHBhci0+b3Blbl9sb2NrKSk7Ci0JY29uc29sZV91bmxvY2so
KTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCiAJcmV0dXJuIDA7CiB9CkBAIC0xMjM3LDcgKzEy
MzYsNyBAQCBzdGF0aWMgaW50IGk3NDBmYl9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKmRldikKIAlz
dHJ1Y3QgZmJfaW5mbyAqaW5mbyA9IHBjaV9nZXRfZHJ2ZGF0YShkZXYpOwogCXN0cnVjdCBpNzQw
ZmJfcGFyICpwYXIgPSBpbmZvLT5wYXI7CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9jb25zb2xl
X2xvY2soKTsKIAltdXRleF9sb2NrKCYocGFyLT5vcGVuX2xvY2spKTsKIAogCWlmIChwYXItPnJl
Zl9jb3VudCA9PSAwKQpAQCAtMTI1Myw3ICsxMjUyLDcgQEAgc3RhdGljIGludCBpNzQwZmJfcmVz
dW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAKIGZhaWw6CiAJbXV0ZXhfdW5sb2NrKCYocGFyLT5v
cGVuX2xvY2spKTsKLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJ
cmV0dXJuIDA7CiB9CiAjZWxzZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9pODEwL2k4MTBf
bWFpbi5jIGIvZHJpdmVycy92aWRlby9pODEwL2k4MTBfbWFpbi5jCmluZGV4IGI4M2YzNjEuLjg0
ZmUxZWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vaTgxMC9pODEwX21haW4uYworKysgYi9k
cml2ZXJzL3ZpZGVvL2k4MTAvaTgxMF9tYWluLmMKQEAgLTQwLDcgKzQwLDYgQEAKICNpbmNsdWRl
IDxsaW51eC9wY2lfaWRzLmg+CiAjaW5jbHVkZSA8bGludXgvcmVzb3VyY2UuaD4KICNpbmNsdWRl
IDxsaW51eC91bmlzdGQuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAKICNpbmNsdWRl
IDxhc20vaW8uaD4KICNpbmNsdWRlIDxhc20vZGl2NjQuaD4KQEAgLTE1NzQsNyArMTU3Myw3IEBA
IHN0YXRpYyBpbnQgaTgxMGZiX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKmRldiwgcG1fbWVzc2Fn
ZV90IG1lc2cpCiAJCXJldHVybiAwOwogCX0KIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNv
bGVfbG9jaygpOwogCWZiX3NldF9zdXNwZW5kKGluZm8sIDEpOwogCiAJaWYgKGluZm8tPmZib3Bz
LT5mYl9zeW5jKQpAQCAtMTU4Nyw3ICsxNTg2LDcgQEAgc3RhdGljIGludCBpODEwZmJfc3VzcGVu
ZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwbV9tZXNzYWdlX3QgbWVzZykKIAlwY2lfc2F2ZV9zdGF0
ZShkZXYpOwogCXBjaV9kaXNhYmxlX2RldmljZShkZXYpOwogCXBjaV9zZXRfcG93ZXJfc3RhdGUo
ZGV2LCBwY2lfY2hvb3NlX3N0YXRlKGRldiwgbWVzZykpOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJ
ZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpAQCAtMTYwNSw3ICsxNjA0LDcg
QEAgc3RhdGljIGludCBpODEwZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJCXJldHVy
biAwOwogCX0KIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCXBjaV9z
ZXRfcG93ZXJfc3RhdGUoZGV2LCBQQ0lfRDApOwogCXBjaV9yZXN0b3JlX3N0YXRlKGRldik7CiAK
QEAgLTE2MjEsNyArMTYyMCw3IEBAIHN0YXRpYyBpbnQgaTgxMGZiX3Jlc3VtZShzdHJ1Y3QgcGNp
X2RldiAqZGV2KQogCWZiX3NldF9zdXNwZW5kIChpbmZvLCAwKTsKIAlpbmZvLT5mYm9wcy0+ZmJf
YmxhbmsoVkVTQV9OT19CTEFOS0lORywgaW5mbyk7CiBmYWlsOgotCWNvbnNvbGVfdW5sb2NrKCk7
CisJZmJfY29uc29sZV91bmxvY2soKTsKIAlyZXR1cm4gMDsKIH0KIC8qKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9qejQ3NDBfZmIuYyBiL2RyaXZlcnMvdmlkZW8vano0
NzQwX2ZiLmMKaW5kZXggZGUzNjY5My4uN2U5MzAxYSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRl
by9qejQ3NDBfZmIuYworKysgYi9kcml2ZXJzL3ZpZGVvL2p6NDc0MF9mYi5jCkBAIC0yMSw3ICsy
MSw2IEBACiAjaW5jbHVkZSA8bGludXgvY2xrLmg+CiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4K
IAotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4KICNpbmNsdWRlIDxsaW51eC9mYi5oPgogCiAj
aW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KQEAgLTc3OCw5ICs3NzcsOSBAQCBzdGF0aWMg
aW50IGp6ZmJfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7CiAJc3RydWN0IGp6ZmIgKmp6
ZmIgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNv
bGVfbG9jaygpOwogCWZiX3NldF9zdXNwZW5kKGp6ZmItPmZiLCAxKTsKLQljb25zb2xlX3VubG9j
aygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAltdXRleF9sb2NrKCZqemZiLT5sb2NrKTsK
IAlpZiAoanpmYi0+aXNfZW5hYmxlZCkKQEAgLTgwMCw5ICs3OTksOSBAQCBzdGF0aWMgaW50IGp6
ZmJfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIAkJanpmYl9lbmFibGUoanpmYik7CiAJbXV0
ZXhfdW5sb2NrKCZqemZiLT5sb2NrKTsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVf
bG9jaygpOwogCWZiX3NldF9zdXNwZW5kKGp6ZmItPmZiLCAwKTsKLQljb25zb2xlX3VubG9jaygp
OworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlkZW8vbXgzZmIuYyBiL2RyaXZlcnMvdmlkZW8vbXgzZmIuYwppbmRleCBjODlmOGE4
Li5kYTI1ZmExIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL214M2ZiLmMKKysrIGIvZHJpdmVy
cy92aWRlby9teDNmYi5jCkBAIC0yMyw3ICsyMyw2IEBACiAjaW5jbHVkZSA8bGludXgvaW9wb3J0
Lmg+CiAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KICNpbmNsdWRlIDxsaW51eC9kbWFl
bmdpbmUuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAjaW5jbHVkZSA8bGludXgvY2xr
Lmg+CiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KIApAQCAtMTIwNCw5ICsxMjAzLDkgQEAgc3Rh
dGljIGludCBteDNmYl9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHBtX21l
c3NhZ2VfdCBzdGF0ZSkKIAlzdHJ1Y3QgbXgzZmJfZGF0YSAqbXgzZmIgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsKIAlzdHJ1Y3QgbXgzZmJfaW5mbyAqbXgzX2ZiaSA9IG14M2ZiLT5mYmkt
PnBhcjsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZiX3NldF9z
dXNwZW5kKG14M2ZiLT5mYmksIDEpOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91
bmxvY2soKTsKIAogCWlmIChteDNfZmJpLT5ibGFuayA9PSBGQl9CTEFOS19VTkJMQU5LKSB7CiAJ
CXNkY19kaXNhYmxlX2NoYW5uZWwobXgzX2ZiaSk7CkBAIC0xMjI5LDkgKzEyMjgsOSBAQCBzdGF0
aWMgaW50IG14M2ZiX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlzZGNf
c2V0X2JyaWdodG5lc3MobXgzZmIsIG14M2ZiLT5iYWNrbGlnaHRfbGV2ZWwpOwogCX0KIAotCWNv
bnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZiX3NldF9zdXNwZW5kKG14M2Zi
LT5mYmksIDApOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAog
CXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9udmlkaWEvbnZpZGlhLmMg
Yi9kcml2ZXJzL3ZpZGVvL252aWRpYS9udmlkaWEuYwppbmRleCBmZTEzYWM1Li5mNDdlYjJhIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL252aWRpYS9udmlkaWEuYworKysgYi9kcml2ZXJzL3Zp
ZGVvL252aWRpYS9udmlkaWEuYwpAQCAtMTksNyArMTksNiBAQAogI2luY2x1ZGUgPGxpbnV4L2Zi
Lmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgotI2lu
Y2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4KICNpbmNsdWRlIDxsaW51eC9iYWNrbGlnaHQuaD4KICNp
ZmRlZiBDT05GSUdfTVRSUgogI2luY2x1ZGUgPGFzbS9tdHJyLmg+CkBAIC0xMDU3LDcgKzEwNTYs
NyBAQCBzdGF0aWMgaW50IG52aWRpYWZiX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKmRldiwgcG1f
bWVzc2FnZV90IG1lc2cpCiAKIAlpZiAobWVzZy5ldmVudCA9PSBQTV9FVkVOVF9QUkVUSEFXKQog
CQltZXNnLmV2ZW50ID0gUE1fRVZFTlRfRlJFRVpFOwotCWNvbnNvbGVfbG9jaygpOworCWZiX2Nv
bnNvbGVfbG9jaygpOwogCXBhci0+cG1fc3RhdGUgPSBtZXNnLmV2ZW50OwogCiAJaWYgKG1lc2cu
ZXZlbnQgJiBQTV9FVkVOVF9TTEVFUCkgewpAQCAtMTA3MCw3ICsxMDY5LDcgQEAgc3RhdGljIGlu
dCBudmlkaWFmYl9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBtX21lc3NhZ2VfdCBtZXNn
KQogCX0KIAlkZXYtPmRldi5wb3dlci5wb3dlcl9zdGF0ZSA9IG1lc2c7CiAKLQljb25zb2xlX3Vu
bG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTEwNzks
NyArMTA3OCw3IEBAIHN0YXRpYyBpbnQgbnZpZGlhZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpk
ZXYpCiAJc3RydWN0IGZiX2luZm8gKmluZm8gPSBwY2lfZ2V0X2RydmRhdGEoZGV2KTsKIAlzdHJ1
Y3QgbnZpZGlhX3BhciAqcGFyID0gaW5mby0+cGFyOwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJf
Y29uc29sZV9sb2NrKCk7CiAJcGNpX3NldF9wb3dlcl9zdGF0ZShkZXYsIFBDSV9EMCk7CiAKIAlp
ZiAocGFyLT5wbV9zdGF0ZSAhPSBQTV9FVkVOVF9GUkVFWkUpIHsKQEAgLTEwOTcsNyArMTA5Niw3
IEBAIHN0YXRpYyBpbnQgbnZpZGlhZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiAJbnZp
ZGlhZmJfYmxhbmsoRkJfQkxBTktfVU5CTEFOSywgaW5mbyk7CiAKIGZhaWw6Ci0JY29uc29sZV91
bmxvY2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCXJldHVybiAwOwogfQogI2Vsc2UKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vcHMzZmIuYyBiL2RyaXZlcnMvdmlkZW8vcHMzZmIuYwpp
bmRleCAyMTNmYmJjLi5jYjJlMTc0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL3BzM2ZiLmMK
KysrIGIvZHJpdmVycy92aWRlby9wczNmYi5jCkBAIC0yMyw3ICsyMyw2IEBACiAjaW5jbHVkZSA8
bGludXgvc3RyaW5nLmg+CiAjaW5jbHVkZSA8bGludXgvbW0uaD4KICNpbmNsdWRlIDxsaW51eC9p
bnRlcnJ1cHQuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAjaW5jbHVkZSA8bGludXgv
aW9jdGwuaD4KICNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+CiAjaW5jbHVkZSA8bGludXgvZnJl
ZXplci5oPgpAQCAtNTE1LDcgKzUxNCw3IEBAIHN0YXRpYyBpbnQgcHMzZmJfcmVsZWFzZShzdHJ1
Y3QgZmJfaW5mbyAqaW5mbywgaW50IHVzZXIpCiAJCQlhdG9taWNfc2V0KCZwczNmYi5leHRfZmxp
cCwgMCk7CiAJCQlpZiAoY29uc29sZV90cnlsb2NrKCkpIHsKIAkJCQlwczNmYl9zeW5jKGluZm8s
IDApOwkvKiBzaW5nbGUgYnVmZmVyICovCi0JCQkJY29uc29sZV91bmxvY2soKTsKKwkJCQlmYl9j
b25zb2xlX3VubG9jaygpOwogCQkJfQogCQl9CiAJfQpAQCAtODMwLDE0ICs4MjksMTQgQEAgc3Rh
dGljIGludCBwczNmYl9pb2N0bChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgdW5zaWduZWQgaW50IGNt
ZCwKIAkJCWlmICh2bW9kZSkgewogCQkJCXZhciA9IGluZm8tPnZhcjsKIAkJCQlmYl92aWRlb21v
ZGVfdG9fdmFyKCZ2YXIsIHZtb2RlKTsKLQkJCQljb25zb2xlX2xvY2soKTsKKwkJCQlmYl9jb25z
b2xlX2xvY2soKTsKIAkJCQlpbmZvLT5mbGFncyB8PSBGQklORk9fTUlTQ19VU0VSRVZFTlQ7CiAJ
CQkJLyogRm9yY2UsIGluIGNhc2Ugb25seSBzcGVjaWFsIGJpdHMgY2hhbmdlZCAqLwogCQkJCXZh
ci5hY3RpdmF0ZSB8PSBGQl9BQ1RJVkFURV9GT1JDRTsKIAkJCQlwYXItPm5ld19tb2RlX2lkID0g
dmFsOwogCQkJCXJldHZhbCA9IGZiX3NldF92YXIoaW5mbywgJnZhcik7CiAJCQkJaW5mby0+Zmxh
Z3MgJj0gfkZCSU5GT19NSVNDX1VTRVJFVkVOVDsKLQkJCQljb25zb2xlX3VubG9jaygpOworCQkJ
CWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJCQl9CiAJCQlicmVhazsKIAkJfQpAQCAtODgxLDkgKzg4
MCw5IEBAIHN0YXRpYyBpbnQgcHMzZmJfaW9jdGwoc3RydWN0IGZiX2luZm8gKmluZm8sIHVuc2ln
bmVkIGludCBjbWQsCiAJCQlicmVhazsKIAogCQlkZXZfZGJnKGluZm8tPmRldmljZSwgIlBTM0ZC
X0lPQ1RMX0ZTRUw6JWRcbiIsIHZhbCk7Ci0JCWNvbnNvbGVfbG9jaygpOworCQlmYl9jb25zb2xl
X2xvY2soKTsKIAkJcmV0dmFsID0gcHMzZmJfc3luYyhpbmZvLCB2YWwpOwotCQljb25zb2xlX3Vu
bG9jaygpOworCQlmYl9jb25zb2xlX3VubG9jaygpOwogCQlicmVhazsKIAogCWRlZmF1bHQ6CkBA
IC05MDMsOSArOTAyLDkgQEAgc3RhdGljIGludCBwczNmYmQodm9pZCAqYXJnKQogCQlzZXRfY3Vy
cmVudF9zdGF0ZShUQVNLX0lOVEVSUlVQVElCTEUpOwogCQlpZiAocHMzZmIuaXNfa2lja2VkKSB7
CiAJCQlwczNmYi5pc19raWNrZWQgPSAwOwotCQkJY29uc29sZV9sb2NrKCk7CisJCQlmYl9jb25z
b2xlX2xvY2soKTsKIAkJCXBzM2ZiX3N5bmMoaW5mbywgMCk7CS8qIHNpbmdsZSBidWZmZXIgKi8K
LQkJCWNvbnNvbGVfdW5sb2NrKCk7CisJCQlmYl9jb25zb2xlX3VubG9jaygpOwogCQl9CiAJCXNj
aGVkdWxlKCk7CiAJfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9weGFmYi5jIGIvZHJpdmVy
cy92aWRlby9weGFmYi5jCmluZGV4IDNmOTAyNTUuLmExYWYyMTIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdmlkZW8vcHhhZmIuYworKysgYi9kcml2ZXJzL3ZpZGVvL3B4YWZiLmMKQEAgLTU0LDcgKzU0
LDYgQEAKICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgogI2luY2x1ZGUgPGxpbnV4L2t0aHJlYWQu
aD4KICNpbmNsdWRlIDxsaW51eC9mcmVlemVyLmg+Ci0jaW5jbHVkZSA8bGludXgvY29uc29sZS5o
PgogCiAjaW5jbHVkZSA8bWFjaC9oYXJkd2FyZS5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgpAQCAt
NzMzLDkgKzczMiw5IEBAIHN0YXRpYyBpbnQgb3ZlcmxheWZiX29wZW4oc3RydWN0IGZiX2luZm8g
KmluZm8sIGludCB1c2VyKQogCiAJaWYgKG9mYi0+dXNhZ2UrKyA9PSAwKSB7CiAJCS8qIHVuYmxh
bmsgdGhlIGJhc2UgZnJhbWVidWZmZXIgKi8KLQkJY29uc29sZV9sb2NrKCk7CisJCWZiX2NvbnNv
bGVfbG9jaygpOwogCQlmYl9ibGFuaygmb2ZiLT5mYmktPmZiLCBGQl9CTEFOS19VTkJMQU5LKTsK
LQkJY29uc29sZV91bmxvY2soKTsKKwkJZmJfY29uc29sZV91bmxvY2soKTsKIAl9CiAKIAlyZXR1
cm4gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vczNmYi5jIGIvZHJpdmVycy92aWRlby9z
M2ZiLmMKaW5kZXggMWQwMDczNi4uNzc1OWM4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9z
M2ZiLmMKKysrIGIvZHJpdmVycy92aWRlby9zM2ZiLmMKQEAgLTIyLDcgKzIyLDYgQEAKICNpbmNs
dWRlIDxsaW51eC9zdmdhLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxp
bnV4L3BjaS5oPgotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4gLyogV2h5IHNob3VsZCBmYiBk
cml2ZXIgY2FsbCBjb25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBjb25zb2xlX2xvY2soKSAqLwog
I2luY2x1ZGUgPHZpZGVvL3ZnYS5oPgogCiAjaW5jbHVkZSA8bGludXgvaTJjLmg+CkBAIC0xNDQ1
LDEyICsxNDQ0LDEyIEBAIHN0YXRpYyBpbnQgczNfcGNpX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYq
IGRldiwgcG1fbWVzc2FnZV90IHN0YXRlKQogCiAJZGV2X2luZm8oaW5mby0+ZGV2aWNlLCAic3Vz
cGVuZFxuIik7CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9mYl9jb25zb2xlX2xvY2soKTsKIAlt
dXRleF9sb2NrKCYocGFyLT5vcGVuX2xvY2spKTsKIAogCWlmICgoc3RhdGUuZXZlbnQgPT0gUE1f
RVZFTlRfRlJFRVpFKSB8fCAocGFyLT5yZWZfY291bnQgPT0gMCkpIHsKIAkJbXV0ZXhfdW5sb2Nr
KCYocGFyLT5vcGVuX2xvY2spKTsKLQkJY29uc29sZV91bmxvY2soKTsKKwkJZmJfY29uc29sZV91
bmxvY2soKTsKIAkJcmV0dXJuIDA7CiAJfQogCkBAIC0xNDYxLDcgKzE0NjAsNyBAQCBzdGF0aWMg
aW50IHMzX3BjaV9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2KiBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0
ZSkKIAlwY2lfc2V0X3Bvd2VyX3N0YXRlKGRldiwgcGNpX2Nob29zZV9zdGF0ZShkZXYsIHN0YXRl
KSk7CiAKIAltdXRleF91bmxvY2soJihwYXItPm9wZW5fbG9jaykpOwotCWNvbnNvbGVfdW5sb2Nr
KCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpAQCAtMTQ3NywxMiAr
MTQ3NiwxMiBAQCBzdGF0aWMgaW50IHMzX3BjaV9yZXN1bWUoc3RydWN0IHBjaV9kZXYqIGRldikK
IAogCWRldl9pbmZvKGluZm8tPmRldmljZSwgInJlc3VtZVxuIik7CiAKLQljb25zb2xlX2xvY2so
KTsKKwlmYl9mYl9jb25zb2xlX2xvY2soKTsKIAltdXRleF9sb2NrKCYocGFyLT5vcGVuX2xvY2sp
KTsKIAogCWlmIChwYXItPnJlZl9jb3VudCA9PSAwKSB7CiAJCW11dGV4X3VubG9jaygmKHBhci0+
b3Blbl9sb2NrKSk7Ci0JCWNvbnNvbGVfdW5sb2NrKCk7CisJCWZiX2NvbnNvbGVfdW5sb2NrKCk7
CiAJCXJldHVybiAwOwogCX0KIApAQCAtMTQ5MSw3ICsxNDkwLDcgQEAgc3RhdGljIGludCBzM19w
Y2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2KiBkZXYpCiAJZXJyID0gcGNpX2VuYWJsZV9kZXZpY2Uo
ZGV2KTsKIAlpZiAoZXJyKSB7CiAJCW11dGV4X3VubG9jaygmKHBhci0+b3Blbl9sb2NrKSk7Ci0J
CWNvbnNvbGVfdW5sb2NrKCk7CisJCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJCWRldl9lcnIoaW5m
by0+ZGV2aWNlLCAiZXJyb3IgJWQgZW5hYmxpbmcgZGV2aWNlIGZvciByZXN1bWVcbiIsIGVycik7
CiAJCXJldHVybiBlcnI7CiAJfQpAQCAtMTUwMSw3ICsxNTAwLDcgQEAgc3RhdGljIGludCBzM19w
Y2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2KiBkZXYpCiAJZmJfc2V0X3N1c3BlbmQoaW5mbywgMCk7
CiAKIAltdXRleF91bmxvY2soJihwYXItPm9wZW5fbG9jaykpOwotCWNvbnNvbGVfdW5sb2NrKCk7
CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9zYXZhZ2Uvc2F2YWdlZmJfZHJpdmVyLmMgYi9kcml2ZXJzL3ZpZGVvL3NhdmFn
ZS9zYXZhZ2VmYl9kcml2ZXIuYwppbmRleCAwZDBmNTJjLi5iZjY0MjIxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3ZpZGVvL3NhdmFnZS9zYXZhZ2VmYl9kcml2ZXIuYworKysgYi9kcml2ZXJzL3ZpZGVv
L3NhdmFnZS9zYXZhZ2VmYl9kcml2ZXIuYwpAQCAtNTEsNyArNTEsNiBAQAogI2luY2x1ZGUgPGxp
bnV4L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgvcGNpLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
PgotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4KIAogI2luY2x1ZGUgPGFzbS9pby5oPgogI2lu
Y2x1ZGUgPGFzbS9pcnEuaD4KQEAgLTIzOTEsNyArMjM5MCw3IEBAIHN0YXRpYyBpbnQgc2F2YWdl
ZmJfc3VzcGVuZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwbV9tZXNzYWdlX3QgbWVzZykKIAlpZiAo
bWVzZy5ldmVudCA9PSBQTV9FVkVOVF9GUkVFWkUpCiAJCXJldHVybiAwOwogCi0JY29uc29sZV9s
b2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJZmJfc2V0X3N1c3BlbmQoaW5mbywgMSk7CiAK
IAlpZiAoaW5mby0+ZmJvcHMtPmZiX3N5bmMpCkBAIC0yNDAzLDcgKzI0MDIsNyBAQCBzdGF0aWMg
aW50IHNhdmFnZWZiX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKmRldiwgcG1fbWVzc2FnZV90IG1l
c2cpCiAJcGNpX3NhdmVfc3RhdGUoZGV2KTsKIAlwY2lfZGlzYWJsZV9kZXZpY2UoZGV2KTsKIAlw
Y2lfc2V0X3Bvd2VyX3N0YXRlKGRldiwgcGNpX2Nob29zZV9zdGF0ZShkZXYsIG1lc2cpKTsKLQlj
b25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAlyZXR1cm4gMDsKIH0K
QEAgLTI0MjcsNyArMjQyNiw3IEBAIHN0YXRpYyBpbnQgc2F2YWdlZmJfcmVzdW1lKHN0cnVjdCBw
Y2lfZGV2KiBkZXYpCiAJCXJldHVybiAwOwogCX0KIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2Nv
bnNvbGVfbG9jaygpOwogCiAJcGNpX3NldF9wb3dlcl9zdGF0ZShkZXYsIFBDSV9EMCk7CiAJcGNp
X3Jlc3RvcmVfc3RhdGUoZGV2KTsKQEAgLTI0NDEsNyArMjQ0MCw3IEBAIHN0YXRpYyBpbnQgc2F2
YWdlZmJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2KiBkZXYpCiAJc2F2YWdlZmJfc2V0X3BhcihpbmZv
KTsKIAlmYl9zZXRfc3VzcGVuZChpbmZvLCAwKTsKIAlzYXZhZ2VmYl9ibGFuayhGQl9CTEFOS19V
TkJMQU5LLCBpbmZvKTsKLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7
CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vc2hfbW9iaWxlX2xj
ZGNmYi5jIGIvZHJpdmVycy92aWRlby9zaF9tb2JpbGVfbGNkY2ZiLmMKaW5kZXggNjk5NDg3Yy4u
MmJjMTExOSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9zaF9tb2JpbGVfbGNkY2ZiLmMKKysr
IGIvZHJpdmVycy92aWRlby9zaF9tb2JpbGVfbGNkY2ZiLmMKQEAgLTExLDcgKzExLDYgQEAKICNp
bmNsdWRlIDxsaW51eC9hdG9taWMuaD4KICNpbmNsdWRlIDxsaW51eC9iYWNrbGlnaHQuaD4KICNp
bmNsdWRlIDxsaW51eC9jbGsuaD4KLSNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+CiAjaW5jbHVk
ZSA8bGludXgvY3R5cGUuaD4KICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgogI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+CkBAIC01NzUsNyArNTc0LDcgQEAgc3RhdGljIGludCBzaF9tb2Jp
bGVfbGNkY19kaXNwbGF5X25vdGlmeShzdHJ1Y3Qgc2hfbW9iaWxlX2xjZGNfY2hhbiAqY2gsCiAJ
Y2FzZSBTSF9NT0JJTEVfTENEQ19FVkVOVF9ESVNQTEFZX0NPTk5FQ1Q6CiAJCS8qIEhETUkgcGx1
ZyBpbiAqLwogCQlpZiAobG9ja19mYl9pbmZvKGluZm8pKSB7Ci0JCQljb25zb2xlX2xvY2soKTsK
KwkJCWZiX2NvbnNvbGVfbG9jaygpOwogCiAJCQljaC0+ZGlzcGxheS53aWR0aCA9IG1vbnNwZWMt
Pm1heF94ICogMTA7CiAJCQljaC0+ZGlzcGxheS5oZWlnaHQgPSBtb25zcGVjLT5tYXhfeSAqIDEw
OwpAQCAtNTk0LDcgKzU5Myw3IEBAIHN0YXRpYyBpbnQgc2hfbW9iaWxlX2xjZGNfZGlzcGxheV9u
b3RpZnkoc3RydWN0IHNoX21vYmlsZV9sY2RjX2NoYW4gKmNoLAogCQkJCWZiX3NldF9zdXNwZW5k
KGluZm8sIDApOwogCQkJfQogCi0JCQljb25zb2xlX3VubG9jaygpOworCQkJZmJfY29uc29sZV91
bmxvY2soKTsKIAkJCXVubG9ja19mYl9pbmZvKGluZm8pOwogCQl9CiAJCWJyZWFrOwpAQCAtNjAy
LDkgKzYwMSw5IEBAIHN0YXRpYyBpbnQgc2hfbW9iaWxlX2xjZGNfZGlzcGxheV9ub3RpZnkoc3Ry
dWN0IHNoX21vYmlsZV9sY2RjX2NoYW4gKmNoLAogCWNhc2UgU0hfTU9CSUxFX0xDRENfRVZFTlRf
RElTUExBWV9ESVNDT05ORUNUOgogCQkvKiBIRE1JIGRpc2Nvbm5lY3QgKi8KIAkJaWYgKGxvY2tf
ZmJfaW5mbyhpbmZvKSkgewotCQkJY29uc29sZV9sb2NrKCk7CisJCQlmYl9jb25zb2xlX2xvY2so
KTsKIAkJCWZiX3NldF9zdXNwZW5kKGluZm8sIDEpOwotCQkJY29uc29sZV91bmxvY2soKTsKKwkJ
CWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJCQl1bmxvY2tfZmJfaW5mbyhpbmZvKTsKIAkJfQogCQli
cmVhazsKQEAgLTE5MzQsOSArMTkzMyw5IEBAIHN0YXRpYyBpbnQgc2hfbW9iaWxlX2xjZGNfcmVs
ZWFzZShzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgaW50IHVzZXIpCiAKIAkvKiBOb3RoaW5nIHRvIHJl
Y29uZmlndXJlLCB3aGVuIGNhbGxlZCBmcm9tIGZiY29uICovCiAJaWYgKHVzZXIpIHsKLQkJY29u
c29sZV9sb2NrKCk7CisJCWZiX2NvbnNvbGVfbG9jaygpOwogCQlzaF9tb2JpbGVfZmJfcmVjb25m
aWcoaW5mbyk7Ci0JCWNvbnNvbGVfdW5sb2NrKCk7CisJCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAJ
fQogCiAJbXV0ZXhfdW5sb2NrKCZjaC0+b3Blbl9sb2NrKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlkZW8vc201MDFmYi5jIGIvZHJpdmVycy92aWRlby9zbTUwMWZiLmMKaW5kZXggMzY5MGVmZi4u
NTM2ZjkyMiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9zbTUwMWZiLmMKKysrIGIvZHJpdmVy
cy92aWRlby9zbTUwMWZiLmMKQEAgLTI4LDcgKzI4LDYgQEAKICNpbmNsdWRlIDxsaW51eC93YWl0
Lmg+CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgv
Y2xrLmg+Ci0jaW5jbHVkZSA8bGludXgvY29uc29sZS5oPgogI2luY2x1ZGUgPGxpbnV4L2lvLmg+
CiAKICNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgpAQCAtMjEwNCw5ICsyMTAzLDkgQEAgc3RhdGlj
IGludCBzbTUwMWZiX3N1c3BlbmRfZmIoc3RydWN0IHNtNTAxZmJfaW5mbyAqaW5mbywKIAogCS8q
IHRlbGwgY29uc29sZS9mYiBkcml2ZXIgd2UgYXJlIHN1c3BlbmRpbmcgKi8KIAotCWNvbnNvbGVf
bG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZiX3NldF9zdXNwZW5kKGZiaSwgMSk7Ci0J
Y29uc29sZV91bmxvY2soKTsKKwlmYl9jb25zb2xlX3VubG9jaygpOwogCiAJLyogYmFja3VwIGNv
cGllcyBpbiBjYXNlIGNoaXAgaXMgcG93ZXJlZCBkb3duIG92ZXIgc3VzcGVuZCAqLwogCkBAIC0y
MTYzLDkgKzIxNjIsOSBAQCBzdGF0aWMgdm9pZCBzbTUwMWZiX3Jlc3VtZV9mYihzdHJ1Y3Qgc201
MDFmYl9pbmZvICppbmZvLAogCQltZW1jcHlfdG9pbyhwYXItPmN1cnNvci5rX2FkZHIsIHBhci0+
c3RvcmVfY3Vyc29yLAogCQkJICAgIHBhci0+Y3Vyc29yLnNpemUpOwogCi0JY29uc29sZV9sb2Nr
KCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJZmJfc2V0X3N1c3BlbmQoZmJpLCAwKTsKLQljb25z
b2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2NrKCk7CiAKIAl2ZnJlZShwYXItPnN0b3Jl
X2ZiKTsKIAl2ZnJlZShwYXItPnN0b3JlX2N1cnNvcik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
ZGVvL3RtaW9mYi5jIGIvZHJpdmVycy92aWRlby90bWlvZmIuYwppbmRleCA4ZTRhNDQ2Li5lMjY2
YjZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL3RtaW9mYi5jCisrKyBiL2RyaXZlcnMvdmlk
ZW8vdG1pb2ZiLmMKQEAgLTI1LDggKzI1LDcgQEAKICNpbmNsdWRlIDxsaW51eC9mYi5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Ci0vKiBX
aHkgc2hvdWxkIGZiIGRyaXZlciBjYWxsIGNvbnNvbGUgZnVuY3Rpb25zPyBiZWNhdXNlIGNvbnNv
bGVfbG9jaygpICovCi0jaW5jbHVkZSA8bGludXgvY29uc29sZS5oPgorLyogV2h5IHNob3VsZCBm
YiBkcml2ZXIgY2FsbCBjb25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBmYl9jb25zb2xlX2xvY2so
KSAqLwogI2luY2x1ZGUgPGxpbnV4L21mZC9jb3JlLmg+CiAjaW5jbHVkZSA8bGludXgvbWZkL3Rt
aW8uaD4KICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CkBAIC05MzgsNyArOTM3LDcgQEAgc3Rh
dGljIGludCB0bWlvZmJfc3VzcGVuZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYsIHBtX21l
c3NhZ2VfdCBzdGF0ZSkKIAljb25zdCBzdHJ1Y3QgbWZkX2NlbGwgKmNlbGwgPSBtZmRfZ2V0X2Nl
bGwoZGV2KTsKIAlpbnQgcmV0dmFsID0gMDsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNv
bGVfbG9jaygpOwogCiAJZmJfc2V0X3N1c3BlbmQoaW5mbywgMSk7CiAKQEAgLTk1OSw3ICs5NTgs
NyBAQCBzdGF0aWMgaW50IHRtaW9mYl9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRl
diwgcG1fbWVzc2FnZV90IHN0YXRlKQogCWlmIChjZWxsLT5zdXNwZW5kKQogCQlyZXR2YWwgPSBj
ZWxsLT5zdXNwZW5kKGRldik7CiAKLQljb25zb2xlX3VubG9jaygpOworCWZiX2ZiX2NvbnNvbGVf
dW5sb2NrKCk7CiAKIAlyZXR1cm4gcmV0dmFsOwogfQpAQCAtOTcwLDcgKzk2OSw3IEBAIHN0YXRp
YyBpbnQgdG1pb2ZiX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiAJY29uc3Qg
c3RydWN0IG1mZF9jZWxsICpjZWxsID0gbWZkX2dldF9jZWxsKGRldik7CiAJaW50IHJldHZhbCA9
IDA7CiAKLQljb25zb2xlX2xvY2soKTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAogCWlmIChjZWxs
LT5yZXN1bWUpIHsKIAkJcmV0dmFsID0gY2VsbC0+cmVzdW1lKGRldik7CkBAIC05ODYsNyArOTg1
LDcgQEAgc3RhdGljIGludCB0bWlvZmJfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRl
dikKIAogCWZiX3NldF9zdXNwZW5kKGluZm8sIDApOwogb3V0OgotCWNvbnNvbGVfdW5sb2NrKCk7
CisJZmJfZmJfY29uc29sZV91bmxvY2soKTsKIAlyZXR1cm4gcmV0dmFsOwogfQogI2Vsc2UKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vdmlhL3ZpYWZiZGV2LmMgYi9kcml2ZXJzL3ZpZGVvL3Zp
YS92aWFmYmRldi5jCmluZGV4IGM4MGU3NzAuLmQzNmIxNzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmlkZW8vdmlhL3ZpYWZiZGV2LmMKKysrIGIvZHJpdmVycy92aWRlby92aWEvdmlhZmJkZXYuYwpA
QCAtMTY5OCwxNyArMTY5OCwxNyBAQCBzdGF0aWMgaW50IHBhcnNlX21vZGUoY29uc3QgY2hhciAq
c3RyLCB1MzIgZGV2aWNlcywgdTMyICp4cmVzLCB1MzIgKnlyZXMpCiAjaWZkZWYgQ09ORklHX1BN
CiBzdGF0aWMgaW50IHZpYWZiX3N1c3BlbmQodm9pZCAqdW51c2VkKQogewotCWNvbnNvbGVfbG9j
aygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZiX3NldF9zdXNwZW5kKHZpYWZiaW5mbywgMSk7
CiAJdmlhZmJfc3luYyh2aWFmYmluZm8pOwotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29s
ZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IHZpYWZiX3Jlc3VtZSh2
b2lkICp1bnVzZWQpCiB7Ci0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9sb2NrKCk7CiAJ
aWYgKHZpYXBhcmluZm8tPnNoYXJlZC0+dmRldi0+ZW5naW5lX21taW8pCiAJCXZpYWZiX3Jlc2V0
X2VuZ2luZSh2aWFwYXJpbmZvKTsKIAl2aWFmYl9zZXRfcGFyKHZpYWZiaW5mbyk7CkBAIC0xNzE2
LDcgKzE3MTYsNyBAQCBzdGF0aWMgaW50IHZpYWZiX3Jlc3VtZSh2b2lkICp1bnVzZWQpCiAJCXZp
YWZiX3NldF9wYXIodmlhZmJpbmZvMSk7CiAJZmJfc2V0X3N1c3BlbmQodmlhZmJpbmZvLCAwKTsK
IAotCWNvbnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAlyZXR1cm4gMDsK
IH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby92dDg2MjNmYi5jIGIvZHJpdmVycy92aWRl
by92dDg2MjNmYi5jCmluZGV4IDRlNzRkMjYuLmNiNDhkNGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmlkZW8vdnQ4NjIzZmIuYworKysgYi9kcml2ZXJzL3ZpZGVvL3Z0ODYyM2ZiLmMKQEAgLTIzLDcg
KzIzLDYgQEAKICNpbmNsdWRlIDxsaW51eC9zdmdhLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
PgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4gLyog
V2h5IHNob3VsZCBmYiBkcml2ZXIgY2FsbCBjb25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBjb25z
b2xlX2xvY2soKSAqLwogI2luY2x1ZGUgPHZpZGVvL3ZnYS5oPgogCiAjaWZkZWYgQ09ORklHX01U
UlIKQEAgLTg0NSwxMiArODQ0LDEyIEBAIHN0YXRpYyBpbnQgdnQ4NjIzX3BjaV9zdXNwZW5kKHN0
cnVjdCBwY2lfZGV2KiBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIAogCWRldl9pbmZvKGluZm8t
PmRldmljZSwgInN1c3BlbmRcbiIpOwogCi0JY29uc29sZV9sb2NrKCk7CisJZmJfY29uc29sZV9s
b2NrKCk7CiAJbXV0ZXhfbG9jaygmKHBhci0+b3Blbl9sb2NrKSk7CiAKIAlpZiAoKHN0YXRlLmV2
ZW50ID09IFBNX0VWRU5UX0ZSRUVaRSkgfHwgKHBhci0+cmVmX2NvdW50ID09IDApKSB7CiAJCW11
dGV4X3VubG9jaygmKHBhci0+b3Blbl9sb2NrKSk7Ci0JCWNvbnNvbGVfdW5sb2NrKCk7CisJCWZi
X2NvbnNvbGVfdW5sb2NrKCk7CiAJCXJldHVybiAwOwogCX0KIApAQCAtODYxLDcgKzg2MCw3IEBA
IHN0YXRpYyBpbnQgdnQ4NjIzX3BjaV9zdXNwZW5kKHN0cnVjdCBwY2lfZGV2KiBkZXYsIHBtX21l
c3NhZ2VfdCBzdGF0ZSkKIAlwY2lfc2V0X3Bvd2VyX3N0YXRlKGRldiwgcGNpX2Nob29zZV9zdGF0
ZShkZXYsIHN0YXRlKSk7CiAKIAltdXRleF91bmxvY2soJihwYXItPm9wZW5fbG9jaykpOwotCWNv
bnNvbGVfdW5sb2NrKCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpA
QCAtODc2LDcgKzg3NSw3IEBAIHN0YXRpYyBpbnQgdnQ4NjIzX3BjaV9yZXN1bWUoc3RydWN0IHBj
aV9kZXYqIGRldikKIAogCWRldl9pbmZvKGluZm8tPmRldmljZSwgInJlc3VtZVxuIik7CiAKLQlj
b25zb2xlX2xvY2soKTsKKwlmYl9jb25zb2xlX2xvY2soKTsKIAltdXRleF9sb2NrKCYocGFyLT5v
cGVuX2xvY2spKTsKIAogCWlmIChwYXItPnJlZl9jb3VudCA9PSAwKQpAQCAtODk1LDcgKzg5NCw3
IEBAIHN0YXRpYyBpbnQgdnQ4NjIzX3BjaV9yZXN1bWUoc3RydWN0IHBjaV9kZXYqIGRldikKIAog
ZmFpbDoKIAltdXRleF91bmxvY2soJihwYXItPm9wZW5fbG9jaykpOwotCWNvbnNvbGVfdW5sb2Nr
KCk7CisJZmJfY29uc29sZV91bmxvY2soKTsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aWRlby94ZW4tZmJmcm9udC5jIGIvZHJpdmVycy92aWRlby94ZW4tZmJmcm9udC5j
CmluZGV4IGI3ZjUxNzMuLjc3MDM5N2U3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL3hlbi1m
YmZyb250LmMKKysrIGIvZHJpdmVycy92aWRlby94ZW4tZmJmcm9udC5jCkBAIC0xOCw3ICsxOCw2
IEBACiAgKiBmcmFtZSBidWZmZXIuCiAgKi8KIAotI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4K
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2ZiLmg+CkBAIC00OTUsMTIgKzQ5NCwxMiBAQCB4ZW5mYl9tYWtlX3ByZWZl
cnJlZF9jb25zb2xlKHZvaWQpCiAJaWYgKGNvbnNvbGVfc2V0X29uX2NtZGxpbmUpCiAJCXJldHVy
bjsKIAotCWNvbnNvbGVfbG9jaygpOworCWZiX2NvbnNvbGVfbG9jaygpOwogCWZvcl9lYWNoX2Nv
bnNvbGUoYykgewogCQlpZiAoIXN0cmNtcChjLT5uYW1lLCAidHR5IikgJiYgYy0+aW5kZXggPT0g
MCkKIAkJCWJyZWFrOwogCX0KLQljb25zb2xlX3VubG9jaygpOworCWZiX2NvbnNvbGVfdW5sb2Nr
KCk7CiAJaWYgKGMpIHsKIAkJdW5yZWdpc3Rlcl9jb25zb2xlKGMpOwogCQljLT5mbGFncyB8PSBD
T05fQ09OU0RFVjsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmIuaCBiL2luY2x1ZGUvbGlu
dXgvZmIuaAppbmRleCBhYzNmMWM2Li43YWU5NmFkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4
L2ZiLmgKKysrIGIvaW5jbHVkZS9saW51eC9mYi5oCkBAIC0xMDIxLDYgKzEwMjEsOCBAQCBleHRl
cm4gaW50IGZiX2dldF9jb2xvcl9kZXB0aChzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwK
IAkJCSAgICAgIHN0cnVjdCBmYl9maXhfc2NyZWVuaW5mbyAqZml4KTsKIGV4dGVybiBpbnQgZmJf
Z2V0X29wdGlvbnMoY2hhciAqbmFtZSwgY2hhciAqKm9wdGlvbik7CiBleHRlcm4gaW50IGZiX25l
d19tb2RlbGlzdChzdHJ1Y3QgZmJfaW5mbyAqaW5mbyk7CitleHRlcm4gdm9pZCBmYl9jb25zb2xl
X3VubG9jayh2b2lkKTsKK2V4dGVybiB2b2lkIGZiX2NvbnNvbGVfbG9jayh2b2lkKTsKIAogZXh0
ZXJuIHN0cnVjdCBmYl9pbmZvICpyZWdpc3RlcmVkX2ZiW0ZCX01BWF07CiBleHRlcm4gaW50IG51
bV9yZWdpc3RlcmVkX2ZiOwotLSAKMS43LjkuNQoK
--e89a8ff1cb4622a14b04cad07484--
