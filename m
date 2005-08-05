From: James Simmons <jsimmons@infradead.org>
Subject: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch
 added to -mm tree
Date: Fri, 5 Aug 2005 21:15:49 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508052109230.19722@pentafluge.infradead.org>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E18bh-0008O8-Iq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:15:53 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E18bg-0004dj-0U
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:15:53 -0700
In-Reply-To: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jamey@handhelds.org, anpaza@mail.ru, mm-commits@vger.kernel.org


> +struct mq1100fb_info {
> +	/* Framebuffer info */
> +	struct fb_info fb;
> +	/* The link to the base SoC driver */
> +	struct mediaq11xx_base *base;
> +	/* The RGB palette */
> +	struct mq1100fb_rgb palette[256];
> +	/* Notifier block */
> +	struct notifier_block notify;
> +	/* Framebuffer offset inside MediaQ RAM */
> +	u32 fb_addr, fb_size;
> +	/* The pseudo-palette */
> +	u32 pseudo_pal[16];
> +	/* Device instance number (0-7) */
> +	u8 inst;
> +	/* Combination of MQ_Rotate_XXX bits */
> +	u8 rotation;
> +	/* 1 if device is active, 0 if poweroff */
> +	unsigned active:1;
> +	/* 1 if initialization is complete, 0 while it is deferred */
> +	unsigned initcomplete:1;
> +	/* 1 if power is enabled to the MEDIAQ_11XX_FB_DEVICE_ID subdevice */
> +	unsigned poweron:1;
> +};

I recommend you rename that to mq1100_par and remove the struct fb_info in 
there. Its easier to deal with when you will use framebuffer_alloc. 

> +static int mq1100fb_probe (struct device *dev, struct mediaq11xx_base *base)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct fb_info *info;
> +
> +	info = kmalloc (sizeof (struct mq1100fb_info), GFP_KERNEL);
> +	memset (info, 0, sizeof (struct mq1100fb_info));

	info = framebuffer_alloc(sizeof(struct mq1100_par), &pdev->dev);

> +static int mq1100fb_platform_remove (struct device *dev)
> +{
> +	struct fb_info *info =
> +		(struct fb_info *)dev_get_drvdata (dev);
> +
> +	debug_func ("\n");
> +
> +	if (info->active) {
> +		mq1100fb_power (info, 4);
> +		unregister_framebuffer (&info->fb);
> +		info->base->free (info->base, info->fb_addr, info->fb_size);
> +	}
	framebuffer_release(info);
> +	return 0;
> +}



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
