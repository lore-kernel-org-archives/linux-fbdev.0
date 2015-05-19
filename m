From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 19 May 2015 09:18:36 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Message-Id: <CAFRkauDznzcq6yVqQdDrNeaKu666Q_3M+LO1ZNV0DLzCjxOh4w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431785290.6638.1.camel@ingics.com>
	<20150519075908.GA23505@pengutronix.de>
In-Reply-To: <20150519075908.GA23505@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

2015-05-19 15:59 GMT+08:00 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Sat, May 16, 2015 at 10:08:10PM +0800, Axel Lin wrote:
>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions),
>> the gpiod_get* functions take an additional parameter that allows to
>> specify direction and initial value for output.
>> Simplify the usage of devm_gpiod_get_optional accordingly.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> as I just sent the same patch:
>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> @Axel: Do you have some more patches of this type in the queue? I
No, I don't have other patches of this type in the queue.

Regards,
Axel
