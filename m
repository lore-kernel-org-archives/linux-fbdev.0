From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Mon, 20 Sep 2004 08:52:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040920085214.0abe33a0.akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston>
	<200409110504.09812.adaplas@hotpop.com>
	<1095672428.13735.3.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266725AbUITPyk@vger.kernel.org>
In-Reply-To: <1095672428.13735.3.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  Andrew, Any reason why this patch isn't upstream ? The recent changes
>  to fbdev in 2.6.9-* are a regression and we need this patch to get bac
>  the video=ofonly feature.

Well I have a whole bunch of fbcon/fbdev patches here, but at some point
one needs to plug the flow so we can get 2.6.9 out the door.  And nobody
told me (until now) that we had a problem.

Tony, which of the below shold be merged into 2.6.9?

fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
fbdev-fix-logo-drawing-failure-for-vga16fb.patch
fbdev-initialize-i810fb-after-agpgart.patch
fbdev-fix-userland-compile-breakage.patch
fbcon-fix-setup-boot-options-of-fbcon.patch
fbdev-pass-struct-device-to-class_simple_device_add.patch
fbdev-add-tile-blitting-support.patch
fbcon-fix-fbcons-setup-routine.patch
fbdev-arrange-driver-order-in-makefile.patch
fbdev-fix-scrolling-corruption.patch
radeonfb-fix-warnings-about-uninitialized-variables.patch
fbdev-remove-i810fb-explicit-agp-initialization-hack.patch
