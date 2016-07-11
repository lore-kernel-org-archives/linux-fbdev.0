From: Michael Hennerich <michael.hennerich@analog.com>
Date: Mon, 11 Jul 2016 07:25:44 +0000
Subject: Re: [PATCH] backlight: adp5520: fix error handling in adp5520_bl_probe()
Message-Id: <578349F8.2070207@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1468016392-6061-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1468016392-6061-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On 09.07.2016 00:19, Alexey Khoroshilov wrote:
> If adp5520_bl_setup() fails, sysfs group left unremoved.
>
> By the way, fix overcomplicated assignement of error code.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/video/backlight/adp5520_bl.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlig=
ht/adp5520_bl.c
> index dd88ba1d71ce..35373e2065b2 100644
> --- a/drivers/video/backlight/adp5520_bl.c
> +++ b/drivers/video/backlight/adp5520_bl.c
> @@ -332,10 +332,18 @@ static int adp5520_bl_probe(struct platform_device =
*pdev)
>   	}
>
>   	platform_set_drvdata(pdev, bl);
> -	ret |=3D adp5520_bl_setup(bl);
> +	ret =3D adp5520_bl_setup(bl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to setup\n");
> +		if (data->pdata->en_ambl_sens)
> +			sysfs_remove_group(&bl->dev.kobj,
> +					&adp5520_bl_attr_group);
> +		return ret;
> +	}
> +
>   	backlight_update_status(bl);
>
> -	return ret;
> +	return 0;
>   }
>
>   static int adp5520_bl_remove(struct platform_device *pdev)
>


--=20
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 M=FCnchen
Sitz der Gesellschaft M=FCnchen, Registergericht M=FCnchen HRB 40368,
Gesch=E4ftsf=FChrer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
