From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 08 Mar 2012 17:55:57 +0000
Subject: [PATCH 0/2] viafb modetable conversion
Message-Id: <cover.1331229163.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hi all,

finally the modetable conversion is here. The first patch does the 
conversion to get rid of some strange things and lot of defines.
The conversion was done by a program and causes a lot of warnings by 
generating lines longer than 80 characters which I do not consider 
worth fixing. A side effect of this conversion seems to be that CRTs 
are happier with the resulting modes/clocks as the conversion program 
used floating point and therefore the resulting pixclocks are closer to 
what they should be.
The second patch is just sort of performance optimization by avoiding 
two unnecessary modetable walks.


Best regards,

Florian Tobias Schandinat


Florian Tobias Schandinat (2):
  viafb: modetable conversion
  viafb: avoid refresh and mode lookup in set_par

 drivers/video/via/dvi.c      |    2 +-
 drivers/video/via/hw.c       |   41 +--
 drivers/video/via/hw.h       |    4 +-
 drivers/video/via/lcd.c      |   53 +---
 drivers/video/via/share.h    |  331 --------------------
 drivers/video/via/viafbdev.c |   32 +-
 drivers/video/via/viamode.c  |  713 ++++++------------------------------------
 drivers/video/via/viamode.h  |   11 +-
 8 files changed, 134 insertions(+), 1053 deletions(-)

-- 
1.7.9

