From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: 04 Dec 2002 17:08:53 +0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039003565.1079.67.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
	<1038917280.1228.7.camel@localhost.localdomain> 
	<20021204073218.GA1025@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021204073218.GA1025@iliana>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2002-12-04 at 12:32, Sven Luther wrote:
> On Tue, Dec 03, 2002 at 05:22:35PM +0500, Antonino Daplas wrote:
> > >   2) The ability to go back to vga text mode on close of /dev/fb. 
> > >      Yes fbdev/fbcon supports that now. 
> > 
> > I'll take a stab at writing VGA save/restore routines which hopefully is
> > generic enough to be used by various hardware.  No promises though, VGA
> > programming gives me a headache :(
> 
> BTW, i am writing a fbdev for a card where the docs tell me to disable
> vga output before enabling graphical output. Does i need to do this in
> the fbdev i write, or is it already handled by the vga layer, or
> whatever ?

Most cards with a VGA core needs to disable the VGA output before going
to graphics mode.  Disabling VGA output is hardware specific, and is
usually automatic when you go to graphics mode.

Because James wrote the fb framework to be very modular, then you must
be careful to save/restore the initial video state  when loading or
unloading.  Theoretically, a driver should load, but not go to graphics
mode immediately.  Only upon a call to xxxfb_set_par() should the driver
do so.  Before going to graphics mode, that's were you save the initial
state.  Have a reference count or something to keep track of the number
of users, and when this reference count becomes zero, restore the
initial state.  You should be able to do this by hooking these routines
in fb_open() and fb_release().

The one I submitted (and a revised one I'm going to submit soon) should
be able to restore the VGA text/graphics mode.  Complement this with
your hardware's extended state save and restore routines and you should
be able to load/use/unload your driver repeatedly :-).

Tony

Tony
