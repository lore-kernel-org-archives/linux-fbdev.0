From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 19 Apr 2011 05:45:48 +0000
Subject: [GIT PULL] viafb regression fix for 2.6.39
Message-Id: <4DAD218C.6070708@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

please pull the viafb regression fix below.
It fixes a bug in the OLPC modeline to make the OLPC display work again.


Thanks,

Florian Tobias Schandinat


The following changes since commit 3f086fe93f734ba76f2e130777687f81e0cbb318:
   Florian Tobias Schandinat (1):
         viafb: initialize margins correct

are available in the git repository at:

   git://github.com/schandinat/linux-2.6.git viafb-next

Florian Tobias Schandinat (1):
       viafb: fix OLPC DCON refresh rate

  drivers/video/via/hw.c      |    8 ++++++--
  drivers/video/via/viamode.c |    2 +-
  2 files changed, 7 insertions(+), 3 deletions(-)
