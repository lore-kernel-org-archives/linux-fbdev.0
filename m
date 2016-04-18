From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Mon, 18 Apr 2016 19:56:56 +0000
Subject: [PATCH 0/2] Persistent scrollback buffers for all VGA consoles
Message-Id: <1461009418-1795-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461009405-1738-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1461009405-1738-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, thomas@winischhofer.net, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jejb@parisc-linux.org, deller@gmx.de, manuel.schoelling@gmx.de, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org

Another attempt to add persistent scrollback buffers for all VGA consoles,
so the buffer is not flushed when swithing back and forth between consoles.

Note that breaks tools like bash's clear_console and thus might have
security implications:
clear_console relies on this 'anti-feature' of the kernel to clear the buff=
er
when consoles are switched.

To offer a way for userland tools to flush the buffer my second patch adds
a ioctl call for that.
Also this feature is disabled by default and security implications are clea=
rly
stated in its documentation.

Manuel Sch=C3=B6lling (2):
  console: Add persistent scrollback buffers for all VGA consoles
  console: Add ioctl for flushing the scrollback buffer

 drivers/tty/vt/vt_ioctl.c               |  20 ++++
 drivers/usb/misc/sisusbvga/sisusb_con.c |   1 +
 drivers/video/console/Kconfig           |  22 +++-
 drivers/video/console/dummycon.c        |   1 +
 drivers/video/console/mdacon.c          |   6 +
 drivers/video/console/newport_con.c     |   1 +
 drivers/video/console/sticon.c          |   7 ++
 drivers/video/console/vgacon.c          | 195 ++++++++++++++++++++++------=
----
 include/linux/console.h                 |   1 +
 include/uapi/linux/vt.h                 |   1 +
 10 files changed, 194 insertions(+), 61 deletions(-)

--=20
2.1.4

