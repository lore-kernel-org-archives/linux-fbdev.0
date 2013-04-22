From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 22 Apr 2013 10:19:37 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Fix colors display on lower color depth
Message-Id: <51750EB9.3020301@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
 <201304221116.18080.marex@denx.de>
In-Reply-To: <201304221116.18080.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Marek,

Le 22/04/2013 11:16, Marek Vasut a =E9crit :
> Dear Maxime Ripard,
>=20
>> The current code always registers as a 32 bits display, and uses the
>> hardware to drop the MSB of each color to abjust to the interface width
>> used by the panel.
>>
>> This results on 18 bits (and probably 16 bits display as well) in colors
>> being displayed poorly, because the MSB are obviously the most important
>> bits for each color definition.
>>
>> The default controller behaviour when using an interface width smaller
>> than the color depth is to drop the LSBs of each color, which makes more
>> sense because you lose the least important part of the color definition.
>>
>> So, to fix the colors display, just get back to the default controller
>> behaviour.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Did you receive my latest email? Check M28EVK (imx28-m28evk.dts), it uses=
 18bit=20
> LCD and works without this patch I think.

Thanks for the pointer. You mentionned in your other mail that it was
wired on 24bits but that the screen is actually 18 bits. I went to
search for the schematics to look at the wirings to see what could
differ, but I couldn't find any for the M28EVK. Are they publicly available?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
