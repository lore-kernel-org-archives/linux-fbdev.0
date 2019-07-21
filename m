From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 21 Jul 2019 18:54:39 +0000
Subject: [RFC] Staging: fbtft: Typo in
Message-Id: <f4881a63-8702-55f2-ed03-cfbc30970083@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

looking at the code in 'drivers/staging/fbtft/fb_pcd8544.c', there seems 
to be some typos.

At the end of the file, we can find:

FBTFT_REGISTER_DRIVER(DRVNAME, "philips,pdc8544", &display);
...
MODULE_ALIAS("spi:pdc8544");


It is likely that the 2 pdc8544 should be pcd8544. (d and c switched)

As I don't know the implication of such a change, I prefer to first 
report the potential issue, before proposing a patch for it.

Any feedback back appreciated.

Best regards,
Christophe JAILLET
