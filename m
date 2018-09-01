From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 01 Sep 2018 14:08:41 +0000
Subject: [PATCH v3 00/13] remove_conflicting_framebuffers() cleanup
Message-Id: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

This series cleans up duplicated code for replacing firmware FB
driver with proper DRI driver and adds handover support to
Tegra driver.

This is a sligtly updated version of a series sent on 24 Nov 2017.

---
v2:
 - rebased on current drm-next
 - dropped staging/sm750fb changes
 - added kernel docs for DRM helpers
v3:
 - move kerneldoc to fbdev, where functions are implemented
 - split kerneldoc for remove_conflicting_framebuffers()
 - propagate return value in remove_conflicting_pci_framebuffers()

---
Michał Mirosław (13):
  fbdev: show fbdev number for debugging
  fbdev: allow apertures = NULL in remove_conflicting_framebuffers()
  fbdev: add kerneldoc do remove_conflicting_framebuffers()
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 24 +--------
 drivers/gpu/drm/bochs/bochs_drv.c        | 18 +------
 drivers/gpu/drm/cirrus/cirrus_drv.c      | 23 +--------
 drivers/gpu/drm/mgag200/mgag200_drv.c    | 21 +-------
 drivers/gpu/drm/mgag200/mgag200_main.c   |  9 ----
 drivers/gpu/drm/radeon/radeon_drv.c      | 23 +--------
 drivers/gpu/drm/sun4i/sun4i_drv.c        | 18 +------
 drivers/gpu/drm/tegra/drm.c              |  4 ++
 drivers/gpu/drm/vc4/vc4_drv.c            | 20 +-------
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 ++-------
 drivers/video/fbdev/core/fbmem.c         | 63 +++++++++++++++++++++++-
 include/drm/drm_fb_helper.h              | 12 +++++
 include/linux/fb.h                       |  2 +
 13 files changed, 89 insertions(+), 172 deletions(-)

-- 
2.18.0
