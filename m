From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] eink_apollofb: new driver for
	Apollo eInk controller.
Date: Sat, 12 Jul 2008 19:20:13 -0700
Message-ID: <20080712192013.1fb9519b.akpm@linux-foundation.org>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KHrCK-0000hu-Ks for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 19:20:24 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KHrCI-0006cC-Qb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 19:20:24 -0700
In-Reply-To: <1215788071-25764-2-git-send-email-jekhor@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 11 Jul 2008 17:54:31 +0300 Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> Add a new driver for eInk Apollo controller. This
> controller is used in various bookreaders with eInk
> displays.
> 
> The eink_apollofb driver supports many features of
> Apollo chip, in difference with the hecubafb driver:
> 2-bit color depth, partial picture loading, flash
> read/write.
> 
> The driver uses platform_device framework for
> platform-specific functions (set values of control
> lines, read/write data from/to bus etc.) and can be
> used on any platform.
> 
> This driver has been developed for the OpenInkpot
> project (http://openinkpot.org/).

Please copy linux-fbdev-devel on fbdev patches.

Please consider adding a MAINTAINERS record when adding new drivers.

checkpatch correctly warns:

WARNING: consider using strict_strtoul in preference to simple_strtoul
#703: FILE: drivers/video/eink_apollofb.c:573:
+	unsigned long state = simple_strtoul(buf, &after, 10);

WARNING: consider using strict_strtoul in preference to simple_strtoul
#734: FILE: drivers/video/eink_apollofb.c:604:
+	unsigned long state = simple_strtoul(buf, &after, 10);

WARNING: consider using strict_strtoul in preference to simple_strtoul
#773: FILE: drivers/video/eink_apollofb.c:643:
+	unsigned long state = simple_strtoul(buf, &after, 10);

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index e0c5f96..ad23464 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -718,6 +718,23 @@ config FB_N411
>           This enables support for the Apollo display controller in its
>           Hecuba form using the n411 devkit.
>  
> +config FB_EINK_APOLLO
> +       tristate "Apollo eInk display controller support"
> +       depends on EXPERIMENTAL && FB && MMU
> +       select FB_SYS_FILLRECT
> +       select FB_SYS_COPYAREA
> +       select FB_SYS_IMAGEBLIT
> +       select FB_SYS_FOPS
> +       select FB_DEFERRED_IO
> +       help
> +         This enables support for Apollo eInk display controller.
> +	 Includes support of deferred IO and 2-bit grayscale mode.

Whitespace inconsistency there, which I will fix.

>
> ...
>
> +/* Display specific information */
> +#define DPY_W 600
> +#define DPY_H 800
> +
> +#define is_portrait(var) (!(var.rotate % 180))

Could be implemented in a C function.

>
> ...
>
> +static inline int apollo_wait_for_ack_value(struct apollofb_par *par,
> +		unsigned int value)
> +{
> +	unsigned long timeout = jiffies + 2 * HZ;
> +
> +	while ((par->ops->get_ctl_pin(H_ACK) != value) &&
> +			time_before(jiffies, timeout))
> +		schedule();
> +
> +	if (par->ops->get_ctl_pin(H_ACK) != value) {
> +		printk(KERN_ERR "%s: Wait for H_ACK == %u, timeout\n",
> +				__func__, value);
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Is a busy-wait unavoidable here?

Are you sure this function is never called from atomic context?

This function is far too large to inline.  I'll fix that.

> +#define apollo_wait_for_ack(par)	apollo_wait_for_ack_value(par, 0)
> +#define apollo_wait_for_ack_clear(par)	apollo_wait_for_ack_value(par, 1)

Could be implemented as C functions.

> +static int apollo_send_data(struct apollofb_par *par, unsigned char data)
> +{
> +	int res = 0;;
> +
> +	par->ops->write_value(data);
> +	par->ops->set_ctl_pin(H_DS, 0);
> +	res = apollo_wait_for_ack(par);
> +	par->ops->set_ctl_pin(H_DS, 1);
> +	if (!res)
> +		apollo_wait_for_ack_clear(par);
> +	return res;
> +}
> +
> +

extra newline

>
> ...
>
> +static void apollofb_apollo_update_part(struct apollofb_par *par,
> +		unsigned int x1, unsigned int y1,
> +		unsigned int x2, unsigned int y2)
> +{
> +	int i, j, k;
> +	struct fb_info *info = par->info;
> +	unsigned int width = is_portrait(info->var) ? info->var.xres :
> +							info->var.yres;
> +	unsigned int bpp = info->var.green.length;
> +	unsigned int pixels_in_byte = 8 / bpp;
> +	unsigned char *buf = (unsigned char __force *)info->screen_base;
> +	unsigned char tmp, mask;
> +
> +	y1 -= y1 % 4;
> +
> +	if ((y2 + 1) % 4)
> +		y2 += 4 - ((y2 + 1) % 4);
> +
> +	x1 -= x1 % 4;
> +
> +	if ((x2 + 1) % 4)
> +		x2 += 4 - ((x2 + 1) % 4);
> +
> +	mask = 0;
> +	for (i = 0; i < bpp; i++)
> +		mask = (mask << 1) | 1;

I think this is this equivalent to

	(1 << bpp) - 1

> +	mutex_lock(&par->lock);
> +
> +	if (par->current_mode == APOLLO_STATUS_MODE_SLEEP)
> +		apollo_set_normal_mode(par);
> +
> +	if (par->options.manual_refresh)
> +		apollo_send_command(par, APOLLO_MANUAL_REFRESH);
> +
> +	apollo_send_command(par, APOLLO_LOAD_PARTIAL_PICTURE);
> +	apollo_send_data(par, (x1 >> 8) & 0xff);
> +	apollo_send_data(par, x1 & 0xff);
> +	apollo_send_data(par, (y1 >> 8) & 0xff);
> +	apollo_send_data(par, y1 & 0xff);
> +	apollo_send_data(par, (x2 >> 8) & 0xff);
> +	apollo_send_data(par, x2 & 0xff);
> +	apollo_send_data(par, (y2 >> 8) & 0xff);
> +	apollo_send_data(par, y2 & 0xff);
> +
> +	k = 0;
> +	tmp = 0;
> +	for (i = y1; i <= y2; i++)
> +		for (j = x1; j <= x2; j++) {
> +			tmp = (tmp << bpp) | (buf[i * width + j] & mask);
> +			k++;
> +			if (k % pixels_in_byte == 0)
> +				apollo_send_data(par, tmp);
> +		}
> +
> +	apollo_send_command(par, APOLLO_STOP_LOADING);
> +	apollo_send_command(par, APOLLO_DISPLAY_PARTIAL_PICTURE);
> +
> +	if (par->options.use_sleep_mode)
> +		apollo_set_sleep_mode(par);
> +
> +	mutex_unlock(&par->lock);
> +}
> +
> +/* this is called back from the deferred io workqueue */
> +static void apollofb_dpy_deferred_io(struct fb_info *info,
> +				struct list_head *pagelist)
> +{
> +
> +	struct apollofb_par *par = info->par;
> +	unsigned int width = is_portrait(info->var) ? info->var.xres :
> +							info->var.yres;
> +	unsigned int height = is_portrait(info->var) ? info->var.yres :
> +							info->var.xres;
> +	unsigned long int start_page = -1, end_page = -1;
> +	unsigned int y1 = 0, y2 = 0;
> +	struct page *cur;
> +
> +

extra newline

> +	list_for_each_entry(cur, pagelist, lru) {
> +		if (start_page == -1) {
> +			start_page = cur->index;
> +			end_page = cur->index;
> +			continue;
> +		}
> +
> +		if (cur->index == end_page + 1) {
> +			end_page++;
> +		} else {
> +			y1 = start_page * PAGE_SIZE / width;
> +			y2 = ((end_page + 1) * PAGE_SIZE - 1) / width;
> +			if (y2 >= height)
> +				y2 = height - 1;
> +
> +			apollofb_apollo_update_part(par, 0, y1, width - 1, y2);
> +
> +			start_page = cur->index;
> +			end_page = cur->index;
> +		}
> +	}
> +
> +	y1 = start_page * PAGE_SIZE / width;
> +	y2 = ((end_page + 1) * PAGE_SIZE - 1) / width;
> +	if (y2 >= height)
> +		y2 = height - 1;
> +
> +	apollofb_apollo_update_part(par, 0, y1,	width - 1, y2);
> +}
> +
>
> ...
>
>
> +static void apollofb_imageblit(struct fb_info *info,
> +				const struct fb_image *image)
> +{
> +	struct apollofb_par *par = info->par;
> +
> +	sys_imageblit(info, image);
> +
> +	schedule_delayed_work(&par->deferred_work, info->fbdefio->delay);
> +}

hrm.  The sys_foo namespace is normally for system calls.  Looks like
the fbdev layer has been involved in a bit of namespace piracy.

> +int apollofb_cursor(struct fb_info *info, struct fb_cursor *cursor)
> +{
> +	return 0;
> +}

I made this static.

> +/*
> + * this is the slow path from userspace. they can seek and write to
> + * the fb. it's inefficient to do anything less than a full screen draw
> + */
> +static ssize_t apollofb_write(struct fb_info *info, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	unsigned long p;
> +	int err = -EINVAL;
> +	struct apollofb_par *par;
> +	unsigned int xres;
> +	unsigned int fbmemlength;
> +
> +	p = *ppos;
> +	par = info->par;
> +	xres = info->var.xres;
> +	fbmemlength = (xres * info->var.yres)/8 * info->var.bits_per_pixel;
> +
> +	if (p > fbmemlength)
> +		return -ENOSPC;
> +
> +	err = 0;
> +	if ((count + p) > fbmemlength) {
> +		count = fbmemlength - p;
> +		err = -ENOSPC;
> +	}

ENOSPC is "ran out of disk space".  It's a bit weird to use it here. 
EINVAL would make more sense?

> +	if (count) {
> +		char *base_addr;
> +
> +		base_addr = (char __force *)info->screen_base;
> +		count -= copy_from_user(base_addr + p, buf, count);
> +		*ppos += count;
> +		err = -EFAULT;
> +	}
> +
> +	schedule_delayed_work(&par->deferred_work, info->fbdefio->delay);
> +
> +	if (count)
> +		return count;
> +
> +	return err;
> +}
> +
>
> ...
>
> +static ssize_t apollofb_temperature_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +	char temp;
> +
> +	mutex_lock(&par->lock);
> +
> +	apollo_send_command(par, APOLLO_READ_TEMPERATURE);
> +
> +	temp = apollo_read_data(par);
> +
> +	mutex_unlock(&par->lock);
> +
> +	sprintf(buf, "%d\n", temp);
> +	return strlen(buf) + 1;

I think

	return sprintf(buf, "%d\n", temp);

would work here.  Not sure about the accounting of the trailing \0.

> +}
> +
> +static ssize_t apollofb_manual_refresh_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +
> +	sprintf(buf, "%d\n", par->options.manual_refresh);
> +	return strlen(buf) + 1;

ditto.

> +}
> +
> +static ssize_t apollofb_manual_refresh_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +	char *after;
> +	unsigned long state = simple_strtoul(buf, &after, 10);
> +	size_t count = after - buf;
> +	ssize_t ret = -EINVAL;
> +
> +	if (*after && isspace(*after))
> +		count++;
> +
> +	if ((count == size) && (state <= 1)) {
> +		ret = count;
> +		par->options.manual_refresh = state;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t apollofb_use_sleep_mode_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +
> +	sprintf(buf, "%d\n", par->options.use_sleep_mode);
> +	return strlen(buf) + 1;

tritto

> +}
> +
> +static ssize_t apollofb_use_sleep_mode_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +	char *after;
> +	unsigned long state = simple_strtoul(buf, &after, 10);
> +	size_t count = after - buf;
> +	ssize_t ret = -EINVAL;
> +
> +	if (*after && isspace(*after))
> +		count++;
> +
> +	if ((count == size) && (state <= 1)) {
> +		ret = count;
> +		par->options.use_sleep_mode = state;
> +
> +		mutex_lock(&par->lock);
> +
> +		if (state)
> +			apollo_set_sleep_mode(par);
> +		else
> +			apollo_set_normal_mode(par);
> +
> +		mutex_unlock(&par->lock);
> +
> +	}
> +
> +	return ret;
> +}

