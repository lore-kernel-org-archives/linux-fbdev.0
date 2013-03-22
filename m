From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:12:28 +0000
Subject: [PATCH 0/9] AUO-K190x: Rotation, truecolor and misc fixes
Message-Id: <201303221512.28604.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

This series enables rotating the display using the framebuffer functions.
It also introduces a 16bit truecolor mode for applications that don't work
well with the only mode (8bit grayscale) that is available currently.

Heiko St=C3=BCbner (9):
  AUO-K190x: Use correct line length
  AUO-K190x: add runtime-pm calls to controller init functions
  AUO-K190x: set the correct runtime-pm state in recover
  AUO-K190x: make memory check in check_var more flexible
  AUO-K190x: move var resolution-handling into check_var
  AUO-K190x: make color handling more flexible
  AUO-K190x: add a 16bit truecolor mode
  AUO-K190x: add framebuffer rotation support
  AUO-K190x: Add resolutions for portrait displays

 drivers/video/auo_k1900fb.c |   11 ++-
 drivers/video/auo_k1901fb.c |   11 ++-
 drivers/video/auo_k190x.c   |  235 +++++++++++++++++++++++++++++++++++----=
----
 include/video/auo_k190xfb.h |    3 +-
 4 files changed, 214 insertions(+), 46 deletions(-)

--=20
1.7.2.3

