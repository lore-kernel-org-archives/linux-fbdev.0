From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] clps711xfb: use framebuffer_alloc()
 to allocate fb_info struct
Date: Mon, 4 May 2009 22:19:39 +0200
Message-ID: <20090504221939.7cc491f8.krzysztof.h1@poczta.fm>
References: <20090504185746.a8507d17.krzysztof.h1@poczta.fm>
	<10f740e80905041239u792aca14kc7056bbce98d2a15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M14ji-0006zt-Ox
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 20:26:02 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M14je-00040S-Pv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 20:26:02 +0000
In-Reply-To: <10f740e80905041239u792aca14kc7056bbce98d2a15@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 4 May 2009 21:39:27 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, May 4, 2009 at 18:57, Krzysztof Helt <krzysztof.h1@poczta.fm> wro=
te:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> >
> > Use the framebuffer_alloc() function to allocate the fb_info
> > structure so the structure is correctly initialized after allocation.
> >
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > =A0drivers/video/clps711xfb.c | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
> > index 16f5db4..80fd5f1 100644
> > --- a/drivers/video/clps711xfb.c
> > +++ b/drivers/video/clps711xfb.c
> > @@ -366,7 +366,7 @@ int __init clps711xfb_init(void)
> > =A0 =A0 =A0 =A0if (fb_get_options("clps711xfb", NULL))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> >
> > - =A0 =A0 =A0 cfb =3D kzalloc(sizeof(*cfb), GFP_KERNEL);
> > + =A0 =A0 =A0 cfb =3D framebuffer_alloc(0, NULL);
> > =A0 =A0 =A0 =A0if (!cfb)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =

> While currently framebuffer_release() is identical to kfree(), I think
> these should
> also be converted from kfree() to framebuffer_release().
> =


Ok.

Regards,
Krzysztof

----------------------------------------------------------------------
Dzwonki na komork=EA!
Sprawdz >> http://link.interia.pl/f2152 =



---------------------------------------------------------------------------=
---
Register Now & Save for Velocity, the Web Performance & Operations =

Conference from O'Reilly Media. Velocity features a full day of =

expert-led, hands-on workshops and two days of sessions from industry =

leaders in dedicated Performance & Operations tracks. Use code vel09scf =

and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
