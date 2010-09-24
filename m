From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 24 Sep 2010 04:50:15 +0000
Subject: [PATCH 0/4] initial suspend and resume support
Message-Id: <cover.1285303222.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jonathan Corbet <corbet@lwn.net>

Hi,

this little patch series finally adds basic suspend and resume support.
The good thing is, that it nearly works. Well in fact it should work
fine if the only connected device is a CRT. For other devices it might
happen that suspend and resume works but the screen stays black. This
is probably caused by auxiliary devices that are connect via I2C lines
and not yet reinitialized properly.
This should be a huge improvent above the current behaviour, especially
the hardware acceleration including a visible cursor works.

As usual tests were performed on CLE266, VX800 and VX855.
These patches are also available on
	git://github.com/schandinat/linux-2.6.git viafb-s4v1

Happy testing :)


Thanks,

Florian Tobias Schandinat


Deepak Saxena (1):
  Minimal support for viafb suspend/resume

Florian Tobias Schandinat (3):
  viafb: restore display on resume
  viafb: make suspend and resume work (on all machines?)
  viafb: fix hardware acceleration for suspend & resume

 drivers/video/via/accel.c    |   43 +++++++++++++++++++++++++----------------
 drivers/video/via/accel.h    |    3 +-
 drivers/video/via/via-core.c |    4 +++
 drivers/video/via/viafbdev.c |   43 +++++++++++++++++++++++++++++++++++++++++-
 drivers/video/via/viafbdev.h |    2 +
 5 files changed, 76 insertions(+), 19 deletions(-)

