From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] tdfxfb: move I2C functionality into the tdfxfb
Date: Mon, 23 Mar 2009 13:18:43 +0100
Message-ID: <20090323131843.64eacafe@hyperion.delvare>
References: <20090323110133.7CB7186118D@f35.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090323110133.7CB7186118D-UW0e3zZ4DiCOitzWlErfBcT2TbGLZofU@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
To: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 23 Mar 2009 12:01:33 +0100, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org wrote:
> Jean Delvare napisa=C5=82(a):
> > On Sat, 21 Mar 2009 20:29:54 +0100, Krzysztof Helt wrote:
> > > +	depends on FB_3DFX >> EXPERIMENTAL
> > > +	select FB_DDC
> > > +	default y
> > > +	help
> > > +	  Say Y here if you want DDC/I2C support for your 3dfx Voodoo3.
> >=20
> > It might be worth adding a note that the driver itself doesn&#039;t=
 yet take
> > benefit of the DDC channel.
>=20
> IHMO, it does not matter. A separate patch which make use of it is al=
ready
> ready to post. If this patch is accepted, the second one will be post=
ed. It=20
> is not worth to add a comment then remove it in the next patch.

Ah, very well then. I wasn't sure if you had already been working on it
or if it was just a plan for the future. If you already have a patch
implementing "full support" then I agree with you.

> > > (...)
> > > +	tdfxfb_setup_ddc_bus(>par->chan[0], "VOODOO3-DDC", info->dev);
> > > +	tdfxfb_setup_i2c_bus(>par->chan[1], "VOODOO3-I2C", info->dev);
> >=20
> > Why all-caps names? What about "Voodoo3 DDC" and "Voodoo3 I2C" inst=
ead?
> >=20
>=20
> Just a choice. One other driver does it this way. I'll change to
> the proposed names.

The I2C bus names of framebuffer drivers have a rather bad history :(

> > Next step is to deprecate i2c-voodoo3. This requires changes to
> > drivers/i2c/busses/Kconfig and
> > Documentation/feature-removal-schedule.txt. Are you going to do it =
or
> > should I?
>=20
> I don't care. First, this patch must be accepted.

It will be accepted, don't worry :)

I'll prepare the deprecation patch now, should be fairly trivial.

--=20
Jean Delvare
