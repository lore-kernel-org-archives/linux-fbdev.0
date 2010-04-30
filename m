From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2010 21:39:47 +0000
Subject: [PATCH 1/3] viafb: Do not remove gpiochip under spinlock
Message-Id: <1272663589-4950-2-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272663589-4950-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272663589-4950-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

gpiochip_remove() is not meant to be called with interrupts disabled, and
there is no need for the lock here in any case.

Reported-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via-gpio.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/via-gpio.c b/drivers/video/via/via-gpio.c
index 44537be..63cb7ac 100644
--- a/drivers/video/via/via-gpio.c
+++ b/drivers/video/via/via-gpio.c
@@ -246,7 +246,6 @@ static int viafb_gpio_remove(struct platform_device *pl=
atdev)
 	unsigned long flags;
 	int ret =3D 0, i;
=20
-	spin_lock_irqsave(&gpio_config.vdev->reg_lock, flags);
 	/*
 	 * Get unregistered.
 	 */
@@ -254,16 +253,16 @@ static int viafb_gpio_remove(struct platform_device *=
platdev)
 		ret =3D gpiochip_remove(&gpio_config.gpio_chip);
 		if (ret) { /* Somebody still using it? */
 			printk(KERN_ERR "Viafb: GPIO remove failed\n");
-			goto out;
+			return ret;
 		}
 	}
 	/*
 	 * Disable the ports.
 	 */
+	spin_lock_irqsave(&gpio_config.vdev->reg_lock, flags);
 	for (i =3D 0; i < gpio_config.gpio_chip.ngpio; i +=3D 2)
 		viafb_gpio_disable(gpio_config.active_gpios[i]);
 	gpio_config.gpio_chip.ngpio =3D 0;
-out:
 	spin_unlock_irqrestore(&gpio_config.vdev->reg_lock, flags);
 	return ret;
 }
--=20
1.7.0.1

