From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Tue, 22 Nov 2016 16:43:36 +0000
Subject: [PATCH v6 0/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1479833018-20021-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

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

Manuel Sch=C3=B6lling (2):
  console: Move scrollback data into its own struct
  console: Add persistent scrollback buffers for all VGA consoles

 drivers/video/console/Kconfig  |  25 ++++++-
 drivers/video/console/vgacon.c | 149 +++++++++++++++++++++++++++----------=
----
 2 files changed, 120 insertions(+), 54 deletions(-)

--=20
2.1.4

