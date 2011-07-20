From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 20 Jul 2011 15:22:57 +0000
Subject: [GIT PULL] viafb updates for 3.1
Message-Id: <4E26F2D1.5040205@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

please pull the viafb updates below. It contains only 2 fixes.


Thanks,

Florian Tobias Schandinat


The following changes since commit 8aa4d96fe3e4cda9a6469b22b3f017ed30996b10:
   Daniel Drake (1):
         viafb: Automatic OLPC XO-1.5 configuration

are available in the git repository at:

   git://github.com/schandinat/linux-2.6.git viafb-next

Florian Tobias Schandinat (2):
       viafb: use display information in info not in var for panning
       viafb: improve pitch handling

  drivers/video/via/via_modesetting.h |    5 +++++
  drivers/video/via/viafbdev.c        |   16 +++++++++++-----
  2 files changed, 16 insertions(+), 5 deletions(-)
