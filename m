From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 11:55:17 +0000
Subject: [PATCH v2 0/2] video/fbdev/stifb: Adjustments for stifb_init_fb()
Message-Id: <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
 <CGME20171124213055epcas4p45c641222185056871b97f4e7bc235d2e@epcas4p4.samsung.com>
 <25624997.nONnEdNj0s@daneel.sf-tec.de> <1680261.Msdj7gi9fB@amdc3058>
In-Reply-To: <1680261.Msdj7gi9fB@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Helge Deller <deller@gmx.de>, "James E. J. Bottomley" <jejb@parisc-linux.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 12:45:54 +0100

Two update suggestions were taken into account.

Markus Elfring (2):
  Return -ENOMEM after a failed kzalloc()
  Delete an error message for a failed memory allocation

 drivers/video/fbdev/stifb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.15.1

