From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 22 Jul 2013 08:30:44 +0000
Subject: Re: [PATCH 2/3] video: hx8357: Make IM pins optional
Message-Id: <000301ce86b5$c280da30$47828e90$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373902022-20439-3-git-send-email-maxime.ripard@free-electrons.com>
 <003501ce81be$4a945ed0$dfbd1c70$@samsung.com>
 <1373945380.7549.26.camel@marge.simpson.net> <20130719083555.GC5106@lukather>
In-Reply-To: <20130719083555.GC5106@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, July 19, 2013 5:36 PM, Maxime Ripard wrote:
> On Tue, Jul 16, 2013 at 05:29:40AM +0200, Mike Galbraith wrote:
> > On Tue, 2013-07-16 at 09:49 +0900, Jingoo Han wrote:
> > > On Tuesday, July 16, 2013 12:27 AM, Maxime Ripard wrote:
> >
> > > > +
> > > > +			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> > > > +						    GPIOF_OUT_INIT_LOW, "im_pins");
> > >
> > > This makes a checkpatch warning such as 'WARNING: line over 80 characters'.
> > > How about the following?
> > >
> > > 			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> > > 						GPIOF_OUT_INIT_LOW, "im_pins");
> >
> > IIRC, some maintainers gripe (davem?) when they see such alignment,
> > preferring the original arg below arg alignment vs strict 80 column.
> 
> As far as I know, the coding guide styles are quite fuzzy about this:
>   - The new line is not required to be aligned with the braces above
>   - Yet, the emacs config given does indent like this.
>   - 80 characters is said not to be a hard limit

Even though 80 characters is not a hard limit, 80 characters is preferred
if possible.

> 
> I don't really know if there's a better solution here, except maybe:
> ret = devm_gpio_request_one(&spi-dev, lcd->im_pins[i],
> 			    GPIOF_OUT_INIT_LOW,
> 			    "im_pins");

Yes, I think that this can be used. :)


Best regards,
Jingoo Han

> 
> But it's not really a big deal, is it?
> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

