From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ACPI: ibm-acpi: fix initial status of backlight device
Date: Wed, 21 Feb 2007 23:16:43 -0200
Message-ID: <20070222011643.GB8845@khazad-dum.debian.net>
References: <20070219044616.GC25659@washoe.onerussian.com> <20070219000412.acad13de.akpm@linux-foundation.org> <1171876788.6046.3.camel@localhost.localdomain> <877iub9mu2.fsf@sycorax.lbl.gov> <1172097718.5790.29.camel@localhost.localdomain> <20070221231706.GA3336@khazad-dum.debian.net> <1172103159.5790.45.camel@localhost.localdomain> <20070222005122.GA7928@khazad-dum.debian.net> <20070222011017.GA8845@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070222011017.GA8845@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

The brightness class core does not update the initial status of
the device's brightness at register time.  Do it by ourselves
before we register the class device.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Purdie <rpurdie@rpsys.net>
---

NOTE: This patch needs an ACK from Richard Purdie before it can be merged,
as he might want to change the backlight class code instead.

 drivers/acpi/ibm_acpi.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 2429e11..6875421 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1713,6 +1713,13 @@ static struct backlight_properties ibm_backlight_data = {
 
 static int brightness_init(void)
 {
+	int b;
+
+	b = brightness_get(NULL);
+	if (b < 0)
+		return b;
+	ibm_backlight_data.brightness = b;
+
 	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
 							 &ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
-- 
1.4.4.4

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
