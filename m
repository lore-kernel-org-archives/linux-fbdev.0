From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 31 Jul 2012 09:16:18 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731091618.GB15557@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <5016ABDD.5010809@gmail.com>
 <20120730154706.GL4468@opensource.wolfsonmicro.com>
In-Reply-To: <20120730154706.GL4468-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 04:47:06PM +0100, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 10:44:29AM -0500, Rob Herring wrote:
> > On 07/27/2012 07:05 AM, Alexandre Courbot wrote:
>=20
> > > +		power-on-sequence {
> > > +			regulator@0 {
> > > +				id =3D "power";
> > > +				enable;
>=20
> > What do this mean? Isn't this implied for a regulator?
>=20
> I assume you might have some sequences which need some things to be
> turned off for some reason; it at least seems to be something you'd want
> to design for.

Furthermore there is the power-off-sequence equivalent, which you use
for instance when you turn off the panel. Typically they would do the
inverse of the power-on-sequence, so turning off a regulator is
definitiely required.

Thierry

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQF6JiAAoJEN0jrNd/PrOhN58QALwBuu3RhOw7GdcEqzI7luDn
qeYTY2gU2pl6F+NnSiws9VNUoYX387YP/3ocnbV6u7PDRdM6NuXGwLbDGRUHft3z
ohve7zzj0kxD1bG2LTR2qq2/MQFsXPajjEch5eEeobalEyVOsiBp37UxTGFC8+tc
BPpWwACM2ZI8HXgo3sP0YEuSwVxJuUN8UUIpCDWAoRAFkj5iRgRpC9XLf2vr7KeA
uV0Q6P1FlrhfUMS6BXCYPeIVj6mKjg7xOy/602FjGFVJeWlEpKVF40hjcmg8HspX
VeP5KOgtNwk/J/10mZRbHw2TO+zYN13U7bsc6GwnlSJSyrMA7Farb0jDZub5Dcs8
H2dmBx/uTdOiy8S4aLdzfSDDwnqaN3VW854QpYT+JoKZNAEbXAFXMDL4foEkKFLw
r/Ul6E5uxz/D302F3esgzMfbSiBzltI7/o0ZkjfqoBDVTHJH50fuvOkO55xBomW1
t/OlMGZZrXNLkOur4T8dAQHS+X1kzE01BrMnir5lVjzNGnj30G2bS/l7ey7Th4Wn
sfWNX+ELYM4D1qdV3IgS06q+vUlRH0uzY85sIwlA5DTcjWFdHww8IekVl+Qh6FTw
DGm/VmQRJhdBY2mLd3X3PyFPfisfBy9SO1hYBEHZVMxsbA0z2MMV2Bqnqsm2BcYk
gFDefs0kZM2k3Im2pOtZ
=sKXC
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
