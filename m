From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 23 Oct 2019 13:10:49 +0000
Subject: Re: [PATCH 00/36] ARM: samsung platform cleanup
Message-Id: <20191023131049.GG11048@pi3>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191010202802.1132272-1-arnd@arndb.de>
In-Reply-To: <20191010202802.1132272-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Lihua Yao <ylhuajnu@outlook.com>, Kukjin Kim <kgene@kernel.org>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, linux-pwm@vger.kernel.org, Sergio Prado <sergio.prado@e-labworks.com>, linux-pm@vger.kernel.org, Lihua Yao <ylhuajnu@163.com>, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org

On Thu, Oct 10, 2019 at 10:28:02PM +0200, Arnd Bergmann wrote:
> I've spent some time looking at the remaining ARMv4/ARMv5 platforms
> that are not part of ARCH_MULTIPLATFORM, and tried to get them closer
> to that. Here is what came out of that for the samsung platforms:
>=20
> * Exynos and s5pv210 are made independent of plat-samsung
> * device drivers stop using mach/*.h headers for s3c24xx
>   (and other platforms not in this series)
> * s3c24xx and s3c64xx get merged into mach-s3c, removing
>   the need for plat-samsung (I have other patches for the
>   remaining plat-* directories)
> * mach/io.h gets cleaned up to only be needed for BAST
>   PC104 mode (looking for ideas to proceed)
> * mach/irqs.h remains for now, this still needs to be converted
>   to sparse IRQs.
>=20
> Some bits are a little ugly, but overall I think this a big
> improvement.
>=20
> The contents are available for testing in
>=20
> git://kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git s3c-multip=
latform

When sending v2, can you Cc:

Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
Lihua Yao <ylhuajnu@outlook.com>
(or Lihua Yao <ylhuajnu@163.com> if outlook.com bounces)
Sergio Prado <sergio.prado@e-labworks.com>
Sylwester Nawrocki <s.nawrocki@samsung.com>

These are folks which to my knowledge had working S3C and S5P boards
so maybe they could provide testing.

Best regards,
Krzysztof
