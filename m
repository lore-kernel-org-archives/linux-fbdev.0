From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Sat, 29 Nov 2008 14:47:28 -0800
Message-ID: <200811291447.29932.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <492D125D.5010607@teltonika.lt> <45a44e480811260118v440716bbqa8d37c8b696c148a@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755773AbYK2Wzu@vger.kernel.org>
In-Reply-To: <45a44e480811260118v440716bbqa8d37c8b696c148a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wednesday 26 November 2008, Jaya Kumar wrote:
> On Wed, Nov 26, 2008 at 4:09 AM, Paulius Zaleckas wrote:
> > Jaya Kumar wrote:
> >>       void                    (*set)(struct gpio_chip *chip,
> >>                                               unsigned offset, int value);
> >> +     void                    (*set_bus)(struct gpio_chip *chip,
> >> +                                             unsigned offset, int values,
> >
> > I think values should be unsigned
> 
> Okay, can do but it is unusual no?

For bitmasks, anything except "unsigned long" is unusual.
In fact, <linux/bitmask.h> uses them in arrays...

If this goes through, I suspect it would be fair to expect
a gpio_chip to work with only one word at at time.  SOC based
GPIO controllers stick to their natural word sizes (32 or 16
bits in most cases), in arrays, and I've yet to come across
external controllers that are any different.  So passing in
arrays of "unsigned long" would seem to be overkill.

However, "set_bus" is seems misleading to me:  "set" because
it makes me think it's writing to the set_bits register,
which won't clear things; "bus" because this is doing ganged
operations, which aren't only for busses ... and in fact a
bus operation probably needs multiple ganged operations,
e.g. first write the address, handshake, then write data and
handshake again.

Maybe words like "assign" and "bitmask" would get past those
particular issues... though I don't hugely like "assign".

In terms of low level primitives, I've already commented
that the "read" side is missing.  An additional issue came
to mind:  the policy of using contiguous bits should not
be mandated here.  It doesn't need to be, either ... just
pass a mask of valid bits, along with a mask of values.


> since set uses int value, i figured set_bus should be similar right?

It doesn't take a bitmask; that's a single zero/nonzero value,
for which the sign (bit) is irrelevant.  It's signed mostly to
distinguish the two parameters by type, so it's less easy to
confuse them; sometimes the compiler will point out goofage.
(Plus, the offsets can ever be negative.)

- Dave
