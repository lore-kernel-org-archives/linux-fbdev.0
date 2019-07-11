From: Phil Reid <preid@electromag.com.au>
Date: Thu, 11 Jul 2019 08:31:51 +0000
Subject: [PATCH 0/2] Staging: fbtft: Fix probing of gpio descriptor
Message-Id: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, leobras.c@gmail.com, nishadkamdar@gmail.com, preid@electromag.com.au, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, nsaenzjulienne@suse.de

GPIO probing and reset polarity are broken.
Fix them.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")

Phil Reid (2):
  Staging: fbtft: Fix probing of gpio descriptor
  Staging: fbtft: Fix reset assertion when using gpio descriptor

 drivers/staging/fbtft/fbtft-core.c | 43 ++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

-- 
1.8.3.1
