From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:33:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915223331.H10328@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915220742.G10328@flint.arm.linux.org.uk> <20030915212809.GA24924@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0yX-0004hE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:33:37 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19z0yW-000737-D3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:33:36 -0700
Content-Disposition: inline
In-Reply-To: <20030915212809.GA24924@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Mon, Sep 15, 2003 at 11:28:09PM +0200
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
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Mon, Sep 15, 2003 at 11:28:09PM +0200, Kronos wrote:
> > > @@ -1635,6 +1638,16 @@
> > >  	return err;
> > >  }
> > >  
> > > +static void release_cfb_info(struct fb_info *info) {
> > > +	struct cfb_info *cfb = info->par;
> > > +
> > > +	iounmap(cfb->region);
> > > +	fb_alloc_cmap(&info->cmap, 0, 0);
> > > +
> > > +	if (cfb->dev)
> > > +		pci_release_regions(cfb->dev);
> > > +}
> > > +
> > >  static void __devexit cyberpro_pci_remove(struct pci_dev *dev)
> > >  {
> > >  	struct cfb_info *cfb = pci_get_drvdata(dev);
> > 
> > Who says "cfb->dev" remains valid after the PCI device has been removed.
> > This looks like a perfect use-after-free bug waiting to happen.
> 
> cfb->dev is  refcounted, it  won't go  away until we  are done  with the
> cleanup. Maybe I misread  driver core code...

pci_request_regions / pci_release_regions does not perform any reference
counting on the pci device.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
