From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 30 Jan 2013 07:48:52 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <20130130074852.GB17547@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <1359514939-15653-2-git-send-email-acourbot@nvidia.com>
 <5108C9C1.1090707@gmail.com>
 <5108CB4F.7000103@nvidia.com>
In-Reply-To: <5108CB4F.7000103-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 04:27:11PM +0900, Alex Courbot wrote:
> On 01/30/2013 04:20 PM, Mark Zhang wrote:
[...]
> >>+static int panel_claa101_get_modes(struct display_entity *entity,
> >>+				   const struct videomode **modes)
> >>+{
> >>+	/* TODO get modes from EDID? */
> >
> >Why not move the "nvidia,ddc" from encoder's DT to panel's DT? In that
> >case, you can get EDID here. I know drm has some helpers to fetch EDID
> >but I recall there are some other functions which has no drm
> >dependencies which may be suitable for you.
>=20
> I explained this in the cover letter - I'm not sure we want to have
> a dependency on DRM here, as CDF entities could also be connected to
> other subsystems. That's something we need to figure out. But yes,
> ultimately this should be the place where EDID is retrieved.

I already said this in another thread. I think we should only be using
the CDF .get_modes() for static modes that cannot be obtained from EDID.
Thinking about it, I'm not quite sure why EDID would be needed for this
kind of panel anyway. Ventana probably has it because it keeps us from
having to hardcode things, but if we provide drivers for the panel
anyway, we can just as well hard-code the supported mode(s) in those
drivers.

What I'm trying to say is that the existence of EDID is board-specific,
so boards other than Ventana may not have an EDID EEPROM. Or perhaps
this particular display has the EEPROM integrated? Even in that case,
some boards may use this panel and simply not connect the EEPROM to an
I2C controller.

Thierry

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRCNBkAAoJEN0jrNd/PrOhUKUQALony++x4vSXSDZmhoTnTYKV
Jz12eO2zPljEtX0ht77xynK9mumnxUB9Xvxck3x5CY9ElaQgWhonbfCVg/4ByN89
7808wA4k8OKPXJHh0+E6zLyxhPaFUEMDPsbYxCY6IxETCj/0KQE9nE3NEFfkjLWt
pfDpOXSAkSozXiY7lfzEPYDiIwDdabfuedDwHT+gQ2FDVpNG3l50OybG829eJc98
21k2+plr0f6fCMDbf8KVEw8J+4hmPHCcnDy9HciZFoLdLtyM7btlNa9f9/5TdM5W
hmN6VrLlZk3O70MTlNo2AGwOmZ/vVm74CkNOqlndqY3zyTnnwL87lJXdP8CjV0sz
2NOlTptULKo+GJXe8mh8nTEoEuKvjeuodC/5i0k7iiLe3T5gYxOft5vLALS2Xofu
PdH/b0Re0BJY2FCKc6Me310ofmKWv64Rnwb1tDsG7PTO44EdejwZgkVhSyvQk5Ir
b2PlrC8eC9fWNVy9CmjbGA2Ovc2BsiBkRhLmD+TpOyforA4aqRj9DyR3EvccZFZK
v/GWpPtDm3YE3liAkPhvAXOcs8AFkexnD8oTTM20DBX5KbvQnqUGgWSKl6Lfz6R3
ibu6r1/qh28v/xJG00vHYk33bAOI1KmiGJr1O0V6NmRp381Qfsz8Bp0B9zPUkdxz
bJvnn6c9DG8TPo9qQHvm
=ER3g
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
