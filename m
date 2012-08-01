From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 01 Aug 2012 09:46:45 +0000
Subject: Re: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for imx28
Message-Id: <5018FB05.3020902@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
In-Reply-To: <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

Le 31/07/2012 14:02, Fabio Estevam a =C3=A9crit :
> On Tue, Jul 31, 2012 at 7:29 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>=20
>> +                               i2c0_pins_b: i2c0@1 {
>> +                                       reg =3D <1>;
>> +                                       fsl,pinmux-ids =3D <0x3001 0x301=
1>;
>=20
> Can you please also list the name of the pin as comment (just like you
> did for pwm4)?
>=20
> This would allow us to quickly identify the muxing option without the
> need of looking at the mxs pinctrl doc.

You're right, this will be in the next version.

Thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
