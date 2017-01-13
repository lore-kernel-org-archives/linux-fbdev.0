From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Fri, 13 Jan 2017 20:07:54 +0000
Subject: [PATCH v10 0/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170113200758.9880-1-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
In-Reply-To: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

Changes in v10:
  - Fix compilation error if CONFIG_VGACON_SOFT_SCROLLBACK=3Dn
Changes in v9:
  - Make persistent scrollback feature a boot parameter
Changes in v8:
  - Add Reviewed-by/Tested-By statements
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

Manuel Sch=C3=B6lling (4):
  console: Move scrollback data into its own struct
  console: Add callback to flush scrollback buffer to consw struct
  console: Add persistent scrollback buffers for all VGA consoles
  console: Make persistent scrollback a boot parameter

 drivers/tty/vt/vt.c            |   9 +++
 drivers/video/console/Kconfig  |  27 ++++++-
 drivers/video/console/vgacon.c | 164 ++++++++++++++++++++++++++++---------=
----
 include/linux/console.h        |   4 +
 4 files changed, 149 insertions(+), 55 deletions(-)

--=20
2.11.0

