From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 01 Oct 2015 08:00:22 +0000
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while requesting the PWM"
Message-Id: <560CE816.1060307@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
 <87bncjemdk.fsf@belgarion.home>
In-Reply-To: <87bncjemdk.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Robert Jarzmik <robert.jarzmik@free.fr>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Le 30/09/2015 21:29, Robert Jarzmik a =E9crit :
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>=20
>> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
>> This commit breaks legacy platforms, for which :
>>  (a) no pwm table is added (legacy platforms)
>>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefore
>>      chosen =3D NULL, and therefore pwm_get() returns NULL, and pwm_get()
>>      returns -EPROBE_DEFER
>>  (c) as a consequence, this code is unreachable in pwm_bl.c :
>>      if (IS_ERR(pb->pwm)) {
>> 	ret =3D PTR_ERR(pb->pwm);
>>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
>>  	if (ret =3D -EPROBE_DEFER)
>>  		goto err_alloc;
>>
>>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>>  	pb->legacy =3D true;
>>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>>
>> As this code is unreachable, all legacy platforms relying on pwm_id are
>> broken, amongst which pxa have been tested as broken.
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Thierry, would you have a look please ?
> As I said before, all legacy platform relying on pwm_id are broken. I'd l=
ike to
> be sure this lands in the next -rc series.

Well, as I answered on the linux-pwm mailing-list (I was not in copy) here:
http://article.gmane.org/gmane.linux.pwm/2744
I wonder if it's not easier to fix the platforms and add the pwm tables...

Otherwise, Boris proposed this fix:
8<-----------------------------------------------------------
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index eff379b..00483d4 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platform_device=
 *pdev)
 	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
 		ret =3D PTR_ERR(pb->pwm);
-		if (ret =3D -EPROBE_DEFER)
-			goto err_alloc;
=20
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 		pb->legacy =3D true;
 		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
 		if (IS_ERR(pb->pwm)) {
 			dev_err(&pdev->dev, "unable to request legacy PWM\n");
-			ret =3D PTR_ERR(pb->pwm);
+			if (ret !=3D -EPROBE_DEFER)
+				ret =3D PTR_ERR(pb->pwm);
+
 			goto err_alloc;
 		}
 	}

which is not tested and may add an extra non-valid error log.

Bye,
--=20
Nicolas Ferre
