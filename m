From: Timur Tabi <timur@freescale.com>
Date: Mon, 21 Nov 2011 16:22:30 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <4ECA7AC6.2080206@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:

>> Any comments on this patch?  If you're okay with the change, I want to take
>> advantage of it in my framebuffer driver.
> 
> Of course you want, otherwise I'd be wondering why you are sending this patch
> at all.

I frequently have to ping maintainers on patches that I've posted.  I've lost count how many times I've been told, "Oh sorry, I forgot all about your patch".

> But I don't see any advantages of your approach. Instead of pointers to fb_info
> with this patch you could embed fb_info directly in your data structure but that
> is barely a difference for a programmer I'd think. You'd still have to call your
> new functions on init/exit so the amount of function calls needed is the same
> with or without the patch (I could see an advantage if alloc and release were
> pure memory allocations). Or is this all about handling the case when fb_alloc
> fails?

It's all about reducing the number of kmalloc calls.  Here's an example of what my per-device data structure looks like:

struct fsl_diu_data {
	dma_addr_t phys;
	struct fb_info fsl_diu_info[NUM_AOIS];	<-----
	struct mfb_info mfb[NUM_AOIS];
	struct device_attribute dev_attr;
	unsigned int irq;
	int fb_enabled;
	enum fsl_diu_monitor_port monitor_port;
	struct diu __iomem *diu_reg;
	spinlock_t reg_lock;
	u8 dummy_aoi[4 * 4 * 4];
	struct diu_ad dummy_ad __aligned(8);
	struct diu_ad ad[NUM_AOIS] __aligned(8);
	u8 gamma[256 * 3] __aligned(32);
	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
} __aligned(32);

So this way, I have all of the memory I need allocated in one spot.  I know need to allocate one block of memory.

> Historically some drivers don't even call alloc but have their own fb_info and
> call only register.

That's exactly the same thing I want to do.  Do these drivers also initialize info->device and info->bl_curve_mutex by themselves?  How would they know if the fb_info structure got new members that also need to be initialized?

Perhaps we need to move the fb_info initialization code from framebuffer_alloc() into register_framebuffer()?  

> I do not want to add yet another way of doing framebuffer
> initialization unless you can clearly show its benefits.

I think the problem is that we already have two ways that framebuffers are initialized.

What do you think about this:


diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 67afa9c..ba47a38 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -57,12 +57,6 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	if (size)
 		info->par = p + fb_info_size;
 
-	info->device = dev;
-
-#ifdef CONFIG_FB_BACKLIGHT
-	mutex_init(&info->bl_curve_mutex);
-#endif
-
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG


diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index ad93629..ea35bf8 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1591,6 +1591,12 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	mutex_init(&fb_info->lock);
 	mutex_init(&fb_info->mm_lock);
 
+	fb_info->device = dev;
+
+#ifdef CONFIG_FB_BACKLIGHT
+	mutex_init(&fb_info->bl_curve_mutex);
+#endif
+
 	fb_info->dev = device_create(fb_class, fb_info->device,
 				     MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
 	if (IS_ERR(fb_info->dev)) {


There are a few instances where drivers use info->device after calling framebuffer_alloc() but before calling register_framebuffer().  These drivers will need to be fixed.  But otherwise, I think this is a good idea.

-- 
Timur Tabi
Linux kernel developer at Freescale

