From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 19 Aug 2020 16:57:02 +0000
Subject: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference count imbalance on error
Message-Id: <20200819165702.GC3248864@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
In-Reply-To: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, Bryan Wu <cooloney@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Dinghao Liu <dinghao.liu@zju.edu.cn>, Jingoo Han <jingoohan1@gmail.com>, Kangjie Lu <kjlu@umn.edu>, Daniel Thompson <daniel.thompson@linaro.org>

On Wed, 19 Aug 2020, Markus Elfring wrote:

> > When of_property_read_u32_array() returns an error code,
> > a pairing refcount decrement is needed to keep np's refcount balanced.
> 
> Can another imperative wording be helpful for the change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id445bf405cb331117bc98427b1ba6f12418ad17#n151
> 
> Would an other commit message be a bit nicer?
> 
> 
> …
> > +++ b/drivers/video/backlight/sky81452-backlight.c
> > @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> >  					num_entry);
> >  		if (ret < 0) {
> >  			dev_err(dev, "led-sources node is invalid.\n");
> > +			of_node_put(np);
> >  			return ERR_PTR(-EINVAL);
> >  		}
> 
> I propose to add the jump target “put_node” so that a bit of common exception
> handling code can be better reused at the end of this function implementation.
> 
> Regards,
> Markus

You can safely ignore any review comments from Markus!

However, this patch doesn't appear to be in my inbox.

Any ideas as to why?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
