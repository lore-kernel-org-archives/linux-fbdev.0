From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 05 Aug 2011 21:49:53 +0000
Subject: [PATCH 0/6] viafb modesetting update 1
Message-Id: <cover.1312578946.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi all,

this is the first series containing some stable patches of my 
modesetting work. Adding the functions for setting the timing 
parameters in via_modesetting is an important step as well as 
pushing the strange behaviour that sync end and blanking end 
contained the length and not the end value one level up.
Additionally it has some related cleanups.
All this should be relatively stable, is not expected to cause 
regressions and was tested on CLE266, VX800 and VX855. These 
patches will show up in linux-next after the merge window is 
closed.
The next step will be to limit the influence of the modetable 
and hopefully replace parts of it by things provided in the 
subsystem to get rid of some bugs.


Thanks,

Florian Tobias Schandinat


Florian Tobias Schandinat (6):
  viafb: use more compact modesetting functions
  viafb: kill viafb_load_crtc_timing
  viafb: remove superfluous register unlocking/locking
  viafb: remove superfluous mode lookup
  viafb: simplify viafb_fill_crtc_timing
  viafb: remove 640x480-60 CRT special case

 drivers/video/via/dvi.c             |    6 +-
 drivers/video/via/hw.c              |  341 ++---------------------------------
 drivers/video/via/hw.h              |  277 +----------------------------
 drivers/video/via/lcd.c             |   41 ++---
 drivers/video/via/lcd.h             |    2 -
 drivers/video/via/share.h           |   19 +--
 drivers/video/via/via_modesetting.c |  104 +++++++++++
 drivers/video/via/via_modesetting.h |   18 ++
 drivers/video/via/viafbdev.c        |    2 -
 drivers/video/via/viamode.c         |    2 +-
 10 files changed, 161 insertions(+), 651 deletions(-)

