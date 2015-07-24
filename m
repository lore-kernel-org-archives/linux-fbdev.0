From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 24 Jul 2015 06:12:22 +0000
Subject: Re: [PATCH RESEND] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <CAJKOXPc=k8r64_LuUGBaoOK87h07_zXUn_LoQ50KWfbk-1u69w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436274047-3274-1-git-send-email-k.kozlowski.k@gmail.com>
	<254E99D1-79CE-4B90-B732-E5A4A1308DC4@gmail.com>
In-Reply-To: <254E99D1-79CE-4B90-B732-E5A4A1308DC4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2015-07-08 13:34 GMT+09:00 Jingoo Han <jingoohan1@gmail.com>:
>
> On 2015. 7. 7., at PM 10:00, Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:
>>
>> The platform_device_id is not modified by the driver and core uses it as
>> const.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>
> Best regards,
> Jingoo Han

Seems nobody is picking it up, so I merge it through Samsung-SoC tree.
If there are any objections please let me know.

Best regards,
Krzysztof

>
>> ---
>> drivers/video/fbdev/s3c-fb.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
>> index 7e3a05fc47aa..f72dd12456f9 100644
>> --- a/drivers/video/fbdev/s3c-fb.c
>> +++ b/drivers/video/fbdev/s3c-fb.c
>> @@ -1938,7 +1938,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
>>    },
>> };
>>
>> -static struct platform_device_id s3c_fb_driver_ids[] = {
>> +static const struct platform_device_id s3c_fb_driver_ids[] = {
>>    {
>>        .name        = "s3c-fb",
>>        .driver_data    = (unsigned long)&s3c_fb_data_64xx,
>> --
>> 2.1.4
>>
