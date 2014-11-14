From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Nov 2014 10:11:51 +0000
Subject: Re: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
Message-Id: <CACRpkdZiari6CtWq1kBCvX3cwwatJiHAuWUb40WSUEfjZjk+Lg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
	<CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
	<CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
	<CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
	<CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
	<20141106060335.GR8509@sirena.org.uk>
	<CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
In-Reply-To: <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo

On Tue, Nov 11, 2014 at 2:16 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Just to better understand your suggestions: do you want me to convert
> to regmap only gpio driver or do you suggest to convert all LoCoMo drivers?

Um... I was just thinking about this one usecase.

It's no big deal, the other review comments are more important.

> That is doable, of course, but the amount of changes is overwhelming.
> Also I'm concerned about the performance impact from going through
> regmap layers.

Is it on a critical path? The current locking isn't any less invasive
AFAICT.

Yours,
Linus Walleij
