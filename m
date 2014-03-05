From: Daniel Mack <zonque@gmail.com>
Date: Wed, 05 Mar 2014 16:12:45 +0000
Subject: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <1394035969-32420-1-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Here are some cleanups for the pxa3xx-gcu driver. Patch 3/4 is actually
a real bugfix that is needed since the misc code doesn't set
file->private_data for us implicitly anymore.

The rest are just straight-forward cleanups.

Thanks,
Daniel


Daniel Mack (4):
  video: pxa3xx-gcu: rename some symbols
  video: pxa3xx-gcu: pass around struct device *
  video: pxa3xx-gcu: provide an empty .open call
  video: pxa3xx-gcu: switch to devres functions

 drivers/video/pxa3xx-gcu.c | 191 +++++++++++++++++++--------------------------
 1 file changed, 81 insertions(+), 110 deletions(-)

-- 
1.8.5.3

