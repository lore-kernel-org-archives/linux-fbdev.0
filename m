From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb in 2.5.51
Date: 11 Dec 2002 00:11:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039561870.538.28.camel@zion>
References: <15862.27438.787187.93003@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <15862.27438.787187.93003@argo.ozlabs.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Tue, 2002-12-10 at 23:31, Paul Mackerras wrote:
> I tried 2.5.51 on my G3 powerbook (laptop), which has a Rage LT Pro
> video chip (ID 0x4c49 or LI).  With the patch below, atyfb compiles
> and seems to mostly work.  However, I didn't see any penguin on boot.
> Instead the top inch or so of the screen was just black.
> 
> X seems to be running just fine.  I have 'Option "UseFBDev"' in my
> /etc/X11/XF86Config-4.

AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
Marc Aurele La France (maintainer of this driver) is basically allergic
to kernel fbdev support.

> What doesn't work is changing VTs from X to a
> text console.  If I press ctrl-alt-F1, for instance, the colormap
> changes but I don't see anything get redrawn.  The screen looks just
> like what I had in X but with the altered colormap.  If I then press
> alt-F7, it switches back to X and X redraws the screen properly and
> restores its colormap.

I don't know if happened with earlier fbdev versions for you, but one
possibility is that X reconfigures the display base, and possibly more
bits of the card's internal memory map. Either fbdev should restore
that, or adapt to what X set. On R128's and radeon's, this is things
like DISPLAY_BASE_ADDR.
 
> The patch below also takes out the CONFIG_NVRAM stuff since it doesn't
> work and I don't believe anyone has ever used it.

Yup, it's some wacky old pmac stuff that should be killed.
 
> I have also tried aty128fb with some local patches to get it to
> compile for my G4 powerbook.  It also doesn't draw the penguin, and it
> oopses when X starts, for some reason.

Hrm... I'll have to test radeonfb... It worked yesteday in console (I
don't remember about the penguin) but I didn't try X.
 
