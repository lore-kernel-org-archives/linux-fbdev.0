Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C0161
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Oct 2024 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730027622; cv=none; b=kBfnDmae8XWnoDQmfMfC8DUpwCkyWdyblKL25lGnRLlZeHyH2BHOvdkUmRe+qkBXgvbE/Kfa7cKim3XGZStzO8ahAoQ7YfE2XjGX+z0SnkcOg3IHOtOGRQTnN8XJ6lBHskaeUAUU71oTcNqp+XbhXvQGi0eb9Xm9a2JGXVz7TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730027622; c=relaxed/simple;
	bh=qRKB8qGO5ejLR9Nb41NvKrK49wdjs49N23rbgw+N5hk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=GdCPyDIUHAwkRNvy9vfCOTdsHGmdTmWNy/vRn5nNKGMEzomavQRPe9SZXgf5CAyiEeGKySG1yzhcOPy8Ktw3lBAFIfXq+hjLITecjyBqUQuQfybIasvwgoVXKTumoUILYqzuJyySfijPpxJJ7mOTvebHMU3IrLX9y2ESxW8/nG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3fAsE58; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3fAsE58"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43155afca99so30079285e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Oct 2024 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730027618; x=1730632418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnFtMlKXcqmwSsrnLoYOaoECS4thAPfp/RwKyvQKDbo=;
        b=I3fAsE58gwCAN2LiWDOsEbMQkAg9bEzVh9KqDsiPQwacNicaQj20BZcbXZaQsKWdG+
         Me0rN36bJzny6mAqWt6ZzOeJ9G4a632RLfIIFkiAeGXrtDQrSF7xn/GZaJDtANjSKVcZ
         mO7/L1HgSy/w/bJRzzfDmltsf4itclc8mOJOYHrQl4lKpLXNYrBuY1VByj2+U/+VbqhA
         5LvndHx8NtAcIJYa5SysnVAGudduYmsUAphFnbyTeZJcXYpp7xuzNAwxCzwDj+EgSNxP
         Ycu3/1JVfIa+nxjSrA+Ssgw9nc7YAK8KMhCKycxAbXf34YQqgls0ynn6wP8eASRADGjf
         VX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730027618; x=1730632418;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TnFtMlKXcqmwSsrnLoYOaoECS4thAPfp/RwKyvQKDbo=;
        b=VCnZVEP5zQla8q9JIwabNJp+wMJmtVheFDemRcoBXqd2/Nfx7J4l4pQSHm2AEIi2nO
         yRuX5fFyCvlX8IPHOy4v32aeum7B9CXudKMuiKwqriT7WlTnzSTxe75/tPld1CqhCWw1
         6lcd+v/ewqGesUyOxivFBvUBW6G2J5eS5XgT4FOAT+uAX7KA7Kgj1t5/EORMezV4VYJq
         ULwoCqOodX85MSa6jg93z/TITg810mLZff+H2AUW0l+EeeTN7kLJPH5oFv+6WyX9crh/
         cE4TLPHqj0iGgKUldoP/imOY+/r2jBIDGAEifAI92jWftC314lBrA5WTlk9L7o79eVLL
         L2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9LcnLWDtv0i/6K1P/IcmVNUGFUMZMJ4Pzol/GdGRpRnYeLhxwt4oCDtUAXOfIzEMPMTVxG5BVkw2Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQpatVWmWURtoNayN57Ozact8fxxNK2snf+rzoA8x1dX0Tp3l
	Jsx0MpFMjUceFF7/iIdAPin1V4DRO6/xozJsSv+PfP2mBLPoY8iy
X-Google-Smtp-Source: AGHT+IH4rBUTWTPbUDlItDuvaGpoFeuUiPiVpGCiYRECZFQm48W8Eds3MOiAORx5OW1YJlVLuS7Kzw==
X-Received: by 2002:a05:600c:5127:b0:431:4fbd:f571 with SMTP id 5b1f17b1804b1-4319a5ba253mr38235225e9.13.1730027617874;
        Sun, 27 Oct 2024 04:13:37 -0700 (PDT)
