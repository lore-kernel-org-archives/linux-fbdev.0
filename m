From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 07 Aug 2014 10:09:52 +0000
Subject: Re: [PATCH] Adding a support for Skyworks SKY81452
Message-Id: <20140807100952.GH10136@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407398738-7582-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1407398738-7582-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gyungoh Yoo <gyungoh@gmail.com>
Cc: rdunlap@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jg1.han@samsung.com, cooloney@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, grant.likely@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, jack.yoo@skyworksinc.com, florian.vaussard@epfl.ch, thierry.reding@gmail.com, jason@lakedaemon.net, andrew@lunn.ch, silvio.fricke@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 07 Aug 2014, Gyungoh Yoo wrote:

> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> ---
>  Documentation/backlight/sky81452.txt               |  25 ++
>  Documentation/devicetree/bindings/mfd/sky81452.txt |  24 ++
>  .../bindings/regulator/sky81452-regulator.txt      |  16 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  .../video/backlight/sky81452-backlight.txt         |  20 ++
>  drivers/mfd/Kconfig                                |  12 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/sky81452.c                             | 115 +++++++
>  drivers/regulator/Kconfig                          |  11 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/sky81452-regulator.c             | 127 ++++++++
>  drivers/video/backlight/Kconfig                    |  10 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/sky81452-backlight.c       | 333 +++++++++++++++=
++++++
>  include/linux/mfd/sky81452.h                       |  31 ++
>  include/linux/sky81452-backlight.h                 |  46 +++
>  16 files changed, 774 insertions(+)
>  create mode 100644 Documentation/backlight/sky81452.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/sky81452-=
regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/sky=
81452-backlight.txt
>  create mode 100644 drivers/mfd/sky81452.c
>  create mode 100644 drivers/regulator/sky81452-regulator.c
>  create mode 100644 drivers/video/backlight/sky81452-backlight.c
>  create mode 100644 include/linux/mfd/sky81452.h
>  create mode 100644 include/linux/sky81452-backlight.h

Wow, no way.  Please split this up into separate patches.  Ideally, at
least one per subsystem and separate ones again for the DT bindings.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
