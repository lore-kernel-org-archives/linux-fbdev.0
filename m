From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 15:40:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916134009.GA1011@dreamland.darkstar.lan>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan> <20030915235832.M10328@flint.arm.linux.org.uk>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zG4u-0005S2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 06:41:12 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zG4t-0004sh-Ia
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 06:41:11 -0700
Content-Disposition: inline
In-Reply-To: <20030915235832.M10328@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Il Mon, Sep 15, 2003 at 11:58:32PM +0100, Russell King ha scritto: 
> On Tue, Sep 16, 2003 at 12:17:42AM +0200, Kronos wrote:
> > Il Mon, Sep 15, 2003 at 10:40:42PM +0100, Russell King ha scritto: 
> > > There is another reason why the above is fundamentally flawed - who says
> > > that "release_cfb_info" will still be in module space by the time you
> > > need to call it?
> > > 
> > > Eg, you unload your framebuffer driver module immediately after the device
> > > has gone away, but someone is keeping the sysfs files associated with
> > > the fb_info open.
> > 
> > I'm quite sure that this can't happen. If someone is keeping a sysfs
> > file open module use count won't be zero. Right?
> 
> Where are you handling the module use count of the framebuffer driver?

Every   attribute   (ie.  sysfs   file)   has   a  .owner   field   (see
include/linux/sysfs.h), the module  use count is handled  by sysfs. If a
sysfs file is open the module can't be unloaded.

> I'm also confused why you want to keep the device IO regions around
> until all sysfs files have been closed.  I hope you're not thinking
> of touching the hardware after you've returned from the drivers
> ->remove method?

I tought  that some  sysfs file  may use those  things. I was  sure that
class_dev hold a  reference to pci_dev.dev, but that's  not the case. So
yes, that's a bad idea. I'll move pci stuff in the unregister function.

> Is there somewhere I can view the core changes?

They are on fbdev for review, I put a copy here:
http://web.tiscali.it/kronoz/linux/fbdev-class_dev-fbmem.c.diff

The patch is agains James Simmons tree.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vispa candela bruciava l'erbetta
creando un'essenza alquanto sospetta;
sembrava l'odore di una sacrestia
ma presto mi accorsi che era maria.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
