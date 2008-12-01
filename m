From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Mon, 1 Dec 2008 09:10:48 +0800
Message-ID: <45a44e480811301710v78875425p75dedd850728cbec@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <200811291454.17110.david-b@pacbell.net>
	 <45a44e480811291552i77878bcdn5fe33f48fc4236eb@mail.gmail.com>
	 <200811300955.30180.david-b@pacbell.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756798AbYLABLG@vger.kernel.org>
In-Reply-To: <200811300955.30180.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: David Brownell <david-b@pacbell.net>
Cc: Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Mon, Dec 1, 2008 at 1:55 AM, David Brownell <david-b@pacbell.net> wrote:
>
> They wouldn't want names so easily confused with the current set
> of GPIO calls, no.
>

Okay, how does gpio_set/get_values_batch() sound?

>
>> >
>> > Then separately two more things:
>> >
>> >  - A gpio_* interface proposal for higher-level bitmask calls.
>> >   This is worth some discussion; the calls should clearly
>> >   be optional (not everything will implement them), and I
>> >   can't help but suspect <linux/bitmap.h> interfaces should
>> >   interoperate smoothly.
>
> ... including probably ganged request/free, and direction updates.
> When bitbanging a multiplexed parallel databus, you'll often need
> to change directions.

Okay, so I'll also add gpio_direction_output/input_batch and request/free_batch.

>
>
>> >
>> >  - A gpiolib based implementation, using those new gpio_chip
>> >   methods as accelerators if they're present.  This should
>> >   probably also be optional, even at the Kconfig level; many
>> >   systems won't need to spend memory on these calls.
>>
>> Understood. I will make it optional. Does
>> CONFIG_GPIOLIB_MULTIBIT_ACCESS sound okay?
>
> Kind of verbose for my taste, and it's already "multibit" (one
> at a time, but still multiple) ... let's see some more mergeable
> proposals and code first.  Different C file too, I suspect.

Ok, CONFIG_GPIOLIB_BATCH and I'll add this code in
drivers/gpio/gpiolib_batch.c. I hope I have understood that suggestion
correctly.

>
>
>> > Don't assume gpiolib when defining the interface.
>>
>> Ok, I didn't understand this part. I think you mentioned a higher
>> level interface before but I didn't fully understand, if not gpiolib,
>> then at what level do you recommend?
>
> The gpio_*() interfaces are how system glue code and drivers
> access GPIOs, unless they roll their own chip-specific calls.
>
> Whereas gpiolib (and gpio_chip) are an *optional* framework
> for implementing those calls.  Platforms can (and do!) use
> other frameworks ... maybe they don't want to pay its costs,
> and don't need the various GPIO expander drivers.
>
> So to repeat:  don't assume the interface is implemented in
> one particular way (using gpiolib).  It has to make sense
> with other implementation strategies too.  Standard split
> between interface and implementation, that's all.  (Some folk
> have been heard to talk about "gpiolib" as the interface to
> drivers ... it's not, it's a provider-only interface library.)
>

Okay, I read above several times and I read Documentation/gpio.txt.
But... I'm not confident I've understood your meanings above in terms
of how it should change the code. What I know so far is:

a)
arch/arm/mach-pxa/include/mach/gpio.h is where the pxa GPIO api
interface is defined. So that's where I will put the
gpio_get/set_values_batch functions. This will match the existing
gpio_set/get_value code there.

b)
arch/arm/mach-pxa/gpio.c is where the implementation is.
So I'll put the pxa_gpio_direction_input/output_batch and
pxa_gpio_set/get_batch there.

c)
drivers/gpio/gpiolib_batch.c

This is where I'd put the generic platform independent implementations
of __gpio_set/get_values_batch

Does this sound consistent with your recommendation? If not, I need
more help to understand what changes you are recommending.


> Doesn't necessarily need to be *you* doing that, but if it only
> works on older gumstix boards it'd not be general enough.  Which
> is part of why I say to get the lowest level proposal out there
> first.  If done right, it'll be easy to support on other chips.

Yes, I completely agree that it must work on a wide range of
architectures. But I don't understand what you mean when you say get
the lowest level proposal out there first. I see the RFC code that I
posted as being the lowest level proposal (albeit needing better name
and bitmask support) and one that is sufficiently general that it can
be implemented on other architectures. If it can't, can you help me
understand by pointing to which portion would break on other archs?

Thanks,
jaya
