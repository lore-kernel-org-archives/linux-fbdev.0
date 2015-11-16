From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:42 +0000
Subject: [PATCH v4 19/24] pwm: add the PWM initial state retrieval infra
Message-Id: <1447664207-24370-20-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a ->reset_state() function to the pwm_ops struct to let PWM drivers
initialize the PWM state attached to a PWM device.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/core.c  | 3 +++
 include/linux/pwm.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6bbda6c..ce8b373 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -271,6 +271,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm_set_default_polarity(pwm, polarity);
 		mutex_init(&pwm->lock);
 
+		if (chip->ops->reset_state)
+			chip->ops->reset_state(chip, pwm);
+
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 292e7da..caa0ffe 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -182,6 +182,9 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @reset_state: reset the current PWM state (pwm->state) to the actual
+ *		 hardware state. This function is only called once per
+ *		 PWM device when the PWM chip is registered.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -194,6 +197,7 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	void (*reset_state)(struct pwm_chip *chip, struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
-- 
2.1.4

