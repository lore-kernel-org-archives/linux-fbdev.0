From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Tue, 21 Sep 2004 03:38:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409210338.00863.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <1095672428.13735.3.camel@gaston> <20040920085214.0abe33a0.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267251AbUITThY@vger.kernel.org>
In-Reply-To: <20040920085214.0abe33a0.akpm@osdl.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

On Monday 20 September 2004 23:52, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >  Andrew, Any reason why this patch isn't upstream ? The recent changes
> >  to fbdev in 2.6.9-* are a regression and we need this patch to get bac
> >  the video=ofonly feature.
>
> Well I have a whole bunch of fbcon/fbdev patches here, but at some point
> one needs to plug the flow so we can get 2.6.9 out the door.  And nobody
> told me (until now) that we had a problem.
>
> Tony, which of the below shold be merged into 2.6.9?
>

> fbdev-fix-userland-compile-breakage.patch
> fbcon-fix-fbcons-setup-routine.patch
> fbdev-arrange-driver-order-in-makefile.patch

These 3 need to go to mainline.

> fbdev-fix-logo-drawing-failure-for-vga16fb.patch
> fbcon-fix-setup-boot-options-of-fbcon.patch

These 2 need not go immediately as no one will probably notice what they
fixed.

> radeonfb-fix-warnings-about-uninitialized-variables.patch

I haven't seen this.

> fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
> fbdev-initialize-i810fb-after-agpgart.patch
> fbdev-pass-struct-device-to-class_simple_device_add.patch
> fbdev-add-tile-blitting-support.patch
> fbdev-fix-scrolling-corruption.patch
> fbdev-remove-i810fb-explicit-agp-initialization-hack.patch

These can wait.

Tony
