From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 19 May 2014 20:42:32 +0000
Subject: [PATCHv2 resend 01/11] pwm: add period and polarity to struct pwm_lookup
Message-Id: <1400532162-29483-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Adds a period and a polarity member to struct pwm_lookup so that when performing
a lookup using the lookup table instead of device tree, we are able to set the
period and the polarity accordingly like what is done in
of_pwm_xlate_with_flags.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/core.c  | 8 +++++++-
 include/linux/pwm.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a80471399c20..4b66bf09ee55 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -661,10 +661,16 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 		}
 	}
 
+	mutex_unlock(&pwm_lookup_lock);
+
 	if (chip)
 		pwm = pwm_request_from_chip(chip, index, con_id ?: dev_id);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm_set_period(pwm, p->period);
+	pwm_set_polarity(pwm, p->polarity);
 
-	mutex_unlock(&pwm_lookup_lock);
 
 	return pwm;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4717f54051cb..2f45e2fe5b93 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -274,6 +274,8 @@ struct pwm_lookup {
 	unsigned int index;
 	const char *dev_id;
 	const char *con_id;
+	unsigned int period;
+	enum pwm_polarity polarity;
 };
 
 #define PWM_LOOKUP(_provider, _index, _dev_id, _con_id)	\
-- 
1.9.1

