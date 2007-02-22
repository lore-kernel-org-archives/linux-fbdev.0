From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: ibm-acpi: fix initial status of backlight device
Date: Thu, 22 Feb 2007 16:19:35 -0200
Message-ID: <20070222181935.GG25887@khazad-dum.debian.net>
References: <1171876788.6046.3.camel@localhost.localdomain> <877iub9mu2.fsf@sycorax.lbl.gov> <1172097718.5790.29.camel@localhost.localdomain> <20070221231706.GA3336@khazad-dum.debian.net> <1172103159.5790.45.camel@localhost.localdomain> <20070222005122.GA7928@khazad-dum.debian.net> <20070222011017.GA8845@khazad-dum.debian.net> <20070222011643.GB8845@khazad-dum.debian.net> <1172138587.5837.37.camel@localhost.localdomain> <20070222144511.GC25887@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070222144511.GC25887@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Here's the final version.  I will request a pull from Len Brown to get it
into acpi-test, from where it will eventually reach mainline at Len's
discretion.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ACPI: ibm-acpi: fix initial status of backlight device

The brightness class core does not update the initial status of the
device's brightness at register time.  Do it by ourselves.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/acpi/ibm_acpi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 4cc534e..7c1b418 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1711,6 +1711,12 @@ static struct backlight_ops ibm_backlight_data = {
 
 static int brightness_init(void)
 {
+	int b;
+
+	b = brightness_get(NULL);
+	if (b < 0)
+		return b;
+
 	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
 							 &ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
@@ -1718,7 +1724,9 @@ static int brightness_init(void)
 		return PTR_ERR(ibm_backlight_device);
 	}
 
-        ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.brightness = b;
+	backlight_update_status(ibm_backlight_device);
 
 	return 0;
 }
-- 
1.4.4.4

