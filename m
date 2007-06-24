From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 3/4] fbdev: uvesafb driver
Date: Sun, 24 Jun 2007 12:50:31 +0900
Message-ID: <20070624035031.GA4041@APFDCB5C>
References: <20070623105243.GD12623@spock.one.pl>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755167AbXFXD73@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070623105243.GD12623@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> +static int uvesafb_blank(int blank, struct fb_info *info)
> +{
> +	struct uvesafb_par *par = info->par;
> +	struct uvesafb_ktask *task;
> +	int err = 1;
> +
> +	if (par->vbe_ib.capabilities & VBE_CAP_VGACOMPAT) {
> +		int loop = 10000;
> +		u8 seq = 0, crtc17 = 0;
> +
> +		if (blank == FB_BLANK_POWERDOWN) {
> +			seq = 0x20;
> +			crtc17 = 0x00;
> +			err = 0;
> +		} else {
> +			seq = 0x00;
> +			crtc17 = 0x80;
> +			err = (blank == FB_BLANK_UNBLANK) ? 0 : -EINVAL;
> +		}
> +
> +		vga_wseq(NULL, 0x00, 0x01);
> +		seq |= vga_rseq(NULL, 0x01) & ~0x20;
> +		vga_wseq(NULL, 0x00, seq);
> +
> +		crtc17 |= vga_rcrt(NULL, 0x17) & ~0x80;
> +		while (loop--);
> +		vga_wcrt(NULL, 0x17, crtc17);
> +		vga_wseq(NULL, 0x00, 0x03);
> +	} else {
> +		task = uvesafb_prep();
> +		if (!task)
> +			return -ENOMEM;
> +
> +		task->t.regs.eax = 0x4f10;
> +		switch (blank) {
> +		case FB_BLANK_UNBLANK:
> +			task->t.regs.ebx = 0x0001;
> +			break;
> +		case FB_BLANK_NORMAL:
> +			task->t.regs.ebx = 0x0101;	/* standby */
> +			break;
> +		case FB_BLANK_POWERDOWN:
> +			task->t.regs.ebx = 0x0401;	/* powerdown */
> +			break;
> +		default:
> +			goto out;
> +		}
> +		task->t.flags = 0;
> +
> +		err = uvesafb_exec(task);
> +		if (!err && (task->t.regs.eax & 0xffff) == 0x004f)
> +			err = 0;

There is no effect to this assignment.

	if (!err && ... )
		err = 0;

> +out:		uvesafb_free(task);
> +	}
> +	return err;
> +}

[...]

> +static int __devinit uvesafb_init(void)
> +{
> +	int err;
> +
> +#ifndef MODULE
> +	char *option = NULL;
> +
> +	if (fb_get_options("uvesafb", &option))
> +		return -ENODEV;
> +	uvesafb_setup(option);
> +#endif
> +	err = cn_add_callback(&uvesafb_cn_id, "uvesafb", uvesafb_cn_callback);
> +	if (err)
> +		goto err_out;
> +
> +	err = platform_driver_register(&uvesafb_driver);
> +
> +	if (!err) {
> +		uvesafb_device = platform_device_alloc("uvesafb", 0);
> +		if (uvesafb_device)
> +			err = platform_device_add(uvesafb_device);
> +		else
> +			err = -ENOMEM;
> +
> +		if (err) {
> +			platform_device_put(uvesafb_device);
> +			platform_driver_unregister(&uvesafb_driver);

Initialization failed. It should return from this function here.
Otherwise it will attempt to call driver_create_file() with unregistered
driver below.

And you forgot to put:
			cn_del_callback(&uvesafb_cn_id);

> +		}
> +
> +		err = driver_create_file(&uvesafb_driver.driver,
> +				&driver_attr_v86d);
> +		if (err) {
> +			printk(KERN_WARNING "uvesafb: failed to register "
> +					"attributes\n");
> +			err = 0;
> +		}
> +	}
> +	return err;
> +
> +err_out:
> +	if (nls && nls->sk_socket)
> +		sock_release(nls->sk_socket);

I can't find any uses of nls in this driver.

> +	return err;
> +}
