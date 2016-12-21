From: Vladimir Zapolskiy <vz@mleia.com>
Date: Wed, 21 Dec 2016 03:27:13 +0000
Subject: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <20161221032717.13154-1-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The changeset contains a number of cleanups, changed semantics of
init_panel() callback, which allows to simplify getting of panel
properties from panel device tree node, and a handling of optional
"enable-gpios" panel property, the latter is described in
display/panel/panel-dpi.txt device tree binding documentation, but
it has been unsupported by the ARM CLCD driver.

Vladimir Zapolskiy (4):
  video: ARM CLCD: sort included headers out alphabetically
  video: ARM CLCD: use panel device node for panel initialization
  video: ARM CLCD: use panel device node for getting backlight and mode
  video: ARM CLCD: add support of an optional GPIO to enable panel

 drivers/video/fbdev/amba-clcd-nomadik.c   |  9 +---
 drivers/video/fbdev/amba-clcd-nomadik.h   |  5 +-
 drivers/video/fbdev/amba-clcd-versatile.c | 14 ++----
 drivers/video/fbdev/amba-clcd-versatile.h |  5 +-
 drivers/video/fbdev/amba-clcd.c           | 80 +++++++++++++++++++------------
 include/linux/amba/clcd.h                 |  2 +
 6 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.10.2

