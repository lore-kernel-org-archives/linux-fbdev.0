From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Wed, 01 Jul 2015 21:50:46 +0000
Subject: [RFC PATCH 16/15] pwm: add informations about polarity, duty cycle and period to debugfs
Message-Id: <3365087.n2eEES60JK@diego>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The pwm-states make it possible to also output the polarity, duty cycle
and period information in the debugfs pwm summary-outout.
This makes it easier to gather overview information about pwms without
needing to walk through the sysfs attributes of every pwm.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
might be nice to have too ;-)

 drivers/pwm/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6dafd8e..79037a2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -951,9 +951,18 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
 
-		if (pwm_is_enabled(pwm))
+		if (pwm_is_enabled(pwm)) {
 			seq_puts(s, " enabled");
 
+			seq_printf(s, " period:%uns",
+				   pwm_get_period(pwm));
+			seq_printf(s, " duty:%uns",
+				   pwm_get_duty_cycle(pwm));
+			seq_printf(s, " polarity:%s",
+				   pwm_get_polarity(pwm) ? "inverse"
+							 : "normal");
+		}
+
 		seq_puts(s, "\n");
 	}
 }
-- 
2.1.4


