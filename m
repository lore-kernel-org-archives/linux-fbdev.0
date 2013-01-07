From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 07 Jan 2013 16:06:10 +0000
Subject: Re: [PATCH] video: ssd1307fb: Fix bit order bug in the byte translation function
Message-Id: <50EAF272.4060305@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

Le 18/12/2012 14:49, Maxime Ripard (by way of Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>) a =E9crit :
> This was leading to a strange behaviour when using the fbcon driver on
> top of this one: the letter were in the right order, but each letter was
> having a vertical symmetry.
>=20
> This was because the addressing was right for the byte, but the
> addressing of each individual bit was inverted.

I'd really like to see this patch merged into one of 3.8-rc's.

Is this ok for you?

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
