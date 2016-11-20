From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Sun, 20 Nov 2016 21:58:06 +0000
Subject: [PATCH v5 0/2] console: Add persistent scrollback buffers for all VGA console
Message-Id: <1479679088-3015-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161118005309.GC26324@dell-m4800.home>
In-Reply-To: <20161118005309.GC26324@dell-m4800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: manuel.schoelling@gmx.de, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

Changes in v5:
  - Clearify documentation
  - Skip superfluous array initialization
  - Disable scrollback if buffer allocation fails
  - Refactor vgacon_switch_scrollback()
  - Rename vgacon_switch_scrollback() to vgacon_scrollback_switch()
  - Add check for fg_console in vgacon_scrollback_update
Changes in v4.1 to v4.2:
  - Fix compiler error
Changes in v4:
  - Rename from VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE to
    VGACON_SOFT_SCROLLBACK_PERSISTENT
  - Split into two patches
  - Rework documentation
  - Remove cosmetic changes in comments (postponed)
Changes in v3:
  - Add config option for this feature
  - Fallback to old scrollback buffer if kcalloc() fails
  - Remove ioctl() call again and add documentation about existing
    escape sequence to flush the scrollback buffer
Changes in v2:
  - Add ioctl() call to flush scrollback buffer
  - (Patch v2 was not labeled as such, sorry)

Manuel Sch=C3=B6lling (2):
  console: Move scrollback data into its own struct
  console: Add persistent scrollback buffers for all VGA consoles

 drivers/video/console/Kconfig  |  25 ++++++-
 drivers/video/console/vgacon.c | 146 +++++++++++++++++++++++++++----------=
----
 2 files changed, 117 insertions(+), 54 deletions(-)

--=20
2.1.4

