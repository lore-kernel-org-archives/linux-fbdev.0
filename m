From: krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org
Subject: =?UTF-8?q?Re:_Re:_[PATCH]_tdfxfb:_move_I2C_functionality_into_the_tdfxfb?=
Date: 23 Mar 2009 13:50:20 +0100
Message-ID: <20090323125020.6BE7C386CB2@f02.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jean Delvare napisa=B3(a):
> On 23 Mar 2009 12:01:33 +0100, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org wrote:
> > Jean Delvare napisa=B3(a):
> > > On Sat, 21 Mar 2009 20:29:54 +0100, Krzysztof Helt wrote:
> > > > +	depends on FB_3DFX >> EXPERIMENTAL
> > > > +	select FB_DDC
> > > > +	default y
> > > > +	help
> > > > +	  Say Y here if you want DDC/I2C support for your 3dfx Voodoo=
3.
> > >=20
> > > It might be worth adding a note that the driver itself doesn>#039=
;t
> yet take
> > > benefit of the DDC channel.
> >=20
> > IHMO, it does not matter. A separate patch which make use of it is
> already
> > ready to post. If this patch is accepted, the second one will be po=
sted.
> It=20
> > is not worth to add a comment then remove it in the next patch.
>=20
> Ah, very well then. I wasn&#039;t sure if you had already been workin=
g on it
> or if it was just a plan for the future. If you already have a patch
> implementing "full support" then I agree with you.
>=20

It was work in progress when the first patch was posted. It is ready no=
w.

> > > Next step is to deprecate i2c-voodoo3. This requires changes to
> > > drivers/i2c/busses/Kconfig and
> > > Documentation/feature-removal-schedule.txt. Are you going to do i=
t or
> > > should I?
> >=20
> > I don&#039;t care. First, this patch must be accepted.
>=20
> It will be accepted, don&#039;t worry :)
>=20
> I&#039;ll prepare the deprecation patch now, should be fairly trivial=
=2E
>=20

Thanks.

Regards,
Krzysztof

----------------------------------------------------------------------
Szukasz pieniedzy? Wez podwojny limit zadluzenia w koncie direct.
>> http://link.interia.pl/f20a3
