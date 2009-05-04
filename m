From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_initialize_fb=5Finfo-?=
	=?utf-8?q?=3Elock_mutex_in_the_framebuffer=5Falloc=28=29?=
Date: 04 May 2009 10:08:27 +0200
Message-ID: <20090504080828.06FC42B7C46@f04.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M0tEA-0003Q8-8Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:08:42 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M0tE1-0001mi-2a for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 08:08:37 +0000
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


They use static global structures like this:

static struct fb_info fb_info =3D {
    .fix =3D {
        .id =3D "Atari ",
        .visual =3D FB_VISUAL_PSEUDOCOLOR,
        .accel  =3D FB_ACCEL_NONE,
    }
};

The fb_info is not allocated.

Still, there is a chance I have missed a driver. I will recheck each driver.

Regards,
Krzysztof

----------------------------------------------------------------------
Wygraj wycieczke do Eurodisneylandu!
Sprawdz >> http://link.interia.pl/f2153


---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
