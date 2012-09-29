From: Jun Nie <niej0001@gmail.com>
Date: Sat, 29 Sep 2012 06:03:18 +0000
Subject: Re: [PATCH] fb: only enable console lock in fb for VGA console
Message-Id: <CAGA24MJpo1wJyDPY58RSWDjxy+PydhYUqc0JPbobSQYpvMbVaA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
In-Reply-To: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

2012/9/29 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Sat, 2012-09-29 at 13:29 +0800, Jun Nie wrote:
>> If VGA console is not enable, we do not have to
>> involve console lock/unlock in FB framework to avoid
>> hold the lock unnecessarily. Otherwise, UART console
>> output may be blocked by FB pan_display etc operations,
>> which hold the console lock. This may block the
>> panic log out on UART, where the lock may never be
>> released by FB.
>
> And you end up removing all locking from the entire fbdev layer ... did
> you actually think about what you were doing here ?
>
> Ben.
>
Hi Ben,
    Yes. If framebuffer console is disabled, I do not see any need to
hold console lock in FB. Please help indicate the risk if any. Thanks!

Jun
>> Signed-off-by: Jun Nie <njun@marvell.com>
>> ---
>>  drivers/video/arkfb.c                  |   11 +++++------
>>  drivers/video/aty/aty128fb.c           |   11 +++++------
>>  drivers/video/aty/atyfb_base.c         |   11 +++++------
>>  drivers/video/aty/radeon_pm.c          |    9 ++++-----
>>  drivers/video/chipsfb.c                |    8 ++++----
>>  drivers/video/da8xx-fb.c               |    9 ++++-----
>>  drivers/video/fb-puv3.c                |    9 ++++-----
>>  drivers/video/fbmem.c                  |   28 ++++++++++++++++++++++------
>>  drivers/video/fbsysfs.c                |   21 ++++++++++-----------
>>  drivers/video/geode/gxfb_core.c        |    9 ++++-----
>>  drivers/video/geode/lxfb_core.c        |    8 ++++----
>>  drivers/video/i740fb.c                 |   11 +++++------
>>  drivers/video/i810/i810_main.c         |    9 ++++-----
>>  drivers/video/jz4740_fb.c              |    9 ++++-----
>>  drivers/video/mx3fb.c                  |    9 ++++-----
>>  drivers/video/nvidia/nvidia.c          |    9 ++++-----
>>  drivers/video/ps3fb.c                  |   15 +++++++--------
>>  drivers/video/pxafb.c                  |    5 ++---
>>  drivers/video/s3fb.c                   |   15 +++++++--------
>>  drivers/video/savage/savagefb_driver.c |    9 ++++-----
>>  drivers/video/sh_mobile_lcdcfb.c       |   13 ++++++-------
>>  drivers/video/sm501fb.c                |    9 ++++-----
>>  drivers/video/tmiofb.c                 |   11 +++++------
>>  drivers/video/via/viafbdev.c           |    8 ++++----
>>  drivers/video/vt8623fb.c               |   11 +++++------
>>  drivers/video/xen-fbfront.c            |    5 ++---
>>  include/linux/fb.h                     |    2 ++
>>  27 files changed, 140 insertions(+), 144 deletions(-)
>>
>> diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
>> index 555dd4c..774d902 100644
>> --- a/drivers/video/arkfb.c
>> +++ b/drivers/video/arkfb.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/svga.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> -#include <linux/console.h> /* Why should fb driver call console
>> functions? because console_lock() */
>>  #include <video/vga.h>
>>
>>  #ifdef CONFIG_MTRR
>> @@ -1124,12 +1123,12 @@ static int ark_pci_suspend (struct pci_dev*
>> dev, pm_message_t state)
>>
>>       dev_info(info->device, "suspend\n");
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return 0;
>>       }
>>
>> @@ -1140,7 +1139,7 @@ static int ark_pci_suspend (struct pci_dev* dev,
>> pm_message_t state)
>>       pci_set_power_state(dev, pci_choose_state(dev, state));
>>
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -1155,7 +1154,7 @@ static int ark_pci_resume (struct pci_dev* dev)
>>
>>       dev_info(info->device, "resume\n");
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if (par->ref_count = 0)
>> @@ -1174,7 +1173,7 @@ static int ark_pci_resume (struct pci_dev* dev)
>>
>>  fail:
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  #else
>> diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
>> index 747442d..1c6b80b 100644
>> --- a/drivers/video/aty/aty128fb.c
>> +++ b/drivers/video/aty/aty128fb.c
>> @@ -60,7 +60,6 @@
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>>  #include <linux/ioport.h>
>> -#include <linux/console.h>
>>  #include <linux/backlight.h>
>>  #include <asm/io.h>
>>
>> @@ -1884,7 +1883,7 @@ static void aty128_early_resume(void *data)
>>               return;
>>       pci_restore_state(par->pdev);
>>       aty128_do_resume(par->pdev);
>> -     console_unlock();
>> +     fb_console_unlock();
>>  }
>>  #endif /* CONFIG_PPC_PMAC */
>>
>> @@ -2461,7 +2460,7 @@ static int aty128_pci_suspend(struct pci_dev
>> *pdev, pm_message_t state)
>>
>>       printk(KERN_DEBUG "aty128fb: suspending...\n");
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       fb_set_suspend(info, 1);
>>
>> @@ -2493,7 +2492,7 @@ static int aty128_pci_suspend(struct pci_dev
>> *pdev, pm_message_t state)
>>       if (state.event != PM_EVENT_ON)
>>               aty128_set_suspend(par, 1);
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       pdev->dev.power.power_state = state;
>>
>> @@ -2550,9 +2549,9 @@ static int aty128_pci_resume(struct pci_dev *pdev)
>>  {
>>       int rc;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       rc = aty128_do_resume(pdev);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return rc;
>>  }
>> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
>> index 3f2e8c1..9bb15ab 100644
>> --- a/drivers/video/aty/atyfb_base.c
>> +++ b/drivers/video/aty/atyfb_base.c
>> @@ -58,7 +58,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/delay.h>
>> -#include <linux/console.h>
>>  #include <linux/fb.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> @@ -2065,7 +2064,7 @@ static int atyfb_pci_suspend(struct pci_dev
>> *pdev, pm_message_t state)
>>       if (state.event = pdev->dev.power.power_state.event)
>>               return 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       fb_set_suspend(info, 1);
>>
>> @@ -2093,14 +2092,14 @@ static int atyfb_pci_suspend(struct pci_dev
>> *pdev, pm_message_t state)
>>               par->lock_blank = 0;
>>               atyfb_blank(FB_BLANK_UNBLANK, info);
>>               fb_set_suspend(info, 0);
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return -EIO;
>>       }
>>  #else
>>       pci_set_power_state(pdev, pci_choose_state(pdev, state));
>>  #endif
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       pdev->dev.power.power_state = state;
>>
>> @@ -2129,7 +2128,7 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
>>       if (pdev->dev.power.power_state.event = PM_EVENT_ON)
>>               return 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       /*
>>        * PCI state will have been restored by the core, so
>> @@ -2157,7 +2156,7 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
>>       par->lock_blank = 0;
>>       atyfb_blank(FB_BLANK_UNBLANK, info);
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       pdev->dev.power.power_state = PMSG_ON;
>>
>> diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
>> index 92bda58..a2f07da 100644
>> --- a/drivers/video/aty/radeon_pm.c
>> +++ b/drivers/video/aty/radeon_pm.c
>> @@ -16,7 +16,6 @@
>>
>>  #include "radeonfb.h"
>>
>> -#include <linux/console.h>
>>  #include <linux/agp_backend.h>
>>
>>  #ifdef CONFIG_PPC_PMAC
>> @@ -2626,7 +2625,7 @@ int radeonfb_pci_suspend(struct pci_dev *pdev,
>> pm_message_t mesg)
>>               goto done;
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       fb_set_suspend(info, 1);
>>
>> @@ -2690,7 +2689,7 @@ int radeonfb_pci_suspend(struct pci_dev *pdev,
>> pm_message_t mesg)
>>       if (rinfo->pm_mode & radeon_pm_d2)
>>               radeon_set_suspend(rinfo, 1);
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>   done:
>>       pdev->dev.power.power_state = mesg;
>> @@ -2718,7 +2717,7 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
>>               if (!console_trylock())
>>                       return 0;
>>       } else
>> -             console_lock();
>> +             fb_console_lock();
>>
>>       printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
>>              pci_name(pdev), pdev->dev.power.power_state.event);
>> @@ -2783,7 +2782,7 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
>>       pdev->dev.power.power_state = PMSG_ON;
>>
>>   bail:
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return rc;
>>  }
>> diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
>> index cff742a..d50fa6b 100644
>> --- a/drivers/video/chipsfb.c
>> +++ b/drivers/video/chipsfb.c
>> @@ -460,10 +460,10 @@ static int chipsfb_pci_suspend(struct pci_dev
>> *pdev, pm_message_t state)
>>       if (!(state.event & PM_EVENT_SLEEP))
>>               goto done;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       chipsfb_blank(1, p);
>>       fb_set_suspend(p, 1);
>> -     console_unlock();
>> +     fb_console_unlock();
>>   done:
>>       pdev->dev.power.power_state = state;
>>       return 0;
>> @@ -473,10 +473,10 @@ static int chipsfb_pci_resume(struct pci_dev *pdev)
>>  {
>>          struct fb_info *p = pci_get_drvdata(pdev);
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(p, 0);
>>       chipsfb_blank(0, p);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       pdev->dev.power.power_state = PMSG_ON;
>>       return 0;
>> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
>> index 7ae9d53..9a36bbc 100644
>> --- a/drivers/video/da8xx-fb.c
>> +++ b/drivers/video/da8xx-fb.c
>> @@ -29,7 +29,6 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/clk.h>
>>  #include <linux/cpufreq.h>
>> -#include <linux/console.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> @@ -1406,14 +1405,14 @@ static int fb_suspend(struct platform_device
>> *dev, pm_message_t state)
>>       struct fb_info *info = platform_get_drvdata(dev);
>>       struct da8xx_fb_par *par = info->par;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       if (par->panel_power_ctrl)
>>               par->panel_power_ctrl(0);
>>
>>       fb_set_suspend(info, 1);
>>       lcd_disable_raster();
>>       clk_disable(par->lcdc_clk);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -1422,7 +1421,7 @@ static int fb_resume(struct platform_device *dev)
>>       struct fb_info *info = platform_get_drvdata(dev);
>>       struct da8xx_fb_par *par = info->par;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       clk_enable(par->lcdc_clk);
>>       lcd_enable_raster();
>>
>> @@ -1430,7 +1429,7 @@ static int fb_resume(struct platform_device *dev)
>>               par->panel_power_ctrl(1);
>>
>>       fb_set_suspend(info, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/fb-puv3.c b/drivers/video/fb-puv3.c
>> index 60a787f..87c8c4e 100644
>> --- a/drivers/video/fb-puv3.c
>> +++ b/drivers/video/fb-puv3.c
>> @@ -17,7 +17,6 @@
>>  #include <linux/clk.h>
>>  #include <linux/fb.h>
>>  #include <linux/init.h>
>> -#include <linux/console.h>
>>
>>  #include <asm/sizes.h>
>>  #include <mach/hardware.h>
>> @@ -759,7 +758,7 @@ static int unifb_resume(struct platform_device *dev)
>>       if (dev->dev.power.power_state.event = PM_EVENT_ON)
>>               return 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       if (dev->dev.power.power_state.event = PM_EVENT_SUSPEND) {
>>               writel(unifb_regs[0], UDE_FSA);
>> @@ -775,7 +774,7 @@ static int unifb_resume(struct platform_device *dev)
>>       }
>>       dev->dev.power.power_state = PMSG_ON;
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return rc;
>>  }
>> @@ -804,11 +803,11 @@ static int unifb_suspend(struct platform_device
>> *dev, pm_message_t mesg)
>>               goto done;
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       /* do nothing... */
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>  done:
>>       dev->dev.power.power_state = mesg;
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index 0dff12a..c2d4627 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -85,6 +85,22 @@ EXPORT_SYMBOL(lock_fb_info);
>>   * Helpers
>>   */
>>
>> +void fb_console_lock(void)
>> +{
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE
>> +     console_lock();
>> +#endif
>> +}
>> +EXPORT_SYMBOL(fb_console_lock);
>> +
>> +void fb_console_unlock(void)
>> +{
>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE
>> +     console_unlock();
>> +#endif
>> +}
>> +EXPORT_SYMBOL(fb_console_unlock);
>> +
>>  int fb_get_color_depth(struct fb_var_screeninfo *var,
>>                      struct fb_fix_screeninfo *fix)
>>  {
>> @@ -1101,11 +1117,11 @@ static long do_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>                       return -EFAULT;
>>               if (!lock_fb_info(info))
>>                       return -ENODEV;
>> -             console_lock();
>> +             fb_console_lock();
>>               info->flags |= FBINFO_MISC_USEREVENT;
>>               ret = fb_set_var(info, &var);
>>               info->flags &= ~FBINFO_MISC_USEREVENT;
>> -             console_unlock();
>> +             fb_console_unlock();
>>               unlock_fb_info(info);
>>               if (!ret && copy_to_user(argp, &var, sizeof(var)))
>>                       ret = -EFAULT;
>> @@ -1137,9 +1153,9 @@ static long do_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>                       return -EFAULT;
>>               if (!lock_fb_info(info))
>>                       return -ENODEV;
>> -             console_lock();
>> +             fb_console_lock();
>>               ret = fb_pan_display(info, &var);
>> -             console_unlock();
>> +             fb_console_unlock();
>>               unlock_fb_info(info);
>>               if (ret = 0 && copy_to_user(argp, &var, sizeof(var)))
>>                       return -EFAULT;
>> @@ -1184,11 +1200,11 @@ static long do_fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>       case FBIOBLANK:
>>               if (!lock_fb_info(info))
>>                       return -ENODEV;
>> -             console_lock();
>> +             fb_console_lock();
>>               info->flags |= FBINFO_MISC_USEREVENT;
>>               ret = fb_blank(info, arg);
>>               info->flags &= ~FBINFO_MISC_USEREVENT;
>> -             console_unlock();
>> +             fb_console_unlock();
>>               unlock_fb_info(info);
>>               break;
>>       default:
>> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
>> index a55e366..976d8f5 100644
>> --- a/drivers/video/fbsysfs.c
>> +++ b/drivers/video/fbsysfs.c
>> @@ -18,7 +18,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>>  #include <linux/fb.h>
>> -#include <linux/console.h>
>>  #include <linux/module.h>
>>
>>  #define FB_SYSFS_FLAG_ATTR 1
>> @@ -92,11 +91,11 @@ static int activate(struct fb_info *fb_info,
>> struct fb_var_screeninfo *var)
>>       int err;
>>
>>       var->activate |= FB_ACTIVATE_FORCE;
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_info->flags |= FBINFO_MISC_USEREVENT;
>>       err = fb_set_var(fb_info, var);
>>       fb_info->flags &= ~FBINFO_MISC_USEREVENT;
>> -     console_unlock();
>> +     fb_console_unlock();
>>       if (err)
>>               return err;
>>       return 0;
>> @@ -177,7 +176,7 @@ static ssize_t store_modes(struct device *device,
>>       if (i * sizeof(struct fb_videomode) != count)
>>               return -EINVAL;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       list_splice(&fb_info->modelist, &old_list);
>>       fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
>>                                &fb_info->modelist);
>> @@ -187,7 +186,7 @@ static ssize_t store_modes(struct device *device,
>>       } else
>>               fb_destroy_modelist(&old_list);
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -303,11 +302,11 @@ static ssize_t store_blank(struct device *device,
>>       char *last = NULL;
>>       int err;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_info->flags |= FBINFO_MISC_USEREVENT;
>>       err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
>>       fb_info->flags &= ~FBINFO_MISC_USEREVENT;
>> -     console_unlock();
>> +     fb_console_unlock();
>>       if (err < 0)
>>               return err;
>>       return count;
>> @@ -366,9 +365,9 @@ static ssize_t store_pan(struct device *device,
>>               return -EINVAL;
>>       var.yoffset = simple_strtoul(last, &last, 0);
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       err = fb_pan_display(fb_info, &var);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       if (err < 0)
>>               return err;
>> @@ -403,9 +402,9 @@ static ssize_t store_fbstate(struct device *device,
>>
>>       if (!lock_fb_info(fb_info))
>>               return -ENODEV;
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(fb_info, (int)state);
>> -     console_unlock();
>> +     fb_console_unlock();
>>       unlock_fb_info(fb_info);
>>
>>       return count;
>> diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
>> index b4f19db..ba7dd0a 100644
>> --- a/drivers/video/geode/gxfb_core.c
>> +++ b/drivers/video/geode/gxfb_core.c
>> @@ -27,7 +27,6 @@
>>  #include <linux/mm.h>
>>  #include <linux/delay.h>
>>  #include <linux/fb.h>
>> -#include <linux/console.h>
>>  #include <linux/suspend.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> @@ -344,10 +343,10 @@ static int gxfb_suspend(struct pci_dev *pdev,
>> pm_message_t state)
>>       struct fb_info *info = pci_get_drvdata(pdev);
>>
>>       if (state.event = PM_EVENT_SUSPEND) {
>> -             console_lock();
>> +             fb_console_lock();
>>               gx_powerdown(info);
>>               fb_set_suspend(info, 1);
>> -             console_unlock();
>> +             fb_console_unlock();
>>       }
>>
>>       /* there's no point in setting PCI states; we emulate PCI, so
>> @@ -361,7 +360,7 @@ static int gxfb_resume(struct pci_dev *pdev)
>>       struct fb_info *info = pci_get_drvdata(pdev);
>>       int ret;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       ret = gx_powerup(info);
>>       if (ret) {
>>               printk(KERN_ERR "gxfb:  power up failed!\n");
>> @@ -369,7 +368,7 @@ static int gxfb_resume(struct pci_dev *pdev)
>>       }
>>
>>       fb_set_suspend(info, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  #endif
>> diff --git a/drivers/video/geode/lxfb_core.c b/drivers/video/geode/lxfb_core.c
>> index 416851c..5341bf1 100644
>> --- a/drivers/video/geode/lxfb_core.c
>> +++ b/drivers/video/geode/lxfb_core.c
>> @@ -465,10 +465,10 @@ static int lxfb_suspend(struct pci_dev *pdev,
>> pm_message_t state)
>>       struct fb_info *info = pci_get_drvdata(pdev);
>>
>>       if (state.event = PM_EVENT_SUSPEND) {
>> -             console_lock();
>> +             fb_console_lock();
>>               lx_powerdown(info);
>>               fb_set_suspend(info, 1);
>> -             console_unlock();
>> +             fb_console_unlock();
>>       }
>>
>>       /* there's no point in setting PCI states; we emulate PCI, so
>> @@ -482,7 +482,7 @@ static int lxfb_resume(struct pci_dev *pdev)
>>       struct fb_info *info = pci_get_drvdata(pdev);
>>       int ret;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       ret = lx_powerup(info);
>>       if (ret) {
>>               printk(KERN_ERR "lxfb:  power up failed!\n");
>> @@ -490,7 +490,7 @@ static int lxfb_resume(struct pci_dev *pdev)
>>       }
>>
>>       fb_set_suspend(info, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  #else
>> diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
>> index ff3f880..b3fe538 100644
>> --- a/drivers/video/i740fb.c
>> +++ b/drivers/video/i740fb.c
>> @@ -24,7 +24,6 @@
>>  #include <linux/pci_ids.h>
>>  #include <linux/i2c.h>
>>  #include <linux/i2c-algo-bit.h>
>> -#include <linux/console.h>
>>  #include <video/vga.h>
>>
>>  #ifdef CONFIG_MTRR
>> @@ -1210,13 +1209,13 @@ static int i740fb_suspend(struct pci_dev *dev,
>> pm_message_t state)
>>       if (state.event = PM_EVENT_FREEZE || state.event = PM_EVENT_PRETHAW)
>>               return 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       /* do nothing if framebuffer is not active */
>>       if (par->ref_count = 0) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return 0;
>>       }
>>
>> @@ -1227,7 +1226,7 @@ static int i740fb_suspend(struct pci_dev *dev,
>> pm_message_t state)
>>       pci_set_power_state(dev, pci_choose_state(dev, state));
>>
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -1237,7 +1236,7 @@ static int i740fb_resume(struct pci_dev *dev)
>>       struct fb_info *info = pci_get_drvdata(dev);
>>       struct i740fb_par *par = info->par;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if (par->ref_count = 0)
>> @@ -1253,7 +1252,7 @@ static int i740fb_resume(struct pci_dev *dev)
>>
>>  fail:
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  #else
>> diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
>> index b83f361..84fe1ed 100644
>> --- a/drivers/video/i810/i810_main.c
>> +++ b/drivers/video/i810/i810_main.c
>> @@ -40,7 +40,6 @@
>>  #include <linux/pci_ids.h>
>>  #include <linux/resource.h>
>>  #include <linux/unistd.h>
>> -#include <linux/console.h>
>>
>>  #include <asm/io.h>
>>  #include <asm/div64.h>
>> @@ -1574,7 +1573,7 @@ static int i810fb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>               return 0;
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(info, 1);
>>
>>       if (info->fbops->fb_sync)
>> @@ -1587,7 +1586,7 @@ static int i810fb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>       pci_save_state(dev);
>>       pci_disable_device(dev);
>>       pci_set_power_state(dev, pci_choose_state(dev, mesg));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -1605,7 +1604,7 @@ static int i810fb_resume(struct pci_dev *dev)
>>               return 0;
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       pci_set_power_state(dev, PCI_D0);
>>       pci_restore_state(dev);
>>
>> @@ -1621,7 +1620,7 @@ static int i810fb_resume(struct pci_dev *dev)
>>       fb_set_suspend (info, 0);
>>       info->fbops->fb_blank(VESA_NO_BLANKING, info);
>>  fail:
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  /***********************************************************************
>> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
>> index de36693..7e9301a 100644
>> --- a/drivers/video/jz4740_fb.c
>> +++ b/drivers/video/jz4740_fb.c
>> @@ -21,7 +21,6 @@
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>>
>> -#include <linux/console.h>
>>  #include <linux/fb.h>
>>
>>  #include <linux/dma-mapping.h>
>> @@ -778,9 +777,9 @@ static int jzfb_suspend(struct device *dev)
>>  {
>>       struct jzfb *jzfb = dev_get_drvdata(dev);
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(jzfb->fb, 1);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       mutex_lock(&jzfb->lock);
>>       if (jzfb->is_enabled)
>> @@ -800,9 +799,9 @@ static int jzfb_resume(struct device *dev)
>>               jzfb_enable(jzfb);
>>       mutex_unlock(&jzfb->lock);
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(jzfb->fb, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
>> index c89f8a8..da25fa1 100644
>> --- a/drivers/video/mx3fb.c
>> +++ b/drivers/video/mx3fb.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/ioport.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>> -#include <linux/console.h>
>>  #include <linux/clk.h>
>>  #include <linux/mutex.h>
>>
>> @@ -1204,9 +1203,9 @@ static int mx3fb_suspend(struct platform_device
>> *pdev, pm_message_t state)
>>       struct mx3fb_data *mx3fb = platform_get_drvdata(pdev);
>>       struct mx3fb_info *mx3_fbi = mx3fb->fbi->par;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(mx3fb->fbi, 1);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       if (mx3_fbi->blank = FB_BLANK_UNBLANK) {
>>               sdc_disable_channel(mx3_fbi);
>> @@ -1229,9 +1228,9 @@ static int mx3fb_resume(struct platform_device *pdev)
>>               sdc_set_brightness(mx3fb, mx3fb->backlight_level);
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(mx3fb->fbi, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
>> index fe13ac5..f47eb2a 100644
>> --- a/drivers/video/nvidia/nvidia.c
>> +++ b/drivers/video/nvidia/nvidia.c
>> @@ -19,7 +19,6 @@
>>  #include <linux/fb.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> -#include <linux/console.h>
>>  #include <linux/backlight.h>
>>  #ifdef CONFIG_MTRR
>>  #include <asm/mtrr.h>
>> @@ -1057,7 +1056,7 @@ static int nvidiafb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>
>>       if (mesg.event = PM_EVENT_PRETHAW)
>>               mesg.event = PM_EVENT_FREEZE;
>> -     console_lock();
>> +     fb_console_lock();
>>       par->pm_state = mesg.event;
>>
>>       if (mesg.event & PM_EVENT_SLEEP) {
>> @@ -1070,7 +1069,7 @@ static int nvidiafb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>       }
>>       dev->dev.power.power_state = mesg;
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>
>> @@ -1079,7 +1078,7 @@ static int nvidiafb_resume(struct pci_dev *dev)
>>       struct fb_info *info = pci_get_drvdata(dev);
>>       struct nvidia_par *par = info->par;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       pci_set_power_state(dev, PCI_D0);
>>
>>       if (par->pm_state != PM_EVENT_FREEZE) {
>> @@ -1097,7 +1096,7 @@ static int nvidiafb_resume(struct pci_dev *dev)
>>       nvidiafb_blank(FB_BLANK_UNBLANK, info);
>>
>>  fail:
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>  #else
>> diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
>> index 213fbbc..cb2e174 100644
>> --- a/drivers/video/ps3fb.c
>> +++ b/drivers/video/ps3fb.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/string.h>
>>  #include <linux/mm.h>
>>  #include <linux/interrupt.h>
>> -#include <linux/console.h>
>>  #include <linux/ioctl.h>
>>  #include <linux/kthread.h>
>>  #include <linux/freezer.h>
>> @@ -515,7 +514,7 @@ static int ps3fb_release(struct fb_info *info, int user)
>>                       atomic_set(&ps3fb.ext_flip, 0);
>>                       if (console_trylock()) {
>>                               ps3fb_sync(info, 0);    /* single buffer */
>> -                             console_unlock();
>> +                             fb_console_unlock();
>>                       }
>>               }
>>       }
>> @@ -830,14 +829,14 @@ static int ps3fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>                       if (vmode) {
>>                               var = info->var;
>>                               fb_videomode_to_var(&var, vmode);
>> -                             console_lock();
>> +                             fb_console_lock();
>>                               info->flags |= FBINFO_MISC_USEREVENT;
>>                               /* Force, in case only special bits changed */
>>                               var.activate |= FB_ACTIVATE_FORCE;
>>                               par->new_mode_id = val;
>>                               retval = fb_set_var(info, &var);
>>                               info->flags &= ~FBINFO_MISC_USEREVENT;
>> -                             console_unlock();
>> +                             fb_console_unlock();
>>                       }
>>                       break;
>>               }
>> @@ -881,9 +880,9 @@ static int ps3fb_ioctl(struct fb_info *info,
>> unsigned int cmd,
>>                       break;
>>
>>               dev_dbg(info->device, "PS3FB_IOCTL_FSEL:%d\n", val);
>> -             console_lock();
>> +             fb_console_lock();
>>               retval = ps3fb_sync(info, val);
>> -             console_unlock();
>> +             fb_console_unlock();
>>               break;
>>
>>       default:
>> @@ -903,9 +902,9 @@ static int ps3fbd(void *arg)
>>               set_current_state(TASK_INTERRUPTIBLE);
>>               if (ps3fb.is_kicked) {
>>                       ps3fb.is_kicked = 0;
>> -                     console_lock();
>> +                     fb_console_lock();
>>                       ps3fb_sync(info, 0);    /* single buffer */
>> -                     console_unlock();
>> +                     fb_console_unlock();
>>               }
>>               schedule();
>>       }
>> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
>> index 3f90255..a1af212 100644
>> --- a/drivers/video/pxafb.c
>> +++ b/drivers/video/pxafb.c
>> @@ -54,7 +54,6 @@
>>  #include <linux/mutex.h>
>>  #include <linux/kthread.h>
>>  #include <linux/freezer.h>
>> -#include <linux/console.h>
>>
>>  #include <mach/hardware.h>
>>  #include <asm/io.h>
>> @@ -733,9 +732,9 @@ static int overlayfb_open(struct fb_info *info, int user)
>>
>>       if (ofb->usage++ = 0) {
>>               /* unblank the base framebuffer */
>> -             console_lock();
>> +             fb_console_lock();
>>               fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
>> -             console_unlock();
>> +             fb_console_unlock();
>>       }
>>
>>       return 0;
>> diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
>> index 1d00736..7759c82 100644
>> --- a/drivers/video/s3fb.c
>> +++ b/drivers/video/s3fb.c
>> @@ -22,7 +22,6 @@
>>  #include <linux/svga.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> -#include <linux/console.h> /* Why should fb driver call console
>> functions? because console_lock() */
>>  #include <video/vga.h>
>>
>>  #include <linux/i2c.h>
>> @@ -1445,12 +1444,12 @@ static int s3_pci_suspend(struct pci_dev* dev,
>> pm_message_t state)
>>
>>       dev_info(info->device, "suspend\n");
>>
>> -     console_lock();
>> +     fb_fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return 0;
>>       }
>>
>> @@ -1461,7 +1460,7 @@ static int s3_pci_suspend(struct pci_dev* dev,
>> pm_message_t state)
>>       pci_set_power_state(dev, pci_choose_state(dev, state));
>>
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -1477,12 +1476,12 @@ static int s3_pci_resume(struct pci_dev* dev)
>>
>>       dev_info(info->device, "resume\n");
>>
>> -     console_lock();
>> +     fb_fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if (par->ref_count = 0) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return 0;
>>       }
>>
>> @@ -1491,7 +1490,7 @@ static int s3_pci_resume(struct pci_dev* dev)
>>       err = pci_enable_device(dev);
>>       if (err) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               dev_err(info->device, "error %d enabling device for resume\n", err);
>>               return err;
>>       }
>> @@ -1501,7 +1500,7 @@ static int s3_pci_resume(struct pci_dev* dev)
>>       fb_set_suspend(info, 0);
>>
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/savage/savagefb_driver.c
>> b/drivers/video/savage/savagefb_driver.c
>> index 0d0f52c..bf64221 100644
>> --- a/drivers/video/savage/savagefb_driver.c
>> +++ b/drivers/video/savage/savagefb_driver.c
>> @@ -51,7 +51,6 @@
>>  #include <linux/fb.h>
>>  #include <linux/pci.h>
>>  #include <linux/init.h>
>> -#include <linux/console.h>
>>
>>  #include <asm/io.h>
>>  #include <asm/irq.h>
>> @@ -2391,7 +2390,7 @@ static int savagefb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>       if (mesg.event = PM_EVENT_FREEZE)
>>               return 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(info, 1);
>>
>>       if (info->fbops->fb_sync)
>> @@ -2403,7 +2402,7 @@ static int savagefb_suspend(struct pci_dev *dev,
>> pm_message_t mesg)
>>       pci_save_state(dev);
>>       pci_disable_device(dev);
>>       pci_set_power_state(dev, pci_choose_state(dev, mesg));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -2427,7 +2426,7 @@ static int savagefb_resume(struct pci_dev* dev)
>>               return 0;
>>       }
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       pci_set_power_state(dev, PCI_D0);
>>       pci_restore_state(dev);
>> @@ -2441,7 +2440,7 @@ static int savagefb_resume(struct pci_dev* dev)
>>       savagefb_set_par(info);
>>       fb_set_suspend(info, 0);
>>       savagefb_blank(FB_BLANK_UNBLANK, info);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
>> index 699487c..2bc1119 100644
>> --- a/drivers/video/sh_mobile_lcdcfb.c
>> +++ b/drivers/video/sh_mobile_lcdcfb.c
>> @@ -11,7 +11,6 @@
>>  #include <linux/atomic.h>
>>  #include <linux/backlight.h>
>>  #include <linux/clk.h>
>> -#include <linux/console.h>
>>  #include <linux/ctype.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/delay.h>
>> @@ -575,7 +574,7 @@ static int sh_mobile_lcdc_display_notify(struct
>> sh_mobile_lcdc_chan *ch,
>>       case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
>>               /* HDMI plug in */
>>               if (lock_fb_info(info)) {
>> -                     console_lock();
>> +                     fb_console_lock();
>>
>>                       ch->display.width = monspec->max_x * 10;
>>                       ch->display.height = monspec->max_y * 10;
>> @@ -594,7 +593,7 @@ static int sh_mobile_lcdc_display_notify(struct
>> sh_mobile_lcdc_chan *ch,
>>                               fb_set_suspend(info, 0);
>>                       }
>>
>> -                     console_unlock();
>> +                     fb_console_unlock();
>>                       unlock_fb_info(info);
>>               }
>>               break;
>> @@ -602,9 +601,9 @@ static int sh_mobile_lcdc_display_notify(struct
>> sh_mobile_lcdc_chan *ch,
>>       case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
>>               /* HDMI disconnect */
>>               if (lock_fb_info(info)) {
>> -                     console_lock();
>> +                     fb_console_lock();
>>                       fb_set_suspend(info, 1);
>> -                     console_unlock();
>> +                     fb_console_unlock();
>>                       unlock_fb_info(info);
>>               }
>>               break;
>> @@ -1934,9 +1933,9 @@ static int sh_mobile_lcdc_release(struct fb_info
>> *info, int user)
>>
>>       /* Nothing to reconfigure, when called from fbcon */
>>       if (user) {
>> -             console_lock();
>> +             fb_console_lock();
>>               sh_mobile_fb_reconfig(info);
>> -             console_unlock();
>> +             fb_console_unlock();
>>       }
>>
>>       mutex_unlock(&ch->open_lock);
>> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
>> index 3690eff..536f922 100644
>> --- a/drivers/video/sm501fb.c
>> +++ b/drivers/video/sm501fb.c
>> @@ -28,7 +28,6 @@
>>  #include <linux/wait.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/clk.h>
>> -#include <linux/console.h>
>>  #include <linux/io.h>
>>
>>  #include <asm/uaccess.h>
>> @@ -2104,9 +2103,9 @@ static int sm501fb_suspend_fb(struct sm501fb_info *info,
>>
>>       /* tell console/fb driver we are suspending */
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(fbi, 1);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       /* backup copies in case chip is powered down over suspend */
>>
>> @@ -2163,9 +2162,9 @@ static void sm501fb_resume_fb(struct sm501fb_info *info,
>>               memcpy_toio(par->cursor.k_addr, par->store_cursor,
>>                           par->cursor.size);
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(fbi, 0);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       vfree(par->store_fb);
>>       vfree(par->store_cursor);
>> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
>> index 8e4a446..e266b6b 100644
>> --- a/drivers/video/tmiofb.c
>> +++ b/drivers/video/tmiofb.c
>> @@ -25,8 +25,7 @@
>>  #include <linux/fb.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>> -/* Why should fb driver call console functions? because console_lock() */
>> -#include <linux/console.h>
>> +/* Why should fb driver call console functions? because fb_console_lock() */
>>  #include <linux/mfd/core.h>
>>  #include <linux/mfd/tmio.h>
>>  #include <linux/uaccess.h>
>> @@ -938,7 +937,7 @@ static int tmiofb_suspend(struct platform_device
>> *dev, pm_message_t state)
>>       const struct mfd_cell *cell = mfd_get_cell(dev);
>>       int retval = 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       fb_set_suspend(info, 1);
>>
>> @@ -959,7 +958,7 @@ static int tmiofb_suspend(struct platform_device
>> *dev, pm_message_t state)
>>       if (cell->suspend)
>>               retval = cell->suspend(dev);
>>
>> -     console_unlock();
>> +     fb_fb_console_unlock();
>>
>>       return retval;
>>  }
>> @@ -970,7 +969,7 @@ static int tmiofb_resume(struct platform_device *dev)
>>       const struct mfd_cell *cell = mfd_get_cell(dev);
>>       int retval = 0;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>
>>       if (cell->resume) {
>>               retval = cell->resume(dev);
>> @@ -986,7 +985,7 @@ static int tmiofb_resume(struct platform_device *dev)
>>
>>       fb_set_suspend(info, 0);
>>  out:
>> -     console_unlock();
>> +     fb_fb_console_unlock();
>>       return retval;
>>  }
>>  #else
>> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
>> index c80e770..d36b173 100644
>> --- a/drivers/video/via/viafbdev.c
>> +++ b/drivers/video/via/viafbdev.c
>> @@ -1698,17 +1698,17 @@ static int parse_mode(const char *str, u32
>> devices, u32 *xres, u32 *yres)
>>  #ifdef CONFIG_PM
>>  static int viafb_suspend(void *unused)
>>  {
>> -     console_lock();
>> +     fb_console_lock();
>>       fb_set_suspend(viafbinfo, 1);
>>       viafb_sync(viafbinfo);
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>>
>>  static int viafb_resume(void *unused)
>>  {
>> -     console_lock();
>> +     fb_console_lock();
>>       if (viaparinfo->shared->vdev->engine_mmio)
>>               viafb_reset_engine(viaparinfo);
>>       viafb_set_par(viafbinfo);
>> @@ -1716,7 +1716,7 @@ static int viafb_resume(void *unused)
>>               viafb_set_par(viafbinfo1);
>>       fb_set_suspend(viafbinfo, 0);
>>
>> -     console_unlock();
>> +     fb_console_unlock();
>>       return 0;
>>  }
>>
>> diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
>> index 4e74d26..cb48d4d 100644
>> --- a/drivers/video/vt8623fb.c
>> +++ b/drivers/video/vt8623fb.c
>> @@ -23,7 +23,6 @@
>>  #include <linux/svga.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> -#include <linux/console.h> /* Why should fb driver call console
>> functions? because console_lock() */
>>  #include <video/vga.h>
>>
>>  #ifdef CONFIG_MTRR
>> @@ -845,12 +844,12 @@ static int vt8623_pci_suspend(struct pci_dev*
>> dev, pm_message_t state)
>>
>>       dev_info(info->device, "suspend\n");
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if ((state.event = PM_EVENT_FREEZE) || (par->ref_count = 0)) {
>>               mutex_unlock(&(par->open_lock));
>> -             console_unlock();
>> +             fb_console_unlock();
>>               return 0;
>>       }
>>
>> @@ -861,7 +860,7 @@ static int vt8623_pci_suspend(struct pci_dev* dev,
>> pm_message_t state)
>>       pci_set_power_state(dev, pci_choose_state(dev, state));
>>
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> @@ -876,7 +875,7 @@ static int vt8623_pci_resume(struct pci_dev* dev)
>>
>>       dev_info(info->device, "resume\n");
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       mutex_lock(&(par->open_lock));
>>
>>       if (par->ref_count = 0)
>> @@ -895,7 +894,7 @@ static int vt8623_pci_resume(struct pci_dev* dev)
>>
>>  fail:
>>       mutex_unlock(&(par->open_lock));
>> -     console_unlock();
>> +     fb_console_unlock();
>>
>>       return 0;
>>  }
>> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
>> index b7f5173..770397e7 100644
>> --- a/drivers/video/xen-fbfront.c
>> +++ b/drivers/video/xen-fbfront.c
>> @@ -18,7 +18,6 @@
>>   * frame buffer.
>>   */
>>
>> -#include <linux/console.h>
>>  #include <linux/kernel.h>
>>  #include <linux/errno.h>
>>  #include <linux/fb.h>
>> @@ -495,12 +494,12 @@ xenfb_make_preferred_console(void)
>>       if (console_set_on_cmdline)
>>               return;
>>
>> -     console_lock();
>> +     fb_console_lock();
>>       for_each_console(c) {
>>               if (!strcmp(c->name, "tty") && c->index = 0)
>>                       break;
>>       }
>> -     console_unlock();
>> +     fb_console_unlock();
>>       if (c) {
>>               unregister_console(c);
>>               c->flags |= CON_CONSDEV;
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index ac3f1c6..7ae96ad 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -1021,6 +1021,8 @@ extern int fb_get_color_depth(struct
>> fb_var_screeninfo *var,
>>                             struct fb_fix_screeninfo *fix);
>>  extern int fb_get_options(char *name, char **option);
>>  extern int fb_new_modelist(struct fb_info *info);
>> +extern void fb_console_unlock(void);
>> +extern void fb_console_lock(void);
>>
>>  extern struct fb_info *registered_fb[FB_MAX];
>>  extern int num_registered_fb;
>
>
