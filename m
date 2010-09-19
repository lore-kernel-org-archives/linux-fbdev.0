From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Sep 2010 07:26:05 +0000
Subject: [PATCH 00/12] viafb output device rework - part 2
Message-Id: <cover.1284879532.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi,

this part of the patch series has finally a huge impact on the user
experience:

- A new/extended interface in proc allows enabling/disabling of output
  devices during runtime

- The device initialization time is significant shorter after reducing
  I2C timing values to a sane limit

- A regression is fixed that prevented detection of VT1636 chips and
  therefore broke the framebuffer in such configurations

But it contains also a lot of changes in the background that will
(hopefully) lead to a better future.

The complete patch series until now can also be found at
	git://github.com/schandinat/linux-2.6.git viafb-s3v1

As usual, some tests were performed on CLE266, VX800 and VX855.

Any opinions/suggestions?


Have fun,

Florian Tobias Schandinat


Florian Tobias Schandinat (12):
  viafb: add interface for output device configuration
  viafb: limit LCD code impact
  viafb: introduce per output device power management
  viafb: vt1636 cleanup
  viafb: fix i2c_transfer error handling
  viafb: enable I2C for CRT
  viafb: reduce I2C timeout and delay
  viafb: add function to change sync polarity per device
  viafb: set sync polarity for all output devices
  viafb: add a mapping of supported output devices
  viafb: rename output devices
  viafb: add documentation for proc interface

 Documentation/fb/viafb.txt   |   48 ++++++++
 drivers/video/via/Makefile   |    2 +-
 drivers/video/via/dvi.c      |   25 +----
 drivers/video/via/global.h   |    1 -
 drivers/video/via/hw.c       |  265 ++++++++++++++++++++++++++++++++++++------
 drivers/video/via/hw.h       |   30 ++++-
 drivers/video/via/lcd.c      |   41 -------
 drivers/video/via/tbl1636.c  |   71 -----------
 drivers/video/via/tbl1636.h  |   34 ------
 drivers/video/via/via-core.c |    2 +-
 drivers/video/via/via_i2c.c  |   31 ++++-
 drivers/video/via/viafbdev.c |  225 ++++++++++++++++++++++++++++++++----
 drivers/video/via/viafbdev.h |    2 +
 drivers/video/via/vt1636.c   |  121 +++++++-------------
 14 files changed, 576 insertions(+), 322 deletions(-)
 delete mode 100644 drivers/video/via/tbl1636.c
 delete mode 100644 drivers/video/via/tbl1636.h

