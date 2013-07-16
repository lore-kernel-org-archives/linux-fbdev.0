From: Mike Galbraith <bitbucket@online.de>
Date: Tue, 16 Jul 2013 03:29:40 +0000
Subject: Re: [PATCH 2/3] video: hx8357: Make IM pins optional
Message-Id: <1373945380.7549.26.camel@marge.simpson.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373902022-20439-3-git-send-email-maxime.ripard@free-electrons.com>
 <003501ce81be$4a945ed0$dfbd1c70$@samsung.com>
In-Reply-To: <003501ce81be$4a945ed0$dfbd1c70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2013-07-16 at 09:49 +0900, Jingoo Han wrote: 
> On Tuesday, July 16, 2013 12:27 AM, Maxime Ripard wrote:

> > +
> > +			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> > +						    GPIOF_OUT_INIT_LOW, "im_pins");
> 
> This makes a checkpatch warning such as 'WARNING: line over 80 characters'.
> How about the following?
> 
> 			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> 						GPIOF_OUT_INIT_LOW, "im_pins");

IIRC, some maintainers gripe (davem?) when they see such alignment,
preferring the original arg below arg alignment vs strict 80 column.

-Mike

