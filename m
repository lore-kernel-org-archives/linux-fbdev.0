From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: matroxfb: fix regression with uninitalized fb_info->mm_lock
 mutex (second head)
Date: Tue, 7 Jul 2009 13:30:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907071327370.3210@localhost.localdomain>
References: <20090707223413.d56c6a7f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757025AbZGGUdT@vger.kernel.org>
In-Reply-To: <20090707223413.d56c6a7f.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, rjw@sisk.pl, stable@kernel.org



On Tue, 7 Jul 2009, Krzysztof Helt wrote:
> 
> Remove redundant locking by the mm_lock mutex before a second head of matrox 
> framebuffer is registered.

Why do you write misleading commentary like this.

> +/*
> + * This function is called before the register_framebuffer so
> + * no locking is needed.
> + */

Or this?

It's not about "needed". The locking is not only not needed, it would be 
BUGGY.

And it's not "redundant". That implies that it's done somewhere else. It's 
more than "not needed" - it would be actively buggy to lock things there.

I really don't like how you're approaching this. You're ignoring the real 
issues I ask you, you're writing misleading comments and commit messages, 
and the end result is fragile code. I still don't understand why you 
insist on initializing those things late, which is the primary problem 
here.

		Linus
