From: krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org
Subject: =?UTF-8?q?Re:_Re:_[PATCH_2/2]_tdfxfb:_make_use_of_DDC_information_about_connected__monitor?=
Date: 25 Mar 2009 07:36:15 +0100
Message-ID: <20090325063616.16A371D789D@f39.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akp>

Jean Delvare napisa=B3(a):
> Hi Krzysztof,
>=20
> On Mon, 23 Mar 2009 19:26:46 +0100, Krzysztof Helt wrote:
> > From: Krzysztof Helt >krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> >=20
> > Read DDC information from a connected monitor
> > and use it to select initial mode (if the mode
> > is not specified).
> > Also, use the information to protect against
> > modes outside the monitor specs.
> >=20
> > Signed-off-by: Krzysztof Helt >krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> > ---
> >  drivers/video/tdfxfb.c |   67
> +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 63 insertions(+), 4 deletions(-)
>=20
> Patch tested successfully. Without the patch:
>=20
> fb: 3Dfx Voodoo3 memory =3D 16384K
> Console: switching to colour frame buffer device 80x30
>=20
> With the patch:
>=20
> fb: 3Dfx Voodoo3 memory =3D 16384K
> Console: switching to colour frame buffer device 128x48
>=20
> Much better! :) This is on a Voodoo3. If you want me to test somethin=
g
> in particular, just let me know.
>=20

I have tested it on Voodoo3 3000 AGP and Voodoo5 AGP with LCD panel
and CRT monitor. It is reallycool on CRT monitor - it returns
a resolution with high refresh rate and quite useful
(on my 15" CRT it is 800x600 at 85Hz).

If you can test the BT869 driver for a Voodoo3 card (mentioned
in the i2c-voodoo3 doc) it would be great.

Thank you for testing,
Krzysztof



----------------------------------------------------------------------
Opony letnie do 30% taniej i z darmow=B1 dostaw=B1!
Sprawd=BC >>> http://link.interia.pl/f20b7
