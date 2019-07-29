From: Paul Cercueil <paul@crapouillou.net>
Date: Mon, 29 Jul 2019 17:05:21 +0000
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
Message-Id: <1564419921.1759.1@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
In-Reply-To: <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, linux-pm@vger.kernel.org, linux-mips@vger.kernel.orgDRImailinglist

Hi Richard,


Le lun. 29 juil. 2019 =E0 7:23, Richard Weinberger=20
<richard.weinberger@gmail.com> a =E9crit :
> On Fri, Jul 26, 2019 at 12:02 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  This patchset converts the Qi LB60 MIPS board to devicetree and=20
>> makes it
>>  use all the shiny new drivers that have been developed or updated
>>  recently.
>>=20
>>  All the crappy old drivers and custom code can be dropped since they
>>  have been replaced by better alternatives.
>>=20
>>  Some of these alternatives are not yet in 5.3-rc1 but have already=20
>> been
>>  accepted by their respective maintainer for inclusion in 5.4-rc1.
>>=20
>>  To upstream this patchset, I think that as soon as MIPS maintainers
>>  agree to take patches 01-03/11 and 11/11, the other patches can go
>>  through their respective maintainer's tree.
>=20
> Was this series tested with the Ben Nanonote device?
> I have one of these and from time to time I upgrade the kernel on it.

Yes! Artur (Cc'd) tested it.

You can test it yourself, after merging this patchset with:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git=20
branch next,
git://git.freedesktop.org/git/drm-misc branch drm-misc-next.

These will be in 5.4-rc1.

Cheers,
-Paul
