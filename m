From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] gpiolib: add set/get batch v4
Date: Mon, 19 Jan 2009 22:19:40 +0800
Message-ID: <45a44e480901190619i18749c75jaa2d4606da251921@mail.gmail.com>
References: <12321862383405-git-send-email-jayakumar.lkml@gmail.com>
	 <20090119100342.GA16400@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20090119100342.GA16400@pengutronix.de>
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Mon, Jan 19, 2009 at 6:03 PM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hi Jaya,
>
> On Sat, Jan 17, 2009 at 05:57:17PM +0800, Jaya Kumar wrote:
>> Hi friends,
>>
>> This is v4 of batch support for gpiolib. Thanks to David Brownell, E=
ric Miao,
>> David Hylands, Robin, Ben, Jamie and others for prior feedback. The =
post for
>> v3 summarized the previous discussion. Since then the changes I've m=
ade are:
>> - split the patches into generic and arch specific
> IMHO this should be three patches: "gpiolib", "pxa" and "am300epd".
> Well, ...

Hi Uwe,

Ok, will do.

>
>> +[OPTIONAL] Spinlock-Safe GPIO Batch access
> Is it really spinlock safe in general?  Or only if gpio_cansleep(gpio=
)
> if false for each gpio to get or set?

You are correct to raise this issue. It is only spinlock safe if
chip->cansleep is false. Initially, I wasn't sure what to do. The
original gpio set/get_value() just does;
        WARN_ON(extra_checks && chip->can_sleep);
and it is documented as:

"
Spinlock-Safe GPIO access
-------------------------
<snip>
return zero.  Also, using these calls for GPIOs that can't safely be ac=
cessed
without sleeping (see below) is an error.
"

I will change this in the batch code to return an error if can_sleep
is detected on any involved gpio_chip.

>
>> +static int __generic_gpio_set_batch(struct gpio_chip *chip, unsigne=
d offset,
>> +                                     u32 values, u32 bitmask, int w=
idth)
> IMHO a better name is __gpio_set_batch_generic (or
> __gpiolib_set_batch_generic?), YMMV.

Agreed. Will change.

>
>> +int __gpio_set_batch(unsigned gpio, u32 values, u32 bitmask, int bi=
twidth)
> Sometimes your width parameter is called bitwidth, sometimes width.  =
I'd
> like to have that consistant.

Ok, you're right. I'll fix this.

>
> While talking about this parameter.  I don't really like it, because =
you
> can calculate it from bitmask.  In an earlier mail you write:

Agreed.

>
>        bitwidth (needed to iterate and map to chip ngpios) could be
>        calculated from bitmask, but that involves iteratively countin=
g
>        bits from the mask, so we would have to do 800*600 bit counts.
>        Unless, we do ugly things like cache the previous bitwidth/mas=
k
>        and compare against the current caller arguments. Given that t=
he
>        bitwidth would typically be a fixed value, I believe it is mor=
e
>        intuitive for the caller to provide it, ...
>
> I think it's easier than that.  bitwidth is just fls(bitmask) which
> should be efficient enough not to bother the programmer.  If bitmask =
is
> constant it's even the compiler that does the work here.
>

That is a good point. I agree that width is ugly in the main API. It
is just fls(mask) and I now realize that this is an inline so you're
right it would get taken care of by the compiler. fls is checked with
__constant_fls first. Beauty! Thanks Uwe! I'll make these changes.

Thanks,
jaya
