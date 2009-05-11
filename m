From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Locking problem: fb_info->lock and
	mm->mmap_sem
Date: Mon, 11 May 2009 16:29:55 -0700
Message-ID: <20090511162955.b4684e25.akpm@linux-foundation.org>
References: <20090511064629.0DB50860D99@f23.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M3f0L-0007Ps-VU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 23:33:53 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M3f0K-0007WU-S2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 23:33:53 +0000
In-Reply-To: <20090511064629.0DB50860D99@f23.poczta.interia.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, righi.andrea@gmail.com

On 11 May 2009 08:46:28 +0200
krzysztof.h1@poczta.fm wrote:

> Andrew Morton napisa__(a):
> > On Sun, 10 May 2009 20:34:55 +0200 Krzysztof Helt >krzysztof.h1@poczta.fm>
> > wrote:
> > 
> > > I can prepare the patch which contains changes
> > > equivalent to revert of these fixes.
> > > 
> > > This version does not show any problems. 
> > 
> > That sounds like an OK plan to me.  Doing this via separate manual
> > reversion patches would make things easier to maintain, assuming that
> > this is a 2.6.31 activity.
> > 
> 
> I suppose it should go into the 2.6.30 as it fixes a current problem.

OK.  Were you planning on sending the patches?

I could put the patches together here, but it'd be good if you could
send along the git commit IDs to reduce the risk of me screwing it up.


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
