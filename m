From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 07 Aug 2011 15:46:54 +0000
Subject: [PATCH 0/6] viafb modesetting update 2
Message-Id: <cover.1312730859.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi all,

this is the second patch series. It's a little less stable than the 
previous one but it contains some great internal improvements.
We do no longer rely on the modetable structure across all sections 
and we use the values in var directly for CRT and DVI when possible. 
Basically this enables us to allow arbitary modes passed in var. 
That's not implemented yet and probably will never be the default as 
we want to do some sanity checking in check_var for the devices 
connected but would allow overriding buggy information.
Anyway with these patches it will be very simple to avoid the buggy 
modetable we use at the moment.


Best regards,

Florian Tobias Schandinat


Florian Tobias Schandinat (6):
  viafb: add new funcions to select a single mode
  viafb: eliminate viafb_get_pixclock
  viafb: use information in var for modesetting
  viafb: seperate hardware initialization
  viafb: eliminate modetable dependancy of LCD modesetting
  viafb: get rid of the remaining modetable structure assumptions

 drivers/video/via/dvi.c      |   30 ++----
 drivers/video/via/dvi.h      |    3 +-
 drivers/video/via/global.c   |    2 +
 drivers/video/via/global.h   |    2 +
 drivers/video/via/hw.c       |  229 ++++++++++++++++-------------------------
 drivers/video/via/hw.h       |   12 +--
 drivers/video/via/lcd.c      |   12 +--
 drivers/video/via/lcd.h      |    5 +-
 drivers/video/via/share.h    |    4 -
 drivers/video/via/viafbdev.c |   38 +++----
 drivers/video/via/viamode.c  |   58 ++++++++---
 drivers/video/via/viamode.h  |    4 +-
 12 files changed, 177 insertions(+), 222 deletions(-)

