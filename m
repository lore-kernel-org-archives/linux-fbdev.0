From: Dave Airlie <airlied@linux.ie>
Date: Fri, 25 Jan 2013 00:42:37 +0000
Subject: [git pull] fbcon locking fixes.
Message-Id: <alpine.DEB.2.00.1301250041001.25545@skynet.skynet.ie>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
Cc: DRI mailing list <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


Hi Linus,

These patches have been sailing around long enough, waiting for a maintainer
to reappear, so I've decided enough is enough, lockdep is kinda useful to have.

Thanks to Daniel for annoying me enough :-)

Dave 'not the fbdev maintainer' Airlie.

The following changes since commit ba2ab41f3d68f277860768b2c5b197768b196332:

  Merge tag 'pm+acpi-for-3.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2013-01-24 10:19:13 -0800)

are available in the git repository at:


  git://people.freedesktop.org/~airlied/linux fbcon-locking-fixes

for you to fetch changes up to a9d2331a8eccc17408abd5a7cd3e463745254d65:

  fb: Yet another band-aid for fixing lockdep mess (2013-01-25 10:34:49 +1000)

----------------------------------------------------------------
Alan Cox (1):
      fb: rework locking to fix lock ordering on takeover

Takashi Iwai (1):
      fb: Yet another band-aid for fixing lockdep mess

 drivers/tty/vt/vt.c           | 134 ++++++++++++++++++++++++++++++------------
 drivers/video/console/fbcon.c |  33 ++++++++++-
 drivers/video/fbmem.c         |   9 ++-
 drivers/video/fbsysfs.c       |   3 +
 include/linux/console.h       |   2 +
 include/linux/vt_kern.h       |   2 +
 6 files changed, 140 insertions(+), 43 deletions(-)
