From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Wed, 02 Feb 2011 10:00:33 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <1296640833.22506.80.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mit, 2011-02-02 at 07:50 +0200, Alexander Goomenyuk wrote:=20
>=20
> P.S. There is also strange side effect after reloading radeon driver
> from X console: the screen switch off. So I have to switch between
> virtual console and X. Is it an bug?

I think there's a bug where unloading the radeon kernel module without
KMS will interfere with the hardware state for the X driver. However,
you can only unload the radeon kernel module if the X driver uses
neither KMS nor DRI in general, which is undesirable in the first place.
So fixing this is low priority even as far as UMS bugs are concerned.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
