From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 15 Aug 2016 13:46:12 +0000
Subject: Re: [PATCH] backlight-tosa: Delete owner assignment
Message-Id: <20160815134612.GH25844@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efe9964f-c907-305c-b75e-32a4139d1edd@users.sourceforge.net>
 <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com>
In-Reply-To: <CAOMGZ=EWsO_pRg+s+hnPmwRePcrijFK3v+SRKTizfbqyY83iqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, Kernel Janitors List <kernel-janitors@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>

On Mon, 15 Aug 2016, Vegard Nossum wrote:

> On 15 August 2016 at 13:12, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 15 Aug 2016 13:03:29 +0200
> >
> > The field "owner" is set by core. Thus delete an extra initialisation.
>=20
> Hi,
>=20
> Just a small nit on the patch title: "delete owner assignment" is
> virtually useless as a title because it has no meaning without the
> broader context and only describes the literal change. It's like
> naming a patch "add a line" or "change the code"; it serves no
> purpose.
>=20
> How about "backlight-tosa: delete _unnecessary_ assignment"? This
> immediately communicates the reason for/intent of the patch (there is
> unnecessary code, thus we can simplify it).

  backlight-tosa: Do not manually assign THIS_MODULE to .owner

  This is unnecessary because ...

> (Sorry about singling out this patch and the apparent bikeshedding,
> this comment obviously applies to a lot of patches by a lot of
> authors!)
>=20
> Thanks,
>=20
>=20
> Vegard

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
