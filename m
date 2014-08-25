From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 25 Aug 2014 12:44:10 +0000
Subject: Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825124410.GZ15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8Y8a5CJOPM/zJV44"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
In-Reply-To: <20140825121228.GB4163@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--8Y8a5CJOPM/zJV44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> [...]
> > > If not, perhaps the clock driver should force the clock to be
> > > enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >=20
> > I'm sorry, but I'm not going to take any code that will do that in our
> > clock driver.
> >=20
> > I'm not going to have a huge list of ifdef depending on configuration
> > options to know which clock to enable, especially when clk_get should
> > have the consumer device as an argument.
>=20
> Are you saying is that you want to solve a platform-specific problem by
> pushing code into simple, generic drivers so that your platform code can
> stay "clean"?

Are you saying that this driver would become "dirty" with such a patch?

If so, we really have an issue in the kernel.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8Y8a5CJOPM/zJV44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+y+aAAoJEBx+YmzsjxAgIH4P/jyqGVqcD9wu7sy8vjDgRx+2
0FqUb7LvuzpudJZgYg1J0mkaX2Ze2Istjg4Ax9pB1FAV5lfllDzTbg6ccuqBPSm8
ADmtMIRfIVMMzMoss7Xl5Yix3RgML0vo1d1NDNZ44qM7adFq8nTWtr3UV/EqZcM1
Q0aWLBvxNS67wveYq9N7Rc0XLjxoCf/RGV58DESyOZ6zO2x4PeEW8lsBznwiQgf1
rQbvJbW4XKKEzC7+MuqRDvHnSC2TVu6Ygu4abR+KkWoOoeSrcdusuVNhk/OWEC0D
7tIkghvtRh/tIZ2M7N9jhujMeiANQ9Lm1tFiL65uwEVo5LhJ3p9Ns1s9LcoYcKjX
t7i4DcD8slCJpsveX8uKLhVnR+sO+mwkhau1Llp9E0gz1FADjgpqwdfKBu4yltnH
QqiYh8GJg8BbrIE1sjIzozik6gYPlGZWmSfiuAPUOCW22Lmra+PUnjP/i+MbLGaC
Jqq2Noxb7kVtKxbUHRQwgL7DSeZcL97D4TpCl/ywI2/sSnDV6JeJe86l/7VPXf/B
l86YGmaMJe0+PP33GTLv7aA5rTLfcJ0hfRKnPdnBjZ9aJZ5099gRH/Hm9rBpWi1Z
QxKUFpoLsQYg05DP8ayZfmlbRSzArWesxpqmFIqHElU3BiDdLmnD+G1Eb0RDXPlE
Iz9F6vkj+1lM9MUzSA/S
=ofIA
-----END PGP SIGNATURE-----

--8Y8a5CJOPM/zJV44--
