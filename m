From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 16 Oct 2017 09:59:13 +0000
Subject: [PATCH 0/5] rockchip: kevin: Enable edp display
Message-Id: <20171016095918.25588-1-jeffy.chen@rock-chips.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, linux-samsung-soc@vger.kernel.org, briannorris@chromium.org, Krzysztof Kozlowski <krzk@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Caesar Wang <wxt@rock-chips.com>, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jef


Make edp display works on chromebook kevin(at least for boot animation).

Also solve some issues i meet during the bringup.


Jeffy Chen (4):
  arm64: dts: rockchip: Enable edp disaplay on kevin
  backlight: pwm_bl: Add device link for pwm_bl and pwm
  drm/rockchip: Fix error handling path in rockchip_dp_bind()
  drm/rockchip: Add device links for master and components

Tomasz Figa (1):
  drm/bridge/analogix: Do not use device's drvdata

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 16 ++++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 ++++++++-----------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 26 +++++-----
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 57 ++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 24 +++++++--
 drivers/video/backlight/pwm_bl.c                   |  2 +
 include/drm/bridge/analogix_dp.h                   | 19 +++++---
 8 files changed, 151 insertions(+), 72 deletions(-)

-- 
2.11.0


