From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Mon, 05 Jan 2015 13:47:36 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20150105134736.GA32429@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2015 at 04:33:22PM +0530, Ssagarr Patil wrote:
> Hi Maxime,
>=20
> >
> > On Fri, Nov 14, 2014 at 05:09:09PM +0530, Ssagarr Patil wrote:
> >> Hi,
> >>
> >> I have the SSD1306 oled device connected via spi, will the same
> >> driver work ? as the current one is based on i2c what all mods would
> >> be required to have it working with SPI ?
> >
> > It won't work out of the box, but it should be fairly easy to support.
> >
> > You need to had support for SPI probing, and then provide some generic
> > accessors the rest of the code can use to wrap around the i2c and spi
> > calls.
> >
> I have done the spi probing stuff, now only stuck with changing this to S=
PI calls,
>=20
> static int ssd1307fb_write_array(struct i2c_client *client,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0struct ssd1307fb_array *array,=
 u32 len)
> {
> =A0=A0=A0 int ret;
>=20
> =A0=A0=A0 len +=3D sizeof(struct ssd1307fb_array);
>=20
> =A0=A0=A0 ret =3D i2c_master_send(client, (u8 *)array, len);
> =A0=A0=A0 if (ret !=3D len) {
> =A0=A0=A0 =A0=A0=A0 dev_err(&client->dev, "Couldn't send I2C command.\n");
> =A0=A0=A0 =A0=A0=A0 return ret;
> =A0=A0=A0 }
>=20
> =A0=A0=A0 return 0;
> }
>=20
> Any help on this would be appreciated!

I'm not sure what help you are expecting.

This is a simple function that takes an array and sends it over I2C.

It's probably even easier with SPI. Have you considered reading
include/spi/spi.h?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUqpX3AAoJEBx+YmzsjxAgLnQQALT9RmTwGpe4x14JGt4ubbob
4sdTTDeHkatwki1NCGvO6AMlJWvldsIM4pT+c2IPUstJGUbBehlJl4TIRuzrtBZf
COVA6IVFQh7Vc+OQGGzFCJ2AcBlQfwo287WS0nXioDPv6TsadgCJns/a2UFj4xPW
CYtqQISI3kwH8kNvW1mMtyHS+S69Wd++6UhMonG6xf5CH1UGx3oaChaCQnJUb7CN
+CMeRQXjK7ez5Q4ABDPuzimYl1K9Q2zOwpey1kcmTCL4wt+tHKPRLejp9S1p8X21
Lz9SFS8G4z5AHSoOamEZ98uwFys/+8HzKnsE8cZEvR2Ce1BJjbhBQVD44zCLzaOV
Xqm2CsQcbPf2jo/5rtW+htng+RXvPOvL+9zu+nxGfuZfsv36DVPh1MMFSdoLxysR
jGSDmhOcI9lrCNcFMpRRBo8mvb8EX8n/07crC7WcSRUEywwoaKeyKmt74eoS67Xu
hBFprgnAG1vnZRQD5OG4buUNOvoAe/pcMFSVPkPHjyVMWQbHRyz78Pk3FVAoopY3
ctxJBRnoJ6Waugz9QHI23iP0Sw7Yo3Z77xgkkueb2FKZRG9Yq3kcXsIMZ6O8a26+
2T2X1b4hfAtHV1ExV6Whw9KbqOtqU4slT/m/yCKAEZ3+Od340wFNeDrxaFHLzc1T
qLfj9jnQkUgYNdBSEocF
=tZsc
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
