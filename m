From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fw: framebuffer blitting performance loss 2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 16:21:24 -0400
Message-ID: <9e4733910507291321609b4c48@mail.gmail.com>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>
	 <200507221158.23454.adaplas@gmail.com>
	 <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de>
	 <42EA4E6A.70907@gmail.com>
	 <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DybMS-0001KG-Js
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:21:40 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DybMS-000847-4Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 13:21:40 -0700
Received: by wproxy.gmail.com with SMTP id 36so676443wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 13:21:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>

On 7/29/05, James Simmons <jsimmons@infradead.org> wrote:
>=20
> > Thank you for your persistence.  I think I know the culprit.  Someone
> > insisted on using memcpy in fb_pad_aligned_buffer().  I have already
> > fixed this before, but apparently, the memcpy was brought back.  Try
> > the attached patch and let me know.
>=20
> Yipes, I did that. The memcpy function is suppose to be optimized for the
> platform. See string.h in the include/asm directory. I seen for example
> the Athlon would use the 3DNow instruction set to copy data. Something
> is really wrong with memcpy if moving byte by byte is faster !!!!
> Alot of drivers use memcpy. If memcpy sucks then drivers should be copyin=
g
> byte by byte then. The question I have is this the case for non intel
> platforms as well. Could someone run the numbers on other platforms?

memmove/memcpy is faster. memcpy is faster than memmove so use it if
you can. But, there is a lower limit probably around 16 bytes or so
where the loop becomes faster.  So if you know that you will always be
copying small fragments use the loop.  The compiler can't decide
between loop/memcpy for you since it doesn't know the upper limit on
the length, it is forced to use memcpy since you told it so.

For small things it is even better use a structure assignment if
possible. That lets the compiler decide to do a loop or memcpy since
the length is known.

In this case if we could figure out how to give the compiler an upper
bound on the loop it might decide to unroll it and use multiple moves.

>=20
> > Tony
> >
> >    fbdev: Replace memcpy with for-loop when preparing bitmap
> >
> >     Do not use memcpy in fb_pad_aligned_buffer. It is suboptimal becaus=
e only
> >     a few bytes are moved at a time. Replace with a for-loop.
> >
> >     From: Antonino Daplas <adaplas@pol.net>
> >     Signed-off-by: Antonino Daplas <adaplas@pol.net>
> > ---
> >
> >  fbmem.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -80,10 +80,12 @@ EXPORT_SYMBOL(fb_get_color_depth);
> >   */
> >  void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,=
 u32 height)
> >  {
> > -     int i;
> > +     int i, j;
> >
> >       for (i =3D height; i--; ) {
> > -             memcpy(dst, src, s_pitch);
> > +             /* s_pitch is a few bytes at the most, memcpy is suboptim=
al */
> > +             for (j =3D 0; j < s_pitch; j++)
> > +                     dst[j] =3D src[j];
> >               src +=3D s_pitch;
> >               dst +=3D d_pitch;
> >       }
> >
> >
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO Sept=
ember
> > 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing &=
 QA
> > Security * Process Improvement & Measurement * http://www.sqe.com/bsce5=
sf
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
