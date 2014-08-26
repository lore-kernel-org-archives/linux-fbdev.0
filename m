From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 26 Aug 2014 13:22:07 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826132207.GL15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lZ/rxkrO12p3KhS7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
 <20140825151255.GA14967@ulmo.nvidia.com>
 <20140825151822.GC21020@skynet.be> <20140826084026.GF17263@ulmo>
In-Reply-To: <20140826084026.GF17263@ulmo>
To: linux-arm-kernel@lists.infradead.org


--lZ/rxkrO12p3KhS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 10:40:27AM +0200, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 05:18:22PM +0200, Luc Verhaegen wrote:
> > On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> > >=20
> > > Out of curiosity, how does this work in practice? How does the
> > > bootloader create this entry? Does it scan the DT to see which clocks
> > > the real hardware device references and then simply copies them to the
> > > simplefb node?
> > >=20
> > > Thierry
> >=20
> > https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg06619.html
>=20
> That looks like a royal pain. Again, I think it'd be much simpler (but
> not less code, unfortunately) to do this on a per-resource basis. That
> way these low-level firmware drivers in the kernel can stay trivial,
> keeping the real complexity where they belong: in hardware-specific
> drivers such as DRM/KMS.

So we have to write a DRM/KMS driver in order to have display working
while waiting for a DRM/KMS driver to be worked on? Come on...

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lZ/rxkrO12p3KhS7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/In/AAoJEBx+YmzsjxAg9RUP/0xHYE3VA/x3o2r2nSWIrrxa
V5VPna0FndwKOyJNPRwm3Oon9W7am0ncZUAxUhHIOmx1hHkXDwu8f86Ekga9oUyP
jf+RoM3/vN+v339BdTlwQQLrzOCFpVghr1Xn0CcCXL/gUq80XTretHpzsQk2HMta
RoPBVoHUMH1ZA5X6IOVtCVdmsch3d9ec6aBL0WvMNRuwbrRcKnnhw0TCu5s6XXqx
dZYgC6kHTVblkzCah6AE26KIdl8i+oy1LjeBLXriUWknaSvYo03MUl0sMteDMitP
sREZdU37MYgN8sE6O08ndHQATjH2fXCj/6XpjEXAyHdsBb4kFUZvXRXKuJ9rW7Tu
5ez7CTIu+WGamiXx7wn7iLtz8wnDSXgQAvZllxjxNL8It8y0HF1jNay/Gd4EPqzX
s+zg2xTRqXX9+d8crs9XCTblfJqDPlFpBsHBrEbDRLTPoX3DglqtspsBab91roEY
/9yCpTWdLEigGyy/25NHhV10kKLep9tIht+fiTQ1WeWFaoEoAk4gLp4i0Z5YINn6
fBokS/QY4/26aDxumLJ0rbeNmDobPbj3iIf5Y2nscqlDmmRdrJgVJ5WhyW2Ngibl
Uvwb0WNxEuFpt0y0LSI9jXyyYNt0bPvJBKK9Q4K+vbNs59ADPDl6BLTXEiRwiKDV
eCSfP8MEZgYwysE/s+KV
=n1Dw
-----END PGP SIGNATURE-----

--lZ/rxkrO12p3KhS7--
