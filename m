From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 31 Dec 2008 12:38:13 -0500
Message-ID: <200812311238.13810.rgetz@blackfin.uclinux.org>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200812302355.45193.rgetz@blackfin.uclinux.org> <45a44e480812302058k365eddcfxf902095657b78534@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <45a44e480812302058k365eddcfxf902095657b78534@mail.gmail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue 30 Dec 2008 23:58, Jaya Kumar pondered:
> On Tue, Dec 30, 2008 at 11:55 PM, Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> > Yeah, I hadn't thought about spanning more than one gpio_chip. That's a good
> > point.
> 
> The currently posted code already supports spanning more than one gpio_chip.
> 

But doesn't do all the other things that David suggested/requested.
