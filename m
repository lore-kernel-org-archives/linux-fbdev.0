From: Sekhar Nori <nsekhar@ti.com>
Date: Thu, 08 Aug 2019 09:28:31 +0000
Subject: Re: [PATCH v2 0/9] ARM: davinci: da850-evm: remove more legacy GPIO calls
Message-Id: <408dc72e-eb4e-ea8d-2c5d-f7300a7a296d@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722134423.26555-1-brgl@bgdev.pl>
 <CAMRc=Me51RgQu8VK70dy=1OhmHeKo40HLxfsvp2nD5UC+Mzb=w@mail.gmail.com>
In-Reply-To: <CAMRc=Me51RgQu8VK70dy=1OhmHeKo40HLxfsvp2nD5UC+Mzb=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 05/08/19 2:00 PM, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 15:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is another small step on the path to liberating davinci from legacy
>> GPIO API calls and shrinking the davinci GPIO driver by not having to
>> support the base GPIO number anymore.
>>
>> This time we're removing the legacy calls used indirectly by the LCDC
>> fbdev driver.
>>
>> First two patches enable the GPIO backlight driver in
>> davinci_all_defconfig.
>>
>> Patch 3/12 models the backlight GPIO as an actual GPIO backlight device.
>>
>> Patches 4-6 extend the fbdev driver with regulator support and convert
>> the da850-evm board file to using it.
>>
>> Last three patches are improvements to the da8xx fbdev driver since
>> we're already touching it in this series.
>>
>> v1 -> v2:
>> - dopped the gpio-backlight patches from this series as since v5.3-rc1 we
>>   can probe the module with neither the OF node nor platform data
>> - collected review and ack tags
>> - rebased on top of v5.3-rc1
>>
>> Bartosz Golaszewski (9):
>>   ARM: davinci: refresh davinci_all_defconfig
>>   ARM: davinci_all_defconfig: enable GPIO backlight
>>   ARM: davinci: da850-evm: model the backlight GPIO as an actual device
>>   fbdev: da8xx: add support for a regulator
>>   ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
>>   fbdev: da8xx: remove panel_power_ctrl() callback from platform data
>>   fbdev: da8xx-fb: use devm_platform_ioremap_resource()
>>   fbdev: da8xx-fb: drop a redundant if
>>   fbdev: da8xx: use resource management for dma
>>
>>  arch/arm/configs/davinci_all_defconfig  |  27 ++----
>>  arch/arm/mach-davinci/board-da850-evm.c |  90 +++++++++++++-----
>>  drivers/video/fbdev/da8xx-fb.c          | 118 +++++++++++++-----------
>>  include/video/da8xx-fb.h                |   1 -
>>  4 files changed, 141 insertions(+), 95 deletions(-)
>>
>> --
>> 2.21.0
>>
>=20
> Hi Sekhar,
>=20
> the fbdev patches have been acked by Bartlomiej. I think the entire
> series can go through the ARM-SoC tree.

Applied for v5.4. Will queue through ARM-SoC.

Thanks,
Sekhar
