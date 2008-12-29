From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Mon, 29 Dec 2008 12:32:08 -0800
Message-ID: <200812291232.09174.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <1230501634.16910.57.camel@linux-51e8.site> <45a44e480812281628j214a9efvd19e4647fe30582c@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <45a44e480812281628j214a9efvd19e4647fe30582c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Ben Nizette <bn@niasdigital.com>, Robin Getz <rgetz@blackfin.uclinux.org>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Sunday 28 December 2008, Jaya Kumar wrote:
> I'd like to get the start/length approach out there and in-play to
> find out if other people want to use it and how they end up using it.

As an *implementation* constraint, I might agree ... so
long as it's easily changed later.

As an *interface* constraint, I don't ... interfaces are
rarely easy to change.

However, in terms of implementation, most gpio chips have
primitives that work in terms of bitmasks rather than any
kind of start/length primitive.  Example:

 - To set bits in "u32 mask":
	iowrite32(mask, bank_base + SET_REG)
 - To clear bits in "u32 mask"
	iowrite32(mask, bank_base + CLR_REG)
 - To read bits in "u32 mask",
	return mask & ioread32(bank_base + VALUE_REG)

In short, start/length looks most like a policy, of the
"keep them out of interfaces!" flavor, than something
appropriate for an interface.  As noted above, gpio_chip
interfaces would more naturally use masks.

- Dave
