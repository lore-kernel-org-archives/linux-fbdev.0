From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Thu, 06 Jun 2019 10:10:52 +0000
Subject: Re: [PATCH 0/8] fix warnings for same module names
Message-Id: <20190606071052.412a766d@coco.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094657.23612-1-anders.roxell@linaro.org>
In-Reply-To: <20190606094657.23612-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anders Roxell <anders.roxell@linaro.org>
Cc: andrew@lunn.ch, linux-fbdev@vger.kernel.org, airlied@linux.ie, stefan@agner.ch, linux-kernel@vger.kernel.org, a.hajda@samsung.com, lee.jones@linaro.org, marex@denx.de, f.fainelli@gmail.com, vivien.didelot@gmail.com, linux-media@vger.kernel.org, daniel@ffwll.ch, b.zolnierkie@samsung.com, s.hauer@pengutronix.de, broonie@kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, lgirdwood@gmail.com, p.zabel@pengutronix.de, shawnguo@kernel.org, davem@davemloft.net, hkallweit1@gmail.com

Em Thu,  6 Jun 2019 11:46:57 +0200
Anders Roxell <anders.roxell@linaro.org> escreveu:

> Hi,
> 
> This patch set addresses warnings that module names are named the
> same, this may lead to a problem that wrong module gets loaded or if one
> of the two same-name modules exports a symbol, this can confuse the
> dependency resolution. and the build may fail.
> 
> 
> Patch "drivers: net: dsa: realtek: fix warning same module names" and
> "drivers: net: phy: realtek: fix warning same module names" resolves the
> name clatch realtek.ko.
> 
> warning: same module names found:
>   drivers/net/phy/realtek.ko
>   drivers/net/dsa/realtek.ko
> 
> 
> Patch  "drivers: (video|gpu): fix warning same module names" resolves
> the name clatch mxsfb.ko.
> 
> warning: same module names found:
>   drivers/video/fbdev/mxsfb.ko
>   drivers/gpu/drm/mxsfb/mxsfb.ko
> 
> Patch "drivers: media: i2c: fix warning same module names" resolves the
> name clatch adv7511.ko however, it seams to refer to the same device
> name in i2c_device_id, does anyone have any guidance how that should be
> solved?
> 
> warning: same module names found:
>   drivers/gpu/drm/bridge/adv7511/adv7511.ko
>   drivers/media/i2c/adv7511.ko
> 
> 
> Patch "drivers: media: coda: fix warning same module names" resolves the
> name clatch coda.ko.
> 
> warning: same module names found:
>   fs/coda/coda.ko
>   drivers/media/platform/coda/coda.ko

Media change look ok, and probably the other patches too, but the
problem here is: who will apply it and when.

The way you grouped the changes makes harder for subsystem maintainers
to pick, as the same patch touches multiple subsystems.

On the other hand, if this gets picked by someone else, it has the
potential to cause conflicts between linux-next and the maintainer's
tree.

So, the best would be if you re-arrange this series to submit one
patch per subsystem.


> 
> 
> Patch "drivers: net: phy: fix warning same module names" resolves the
> name clatch asix.ko.
> 
> warning: same module names found:
>   drivers/net/phy/asix.ko
>   drivers/net/usb/asix.ko
> 
> Patch "drivers: mfd: 88pm800: fix warning same module names" and
> "drivers: regulator: 88pm800: fix warning same module names" resolves
> the name clatch 88pm800.ko.
> 
> warning: same module names found:
>   drivers/regulator/88pm800.ko
>   drivers/mfd/88pm800.ko
> 
> 
> Cheers,
> Anders
> 
> Anders Roxell (8):
>   drivers: net: dsa: realtek: fix warning same module names
>   drivers: net: phy: realtek: fix warning same module names
>   drivers: (video|gpu): fix warning same module names
>   drivers: media: i2c: fix warning same module names
>   drivers: media: coda: fix warning same module names
>   drivers: net: phy: fix warning same module names
>   drivers: mfd: 88pm800: fix warning same module names
>   drivers: regulator: 88pm800: fix warning same module names
> 
>  drivers/gpu/drm/bridge/adv7511/Makefile | 10 +++++-----
>  drivers/gpu/drm/mxsfb/Makefile          |  4 ++--
>  drivers/media/i2c/Makefile              |  3 ++-
>  drivers/media/platform/coda/Makefile    |  4 ++--
>  drivers/mfd/Makefile                    |  7 +++++--
>  drivers/net/dsa/Makefile                |  4 ++--
>  drivers/net/phy/Makefile                |  6 ++++--
>  drivers/regulator/Makefile              |  3 ++-
>  drivers/video/fbdev/Makefile            |  3 ++-
>  9 files changed, 26 insertions(+), 18 deletions(-)
> 



Thanks,
Mauro
