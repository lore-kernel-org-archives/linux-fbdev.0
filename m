From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix fb_info->lock and
	mm->mmap_sem ...} causes Xfbdev not working
Date: Thu, 9 Apr 2009 14:58:51 +0200
Message-ID: <20090409125850.GA2727@linux>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934038AbZDIM7Z@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Miao <eric.y.miao@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidjaar@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>

On Thu, Apr 09, 2009 at 07:36:24PM +0800, Eric Miao wrote:
> This happens on my Marvell PXA310-based Littleton platform with
> Angstrom Distribution. The offending paths are many:
> 
> FBIOPUT_VSCREENINFO:
>   lock_fb_info()
>   --> fb_set_var()
>     --> fb_notifier_call_chain() [FBINFO_MISC_USEREVENT]
>       --> fbcon_event_notifier() [FB_EVENT_MODE_CHANGE]
>         --> lock_fb_info()
> 
> OK, now hang. I'd suggest a clean fix to the original assumption of
> circular locking
> issue and revert this commit first.
> 
> -- 
> Cheers
> - eric

I can agree to revert 66c1ca019078220dc1bf968f2bb18421100ef147, since I
don't have a clean fix for this. Pushing down fb_info->lock in
fb_set_var() excluding to call fb_notifier_call_chain with fb_info->lock
held doesn't seem to be so trivial...

However, reverting this will re-introduce the circular locking
dependency fb_info->lock => mm->mmap_sem => fb_info->lock.

-Andrea
