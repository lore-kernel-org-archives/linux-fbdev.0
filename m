From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add batch set/get
Date: Mon, 29 Dec 2008 12:33:38 -0800
Message-ID: <200812291233.39258.david-b@pacbell.net>
References: <1230395048446-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70812281938h1b8ad9ecq49a460ac7786ae76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <david-b@pacbell.net>) id 1LHOos-0000US-DU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Dec 2008 20:34:34 +0000
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LHOop-0008At-4L for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Dec 2008 20:34:34 +0000
In-Reply-To: <f17812d70812281938h1b8ad9ecq49a460ac7786ae76@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Ben Gardner <bgardner@wabtec.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Philipp Zabel <philipp.zabel@gmail.com>, Eric Miao <eric.miao@marvell.com>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>

I'm a bit surprised to see patches against 2.6.27, rather
than a 2.6.28 (or 2.6.28-rc) kernel.  ;)


On Sunday 28 December 2008, Eric Miao wrote:
> > @@ -200,8 +203,12 @@ static void am300_set_hdb(struct broadsheetfb_par *par, u16 data)
> >  {
> >        int i;
> >
> > +#ifdef CONFIG_GPIOLIB_BATCH
> > +       gpio_set_batch(DB0_GPIO_PIN, data, 0xFFFF, 16);
> > +#else
> >        for (i = 0; i <= (DB15_GPIO_PIN - DB0_GPIO_PIN) ; i++)
> >                gpio_set_value(DB0_GPIO_PIN + i, (data >> i) & 0x01);
> > +#endif
> 
> Well, if AM300 selects GPIOLIB_BATCH, I don't think we need the
> gpio_set_value() stuffs, and get rid of this #ifdef completely.

Right ... although we don't *have* a GPIOLIB_BATCH,
so that's not (yet?) an option.


> > @@ -1056,6 +1056,128 @@ void __gpio_set_value(unsigned gpio, int value)
> >  }
> >  EXPORT_SYMBOL_GPL(__gpio_set_value);
> >
> > +#ifdef CONFIG_GPIOLIB_BATCH
> > +/**
> > + * __gpio_set_batch() - assign a batch of gpio pins together
> > + * @gpio: starting gpio pin
> > + * @values: values to assign, sequential and including masked bits
> > + * @bitmask: bitmask to be applied to values
> > + * @bitwidth: width inclusive of masked-off bits
> > + * Context: any
> > + *
> > + * This is used directly or indirectly to implement gpio_set_value().
> > + * It invokes the associated gpio_chip.set_batch() method. If that
> > + * method does not exist for any segment that is involved, then it drops
> > + * back down to standard gpio_chip.set()
> > + */
> > +void __gpio_set_batch(unsigned gpio, u32 values, u32 bitmask, int bitwidth)
> > +{
> > +       struct gpio_chip *chip;
> > +       int i = 0;
> > +       int value, width, remwidth;
> > +       u32 mask;
> > +
> > +       do {
> > +               chip = gpio_to_chip(gpio + i);
> > +               WARN_ON(extra_checks && chip->can_sleep);
> > +
> > +               if (!chip->set_batch) {
> > +                       while (((gpio + i) < (chip->base + chip->ngpio))
> > +                               && bitwidth) {
> > +                               mask = 1 << i;
> > +                               value = values & mask;
> > +                               if (bitmask & mask)
> > +                                       chip->set(chip, gpio + i - chip->base,
> > +                                                       value);
> > +                               i++;
> > +                               bitwidth--;
> 
> I recommend this being put into something like 'default_gpio_set_batch', and
> assign this to 'chip->set_batch' when the gpio chip is being registered and
> found 'chip->set_batch == NULL', so to keep this block consistent.
> 
> Same comment to the 'get_batch' implementation below.

Right ... this is something I had suggested earlier:  make
sure that the (renamed) "batch" interfaces don't depend on
some TBD extension to gpio_chip.

Those extensions should be just an optimization.


------------------------------------------------------------------------------
