From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 22 Apr 2013 10:15:39 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Fix colors display on lower color depth
Message-Id: <51750DCB.3060306@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
 <201304221108.17339.jbe@pengutronix.de>
In-Reply-To: <201304221108.17339.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Juergen,

Le 22/04/2013 11:08, Juergen Beisert a =E9crit :
> Hi Maxime,
>=20
> Maxime Ripard wrote:
>> The current code always registers as a 32 bits display, and uses the
>> hardware to drop the MSB of each color to abjust to the interface width
>> used by the panel.
>>
>> This results on 18 bits (and probably 16 bits display as well) in colors
>> being displayed poorly, because the MSB are obviously the most important
>> bits for each color definition.
>=20
> But the "def_rgb666" bitfield description reports correctly to use bit 0.=
.5=20
> for each colour component in this mode. Maybe your userland program has a=
 bug=20
> and forgets to honor the bitfield description?

Hmmm, that might be the case actually, yes, I'll check into this and let
you know. Thanks!

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
