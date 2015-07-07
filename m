From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
Date: Tue, 07 Jul 2015 14:24:10 +0000
Subject: [PATCH 0/2 v2] video/logo: add option to return largest logo for a given resolution
Message-Id: <1436279052-17237-1-git-send-email-urs.fassler@bytesatwork.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, oliver.staebler@bytesatwork.ch, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, urs.fassler@bytesatwork.ch, geert@linux-m68k.org

With this patches, the largest boot logo for a given display resolution is =
used.
We need that functionality since it is common that a product has variants w=
hich
differ only minimal in the hardware. Thus, we have the same kernel binary b=
ut
different device trees for different hardware / displays.
This patches allow use to show a full screen boot logo for every hardware
variant.

This is a rework of the patch from 3 Jul 2015 which respects the runtime-ch=
eck
on m68k.

Urs F=C3=A4ssler (2):
  logo: add option to return largest logo for a given resolution
  fbdev: use largest logo if possible

 drivers/video/fbdev/core/fbmem.c | 21 ++++++----
 drivers/video/logo/Kconfig       |  7 ++++
 drivers/video/logo/logo.c        | 86 ++++++++++++++++++++++++++++++++----=
----
 include/linux/linux_logo.h       |  4 ++
 4 files changed, 94 insertions(+), 24 deletions(-)

--=20
2.1.4

