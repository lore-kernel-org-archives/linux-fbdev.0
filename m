From: Phil Reid <preid@electromag.com.au>
Date: Tue, 16 Jul 2019 00:24:36 +0000
Subject: [PATCH v2 1/2] Staging: fbtft: Fix probing of gpio descriptor
Message-Id: <1563236677-5045-2-git-send-email-preid@electromag.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1563236677-5045-1-git-send-email-preid@electromag.com.au>
In-Reply-To: <1563236677-5045-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, leobras.c@gmail.com, nsaenzjulienne@suse.de, nishadkamdar@gmail.com, preid@electromag.com.au, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

Conversion to use gpio descriptors broke all gpio lookups as
devm_gpiod_get_index was converted to use dev->driver->name for
the gpio name lookup. Fix this by using the name param. In
addition gpiod_get post-fixes the -gpios to the name so that
shouldn't be included in the call. However this then breaks the
of_find_property call to see if the gpio entry exists as all
fbtft treats all gpios as optional. So use devm_gpiod_get_index_optional
instead which achieves the same thing and is simpler.

Nishad confirmed the changes where only ever compile tested.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interfa=
ce")
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/staging/fbtft/fbtft-core.c | 39 ++++++++++++++++++----------------=
----
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbt=
ft-core.c
index 9b07bad..44b8074 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -76,21 +76,18 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 				  struct gpio_desc **gpiop)
 {
 	struct device *dev =3D par->info->device;
-	struct device_node *node =3D dev->of_node;
 	int ret =3D 0;
=20
-	if (of_find_property(node, name, NULL)) {
-		*gpiop =3D devm_gpiod_get_index(dev, dev->driver->name, index,
-					      GPIOD_OUT_HIGH);
-		if (IS_ERR(*gpiop)) {
-			ret =3D PTR_ERR(*gpiop);
-			dev_err(dev,
-				"Failed to request %s GPIO:%d\n", name, ret);
-			return ret;
-		}
-		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
-			      __func__, name);
+	*gpiop =3D devm_gpiod_get_index_optional(dev, name, index,
+					       GPIOD_OUT_HIGH);
+	if (IS_ERR(*gpiop)) {
+		ret =3D PTR_ERR(*gpiop);
+		dev_err(dev,
+			"Failed to request %s GPIO: %d\n", name, ret);
+		return ret;
 	}
+	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
+		      __func__, name);
=20
 	return ret;
 }
@@ -103,34 +100,34 @@ static int fbtft_request_gpios_dt(struct fbtft_par *p=
ar)
 	if (!par->info->device->of_node)
 		return -EINVAL;
=20
-	ret =3D fbtft_request_one_gpio(par, "reset-gpios", 0, &par->gpio.reset);
+	ret =3D fbtft_request_one_gpio(par, "reset", 0, &par->gpio.reset);
 	if (ret)
 		return ret;
-	ret =3D fbtft_request_one_gpio(par, "dc-gpios", 0, &par->gpio.dc);
+	ret =3D fbtft_request_one_gpio(par, "dc", 0, &par->gpio.dc);
 	if (ret)
 		return ret;
-	ret =3D fbtft_request_one_gpio(par, "rd-gpios", 0, &par->gpio.rd);
+	ret =3D fbtft_request_one_gpio(par, "rd", 0, &par->gpio.rd);
 	if (ret)
 		return ret;
-	ret =3D fbtft_request_one_gpio(par, "wr-gpios", 0, &par->gpio.wr);
+	ret =3D fbtft_request_one_gpio(par, "wr", 0, &par->gpio.wr);
 	if (ret)
 		return ret;
-	ret =3D fbtft_request_one_gpio(par, "cs-gpios", 0, &par->gpio.cs);
+	ret =3D fbtft_request_one_gpio(par, "cs", 0, &par->gpio.cs);
 	if (ret)
 		return ret;
-	ret =3D fbtft_request_one_gpio(par, "latch-gpios", 0, &par->gpio.latch);
+	ret =3D fbtft_request_one_gpio(par, "latch", 0, &par->gpio.latch);
 	if (ret)
 		return ret;
 	for (i =3D 0; i < 16; i++) {
-		ret =3D fbtft_request_one_gpio(par, "db-gpios", i,
+		ret =3D fbtft_request_one_gpio(par, "db", i,
 					     &par->gpio.db[i]);
 		if (ret)
 			return ret;
-		ret =3D fbtft_request_one_gpio(par, "led-gpios", i,
+		ret =3D fbtft_request_one_gpio(par, "led", i,
 					     &par->gpio.led[i]);
 		if (ret)
 			return ret;
-		ret =3D fbtft_request_one_gpio(par, "aux-gpios", i,
+		ret =3D fbtft_request_one_gpio(par, "aux", i,
 					     &par->gpio.aux[i]);
 		if (ret)
 			return ret;
--=20
1.8.3.1
