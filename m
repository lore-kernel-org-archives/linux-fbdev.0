From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 13 Apr 2012 17:02:58 +0000
Subject: [GIT PULL] fbdev fixes for 3.4
Message-Id: <4F885C42.2000405@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Linus,

please pull the fixes below. The fix for kyrofb is a bit large but it's just
replacing "unsigned long" by "u32" for 64 bit compatibility.


Thanks,

Florian Tobias Schandinat


The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://github.com/schandinat/linux-2.6.git fbdev-fixes-for-3.4-1

for you to fetch changes up to b78f29ca0516266431688c5eb42d39ce42ec039a:

  video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
(2012-04-09 16:05:57 +0000)

----------------------------------------------------------------
fbdev fixes for 3.4

It includes:
- a compile fix for au1*fb
- a fix to make kyrofb usable on x86_64
- a fix for uvesafb to prevent an oops due to NX-protection

----------------------------------------------------------------
Manuel Lauss (1):
      fbdev: fix au1*fb builds

Ondrej Zary (1):
      kyrofb: fix on x86_64

Wang YanQing (1):
      video:uvesafb: Fix oops that uvesafb try to execute NX-protected page

 drivers/video/au1100fb.c        |    5 +-
 drivers/video/au1200fb.c        |    2 +-
 drivers/video/kyro/STG4000Reg.h |  376 +++++++++++++++++++-------------------
 drivers/video/uvesafb.c         |   11 +-
 4 files changed, 201 insertions(+), 193 deletions(-)
