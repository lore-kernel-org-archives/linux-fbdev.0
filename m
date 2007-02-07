From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Wed, 7 Feb 2007 17:09:49 +0000
Message-ID: <20070207170949.GD21120@fluff.org.uk>
References: <20070206192628.GA13644@fluff.org.uk>
	<20070206210930.fc814bf6.akpm@linux-foundation.org>
	<20070207114825.GA21120@fluff.org.uk>
	<20070207085225.c2371cfd.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEqK2-0001Yo-4e for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 09:11:11 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEqJw-0003CP-1t
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 09:11:06 -0800
Content-Disposition: inline
In-Reply-To: <20070207085225.c2371cfd.akpm@linux-foundation.org>
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

On Wed, Feb 07, 2007 at 08:52:25AM -0800, Andrew Morton wrote:
> On Wed, 7 Feb 2007 11:48:25 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
> 
> > On Tue, Feb 06, 2007 at 09:09:30PM -0800, Andrew Morton wrote:
> > > On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
> > > 
> > > > This patch is an update patch, ready for merging
> > > > for the Silicon Motion SM501 multi-function device
> > > > core.
> > > > 
> > > > This driver handles the core function of the chip,
> > > > including the clock, power control and allocation
> > > > of resources for drivers. It also exports a series
> > > > of platform devices for the function drivers to
> > > > attach to.
> > > > 
> > > > This patch supports both platform and PCI bus
> > > > attached devices.
> > > > 
> > > > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > > 
> > > Can we get Vincent's signoff here?
> > > 
> > > > +#ifdef CONFIG_DEBUG
> > > 
> > > This doesn't appear to be defined anywhere, and nor should it be. 
> > > Something subsystem-specific should be used here?
> > 
> > This protects the code being used by dev_dbg() only from being
> > warned as not being used.
> 
> I know what is does, but I query the use of "CONFIG_DEBUG".  I don't think
> there's a CONFIG_DEBUG defined in existing Kconfig, and your patch doesn't
> add a CONFIG_DEBUG and nor should it, because that would be an
> inappropriate identifier to use.
> 
> So I'd suggest you just use DEBUG, as many other drivers do.  Or call it
> CONFIG_SM501_DEBUG and add the Kconfig record to enable it.

You are right, too used to adding CONFIG_ from playing with Kconfig
 
> > > > +#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
> > > 
> > > eww.
> > 
> > Do you have a better way of printing a nice formatted MHz with
> > fractional parts?
> 
> Nope.
> 
> >  Is it going to be necessary to remove this?
> 
> Nope.  But ewww.
> 
> > > > +		(void)readl(sm->regs);
> > > 
> > > Is there any benefit in all those casts?  Generally we prefer to avoid
> > > them.
> > 
> > I thoguht they where necessary to stop the compiler optimising
> > away the readl() ?
> 
> No, that shuldn't be necessary.  If it was, the compiler would optimise
> away the first readl() in 
> 
> 	my_local = readl(foo);
> 	my_local = readl(bar);
> 
> which would break stuff.  readl() implementations use volatile to prevent
> this.

Ok, i've moved these into their own function called
sm501_sync_regs() to make it more explicit what it is
being used for.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
