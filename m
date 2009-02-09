From: Andres Salomon <dilinger@queued.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 8/15] stifb: check fb_alloc_cmap
 return value and handle failure properly
Date: Mon, 9 Feb 2009 13:57:21 -0500
Message-ID: <20090209135721.1db97470@ephemeral>
References: <20090207121506.427d1cd8@ephemeral>
	<20090209180549.cb07d0fb.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756641AbZBIS5g@vger.kernel.org>
In-Reply-To: <20090209180549.cb07d0fb.krzysztof.h1@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, j@mx08.poczta.interia.pl, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, 9 Feb 2009 18:05:49 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> On Sat, 7 Feb 2009 12:15:06 -0500
> Andres Salomon <dilinger@queued.net> wrote:
> 
> > 
> > Signed-off-by: Andres Salomon <dilinger@debian.org>
> > ---
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> I feel something is not right with the driver if memory 
> region (info->screen_base) is io mapped first then
> reserved with request_mem_region().
> 
> Regards,
> Krzysztof

Yeah, I noticed quite a few other bugs while going through cmap brokenness,
and I'm not even done w/ the cmap stuff yet.  I figured I'd do one thing at
a time.

Thanks for the Acks!
