From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?Locking_problem=3A_fb=5Finfo-=3Eloc?=
	=?utf-8?q?k_and_mm-=3Emmap=5Fsem?=
Date: 11 May 2009 08:46:28 +0200
Message-ID: <20090511064629.0DB50860D99@f23.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M3PHf-0006Kx-JZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 06:46:43 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M3PHV-0003zk-Rt for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 May 2009 06:46:43 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.o>

Andrew Morton napisa=B3(a):
> On Sun, 10 May 2009 20:34:55 +0200 Krzysztof Helt >krzysztof.h1@poczta.fm>
> wrote:
> =

> > I can prepare the patch which contains changes
> > equivalent to revert of these fixes.
> > =

> > This version does not show any problems. =

> =

> That sounds like an OK plan to me.  Doing this via separate manual
> reversion patches would make things easier to maintain, assuming that
> this is a 2.6.31 activity.
> =


I suppose it should go into the 2.6.30 as it fixes a current problem.

> It might be that the old bkl-based code was simply buggy, because
> lock_kernel() gets secretly unlocked by so many operations.  It doesn't
> matter, really.
> =


I suppose that the BKL worked because it was recursive.

> Restoring the lock_kernel()s would make people sad.  Do you have a plan
> to de-BKL the fbdev code via other means?  That wasn't clear from your
> email.
> =

>


Not at the moment. I would like to fix some issues pending (e.g.
nvidia problem with suspend).

I think it was very close to de-bKL with my mm_lock patch
as the last issue I found can only happen if there is more
than one framebuffer (probe and release at the same time).

Regards,
Krzysztof

----------------------------------------------------------------------
Do wygrania 100 podw=F3jnych zaprosze=F1!
Sprawdz >> http://link.interia.pl/f2160 =






---------------------------------------------------------------------------=
---
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i7=
00
Series Scanner you'll get full speed at 300 dpi even with all image =

processing features enabled. http://p.sf.net/sfu/kodak-com
