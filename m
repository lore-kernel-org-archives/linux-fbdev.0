From: James Simmons <jsimmons@infradead.org>
Subject: Re: vga16fb broke
Date: Wed, 19 May 2004 23:09:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0405192307240.28783-100000@phoenix.infradead.org>
References: <20040518173845.1e03288c.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264637AbUESWJk@vger.kernel.org>
In-Reply-To: <20040518173845.1e03288c.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: VANDROVE@vc.cvut.cz, vince@kyllikki.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> > >  	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
> > >  
> > > -	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
> > > +	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);
> > >  	if (!vga16fb.screen_base) {
> > >  		printk(KERN_ERR "vga16fb: unable to map device\n");
> > >  		ret = -ENOMEM;
> > 
> > This will make the driver on all platforms. 
> 
> There's a missing word in that sentence.  Was it "work" or "crash"?  This
> matters ;)

works :-)

> > > and that ARM and others need to teach their VGA_MAP_MEM() to do an internal
> > > ioremap().
> > > 
> > > Or do you mean something else?  Please be more clear?
> > 
> > I like to see the VGA_MAP_MEM hack go away and be replaced with ioremap.
> 
> If you can cut a patch we can ask arch maintainers to review and test it.

I could but that would take some time. For now apply your fix.
Actually Ihave a newer vga16 driver for you I can push you.
