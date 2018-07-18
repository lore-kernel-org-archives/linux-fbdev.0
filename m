From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:03:24 +0000
Subject: [PATCH 3/6] vt: let \e[100m use bright background if unblinking
Message-Id: <20180718030327.579-3-kilobyte@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

Let's keep \e[5m setting this bit, it's a nice way to convey the
information, and it preserves old behaviour.  Some other terminals
that can't or don't want to blink do so as well.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 45057bbf6f74..4096093c8cd2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1709,6 +1709,8 @@ static void csi_m(struct vc_data *vc)
 			if (vc->vc_par[i] >= 90 && vc->vc_par[i] <= 107) {
 				if (vc->vc_par[i] < 100)
 					vc->vc_intensity = 2;
+				else if (vc->vc_unblinking)
+					vc->vc_blink = 1;
 				vc->vc_par[i] -= 60;
 			}
 			if (vc->vc_par[i] >= 30 && vc->vc_par[i] <= 37)
-- 
2.18.0

