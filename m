From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 16:17:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916141713.GA1694@dreamland.darkstar.lan>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan> <20030915235832.M10328@flint.arm.linux.org.uk> <20030916134009.GA1011@dreamland.darkstar.lan> <20030916144459.A20141@flint.arm.linux.org.uk>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zGef-0000WD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 07:18:09 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zGed-0003BF-VV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 07:18:08 -0700
Content-Disposition: inline
In-Reply-To: <20030916144459.A20141@flint.arm.linux.org.uk>
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

Il Tue, Sep 16, 2003 at 02:44:59PM +0100, Russell King ha scritto: 
> On Tue, Sep 16, 2003 at 03:40:09PM +0200, Kronos wrote:
> > Il Mon, Sep 15, 2003 at 11:58:32PM +0100, Russell King ha scritto: 
> > > On Tue, Sep 16, 2003 at 12:17:42AM +0200, Kronos wrote:
> > > > Il Mon, Sep 15, 2003 at 10:40:42PM +0100, Russell King ha scritto: 
> > > > > There is another reason why the above is fundamentally flawed - who says
> > > > > that "release_cfb_info" will still be in module space by the time you
> > > > > need to call it?
> > > > > 
> > > > > Eg, you unload your framebuffer driver module immediately after the device
> > > > > has gone away, but someone is keeping the sysfs files associated with
> > > > > the fb_info open.
> > > > 
> > > > I'm quite sure that this can't happen. If someone is keeping a sysfs
> > > > file open module use count won't be zero. Right?
> > > 
> > > Where are you handling the module use count of the framebuffer driver?
> > 
> > Every   attribute   (ie.  sysfs   file)   has   a  .owner   field   (see
> > include/linux/sysfs.h), the module  use count is handled  by sysfs. If a
> > sysfs file is open the module can't be unloaded.
> 
> The .owner field is set to the module which defined the sysfs attribute.
> This wouldn't be the driver, but would be some other part of the framebuffer
> layer.

Good point. I  was thinking  at files  created by  the driver  itself, I
forgot about  dev attribute. I  can overwrite  .owner of  dev attribute,
fbmem can't be built as module. Sounds good?

> > > Is there somewhere I can view the core changes?
> > 
> > They are on fbdev for review, I put a copy here:
> > http://web.tiscali.it/kronoz/linux/fbdev-class_dev-fbmem.c.diff
> 
> When I tried to get at the fbdev site, it seemed to be down.  Maybe
> some of the kernel documentation needs to be updated?

Try here: http://linux-fbdev.sf.net
Mailing lists are here: http://linux-fbdev.sourceforge.net/mlist.html

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
