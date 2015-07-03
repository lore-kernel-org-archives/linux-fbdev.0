From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Fri, 03 Jul 2015 08:43:22 +0000
Subject: [PATCH] pwm: add informations about polarity, duty cycle and period to debugfs
Message-Id: <2415780.vdSYHqsCOV@diego>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3365087.n2eEES60JK@diego> <20150702150141.5018a791@bbrezillon>
In-Reply-To: <20150702150141.5018a791@bbrezillon>
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
now values are printed independent of the enable status :-)

 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6dafd8e..4360ebb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -954,6 +954,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (pwm_is_enabled(pwm))
 			seq_puts(s, " enabled");
 
+		seq_printf(s, " period:%uns", pwm_get_period(pwm));
+		seq_printf(s, " duty:%uns", pwm_get_duty_cycle(pwm));
+		seq_printf(s, " polarity:%s", pwm_get_polarity(pwm) ? "inverse"
+								    : "normal");
+
 		seq_puts(s, "\n");
 	}
 }
-- 
2.1.4


