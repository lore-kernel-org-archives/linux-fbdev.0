From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Wed, 16 Nov 2016 20:30:58 +0000
Subject: [PATCH v4.1 0/2] console: Add persistent scrollback buffers for all VGA console
Message-Id: <1479328260-16286-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479317933-21849-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1479317933-21849-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: manuel.schoelling@gmx.de, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

Well, that's embarrassing: I changed the order of some local commits
in the last minute, so my patches included a compiler error.

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

 drivers/video/console/Kconfig  |  23 +++++-
 drivers/video/console/vgacon.c | 158 ++++++++++++++++++++++++++++---------=
----
 2 files changed, 127 insertions(+), 54 deletions(-)

--=20
2.1.4

