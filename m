From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 18 Jul 2018 15:55:44 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-Id: <20180718155544.GF4641@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
 <20180718130853.GE4641@dell>
 <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
In-Reply-To: <20180718134103.bgwpgk7l6joxtjoa@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>

On Wed, 18 Jul 2018, Daniel Thompson wrote:

> On Wed, Jul 18, 2018 at 02:08:53PM +0100, Lee Jones wrote:
> > > > > > No, then we are back to the initial issue of num_steps
> > > > > > potentially not
> > > > > > being initialised. We really want both of_property_read_u32() to
> > > > > > succeed AND num_steps to actually be set.
> > > > > 
> > > > > I also think num_steps should be pre-initialised.
> > > 
> > > Yes, I guess it definitely does not hurt.
> > > 
> > > > > Then it will only be set if of_property_read_u32() succeeds.
> > > 
> > > Yes, but we still need to check for both, the function not failing and
> > > num_steps to actually be non zero.
> > 
> > Why?  You don't do anything differently if it fails.
> 
> Only if you initialize num_steps...
> 
> We should either initialize to zero and not worry about the return
> code[1] or we check the return code and not worry about
> initialization[2]. I don't think both are worthwhile.
> 
> Whilst initialization can fix this specific instance we generally avoid
> overusing it since it messes up static analysis and, in this instance,
> distance from declaration to use is >25 lines, hence current patchset.
> 
> 
> Daniel.
> 
> 
> [1] https://lkml.org/lkml/2018/7/16/399
> [2] https://lkml.org/lkml/2018/7/16/1042
> 
> Or...
> 
> We check the return code and leave number
> 
> num_steps is uninitialized and stack allocated so it only has a valid
> value if of_property_read_u32() succeeds.
> 
> We can (and I originally did) fix the bug by initializing num_steps to 0
> but its quite some distance between declaration and use so I accepted
> Marcel's counter proposal to check the return code instead.

Only checking the return value of of_property_read_u32() is also
suitable.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
