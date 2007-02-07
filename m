From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Wed, 7 Feb 2007 11:48:25 +0000
Message-ID: <20070207114825.GA21120@fluff.org.uk>
References: <20070206192628.GA13644@fluff.org.uk>
	<20070206210930.fc814bf6.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HElIL-0001cY-I3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 03:49:01 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HElII-0007tO-Ot
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 03:49:01 -0800
Content-Disposition: inline
In-Reply-To: <20070206210930.fc814bf6.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Tue, Feb 06, 2007 at 09:09:30PM -0800, Andrew Morton wrote:
> On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
> 
> > This patch is an update patch, ready for merging
> > for the Silicon Motion SM501 multi-function device
> > core.
> > 
> > This driver handles the core function of the chip,
> > including the clock, power control and allocation
> > of resources for drivers. It also exports a series
> > of platform devices for the function drivers to
> > attach to.
> > 
> > This patch supports both platform and PCI bus
> > attached devices.
> > 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> Can we get Vincent's signoff here?
> 
> > +#ifdef CONFIG_DEBUG
> 
> This doesn't appear to be defined anywhere, and nor should it be. 
> Something subsystem-specific should be used here?

This protects the code being used by dev_dbg() only from being
warned as not being used.
 
> > +static const unsigned int misc_div[] = {
> > +	[0]		= 1,
> > +	[1]		= 2,
> > +	[2]		= 4,
> > +	[3]		= 8,
> > +	[4]		= 16,
> > +	[5]		= 32,
> > +	[6]		= 64,
> > +	[7]		= 128,
> > +	[8]		= 3,
> > +	[9]		= 6,
> > +	[10]		= 12,
> > +	[11]		= 24,
> > +	[12]		= 48,
> > +	[13]		= 96,
> > +	[14]		= 192,
> > +	[15]		= 384,
> > +};
> > +
> > +static const unsigned int px_div[] = {
> > +	[0]		= 1,
> > +	[1]		= 2,
> > +	[2]		= 4,
> > +	[3]		= 8,
> > +	[4]		= 16,
> > +	[5]		= 32,
> > +	[6]		= 64,
> > +	[7]		= 128,
> > +	[8]		= 3,
> > +	[9]		= 6,
> > +	[10]	        = 12,
> > +	[11]		= 24,
> > +	[12]		= 48,
> > +	[13]		= 96,
> > +	[14]		= 192,
> > +	[15]		= 384,
> > +	[16]		= 5,
> > +	[17]		= 10,
> > +	[18]		= 20,
> > +	[19]		= 40,
> > +	[20]		= 80,
> > +	[21]		= 160,
> > +	[22]		= 320,
> > +	[23]		= 604,
> > +};
> > +#endif
> > +
> > +#define decode_div(val, lshft, selbit, mask, dtab) \
> > +	((((val) & (selbit)) ? pll2 : 288 * MHZ) / dtab[(((val) >> (lshft)) & (mask))])
> 
> A C function would be nicer here, if poss.
> 
> > +#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
> 
> eww.

Do you have a better way of printing a nice formatted MHz with
fractional parts? Is it going to be necessary to remove this?

> > +		(void)readl(sm->regs);
> 
> Is there any benefit in all those casts?  Generally we prefer to avoid
> them.

I thoguht they where necessary to stop the compiler optimising
away the readl() ?
 
> > +EXPORT_SYMBOL_GPL(sm501_misc_control);
> 
> The driver exports a lot of symbols.  Does it really need to?

Yes, these are used by the drivers for the specific function
blocks in the chip.
 
> > +	down(&sm->clock_lock);
> 
> Please convert to a mutex, if possible.

The current callers are the device initialisation and ioctl() calls
from the framebuffer layer. I expect all the other callers to be from
ioctl() calls (to update device parameters) or possibly from sysfs
file interaction, so I think that a mutex may be okay for this.
 
> > +/* sm501_null_release
> > + *
> > + * A release function for the platform devices we create to keep the
> > + * driver core happy, and stop any crashed when the devices are removed
> > +*/
> > +
> > +static void sm501_null_release(struct device *dev)
> > +{
> > +}
> 
> Greg might have an opinion on that ;)

Without this the system OOPses when the driver is removed.
 
> > +static void sm501_create_mem(struct sm501_devdata *sm,
> > +			     struct resource *res,
> > +			     unsigned long *offs,
> > +			     unsigned long size)
> > +{
> > +	*offs -= size;		/* adjust memory size */
> > +
> > +	res->flags = IORESOURCE_MEM;
> > +	res->parent = sm->mem_res;
> > +	res->start = sm->mem_res->start + *offs;
> > +	res->end = res->start + size - 1;
> > +}
> 
> Please use resource_size_t throughout, test with CONFIG_RESOURCES_64BIT on
> and off.

I will go and fix this.5~
 
> > +static inline void sm501_init_reg(struct sm501_devdata *sm,
> > +				  unsigned long reg,
> > +				  struct sm501_reg_init *r)
> > +{
> > +	unsigned long tmp;
> > +
> > +	tmp = readl(sm->regs + reg);
> > +	tmp |= r->set;
> > +	tmp &= ~r->mask;
> > +	writel(tmp, sm->regs + reg);
> > +}
> 
> This might be too large to inline.

possibly.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
