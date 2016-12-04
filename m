From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Sun, 04 Dec 2016 10:53:53 +0000
Subject: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1480848836-11330-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: manuel.schoelling@gmx.de, jslaby@suse.cz, gregkh@linuxfoundation.org, andrey_utkin@fastmail.com, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Adam Borowski <kilobyte@angband.pl>

--
Changes in v7:
  - Add new callback to consw struct for flushing video console driver's
    scrollback buffer. Fixes issues with escape sequence '\e[3J' reported
    by Adam Borowski (kilobyte@angband.pl).
  - Fix style issues
Changes in v6:
  - Change of check if feature is enabled in=20
    vgacon_scrollback_switch()
Changes in v5:
  - Clearify documentation
  - Skip superfluous array initialization
  - Disable scrollback if buffer allocation fails
  - Refactor vgacon_switch_scrollback()
  - Rename vgacon_switch_scrollback() to vgacon_scrollback_switch()
  - Add check for fg_console in vgacon_scrollback_update
Changes in v4.1:
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

Manuel Sch=C3=B6lling (3):
  console: Move scrollback data into its own struct
  console: Add callback to flush scrollback buffer to consw struct
  console: Add persistent scrollback buffers for all VGA consoles

 drivers/tty/vt/vt.c            |   9 +++
 drivers/video/console/Kconfig  |  25 ++++++-
 drivers/video/console/vgacon.c | 165 ++++++++++++++++++++++++++++---------=
----
 include/linux/console.h        |   4 +
 4 files changed, 148 insertions(+), 55 deletions(-)

--=20
2.1.4

