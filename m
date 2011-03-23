From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Mar 2011 12:25:25 +0000
Subject: [GIT PULL] viafb fixes for 2.6.39
Message-Id: <4D89E6B5.8080005@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

please pull the viafb fixes below.
They fix the handling of refresh rates which should now work (or at least work 
much better than it did before). Especially the initial refresh rate as passed 
in via module parameter is now handled correct. Before these patches this didn't 
work for higher refresh rates.


Thanks,

Florian Tobias Schandinat


The following changes since commit 2563afa9ec6970f3545906382cc986ee012f60ec:
   Florian Tobias Schandinat (1):
         Merge branch 'viafb-pll' into viafb-next

are available in the git repository at:

   git://github.com/schandinat/linux-2.6.git viafb-next

Florian Tobias Schandinat (2):
       viafb: refresh rate bug collection
       viafb: initialize margins correct

  drivers/video/via/chip.h     |    1 -
  drivers/video/via/hw.c       |   17 ++++------
  drivers/video/via/hw.h       |    3 +-
  drivers/video/via/viafbdev.c |   74 +++++++++++++++++++++--------------------
  4 files changed, 46 insertions(+), 49 deletions(-)
