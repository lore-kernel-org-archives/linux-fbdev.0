From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_initialize_fb=5Finfo-?=
	=?utf-8?q?=3Elock_mutex_in_the_framebuffer=5Falloc=28=29?=
Date: 04 May 2009 13:47:07 +0200
Message-ID: <20090504114707.A6CBA313C52@f48.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0wde-0005WS-Nr
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 11:47:14 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0wda-0007U5-JC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 11:47:14 +0000
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

Geert Uytterhoeven napisa=B3(a):
> On Sun, May 3, 2009 at 23:30, Krzysztof Helt >krzysztof.h1@poczta.fm>
> wrote:
> > From: Krzysztof Helt >krzysztof.h1@wp.pl>
> >
> > The fb_info->lock mutex should be initialized inside
> > the framebuffer_alloc() function. Otherwise, someone
> > may call a fb layer function which indirectly uses uninitialized
> > mutex.
> > Move initialization of the mutex from the register_framebuffer()
> > to framebuffer_alloc().
> >
> > This may cause problems for drivers which do not use
> > the framebuffer_alloc() to allocate the fb_info structure.
> > Convert the two last drivers to use the framebuffer_alloc().
> =

> > diff -urp linux-orig/drivers/video/igafb.c
> linux-2.6.30/drivers/video/igafb.c
> > diff -urp linux-orig/drivers/video/offb.c
> linux-2.6.30/drivers/video/offb.c
> =

> Are these really the only 2 remaining ones? What about amifb and atafb
> (from the top of my head)?
> =


I have checked the latest 2.6.30-rc4 tree and there are more drivers
which do not use the framebuffer_alloc(). There are four groups:

1. The fb_info structure is declared as a static variable (9 drivers).  =


2. The fb_info structure is part of another structure declared as
the static variable (2 drivers)

3. The fb_info structure is allocated using kzalloc or kmalloc (3 drivers).

4. The fb_info structure is part of a bigger structure which is
allocated using kzalloc or kmalloc (12 drivers).

The third group is an obvious candidate to use the framebuffer_alloc() =

and I will send patches for them (these are two drivers I already converted=
).

The fourth group should be converted to use framebuffer_alloc either by
putting fb_info pointer in the bigger structure or
using fb_info->par to point to the bigger structure.

The groups 1 and 2 are probably not worth converting. It is
ok to have a static fb_info if there is no physical possibility
to have two the same framebuffers inside one machine, e.g.
probably only one on-board amifb framebuffer is possible =

in the Amiga computer.

The 1 and 2 groups require a function fb_info_init() to
initialize non-zero fields in the framebuffer (e.g. mutexes).
The function can be used for the 4th group as well (at least
as a temporary solution).

Regards,
Krzysztof


----------------------------------------------------------------------
Szukasz pracy? Sprawd=BC nasze oferty!
http://link.interia.pl/f2142


---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
