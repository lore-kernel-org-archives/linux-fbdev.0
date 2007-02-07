From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Tue, 6 Feb 2007 21:09:30 -0800
Message-ID: <20070206210930.fc814bf6.akpm@linux-foundation.org>
References: <20070206192628.GA13644@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEf3w-0004sX-GR for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 21:09:44 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEf3u-0000K3-PA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 21:09:44 -0800
In-Reply-To: <20070206192628.GA13644@fluff.org.uk>
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: Greg KH <greg@kroah.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:

> This patch is an update patch, ready for merging
> for the Silicon Motion SM501 multi-function device
> core.
> 
> This driver handles the core function of the chip,
> including the clock, power control and allocation
> of resources for drivers. It also exports a series
> of platform devices for the function drivers to
> attach to.
> 
> This patch supports both platform and PCI bus
> attached devices.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Can we get Vincent's signoff here?

> +#ifdef CONFIG_DEBUG

This doesn't appear to be defined anywhere, and nor should it be. 
Something subsystem-specific should be used here?

> +static const unsigned int misc_div[] = {
> +	[0]		= 1,
> +	[1]		= 2,
> +	[2]		= 4,
> +	[3]		= 8,
> +	[4]		= 16,
> +	[5]		= 32,
> +	[6]		= 64,
> +	[7]		= 128,
> +	[8]		= 3,
> +	[9]		= 6,
> +	[10]		= 12,
> +	[11]		= 24,
> +	[12]		= 48,
> +	[13]		= 96,
> +	[14]		= 192,
> +	[15]		= 384,
> +};
> +
> +static const unsigned int px_div[] = {
> +	[0]		= 1,
> +	[1]		= 2,
> +	[2]		= 4,
> +	[3]		= 8,
> +	[4]		= 16,
> +	[5]		= 32,
> +	[6]		= 64,
> +	[7]		= 128,
> +	[8]		= 3,
> +	[9]		= 6,
> +	[10]	        = 12,
> +	[11]		= 24,
> +	[12]		= 48,
> +	[13]		= 96,
> +	[14]		= 192,
> +	[15]		= 384,
> +	[16]		= 5,
> +	[17]		= 10,
> +	[18]		= 20,
> +	[19]		= 40,
> +	[20]		= 80,
> +	[21]		= 160,
> +	[22]		= 320,
> +	[23]		= 604,
> +};
> +#endif
> +
> +#define decode_div(val, lshft, selbit, mask, dtab) \
> +	((((val) & (selbit)) ? pll2 : 288 * MHZ) / dtab[(((val) >> (lshft)) & (mask))])

A C function would be nicer here, if poss.

> +#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)

eww.

> +		(void)readl(sm->regs);

Is there any benefit in all those casts?  Generally we prefer to avoid
them.

> +EXPORT_SYMBOL_GPL(sm501_misc_control);

The driver exports a lot of symbols.  Does it really need to?

> +	down(&sm->clock_lock);

Please convert to a mutex, if possible.

> +/* sm501_null_release
> + *
> + * A release function for the platform devices we create to keep the
> + * driver core happy, and stop any crashed when the devices are removed
> +*/
> +
> +static void sm501_null_release(struct device *dev)
> +{
> +}

Greg might have an opinion on that ;)

> +static void sm501_create_mem(struct sm501_devdata *sm,
> +			     struct resource *res,
> +			     unsigned long *offs,
> +			     unsigned long size)
> +{
> +	*offs -= size;		/* adjust memory size */
> +
> +	res->flags = IORESOURCE_MEM;
> +	res->parent = sm->mem_res;
> +	res->start = sm->mem_res->start + *offs;
> +	res->end = res->start + size - 1;
> +}

Please use resource_size_t throughout, test with CONFIG_RESOURCES_64BIT on
and off.

> +static inline void sm501_init_reg(struct sm501_devdata *sm,
> +				  unsigned long reg,
> +				  struct sm501_reg_init *r)
> +{
> +	unsigned long tmp;
> +
> +	tmp = readl(sm->regs + reg);
> +	tmp |= r->set;
> +	tmp &= ~r->mask;
> +	writel(tmp, sm->regs + reg);
> +}

This might be too large to inline.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
