From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Mon, 06 Jan 2014 13:17:56 +0000
Subject: [PATCH 0/2] video: mxsfb: fix broken videomode selection
Message-Id: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The first patch in this set converts some messages that are printed
in case of errors to be error messages rather than debug messages.

The second patch fixes a bug in the video selection code that
incorrectly OR's together the 'pixelclk-active' and 'de-active'
flags from all possible video modes specified in DT into one flag.

The current code does not allow selecting one specific mode from a
list of video modes, but always uses the last one of the video modes
listed in the DT.


Since all current dts files only have one entry in their
'display-timings' node, this bug was not apparent and the fix does not
change the driver's behaviour for the current users.

 b/drivers/video/mxsfb.c |    6 +--
 drivers/video/mxsfb.c   |  120 +++++++++++++++++++++++++++++-----------------------------------------
 2 files changed, 53 insertions(+), 73 deletions(-)

