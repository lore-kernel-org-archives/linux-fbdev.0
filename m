From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 15:29:27 +0000
Subject: Re: [PATCH v5 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <56699A57.9030209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xv3jcQLON74TbCw3Ne4BMEpH5rpXG3Mmq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447792337-13876-1-git-send-email-robert.jarzmik@free.fr>
 <1447792337-13876-2-git-send-email-robert.jarzmik@free.fr>
 <5665B3C1.1080005@ti.com> <87bna2kmp7.fsf@belgarion.home>
In-Reply-To: <87bna2kmp7.fsf@belgarion.home>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--xv3jcQLON74TbCw3Ne4BMEpH5rpXG3Mmq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 07/12/15 22:50, Robert Jarzmik wrote:

>> It seems that at least "depth" is missing from the binding document.
> You're right.
>=20
> Actually depth is not a "hardware" caracteristic. Moreover it's just us=
ed as an
> overlay for pxafb_set_pixfmt() to superseed var->bits_per_pixel. I'm wo=
ndering
> if the right path for of_get_pxafb_mode_info() would be to remove compl=
etely
> depth, and leave it initialized at 0 for the DT case.
>=20
> What do you think of this approach ? The other one would be to modify t=
he
> binding, and yet I feel this depth doesn't belong to the binding, it's =
my patch
> which requires another spin IMHO.

Yes, we should avoid non-hardware relate properties in the .dts files if
at all possible. If the driver works fine without the property, I think
it's fine to remove it. If it is required it needs to be added to the
binding document.

 Tomi


--xv3jcQLON74TbCw3Ne4BMEpH5rpXG3Mmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWaZpXAAoJEPo9qoy8lh71jgkQAK96tDHk27IvpACd6KXanxJ/
eEcwBdkiEvE6aexpm2LRC9gcAIVxFN3RKUTkYKaVoAXNeDDCVUWzHx+NTSlhT4Ha
PlgE0GBzsq6sPwKLqDOj07EvfIr9QLKieF4tIZh43wHBf3zQSIE/JR0uVUixi0vr
ah3O42j9IupIcGAgHlh32BmdQXRP1HmlTNFbht+KIVyN63aKSK0Ih2rKInhAKbc/
FK7QSg7K70H/EXyXvMQu44cHAomkJNiedHeMIUG30iPjUCuyAB9kuYeWLZVCW+5j
UhSZPY9AEOV5C7KwPS92UH8UW+QlLF2fztWFk6GyQ8xTm2ugmdy8SEPb4v2bUO6J
xP32imFYADcWTR+Tw7dGKFb2HbN0yTPYXw1CiCAh8Y25SiRR7f9U0TCF7sUM+MXw
CrwTOKf9jkOevU59hOu7+KLv/wwGcLjyJKP9qNEdGeYzQ7k+twNZjPa5jizdrkcO
XJ0Mu/q/YIAA7+fXVIYEzoT7xMxo8jzhnW3Mfi3Kfs0uPFqxDgNPlVlelKCOpDfz
tvqgUwR3jY36RwKugZn4XbWdawqgrI9Aa4HvOJDIMdVUrHAnoJeCiFQz3drbD4eE
9IIKxMXR//1s+wBA48a/mOGauX5oPUPk1sHgu9PV9NWeUsRF6BMSOEuWm1ERBsWA
a+WSdCiw+Wkxd1zwAeNI
=sdhB
-----END PGP SIGNATURE-----

--xv3jcQLON74TbCw3Ne4BMEpH5rpXG3Mmq--
