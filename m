From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:15:00 +0000
Subject: Re: [PATCH -next] fbdev: s3c-fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <908e757a-11e8-c3f0-13d2-5dc8564e5c43@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190904115523.25068-1-yuehaibing@huawei.com>
 <CGME20190917192130epcas4p487980f3b24a63f66203a009f1e59293e@epcas4p4.samsung.com>
 <SL2P216MB0105ADD044BE3CA7B33CB6ECAA8F0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SL2P216MB0105ADD044BE3CA7B33CB6ECAA8F0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jingoohan1@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>


On 9/17/19 9:21 PM, Jingoo Han wrote:
>=20
>=20
> =EF=BB=BFOn 9/4/19, 7:57 AM, YueHaibing wrote:
>=20
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> ---
>>  drivers/video/fbdev/s3c-fb.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
>> index ba04d7a..43ac8d7 100644
>> --- a/drivers/video/fbdev/s3c-fb.c
>> +++ b/drivers/video/fbdev/s3c-fb.c
>> @@ -1411,8 +1411,7 @@ static int s3c_fb_probe(struct platform_device *pd=
ev)
>> =20
>>  	pm_runtime_enable(sfb->dev);
>> =20
>> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	sfb->regs =3D devm_ioremap_resource(dev, res);
>> +	sfb->regs =3D devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(sfb->regs)) {
>>  		ret =3D PTR_ERR(sfb->regs);
>>  		goto err_lcd_clk;
>> --=20
>> 2.7.4
