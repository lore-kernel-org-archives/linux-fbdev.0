From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Locking problem: fb_info->lock and
	mm->mmap_sem
Date: Sun, 10 May 2009 14:02:44 -0700
Message-ID: <20090510140244.91749527.akpm@linux-foundation.org>
References: <20090510203455.2ff347e9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M3GDo-0004Yp-Qk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 May 2009 21:06:08 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M3GDf-0004jz-I7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 May 2009 21:06:08 +0000
In-Reply-To: <20090510203455.2ff347e9.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Uytterhoeven <geert@linux-m68k.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Geert, Andrea Righi <righi.andrea@gmail.com>

On Sun, 10 May 2009 20:34:55 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> I can prepare the patch which contains changes
> equivalent to revert of these fixes.
> 
> This version does not show any problems. 

That sounds like an OK plan to me.  Doing this via separate manual
reversion patches would make things easier to maintain, assuming that
this is a 2.6.31 activity.

It might be that the old bkl-based code was simply buggy, because
lock_kernel() gets secretly unlocked by so many operations.  It doesn't
matter, really.

Restoring the lock_kernel()s would make people sad.  Do you have a plan
to de-BKL the fbdev code via other means?  That wasn't clear from your
email.



------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
