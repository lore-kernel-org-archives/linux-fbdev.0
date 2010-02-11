From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Thu, 11 Feb 2010 10:23:04 +0000
Subject: [PATCH 00/02] sh: Panning fixes
Message-Id: <AB12B32E73474741A2C5361C433A44DE0178367D@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

sh: Panning fixes

[PATCH 01/02] sh: Add wait for vsync
[PATCH 02/02] sh: Fix panning

These patches add wait for vsync and fix the panning
so that apps can just do ioctl(FBIOPAN_DISPLAY) followed
by ioctl(FBIO_WAITFORVSYNC) in order to ensure that the
pan has happened.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---

