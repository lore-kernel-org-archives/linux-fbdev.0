From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 20 Jul 2015 15:32:05 +0000
Subject: [PATCH v2 08/10] pwm: add information about polarity, duty cycle and period to debugfs
Message-Id: <1437406327-6207-9-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

From: Heiko St=C3=BCbner <heiko@sntech.de>

The pwm-states make it possible to also output the polarity, duty cycle
and period information in the debugfs pwm summary-outout.
This makes it easier to gather overview information about pwms without
needing to walk through the sysfs attributes of every pwm.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4fe4703..9fc8338 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -986,6 +986,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct=
 seq_file *s)
 		if (pwm_is_enabled(pwm))
 			seq_puts(s, " enabled");
=20
+		seq_printf(s, " period:%uns", pwm_get_period(pwm));
+		seq_printf(s, " duty:%uns", pwm_get_duty_cycle(pwm));
+		seq_printf(s, " polarity:%s", pwm_get_polarity(pwm) ? "inverse"
+								    : "normal");
+
 		seq_puts(s, "\n");
 	}
 }
--=20
1.9.1

