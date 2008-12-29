From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Mon, 29 Dec 2008 11:32:14 -0800
Message-ID: <200812291132.14806.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <45a44e480811301710v78875425p75dedd850728cbec@mail.gmail.com> <45a44e480812270655u10bde0d2mc7f429cf47ed7bc6@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <45a44e480812270655u10bde0d2mc7f429cf47ed7bc6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Saturday 27 December 2008, Jaya Kumar wrote:
> Oh, gosh darn it, how time has flown. My email above was to make sure
> I have understood the feedback. I assume I should just get started on
> implementing. Just to double check, the plan is:
> - add bitmask support.
> - add get_batch support
> - improve naming. I think gpio_get_batch/gpio_set_batch sounds good.

I was expecting to get some agreement on interfaces first.


> I plan to have something like:
>=20
> void gpio_set_batch(unsigned gpio, u32 values, u32 bitmask, int bitwi=
dth);
> u32 gpio_get_batch(unsigned gpio, u32 bitmask, int bitwidth);

I still don't like the word "batch" here.  Did you look
at the <linux/bitmask.h> interfaces as I suggested?  They
would suggest something rather different:

 - passing bitmasks as {unsigned long *bits, int count} tuples
 - separate calls to:
     * zero a set of bits (loop: gpio_set_value to 0)
     * fill a set of bits (loop: gpio_set_value to 1)
     * copy a set of bits (loop: gpio_set_value to src[i])
     * read a set of bits (loop: dst[i] =3D gpio_get_value)
     * ... maybe more

Any restriction to 32 bit value seems shortsighted.  It would
make sense to wrap the GPIO bitmask descriptions in a struct,
letting drivers work with smaller sets -- probably most would
fit into a single "unsigned long".


> I think I should explain the bitmask and bitwidth choice. The intende=
d
> use case is:
> for (i=3D0; i < 800*600; i++) {
> =A0gpio_set_batch(...)
> }
>=20
> bitwidth (needed to iterate and map to chip ngpios) could be
> calculated from bitmask, but that involves iteratively counting bits
> from the mask, so we would have to do 800*600 bit counts. Unless, we
> do ugly things like cache the previous bitwidth/mask and compare
> against the current caller arguments. Given that the bitwidth would
> typically be a fixed value, I believe it is more intuitive for the
> caller to provide it, eg:
>=20
> gpio_set_batch(DB0, value, 0xFFFF, 16)
>=20
> which has the nice performance benefit of skipping all the bit
> counting in the most common use case scenario.

That doesn't explain the bit mask and bitwidth parameters at all.


> While we are here, I was thinking about it, and its better if I give
> gpio_request/free/direction_batch a miss for now.

Let's not and say we didn't.  Providing incomplete interfaces
isn't really much help.


> Nothing prevents=20
> those features being added at a later point. That way I can focus on
> getting gpio_set/get_batch implemented correctly and merged as the
> first step.

=46irst step needs to be defining the interface extensions needed.

- Dave
