From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 31 Dec 2008 00:02:04 -0500
Message-ID: <45a44e480812302102i2fe91abbt553fa1168d458c93@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <200812281346.56703.rgetz@blackfin.uclinux.org>
	 <200812291156.12230.david-b@pacbell.net>
	 <200812302355.45193.rgetz@blackfin.uclinux.org>
	 <45a44e480812302058k365eddcfxf902095657b78534@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <45a44e480812302058k365eddcfxf902095657b78534@mail.gmail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Dec 30, 2008 at 11:58 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Tue, Dec 30, 2008 at 11:55 PM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
>> Yeah, I hadn't thought about spanning more than one gpio_chip. That's a good
>> point.
>
> The currently posted code already supports spanning more than one gpio_chip.

and btw, that was because the use case needed to span 2, since it
started at 58 and was 16 bits long on a platform where ngpio == 32.
this was explained at the start of the thread.

>
> +       do {
> +               chip = gpio_to_chip(gpio + i);
> +               WARN_ON(extra_checks && chip->can_sleep);
> +
> +               if (!chip->set_bus) {
> +                       while (((gpio + i) < (chip->base + chip->ngpio))
> +                               && bitwidth) {
> +                               value = values & (1 << i);
> +                               chip->set(chip, gpio + i - chip->base, value);
> +                               i++;
> +                               bitwidth--;
> +                       }
> +               } else {
> +                       value = values >> i; /* shift off the used stuff */
> +                       remwidth = ((chip->base + (int) chip->ngpio) -
> +                                       ((int) gpio + i));
> +                       width = min(bitwidth, remwidth);
> +
> +                       chip->set_bus(chip, gpio + i - chip->base, value,
> +                                       width);
> +                       i += width;
> +                       bitwidth -= width;
> +               }
> +       } while (bitwidth);
>
