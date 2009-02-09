From: Andres Salomon <dilinger@queued.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 13/15] amba-clcd: fix cmap memory
 leaks
Date: Mon, 9 Feb 2009 16:55:40 -0500
Message-ID: <20090209165540.523c2ce4@ephemeral>
References: <20090207121848.536b136d@ephemeral>
	<20090209211614.44459a12.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752970AbZBIVzy@vger.kernel.org>
In-Reply-To: <20090209211614.44459a12.krzysztof.h1@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, 9 Feb 2009 21:16:14 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> On Sat, 7 Feb 2009 12:18:48 -0500
> Andres Salomon <dilinger@queued.net> wrote:
> 
> > 
> >  - fix cmap leak in removal path
> >  - fix cmap leak when register_framebuffer fails
> > 
> > Signed-off-by: Andres Salomon <dilinger@debian.org>
> > ---
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> One comment (see below).
> 
[...]
> > @@ -485,6 +489,8 @@ static int clcdfb_remove(struct amba_device
> > *dev) 
> >  	clcdfb_disable(fb);
> >  	unregister_framebuffer(&fb->fb);
> > +	if (fb->fb.cmap.len)
> > +		fb_dealloc_cmap(&fb->fb.cmap);
> 
> Is this if() needed? Is this function called twice (or more) or
> can it be called without the cmap allocated?


It was added as a precaution due to the fb->board->remove callbacks,
but I think I misunderstood the code.  So my official answer is "I'm not
sure." :)





> 
> >  	iounmap(fb->regs);
> >  	clk_put(fb->clk);
> >  
> > -- 
> > 1.5.6.5
> > 
