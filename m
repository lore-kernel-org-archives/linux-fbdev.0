From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 19 Jul 2010 22:34:58 +0000
Subject: Re: [PATCH] viafb: Add transitive dependencies via gpiolib
Message-Id: <20100719163458.297e1b01@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279063845.6139.129.camel@localhost>
In-Reply-To: <1279063845.6139.129.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

[Been on vacation, behind on a number of things...]

On Wed, 14 Jul 2010 09:35:49 +1000
Dave Airlie <airlied@gmail.com> wrote:

> > FB_VIA now selects GPIOLIB, but that is not available on all
> > architectures. =A0Change FB_VIA dependencies to include GPIOLIB
> > dependencies. =20
>=20
> If you can find a via chipset on anything not x86 I'd be impressed.

Agreed.  The right fix is almost certainly to just have FB_VIA depend
on X86.

jon
