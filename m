From: David Lechner <david@lechnology.com>
Date: Mon, 31 Jul 2017 19:09:43 +0000
Subject: [PATCH v2 0/2] Invert margin colors when terminal is inverted
Message-Id: <1501528185-9976-1-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

This is v2 of "fbcon: Use background color for margins=E2=80=8B"[1].

It turns out that using the text background color was not a good choice. So,
I've started over.

In this series, the margin color depends on the terminal's inversion state.=
 If
it is not inverted, then the margins are black as they currently are. But n=
ow,
if the terminal is inverted, the margin color is also inverted, so it is wh=
ite.

In order to detect when the terminal is inverted, I had to add a notifier
callback for the VT_UPDATE event. Otherwise, running `setterm -inverse on`
would not change the margins until I also ran `clear`.

[1]: https://patchwork.kernel.org/patch/9869421/

David Lechner (2):
  fbcon: Invert margin colors when terminal is inverted
  fbcon: add VT notifier for VT_UPDATE event

 drivers/video/console/bitblit.c   |  2 +-
 drivers/video/console/fbcon.c     | 28 ++++++++++++++++++++++++++++
 drivers/video/console/fbcon_ccw.c |  2 +-
 drivers/video/console/fbcon_cw.c  |  2 +-
 drivers/video/console/fbcon_ud.c  |  2 +-
 5 files changed, 32 insertions(+), 4 deletions(-)

--=20
2.7.4

