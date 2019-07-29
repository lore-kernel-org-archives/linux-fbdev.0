From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 29 Jul 2019 11:23:10 +0000
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
Message-Id: <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, linux-pm@vger.kernel.org, linux-mips@vger.kernel.orgDRImailinglistd

On Fri, Jul 26, 2019 at 12:02 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> This patchset converts the Qi LB60 MIPS board to devicetree and makes it
> use all the shiny new drivers that have been developed or updated
> recently.
>
> All the crappy old drivers and custom code can be dropped since they
> have been replaced by better alternatives.
>
> Some of these alternatives are not yet in 5.3-rc1 but have already been
> accepted by their respective maintainer for inclusion in 5.4-rc1.
>
> To upstream this patchset, I think that as soon as MIPS maintainers
> agree to take patches 01-03/11 and 11/11, the other patches can go
> through their respective maintainer's tree.

Was this series tested with the Ben Nanonote device?
I have one of these and from time to time I upgrade the kernel on it.

-- 
Thanks,
//richard
