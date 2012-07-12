From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 12 Jul 2012 15:23:20 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712152320.GA7256@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk> <4FFE4FE6.20109@nvidia.com>
In-Reply-To: <4FFE4FE6.20109@nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2012 at 09:47:42AM +0530, Prashant Gaikwad wrote:
> On Wednesday 11 July 2012 08:14 PM, Mark Brown wrote:

> >I'd also expect to see a range of voltages for each frequency rather
> >than a specific voltage; usually things are at least characterised with
> >a specified tolerance.

> But then how will you determine the operating voltage for a frequency?

By passing the range into the regulator API - the regulator API always
takes a voltage range anyway.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/uviAAoJEBus8iNuMP3dW2wP/RXwWDhxdXzRhZLgSnp/EQ1z
WoP1GpmjK29wCxrOzccVpX1ZRe8CK+EJ0PKBJhKswKYJlu+masomrlvfLxYhAzmX
znwDri9rfe+XF5P0PXnfLWD6NsbObj56UGyJ3XaNyNnkqPhZxtjOsf/9kPeNkqEF
tixnSyn3YfaZDOanjOBG7RE+ludNhh7fd5A1njUeTrZvvmD4zrT83JvjRdTr+hB1
K/yP5SfjOmqX5z6SYdvo6/tw243PJ2hO9Zi7doKWaeRy2I8KbRjVi9yL4sRhGkxs
gWY2RFl6OEt2GuAn9Jy6aVX43IE+HD0N/PUANCFONXeCv5pqwEobkAHB2ghhG3le
nxr0nQuQ3Ug07ULh5WdMZLFoTuurmEgf+dnPan5sR/KGSqnOwZC/obixOi7jM8pq
YCl/AUtJNKQJun/4X4keOIB93h0frrn9X20zyJPDREjERVLEt1lIbVRBvCvKUngr
GB3HyFrCQh8f+mlatYDHKAU2omZI078d2iul3FHm3hN8nI5yaBN82WjtoZgg51IO
bhNTO8sdgYAqnHHDblTqW2KqLHaNqJ2j6quIAO/yPiNZMcvB80yLqacP9rmnRsoN
YTm0CtiFhRyJliWrmu4TXuZZHucpbUfJGI33aoNv3pw2v+IOYoIVbgFdjQyPC62a
JiKnPAASyGJUYNSkncak
=XWde
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
