From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Tue, 22 Mar 2005 00:40:34 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
 <20050321145936.6f742d89.akpm@osdl.org>
Mime-Version: 1.0
In-Reply-To: <20050321145936.6f742d89.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jim.hague@acm.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, 21 Mar 2005, Andrew Morton wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > Hi
> > 
> > Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
> > becomes orange, penguins look sick (not sharp). X starts and runs normal 
> > (doesn't use fb), switching to vt not possible any more. Disabling 
> > fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
> > problem.
> 
> Guennadi, could you please confirm that
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
> 
> fixes this one?

As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X 
switching problem. We still don't know why starting with 2.4.11 I have to 
switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images. Jim 
says it is doubtful that this option brings any optimisations at all, 
still, it is a bit worrying, that something that worked with earlier 
kernels stopped working now. I traced this breakage down to the patch to 
pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem with 
my fb-geometry / colour settings, but I haven't heard from him since then, 
Jim?

Thanks
Guennadi
---
Guennadi Liakhovetski
