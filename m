From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Dec 2012 08:45:49 +0000
Subject: Re: [PATCHv15 3/7] video: add of helper for display timings/videomode
Message-Id: <50C5A13D.7040908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigD5913F5C38A1C760756BBE03"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353920848-1705-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353920848-1705-4-git-send-email-s.trumtrar@pengutronix.de>
 <50B37EEC.6090808@ti.com> <20121126161055.GB30791@pengutronix.de>
 <50B39F46.7050808@ti.com> <1354889568.2533.118.camel@pizza.hi.pengutronix.de>
In-Reply-To: <1354889568.2533.118.camel-/rZezPiN1rtR6QfukMTsflXZhhPuCNm+@public.gmane.org>
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--------------enigD5913F5C38A1C760756BBE03
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-12-07 16:12, Philipp Zabel wrote:
> Hi,
>=20
> Am Montag, den 26.11.2012, 18:56 +0200 schrieb Tomi Valkeinen:

>> So what does the pixelclk-inverted mean? Normally the SoC drives pixel=

>> data on rising edge, and the panel samples it at falling edge? And
>> vice-versa for inverted? Or the other way around?
>>
>> When is hsync/vsync set? On rising or falling edge of pclk?
>>
>> My point here is that the pixelclk-inverted is not crystal clear thing=
,
>> like the hsync/vsync/de-active values are.
>>
>> And while thinking about this, I realized that the meaning of
>> pixelclk-inverted depends on what component is it applied to. Presumin=
g
>> normal pixclk means "pixel data on rising edge", the meaning of that
>> depends on do we consider the SoC or the panel. The panel needs to
>> sample the data on the other edge from the one the SoC uses to drive t=
he
>> data.
>>
>> Does the videomode describe the panel, or does it describe the setting=
s
>> programmed to the SoC?
>=20
> How about calling this property pixelclk-active, active high meaning
> driving pixel data on rising edges and sampling on falling edges (the
> pixel clock is high between driving and sampling the data), and active
> low meaning driving on falling edges and sampling on rising edges?
> It is the same from the SoC perspective and from the panel perspective,=

> and it mirrors the usage of the other *-active properties.

This sounds good to me. It's not quite correct, as neither pixelclock or
pixel data are not really "active" when the clock is high/low, but it
still makes sense and is clear (at least with a short description).

 Tomi



--------------enigD5913F5C38A1C760756BBE03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQxaE9AAoJEPo9qoy8lh71tfkP/3hzeIGnvSuFoVrLGiV/IyGu
2Uk+qSL1REVac/EJZGngR5nMNur+E3nAc/VqdoFPxL3eUQN64aq2/tbD+sB1HzH1
oYz0mVwzowUkGCEM1DVgtVoO9KW4HGHX0//6Jn8w1LlUSvLwJJl1NXlirsfxS5Qu
nr5XG/hzf+zfCF1lsRKxlBxY2Q0JBIL72CkPkCYdMNVpcKKNuqVNl0zGw2aGHm2M
qvo9o00rAW23DKRJOY6GPls1JDMpo+f8RGJExXvJlbONZjouNQM5lHr/UxNVrZum
Izzn7j2Q1pGupDluiNdFPXBKDn0o6aU27xSUTQCu5s3pKuJxiPKT/QBw60eueaPo
8VZvAmrxlC+zEEAwW+T+AXKWfUmnUE4fr4XmMWbg9zclOPf7pdJDJSU15pDG2TYy
5UV0TvuqeSA9MJaZnnhO7kI/YPi0KRCP3zwQf0LNestdxm+3VfpE2oINYJ2eoWq1
WxwQ7SnX/HDuaeCNIcaZB6U5dQ98M0ziyNy7P9aS0dN46CnSYTmLm+h2yhk6eFkS
TvST+YWV+Be3BFVppoH31ICkNotKBI2qGfVH6GcCjXtp1S9N45tC5HbojBLlwze3
SGTb5ZkbV/SHib/OnZtzW+P/+bbmIOplySOf9RQ9zFlf/1mGThXgEEbp36U1lic6
Izb71Op2WrU2TebUsesg
=BhOc
-----END PGP SIGNATURE-----

--------------enigD5913F5C38A1C760756BBE03--
