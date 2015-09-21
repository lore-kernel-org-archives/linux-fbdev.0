From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 21 Sep 2015 09:33:25 +0000
Subject: [PATCH v3 08/12] pwm: add information about polarity, duty cycle and period to debugfs
Message-Id: <1442828009-6241-9-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
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
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ff3c662..7eba2f3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1018,6 +1018,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
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

