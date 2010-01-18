From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jan 2010 21:11:46 +0000
Subject: Re: [PATCH] video/matrox: Checkpatch cleanups for matroxfb_crtc2.c
Message-Id: <20100118221146.5d81fc0e@hyperion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001181934.49519.PeterHuewe@gmx.de>
	<1263842269.26846.122.camel@Joe-Laptop.home>
	<201001182027.29805.PeterHuewe@gmx.de>
	<1263844770.26846.134.camel@Joe-Laptop.home>
In-Reply-To: <1263844770.26846.134.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>, Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, 18 Jan 2010 11:59:30 -0800, Joe Perches wrote:
> On Mon, 2010-01-18 at 20:27 +0100, Peter H=C3=BCwe wrote:
> > the reason behind this change was that spaces and tabs were mixed for=20
> > indention.=20
>=20
> Checkpatch isn't gospel and isn't always right.
>=20
> There should be room for taste preference here
> and I think whatever Petr V's is should prevail.
>=20
> > How about this indention? Would this be better?
>=20
> Well, I don't think so, but others will have different opinions.

I don't see it as an improvement either. Was checkpatch.pl really
complaining about the alignment? Tabs followed by less than 8 spaces is
acceptable and fairly common AFAICT, I can't remember the script
yelling at me when I do it.


--=20
Jean Delvare
