From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 03 Apr 2019 10:19:52 +0000
Subject: [GIT PULL] Immutable branch between MFD and DRM due for the v5.2 merge window
Message-Id: <20190403101952.GO11301@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
In-Reply-To: <20190117133336.19737-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

To whom it may concern,

Enjoy!

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git ib-backlight-drm-v5.2

for you to fetch changes up to 8c5dc8d9f19c7992b5ed557b865127a80149041b:

  video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol (2019-04-03 11:15:57 +0100)

----------------------------------------------------------------
Immutable branch between MFD and DRM due for the v5.2 merge window

----------------------------------------------------------------
Alexander Shiyan (1):
      video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol

 arch/unicore32/Kconfig            |  1 -
 drivers/gpu/drm/Kconfig           |  2 --
 drivers/gpu/drm/bridge/Kconfig    |  1 -
 drivers/gpu/drm/fsl-dcu/Kconfig   |  1 -
 drivers/gpu/drm/i915/Kconfig      |  1 -
 drivers/gpu/drm/nouveau/Kconfig   |  2 --
 drivers/gpu/drm/shmobile/Kconfig  |  1 -
 drivers/gpu/drm/tilcdc/Kconfig    |  1 -
 drivers/staging/olpc_dcon/Kconfig |  1 -
 drivers/usb/misc/Kconfig          |  1 -
 drivers/video/backlight/Kconfig   | 10 ++--------
 drivers/video/fbdev/Kconfig       |  5 -----
 12 files changed, 2 insertions(+), 25 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
