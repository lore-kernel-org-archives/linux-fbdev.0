From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 6/8] fbcon/fbdev: Remove fbc
Date: Wed, 3 Nov 2004 01:17:25 +0100
Message-ID: <20041103001725.GB24964@vana.vc.cvut.cz>
References: <82235870BEB@vcnet.vc.cvut.cz> <200411030512.16925.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP8qB-0003jt-Gz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 16:17:31 -0800
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CP8qA-0002tR-8q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 16:17:31 -0800
Content-Disposition: inline
In-Reply-To: <200411030512.16925.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On Wed, Nov 03, 2004 at 05:12:15AM +0800, Antonino A. Daplas wrote:
> On Tuesday 02 November 2004 19:46, Petr Vandrovec wrote:
> > On  2 Nov 04 at 19:46, Antonino A. Daplas wrote:
> > > diff -Nru a/drivers/video/matrox/matroxfb_base.c
> > > b/drivers/video/matrox/matroxfb_base.c ---
> > > a/drivers/video/matrox/matroxfb_base.c  2004-10-23 02:52:37 +08:00 +++
> > > b/drivers/video/matrox/matroxfb_base.c  2004-11-01 08:32:54 +08:00 @@
> > > -1877,16 +1876,21 @@
> > >     }
> > >     printk("fb%d: %s frame buffer device\n",
> > >            ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
> > > -   if (ACCESS_FBINFO(fbcon.currcon) < 0) {
> > > -       /* there is no console on this fb... but we have to initialize
> > > hardware -        * until someone tells me what is proper thing to do */
> > > -       printk(KERN_INFO "fb%d: initializing hardware\n",
> > > -           ACCESS_FBINFO(fbcon.node));
> > > -       /* We have to use FB_ACTIVATE_FORCE, as we had to put
> > > vesafb_defined to the fbcon.var -        * already before, so
> > > register_framebuffer works correctly. */ -       vesafb_defined.activate
> > > |= FB_ACTIVATE_FORCE;
> > > -       fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
> > > -   }
> > > +   /*
> > > +    * Tony: If this driver is to be mapped to the console, then
> > > +    *       fbcon will automatically do a set_par for us.  The code
> > > below +    *       may not be needed.
> > > +    */
> >
> > Code below (which you made unconditional now) was executed if and only if
> > there is no fbcon attached to this device.  If there is fbcon attached
> > to this device, fbcon.currcon would be >= 0 after register_framebuffer()
> > (and fbcon's startup already did needed set_*).  If there is no fbcon,
> > this adapter is secondary, and it must be initialized too before leaving
> > driver.  But it must not be initialized before call to
> > register_framebuffer, as otherwise taking over vgacon won't work correctly.
> >
> > You could put some 'ACCESS_FBINFO(flags.hw_initialized) = 1' somewhere
> > into matroxfb's set_par and then test this flag instead of fbcon.currcon.
> >
> > But your current code probably does not work very well on primary adapter.
> 
> Why not just leave the hardware uninitialized after register_framebuffer? Then,
> initialize it at the first call to xxxfb_open()?  We can even check a
> flag so we do this only once. This way if people accidentally enabled
> matroxfb but forgot to enable fbcon, they will still get a usable vga
> console.

Because hardware driver is supposed to drive hardware.   Plus I do not agree
with paradigm that open should do something special unless each open provides
completely separate view (like opening /dev/ptmx).  Harddisk also does not
spin up when you open /dev/hda and does not stop when you close it.
					Petr Vandrovec



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
