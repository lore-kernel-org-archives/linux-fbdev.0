From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Remove voodoo code from i2c
Date: Sat, 06 Mar 2004 14:42:45 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078544564.6327.146.camel@gaston>
References: <20040306021016.46831.qmail@web14916.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzSxw-0007yL-Fx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 19:59:08 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AzSOR-0005WJ-4z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 19:22:27 -0800
In-Reply-To: <20040306021016.46831.qmail@web14916.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kronos <kronos@kronoz.cjb.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2004-03-06 at 13:10, Jon Smirl wrote:
> Can this be written as a generic i2c probe function by calling i2c chanel
> functions instead of directly calling radeon_gpio_setscl, etc? The i2c chanel
> functions will then in turn call radeon_gpio_setscl, etc.

Why ? we aren't doing normal i2c big banging here, just hacking
around.

> I was under the impression that this code is used to wake up old style DDC chips
> in the monitor. Waking them up is a function of the monitor, not the radeon
> card. If that is right, this is a monitor problem and this code needs to be in
> every DDC driver, not just the radeon one. On the other hand I've tried every
> old monitor I have around here and none of them need this code.

Why the hell are you folks trying to change that perfectly working code?

We have much more important things to do at this point.

Ben.

> --- Kronos <kronos@kronoz.cjb.net> wrote:
> > Il Sat, Mar 06, 2004 at 10:55:14AM +1100, Benjamin Herrenschmidt ha scritto: 
> > > On Sat, 2004-03-06 at 08:52, Kronos wrote:
> > > > Hi,
> > > > radeon_probe_i2c_connector contains very strange code that just send
> > > > empty start-stop sequencies on the I2C bus. I copied the code from
> > > > XFree86, but speaking with I2C gurus the general feeling is that this
> > > > code can go away without any harm. I tested it on 3 different setup (all
> > > > x86...) and it works well. I don't have any "old" monitor around to
> > > > fiddle with though.
> > > > 
> > > > Oh, if you think that this code should stay I'll send you another patch
> > > > to make it more readable.
> > > 
> > > I'd rather keep the code as close to XFree as possible at this point..
> > 
> > Ok, what about this (cosmetic) patch:
> > 
> > --- linux-2.6/drivers/video/aty/radeon_i2c.c.orig	Sat Feb 28 18:11:42 2004
> > +++ linux-2.6/drivers/video/aty/radeon_i2c.c	Sat Feb 28 18:49:31 2004
> > @@ -174,65 +174,59 @@
> >  int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8
> > **out_edid)
> >  {
> >  	u32 reg = rinfo->i2c[conn-1].ddc_reg;
> > +	struct radeon_i2c_chan *chan = &rinfo->i2c[conn-1];
> >  	u8 *edid = NULL;
> >  	int i, j;
> >  
> >  	OUTREG(reg, INREG(reg) & 
> >  			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
> >  
> > -	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
> > -	(void)INREG(reg);
> > +	radeon_gpio_setscl(chan, 1);
> >  
> >  	for (i = 0; i < 3; i++) {
> >  		/* For some old monitors we need the
> >  		 * following process to initialize/stop DDC
> >  		 */
> > -		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
> > -		(void)INREG(reg);
> > +		radeon_gpio_setsda(chan, 1);
> >  		wait_ms(13);
> >  
> > -		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
> > -		(void)INREG(reg);
> > +		radeon_gpio_setscl(chan, 1);
> >  		for (j = 0; j < 5; j++) {
> > +			/* Wait for ack */
> >  			wait_ms(10);
> > -			if (INREG(reg) & VGA_DDC_CLK_INPUT)
> > +			if (radeon_gpio_getscl(chan))
> >  				break;
> >  		}
> >  		if (j == 5)
> >  			continue;
> >  
> > -		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
> > -		(void)INREG(reg);
> > +		radeon_gpio_setsda(chan, 0);
> >  		wait_ms(15);
> > -		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
> > -		(void)INREG(reg);
> > +		radeon_gpio_setscl(chan, 0);
> >  		wait_ms(15);
> > -		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
> > -		(void)INREG(reg);
> > +		radeon_gpio_setsda(chan, 1);
> >  		wait_ms(15);
> >  
> >  		/* Do the real work */
> > -		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);
> > +		edid = radeon_do_probe_i2c_edid(chan);
> >  
> > -		OUTREG(reg, INREG(reg) | 
> > -				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
> > -		(void)INREG(reg);
> > +		radeon_gpio_setsda(chan, 0);
> > +		radeon_gpio_setscl(chan, 0);
> >  		wait_ms(15);
> > -		
> > -		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
> > -		(void)INREG(reg);
> > +	
> > +		radeon_gpio_setscl(chan, 1);
> >  		for (j = 0; j < 10; j++) {
> > +			/* Wait for ack */
> >  			wait_ms(10);
> > -			if (INREG(reg) & VGA_DDC_CLK_INPUT)
> > +			if (radeon_gpio_getscl(chan))
> >  				break;
> >  		}
> >  
> > -		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
> > -		(void)INREG(reg);
> > +		radeon_gpio_setsda(chan, 1);
> >  		wait_ms(15);
> > -		OUTREG(reg, INREG(reg) |
> > -				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
> > -		(void)INREG(reg);
> > +
> > +		radeon_gpio_setsda(chan, 0);
> > +		radeon_gpio_setscl(chan, 0);
> >  		if (edid)
> >  			break;
> >  	}
> > 
> > In this way it clearer what's going on.
> > 
> > Luca
> > -- 
> > Home: http://kronoz.cjb.net
> > "Sei l'unica donna della mia vita".
> > (Adamo)
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Search - Find what youre looking for faster
> http://search.yahoo.com
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