Is this usersapce interface documented anywhere?


> +static ssize_t apollofb_defio_delay_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +
> +	sprintf(buf, "%lu\n", info->fbdefio->delay * 1000 / HZ);
> +	return strlen(buf) + 1;

whatever comes after tritto ;)

> +}
> +
> +static ssize_t apollofb_defio_delay_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +	char *after;
> +	unsigned long state = simple_strtoul(buf, &after, 10);
> +	size_t count = after - buf;
> +	ssize_t ret = -EINVAL;
> +
> +	if (*after && isspace(*after))
> +		count++;
> +
> +	state = state * HZ / 1000;
> +
> +	if (!state)
> +		state = 1;
> +
> +	if (count == size) {
> +		ret = count;
> +		info->fbdefio->delay = state;
> +	}
> +
> +	return ret;
> +}

See, there might be simpler ways of doing all this string parsing.  But
there's no description of what it's doing and I can't be bothered
reverse-engineering it.

> +static void apollofb_remove_chrdev(struct apollofb_par *par)
> +{
> +	cdev_del(&par->cdev);
> +	unregister_chrdev_region(par->cdev.dev, 1);
> +}

It creates a chardev as well?  Please, these things must be documented
_at least_ in the changelog.  Fully.

> +static u16 red4[] __read_mostly = {
> +    0x0000, 0x5555, 0xaaaa, 0xffff
> +};
> +static u16 green4[] __read_mostly = {
> +    0x0000, 0x5555, 0xaaaa, 0xffff
> +};
> +static u16 blue4[] __read_mostly = {
> +    0x0000, 0x5555, 0xaaaa, 0xffff
> +};
> +
>
> ...
>
> +static int __devexit apollofb_remove(struct platform_device *dev)
> +{
> +	struct fb_info *info = platform_get_drvdata(dev);
> +	struct apollofb_par *par = info->par;
> +
> +	if (info) {
> +		fb_deferred_io_cleanup(info);
> +		cancel_delayed_work(&par->deferred_work);
> +		flush_scheduled_work();

I suspect cancel_delayed_work_sync() would suffice here.

> +		device_remove_file(info->dev, &dev_attr_use_sleep_mode);
> +		device_remove_file(info->dev, &dev_attr_manual_refresh);
> +		device_remove_file(info->dev, &dev_attr_defio_delay);
> +		device_remove_file(info->dev, &dev_attr_temperature);
> +		unregister_framebuffer(info);
> +		vfree((void __force *)info->screen_base);
> +		apollofb_remove_chrdev(info->par);
> +		framebuffer_release(info);
> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int apollofb_suspend(struct platform_device *pdev, pm_message_t message)
> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +	struct apollofb_par *par = info->par;
> +
> +	mutex_lock(&par->lock);
> +	apollo_send_command(par, APOLLO_STANDBY_MODE);
> +	par->current_mode = APOLLO_STATUS_MODE_SLEEP;
> +	mutex_unlock(&par->lock);
> +
> +	return 0;
> +}
> +
> +static int apollofb_resume(struct platform_device *pdev)
> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +	struct apollofb_par *par = info->par;
> +
> +	mutex_lock(&par->lock);
> +	apollo_wakeup(par);
> +	if (!par->options.use_sleep_mode)
> +		apollo_set_normal_mode(par);
> +	mutex_unlock(&par->lock);
> +
> +	return 0;
> +}

Please put

#else
#define apollofb_suspend NULL
#define apollofb_resume NULL

here

> +#endif
> +
> +
> +static struct platform_driver apollofb_driver = {
> +	.probe	= apollofb_probe,
> +	.remove = apollofb_remove,
> +	.driver	= {
> +		.owner	= THIS_MODULE,
> +		.name	= "eink-apollo",
> +	},
> +#ifdef CONFIG_PM
> +	.suspend = apollofb_suspend,
> +	.resume = apollofb_resume,
> +#endif

and remove these ifdefs.  For consistency, and it saves an ifdef.

> +};
> +
> +static int __init apollofb_init(void)
> +{
> +	int ret = 0;

Unneeded initialization

> +
> +	ret = platform_driver_register(&apollofb_driver);
> +
> +	return ret;
> +}

Plain old

	return platform_driver_register(&apollofb_driver);

would suffice?

> +static void __exit apollofb_exit(void)
> +{
> +	platform_driver_unregister(&apollofb_driver);
> +}
> +
> +


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
