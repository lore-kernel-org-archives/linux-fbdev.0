From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Date: Thu, 16 May 2013 07:22:55 +0000
Subject: [PATCH 0/2] video: da8xx-fb trival cleanup
Message-Id: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DLOS <davinci-linux-open-source@linux.davincidsp.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch series cleans the header inclusion and uses devm_* api
in the driver.

This patch series applies on 3.10-rc1 and is only boot
tested enabling FB driver.

Lad, Prabhakar (2):
  video: da8xx-fb: remove unwanted header inclusion and sort the
    alphabetically
  video:da8xx-fb: Convert to devm_* api

 drivers/video/da8xx-fb.c |   62 ++++++++++++---------------------------------
 1 files changed, 17 insertions(+), 45 deletions(-)

-- 
1.7.4.1

