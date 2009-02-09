From: Andres Salomon <dilinger@queued.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 14/15] amifb: check fb_alloc_cmap
 return value and handle failure properly
Date: Mon, 9 Feb 2009 16:51:31 -0500
Message-ID: <20090209165131.4c625d4c@ephemeral>
References: <20090207121857.6bc5d5bc@ephemeral>
	<20090209212629.611bd99d.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755981AbZBIVv5@vger.kernel.org>
In-Reply-To: <20090209212629.611bd99d.krzysztof.h1@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, 9 Feb 2009 21:26:29 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> On Sat, 7 Feb 2009 12:18:57 -0500
> Andres Salomon <dilinger@queued.net> wrote:
> 
> > 
> > Signed-off-by: Andres Salomon <dilinger@debian.org>
> > ---
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> One comment below.
[...]
> > @@ -2456,7 +2458,8 @@ amifb_error:
> >  
> >  static void amifb_deinit(void)
> >  {
> > -	fb_dealloc_cmap(&fb_info.cmap);
> > +	if (fb_info.cmap.len)
> > +		fb_dealloc_cmap(&fb_info.cmap);
> 
> Again, is the "if(fb_info.cmap.len)" needed here?

Yep; amifb_deinit is called from amifb_init in the case of errors.
This can happen before fb_alloc_cmap is called (but after the memory
region has been requested), so we need to explicitly check that cmap
memory has been allocated.
