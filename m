From: Sean Paul <seanpaul@chromium.org>
Date: Mon, 29 Jan 2018 19:29:50 +0000
Subject: [PULL] Backlight helpers from tinydrm
Message-Id: <20180129192950.bvmhkz3h42t5a25r@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dim-tools@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Meghana Madhyastha <meghana.madhyastha@gmail.com>


Hi Lee,
Here's the pull request for Meghana's patch set. It's based on 4.15, and just
contains the backlight portion of the set. I couldn't include the rest as it
depends on patches that only exist in drm-misc-next atm.

Thanks for coordinating with me on this!


topic/backlight_for_lag-2018-01-29:
This contains the backlight portion of Meghana Madhyastha's patch set to
migrate the backlight helpers from tinydrm to the backlight subsystem.

https://patchwork.freedesktop.org/series/36522/

Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>

Cheers, Sean


The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm-misc tags/topic/backlight_for_lag-2018-01-29

for you to fetch changes up to 2e4ef3347b4a4eb65c4fd950d94bbd75fed4d798:

  video: backlight: Add devres versions of of_find_backlight (2018-01-29 10:34:53 -0500)

----------------------------------------------------------------
This contains the backlight portion of Meghana Madhyastha's patch set to
migrate the backlight helpers from tinydrm to the backlight subsystem.

https://patchwork.freedesktop.org/series/36522/

Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>

----------------------------------------------------------------
Meghana Madhyastha (3):
      video: backlight: Add helpers to enable and disable backlight
      video: backlight: Add of_find_backlight helper in backlight.c
      video: backlight: Add devres versions of of_find_backlight

 drivers/video/backlight/backlight.c | 73 +++++++++++++++++++++++++++++++++++++
 include/linux/backlight.h           | 58 +++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

-- 
Sean Paul, Software Engineer, Google / Chromium OS
