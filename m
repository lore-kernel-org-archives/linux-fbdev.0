From: Otto Solares <solca@guug.org>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 17:48:17 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030925234817.GB9615@guug.org>
References: <20030925060524.24191.qmail@web14909.mail.yahoo.com> <20030925192116.GA9615@guug.org> <20030925200155.GA11549@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2frO-0008Fu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 16:49:22 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2frN-00021Y-2I
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 16:49:21 -0700
Content-Disposition: inline
In-Reply-To: <20030925200155.GA11549@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Sep 25, 2003 at 10:01:55PM +0200, Kronos wrote:
> Il Thu, Sep 25, 2003 at 01:21:16PM -0600, Otto Solares ha scritto: 
> > On Wed, Sep 24, 2003 at 11:05:24PM -0700, Jon Smirl wrote:
> > > Here is a sample of what sysfs looks like with the new radeon driver. I have an
> > > Intel 875 chipset so there are three buses: 0 - system, 1 - AGP, 2 - PCI. Note
> > > that the EDID block is available.
> > 
> > This is so cool!
> > 
> > > I was thinking about adding these attributes to the fb device: geometry,
> > > timings, interlaced, hsync, vsync. and then writing a new fbset command.
> > 
> > Plz add that too as is useful info, and has the potential to remove a lot
> > of ioctls in userspace code.
> > 
> > Where can i grab these changes?, are these radeon specific? what about r128?
> 
> EDID stuff is radeon specific, sysfs and class_device no. James Simmons
> is merging sysfs & class_dev code. I'm working on it here:
> 
> bk://mesa3d.bkbits.net/fbdev-2.5
> 
> You can find new radeon driver here:
> 
> bk://ppc.bkbits.net/linuxppc-2.5-benh
> 
> Once core changes are in we can start exporting other attributes.

Good! is somewhere a plain diff as i don't know how to use bk?

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
