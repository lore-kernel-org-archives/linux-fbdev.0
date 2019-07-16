From: Phil Reid <preid@electromag.com.au>
Date: Tue, 16 Jul 2019 00:24:35 +0000
Subject: [PATCH 0/2] Staging: fbtft: Fix probing of gpio descriptor
Message-Id: <1563236677-5045-1-git-send-email-preid@electromag.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
In-Reply-To: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, leobras.c@gmail.com, nsaenzjulienne@suse.de, nishadkamdar@gmail.com, preid@electromag.com.au, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

GPIO probing and reset polarity are broken.
Fix them.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")

Changes from v2:
- Add fixes tag to "Fix reset assertion when using gpio descriptor"
- Add tested-by / reviewed-by tags

Phil Reid (2):
  Staging: fbtft: Fix probing of gpio descriptor
  Staging: fbtft: Fix reset assertion when using gpio descriptor

 drivers/staging/fbtft/fbtft-core.c | 43 ++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

-- 
1.8.3.1
