From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Mon, 29 Dec 2008 11:59:36 -0800
Message-ID: <200812291159.37449.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200812281346.56703.rgetz@blackfin.uclinux.org> <1230501634.16910.57.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1230501634.16910.57.camel@linux-51e8.site>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Ben Nizette <bn@niasdigital.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Sunday 28 December 2008, Ben Nizette wrote:
> > > gpio_set_batch(DB0, value, 0xFFFF, 16)
> > > 
> > > which has the nice performance benefit of skipping all the bit
> > > counting in the most common use case scenario.
> > 
> > but has the requirement that the driver know exactly the board level 
> > impmentation details (something that doesn't sound generic).
> 
> The original use case for these batch operations was in a fastpath -
> setting data lines on a framebuffer.

And the rationale for generalizing them was to let such fastpaths
stop being board-specific hacks.  :)
