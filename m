From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Tue, 6 Jan 2009 17:41:12 -0500
Message-ID: <200901061741.12410.rgetz@blackfin.uclinux.org>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200812311238.13810.rgetz@blackfin.uclinux.org> <45a44e480812311005k709c410ao1116187e9427e452@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <45a44e480812311005k709c410ao1116187e9427e452@mail.gmail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Wed 31 Dec 2008 13:05, Jaya Kumar pondered:
> On Thu, Jan 1, 2009 at 1:38 AM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> > On Tue 30 Dec 2008 23:58, Jaya Kumar pondered:
> >> On Tue, Dec 30, 2008 at 11:55 PM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> >> > Yeah, I hadn't thought about spanning more than one gpio_chip. That's a good
> >> > point.
> >>
> >> The currently posted code already supports spanning more than one gpio_chip.
> >>
> >
> > But doesn't do all the other things that David suggested/requested.
> 
> Hi Robin,
> 
> Yes, you are right. My implementation does not support a driver that
> needs to set/get more than 32-bits of gpio in a single call. I'm okay
> with that restriction as I don't see a concrete use case for that.

It's not the more than 32-bits that I'm concerned about - it is spanning
more than one register. (if all the GPIOs that are left on the board are 
2, 64, and 128, where 2, and 64 are part of the SOC's GPIO, and 128 is on
a GPIO expander - which is a common use case - is this handled?)
