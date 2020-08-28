From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 28 Aug 2020 09:29:04 +0000
Subject: Re: [PATCH] video: backlight: sky81452-backlight: Fix reference count imbalance on error
Message-Id: <20200828092904.GD1826686@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <321fb03d-2307-7f60-f437-cfb99184dfd6@web.de>
 <20200819165702.GC3248864@dell>
 <217e3c0c.b58c.17409fd7496.Coremail.dinghao.liu@zju.edu.cn>
 <20200820062301.GD3248864@dell>
 <3f9fbdb1.bc96.1740a9560d5.Coremail.dinghao.liu@zju.edu.cn>
 <20200820074916.GE3248864@dell>
 <20200820113817.742yvjvdy7a642ew@holly.lan>
In-Reply-To: <20200820113817.742yvjvdy7a642ew@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, Bryan Wu <cooloney@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Markus Elfring <Markus.Elfring@web.de>, dinghao.liu@zju.edu.cn, Jingoo Han <jingoohan1@gmail.com>, Kangjie Lu <kjlu@umn.edu>

On Thu, 20 Aug 2020, Daniel Thompson wrote:

> On Thu, Aug 20, 2020 at 08:49:16AM +0100, Lee Jones wrote:
> > On Thu, 20 Aug 2020, dinghao.liu@zju.edu.cn wrote:
> > 
> > > > On Thu, 20 Aug 2020, dinghao.liu@zju.edu.cn wrote:
> > > > 
> > > > > > On Wed, 19 Aug 2020, Markus Elfring wrote:
> > > > > > 
> > > > > > > > When of_property_read_u32_array() returns an error code,
> > > > > > > > a pairing refcount decrement is needed to keep np's refcount balanced.
> > > > > > > 
> > > > > > > Can another imperative wording be helpful for the change description?
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id445bf405cb331117bc98427b1ba6f12418ad17#n151
> > > > > > > 
> > > > > > > Would an other commit message be a bit nicer?
> > > > > > > 
> > > > > > > 
> > > > > > > …
> > > > > > > > +++ b/drivers/video/backlight/sky81452-backlight.c
> > > > > > > > @@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> > > > > > > >  					num_entry);
> > > > > > > >  		if (ret < 0) {
> > > > > > > >  			dev_err(dev, "led-sources node is invalid.\n");
> > > > > > > > +			of_node_put(np);
> > > > > > > >  			return ERR_PTR(-EINVAL);
> > > > > > > >  		}
> > > > > > > 
> > > > > > > I propose to add the jump target “put_node” so that a bit of common exception
> > > > > > > handling code can be better reused at the end of this function implementation.
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Markus
> > > > > > 
> > > > > > You can safely ignore any review comments from Markus!
> > > > > > 
> > > > > > However, this patch doesn't appear to be in my inbox.
> > > > > > 
> > > > > > Any ideas as to why?
> > > > > > 
> > > > > 
> > > > > Thank you for your advice. My outbox shows that this patch
> > > > > has reached your email server successfully. Maybe this
> > > > > ended up in your junk mail file?
> > > > 
> > > > This has happened recently, so I was sure to check.
> > > > 
> > > > Not there either unfortunately.
> > > > 
> > > > Would you be kind enough to bounce/resend please?
> > > 
> > > Sure.
> > 
> > Looks like you sent it *only* to me.  Please keep everyone else in Cc
> > when doing that, or I can't respond to everyone.
> > 
> > Anyway, besides the subject line (which I can fix easily), the patch
> > looks good to me, but Daniel T must review.
> 
> I've already offered a Reviewed-by for this patch. Perhaps it landed in
> the same place as the original patch...

Patch applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
