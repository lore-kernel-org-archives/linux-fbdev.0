From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 May 2014 10:10:34 +0000
Subject: [PATCH 0/3] OMAPDSS: DT support for panel-lgphilips-lb035q02
Message-Id: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This adds DT support to panel-lgphilips-lb035q02. Compile tested only.

This panel is used on some Overo boards (alto35, if I'm not mistaken).

 Tomi

Tomi Valkeinen (3):
  OMAPDSS: panel-lgphilips-lb035q02: use gpiod for enable gpio
  OMAPDSS: panel-lgphilips-lb035q02: Add DT support
  Doc/DT: Add binding doc for lgphilips,lb035q02.txt

 .../bindings/video/lgphilips,lb035q02.txt          | 33 ++++++++++
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  | 76 +++++++++++++++++-----
 2 files changed, 94 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt

-- 
1.9.1

