From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 01 Jul 2015 08:21:49 +0000
Subject: [RFC PATCH 03/15] pwm: add pwm_get_polarity helper function
Message-Id: <1435738921-25027-4-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Some drivers are directly accessing the ->polarity field in pwm_device.
Add an helper to retrieve the current polarity so that we can easily move
this field elsewhere (required to support atomic update).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d8f6913..6f286df 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -124,6 +124,11 @@ static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
  */
 int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity);
 
+static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
+{
+	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;
+}
+
 /**
  * struct pwm_ops - PWM controller operations
  * @request: optional hook for requesting a PWM
-- 
1.9.1

