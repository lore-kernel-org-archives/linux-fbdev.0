From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 06 Jun 2018 15:46:17 +0000
Subject: Re: [PATCH 08/21] udl-kms: avoid prefetch
Message-Id: <alpine.LRH.2.02.1806061138080.7464@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
 <20180603144221.959741603@twibright.com>
 <d07eb94b8b20a7b9f57f341a51cdcdbb91a60175.camel@synopsys.com>
 <alpine.LRH.2.02.1806051123300.7248@file01.intranet.prod.int.rdu2.redhat.com>
 <fad12efd7a0f93e1dd6de5e7bf0c45832e6d74ea.camel@synopsys.com>
In-Reply-To: <fad12efd7a0f93e1dd6de5e7bf0c45832e6d74ea.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "ladis@linux-mips.org" <ladis@linux-mips.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "bernie@plugable.com" <bernie@plugable.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@redhat.com" <airlied@redhat.com>



On Wed, 6 Jun 2018, Alexey Brodkin wrote:

> Hi Mikulas,
>=20
> On Tue, 2018-06-05 at 11:30 -0400, Mikulas Patocka wrote:
> >=20
> > On Tue, 5 Jun 2018, Alexey Brodkin wrote:
> >=20
> > > Hi Mikulas,
> > >=20
> > > On Sun, 2018-06-03 at 16:41 +0200, Mikulas Patocka wrote:
> > > > Modern processors can detect linear memory accesses and prefetch da=
ta
> > > > automatically, so there's no need to use prefetch.
> > >=20
> > > Not each and every CPU that's capable of running Linux has prefetch
> > > functionality :)
> > >=20
> > > Still read-on...
> > >=20
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > >=20
> > > > ---
> > > >  drivers/gpu/drm/udl/udl_transfer.c |    7 -------
> > > >  1 file changed, 7 deletions(-)
> > > >=20
> > > > Index: linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > > > --- linux-4.16.12.orig/drivers/gpu=
/drm/udl/udl_transfer.c	2018-05-31 14:48:12.000000000 +0200
> > > > +++ linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:=
48:12.000000000 +0200
> > > > @@ -13,7 +13,6 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/fb.h>
> > > > -#include <linux/prefetch.h>
> > > >  #include <asm/unaligned.h>
> > > > =20
> > > >  #include <drm/drmP.h>
> > > > @@ -51,9 +50,6 @@ static int udl_trim_hline(const u8 *bbac
> > > >  	int start =3D width;
> > > >  	int end =3D width;
> > > > =20
> > > > -	prefetch((void *) front);
> > > > -	prefetch((void *) back);
> > >=20
> > > AFAIK prefetcher fetches new data according to a known history... i.e=
. based on previously
> > > used pattern we'll trying to get the next batch of data.
> > >=20
> > > But the code above is in the very beginning of the data processing ro=
utine where
> > > prefetcher doesn't yet have any history to know what and where to pre=
fetch.
> > >=20
> > > So I'd say this particular usage is good.
> > > At least those prefetches shouldn't hurt because typically it
> > > would be just 1 instruction if those exist or nothing if CPU/compiler=
 doesn't
> > > support it.
> >=20
> > See this post https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lw=
n.net_Articles_444336_&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DlqdeeSSEes=
0GFDDl656e
> > ViXO7breS55ytWkhpk5R81I&m=A5RaqJtvajFkM1hL7bOKD5jV7cpFfTvG2Y1cYCdBPd0&s=
=3Dw0W8wFtAgENp8TE6RzdPGhdKRasJc_otIn08V0EkgrY&e=3D where they measured tha=
t=20
> > prefetch hurts performance. Prefetch shouldn't be used unless you have =
a=20
> > proof that it improves performance.
> >=20
> > The problem is that the prefetch instruction causes stalls in the pipel=
ine=20
> > when it encounters TLB miss and the automatic prefetcher doesn't.
>=20
> Wow, thanks for the link.
> I didn't know about that subtle issue with prefetch instructions on ARM a=
nd x86.
>=20
> So OK in case of UDL these prefetches anyways make not not much sense I g=
uess and there's
> something worse still, see what I've got from WandBoard Quad running kmsc=
ube [1] application
> with help of perf utility:
> --------------------------->8-------------------------
> # Overhead  Command  Shared Object            Symbol=20
> # ........  .......  .......................  ...........................=
.............
> #
>     92.93%  kmscube  [kernel.kallsyms]        [k] udl_render_hline
>      2.51%  kmscube  [kernel.kallsyms]        [k] __divsi3
>      0.33%  kmscube  [kernel.kallsyms]        [k] _raw_spin_unlock_irqres=
tore
>      0.22%  kmscube  [kernel.kallsyms]        [k] lock_acquire
>      0.19%  kmscube  [kernel.kallsyms]        [k] _raw_spin_unlock_irq
>      0.17%  kmscube  [kernel.kallsyms]        [k] udl_handle_damage
>      0.12%  kmscube  [kernel.kallsyms]        [k] v7_dma_clean_range
>      0.11%  kmscube  [kernel.kallsyms]        [k] l2c210_clean_range
>      0.06%  kmscube  [kernel.kallsyms]        [k] __memzero
> --------------------------->8-------------------------
>=20
> That said it's not even USB 2.0 which is a bottle-neck but
> computations in the udl_render_hline().
>=20
>=20
> [1] https://cgit.freedesktop.org/mesa/kmscube/
>=20
> -Alexey

Try this patch=20
http://people.redhat.com/~mpatocka/patches/kernel/udl/udlkms-avoid-division=
.patch

It is doing a lot of divisions - and WandBoard has Cortex-A9, that doesn't =

have division instruction.

BTW. the framebuffer UDL driver (not the modesetting driver) has=20
performance counters in sysfs. Their location depends on the system, you=20
can find them with find /sys -name "*metrics*"

The file "metrics_reset" resets the counters, so you can measure if the=20
prefetch instructions improve performance or not.

Mikulas
