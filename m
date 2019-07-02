From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 02 Jul 2019 06:36:53 +0000
Subject: Re: [PATCH 00/12] ARM: davinci: da850-evm: remove more legacy GPIO calls
Message-Id: <20190702063653.GC4652@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
 <fe42c0e1-2bfb-2b1c-2c38-0e176e88ec6e@ti.com>
In-Reply-To: <fe42c0e1-2bfb-2b1c-2c38-0e176e88ec6e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Mon, 01 Jul 2019, Sekhar Nori wrote:

> Hi Lee, Daniel, Jingoo,
> 
> On 25/06/19 10:04 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > This is another small step on the path to liberating davinci from legacy
> > GPIO API calls and shrinking the davinci GPIO driver by not having to
> > support the base GPIO number anymore.
> > 
> > This time we're removing the legacy calls used indirectly by the LCDC
> > fbdev driver.
> > 
> > The first three patches modify the GPIO backlight driver. The first
> > of them adds the necessary functionality, the other two are just
> > tweaks and cleanups.
> 
> Can you take the first three patches for v5.3 - if its not too late? I
> think that will make it easy for rest of patches to make into subsequent
> kernel releases.

It's already too late in the cycle (-rc7) for that.  I require patches
of this nature to have a good soak in -next before being merged. There
shouldn't be an issue with getting them into v5.4 though.

> > Next two patches enable the GPIO backlight driver in
> > davinci_all_defconfig.
> > 
> > Patch 6/12 models the backlight GPIO as an actual GPIO backlight device.
> > 
> > Patches 7-9 extend the fbdev driver with regulator support and convert
> > the da850-evm board file to using it.
> > 
> > Last three patches are improvements to the da8xx fbdev driver since
> > we're already touching it in this series.
> 
> Thanks,
> Sekhar
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
