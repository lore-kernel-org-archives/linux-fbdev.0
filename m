From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:01 +0000
Subject: [PATCH v2 00/12] remove_conflicting_framebuffers() cleanup
Message-Id: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

This series cleans up duplicated code for replacing firmware FB
driver with proper DRI driver and adds handover support to
Tegra driver.

This is a sligtly updated version of a series sent on 24 Nov 2017.

v2:
 - rebased on current drm-next
 - dropped staging/sm750fb changes
 - added kernel docs for DRM helpers

Michał Mirosław (12):
  fbdev: show fbdev number for debugging
  fbdev: allow apertures = NULL in remove_conflicting_framebuffers()
  fbdev: add remove_conflicting_pci_framebuffers()
  drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
  drm/bochs: use simpler remove_conflicting_pci_framebuffers()
  drm/cirrus: use simpler remove_conflicting_pci_framebuffers()
  drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
  drm/radeon: use simpler remove_conflicting_pci_framebuffers()
  drm/virtio: use simpler remove_conflicting_pci_framebuffers()
  drm/vc4: use simpler remove_conflicting_framebuffers(NULL)
  drm/sun4i: use simpler remove_conflicting_framebuffers(NULL)
  drm/tegra: kick out simplefb

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +-------------
 drivers/gpu/drm/bochs/bochs_drv.c        | 18 +----------
 drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +-------------
 drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +------------
 drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ------
 drivers/gpu/drm/radeon/radeon_drv.c      | 23 +-------------
 drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +----------
 drivers/gpu/drm/tegra/drm.c              |  4 +++
 drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-----------
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++------------
 drivers/video/fbdev/core/fbmem.c         | 40 ++++++++++++++++++++++--
 include/drm/drm_fb_helper.h              | 34 ++++++++++++++++++++
 include/linux/fb.h                       |  2 ++
 13 files changed, 88 insertions(+), 172 deletions(-)

-- 
2.18.0
