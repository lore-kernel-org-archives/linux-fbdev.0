From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: hi-res fb console with 2.6.0-testX ?
Date: Tue, 9 Sep 2003 00:38:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030908223814.GA4495@vana.vc.cvut.cz>
References: <C71CD161531@vcnet.vc.cvut.cz> <Pine.GSO.4.21.0309082255570.3273-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309082255570.3273-100000@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, cheapisp@sensewave.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Sep 08, 2003 at 10:57:34PM +0200, Geert Uytterhoeven wrote:
> On Mon, 8 Sep 2003, Petr Vandrovec wrote:
> 
> > And whole fb subsystem changed semantic, so do not build both
> > vesafb & matroxfb into the kernel - either one or another, or
> > you'll be definitely surprised what will happen (and I'm almost
> > sure that blank screen is not what you want).
> 
> What's wrong with the resource system that prevents this from working?

vesafb ignore failures... for framebuffer it just prints warning only, and
for 0x3C0 region it just completely ignores warning (due to vgacon
clash). But it should not be serious, user should just get console 
on matroxfb, and vesafb on /dev/fb1 doing nothing.

Main thing which prevents this from working as users expects is that
modular fbdevs cannot be used by fbcon. So people cannot create
initrd scripts which load proper fbdev driver anymore, after detecting
hardware and making sure that hardware & user wishes & driver are
compatible. They now have to build fbdevs to the kernel, and hope for
the best...
					Best regards,
						Petr Vandrovec