Received: from [192.168.1.138] ([83.165.96.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193594ff3sm71807455e9.12.2024.10.27.04.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 04:13:36 -0700 (PDT)
Message-ID: <0be7bf55-95be-4ff9-98a3-b93fe1f18188@gmail.com>
Date: Sun, 27 Oct 2024 12:13:33 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: gonzalo.silvalde@gmail.com
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev: udl: Make CONFIG_FB_DEVICE optional
References: <20241025092538.38339-1-gonzalo.silvalde@gmail.com>
 <7aabca78-dd34-4819-8a63-105d1a4cb4ba@gmx.de>
In-Reply-To: <7aabca78-dd34-4819-8a63-105d1a4cb4ba@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helge,

Thank you for your feedback.

I understand the concern about the amount of #ifdefs. I’ll review the code to see if there are other ways to handle the conditional dependencies, perhaps by using fb_dbg() or similar, as you suggested. I agree that keeping readability is important, and I’ll explore options to simplify this.

Regarding the reason for removing CONFIG_FB_DEVICE, my understanding is that this would allow the driver to be more flexible without that configuration in certain cases, as mentioned in the GPU TODO [1]. Thomas mentioned I could approach this driver with that in mind. However, if there’s a native DRM driver available that manages this device better, I could focus on other drivers instead.

Would you then recommend that I work on drivers without native DRM support for this kind of task? I’d appreciate any specific suggestions on the approach here.

Best regards,
Gonzalo Silvalde Blanco

[1] https://elixir.bootlin.com/linux/v6.11/source/Documentation/gpu/todo.rst#L459

On 25/10/24 17:37, Helge Deller <deller@gmx.de> wrote:
> On 10/25/24 11:25, Gonzalo Silvalde Blanco wrote:
> > The fb_udl driver currently depends on CONFIG_FB_DEVICE to create sysfs
> > entries and access framebuffer device information. This patch wraps the
> > relevant code blocks with #ifdef CONFIG_FB_DEVICE, allowing the driver to
> > be built and used even if CONFIG_FB_DEVICE is not selected.
> >
> > The sysfs setting only controls access to certain framebuffer attributes
> > and is not required for the basic display functionality to work 
> > correctly.
> > (For information on DisplayLink devices and their Linux support, see:
> > https://wiki.archlinux.org/title/DisplayLink).
> >
> > Tested by building with and without CONFIG_FB_DEVICE, both of which
> > compiled and ran without issues.
> 
> Gonzalo, I don't like this patch very much.
> 
> It adds lots of #ifdefs around functions like dev_dbg().
> Instead of ifdefs, aren't there other possibilities, e.g.
> using fb_dbg() if appropriate?
> Or using any other generic dbg() info or simply dropping the line?
> 
> But more important:
> This is a fbdev driver and currently depends on CONFIG_FB_DEVICE.
> If I'm right, the only reason to disable CONFIG_FB_DEVICE is if
> you want fbdev output at bootup, but otherwise just want to use DRM.
> But then, doesn't there exist a native DRM driver for this graphics
> card which can be used instead?
> If so, I suggest to not change this fbdev driver at all.
> 
> Helge
> 
> > Signed-off-by: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>> ---
> >   drivers/video/fbdev/Kconfig |  1 -
> >   drivers/video/fbdev/udlfb.c | 41 ++++++++++++++++++++++---------------
> >   2 files changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index ea36c6956bf3..9bf6cf74b9cb 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -1588,7 +1588,6 @@ config FB_SMSCUFX
> >   config FB_UDL
> >       tristate "Displaylink USB Framebuffer support"
> >       depends on FB && USB
> > -    depends on FB_DEVICE
> >       select FB_MODE_HELPERS
> >       select FB_SYSMEM_HELPERS_DEFERRED
> >       help
> > diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> > index 71ac9e36f67c..de4800f09dc7 100644
> > --- a/drivers/video/fbdev/udlfb.c
> > +++ b/drivers/video/fbdev/udlfb.c
> > @@ -341,10 +341,10 @@ static int dlfb_ops_mmap(struct fb_info *info, 
> > struct vm_area_struct *vma)
> >           return -EINVAL;
> >
> >       pos = (unsigned long)info->fix.smem_start + offset;
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       dev_dbg(info->dev, "mmap() framebuffer addr:%lu size:%lu\n",
> >           pos, size);
> > -
> > +#endif
> >       while (size > 0) {
> >           page = vmalloc_to_pfn((void *)pos);
> >           if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > @@ -929,10 +929,10 @@ static int dlfb_ops_open(struct fb_info *info, 
> > int user)
> >           info->fbdefio = fbdefio;
> >           fb_deferred_io_init(info);
> >       }
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       dev_dbg(info->dev, "open, user=%d fb_info=%p count=%d\n",
> >           user, info, dlfb->fb_count);
> > -
> > +#endif
> >       return 0;
> >   }
> >
> > @@ -982,9 +982,9 @@ static int dlfb_ops_release(struct fb_info *info, 
> > int user)
> >           kfree(info->fbdefio);
> >           info->fbdefio = NULL;
> >       }
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       dev_dbg(info->dev, "release, user=%d count=%d\n", user, 
> > dlfb->fb_count);
> > -
> > +#endif
> >       return 0;
> >   }
> >
> > @@ -1095,10 +1095,10 @@ static int dlfb_ops_blank(int blank_mode, 
> > struct fb_info *info)
> >       struct dlfb_data *dlfb = info->par;
> >       char *bufptr;
> >       struct urb *urb;
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       dev_dbg(info->dev, "blank, mode %d --> %d\n",
> >           dlfb->blank_mode, blank_mode);
> > -
> > +#endif
> >       if ((dlfb->blank_mode == FB_BLANK_POWERDOWN) &&
> >           (blank_mode != FB_BLANK_POWERDOWN)) {
> >
> > @@ -1190,7 +1190,9 @@ static int dlfb_realloc_framebuffer(struct 
> > dlfb_data *dlfb, struct fb_info *info
> >            */
> >           new_fb = vmalloc(new_len);
> >           if (!new_fb) {
> > +#ifdef CONFIG_FB_DEVICE
> >               dev_err(info->dev, "Virtual framebuffer alloc failed\n");
> > +#endif
> >               return -ENOMEM;
> >           }
> >           memset(new_fb, 0xff, new_len);
> > @@ -1213,9 +1215,11 @@ static int dlfb_realloc_framebuffer(struct 
> > dlfb_data *dlfb, struct fb_info *info
> >            */
> >           if (shadow)
> >               new_back = vzalloc(new_len);
> > +#ifdef CONFIG_FB_DEVICE
> >           if (!new_back)
> >               dev_info(info->dev,
> >                    "No shadow/backing buffer allocated\n");
> > +#endif
> >           else {
> >               dlfb_deferred_vfree(dlfb, dlfb->backing_buffer);
> >               dlfb->backing_buffer = new_back;
> > @@ -1247,14 +1251,14 @@ static int dlfb_setup_modes(struct dlfb_data 
> > *dlfb,
> >       struct device *dev = info->device;
> >       struct fb_videomode *mode;
> >       const struct fb_videomode *default_vmode = NULL;
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       if (info->dev) {
> >           /* only use mutex if info has been registered */
> >           mutex_lock(&info->lock);
> >           /* parent device is used otherwise */
> >           dev = info->dev;
> >       }
> > -
> > +#endif
> >       edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
> >       if (!edid) {
> >           result = -ENOMEM;
> > @@ -1375,10 +1379,10 @@ static int dlfb_setup_modes(struct dlfb_data 
> > *dlfb,
> >   error:
> >       if (edid && (dlfb->edid != edid))
> >           kfree(edid);
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       if (info->dev)
> >           mutex_unlock(&info->lock);
> > -
> > +#endif
> >       return result;
> >   }
> >
> > @@ -1597,8 +1601,10 @@ static int dlfb_parse_vendor_descriptor(struct 
> > dlfb_data *dlfb,
> >   static int dlfb_usb_probe(struct usb_interface *intf,
> >                 const struct usb_device_id *id)
> >   {
> > +#ifdef CONFIG_FB_DEVICE
> >       int i;
> >       const struct device_attribute *attr;
> > +#endif
> >       struct dlfb_data *dlfb;
> >       struct fb_info *info;
> >       int retval;
> > @@ -1701,7 +1707,7 @@ static int dlfb_usb_probe(struct usb_interface 
> > *intf,
> >               retval);
> >           goto error;
> >       }
> > -
> > +#ifdef CONFIG_FB_DEVICE
> >       for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++) {
> >           attr = &fb_device_attrs[i];
> >           retval = device_create_file(info->dev, attr);
> > @@ -1710,17 +1716,16 @@ static int dlfb_usb_probe(struct usb_interface 
> > *intf,
> >                    "failed to create '%s' attribute: %d\n",
> >                    attr->attr.name, retval);
> >       }
> > -
> >       retval = device_create_bin_file(info->dev, &edid_attr);
> >       if (retval)
> >           dev_warn(info->device, "failed to create '%s' attribute: %d\n",
> >                edid_attr.attr.name, retval);
> > -
> >       dev_info(info->device,
> >            "%s is DisplayLink USB device (%dx%d, %dK framebuffer 
> > memory)\n",
> >            dev_name(info->dev), info->var.xres, info->var.yres,
> >            ((dlfb->backing_buffer) ?
> >            info->fix.smem_len * 2 : info->fix.smem_len) >> 10);
> > +#endif
> >       return 0;
> >
> >   error:
> > @@ -1737,8 +1742,9 @@ static void dlfb_usb_disconnect(struct 
> > usb_interface *intf)
> >   {
> >       struct dlfb_data *dlfb;
> >       struct fb_info *info;
> > +#ifdef CONFIG_FB_DEVICE
> >       int i;
> > -
> > +#endif
> >       dlfb = usb_get_intfdata(intf);
> >       info = dlfb->info;
> >
> > @@ -1754,10 +1760,11 @@ static void dlfb_usb_disconnect(struct 
> > usb_interface *intf)
> >       dlfb_free_urb_list(dlfb);
> >
> >       /* remove udlfb's sysfs interfaces */
> > +#ifdef CONFIG_FB_DEVICE
> >       for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
> >           device_remove_file(info->dev, &fb_device_attrs[i]);
> >       device_remove_bin_file(info->dev, &edid_attr);
> > -
> > +#endif
> >       unregister_framebuffer(info);
> >   }
> >
> 
> 
