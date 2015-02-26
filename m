From: hl <hl@rock-chips.com>
Date: Thu, 26 Feb 2015 08:06:17 +0000
Subject: Re: [PATCH 2/2] backlight: pwm: Add backlight-boot-off property
Message-Id: <54EED3F9.7030009@rock-chips.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424920366-7626-1-git-send-email-hl@rock-chips.com>	<1424921954-8621-1-git-send-email-hl@rock-chips.com> <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
In-Reply-To: <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ajay kumar <ajaynumb@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-rockchip@lists.infradead.org


On 2015年02月26日 13:47, Ajay kumar wrote:
> Hi Huang,
>
> On Thu, Feb 26, 2015 at 9:09 AM, huang lin <hl@rock-chips.com> wrote:
>> Add backlight-boot-off property, so we can keeping the
>> backlight disabled at boot until it is enabled implicitly
>> by a panel driver, or explicitly by userspace
>>
>> Signed-off-by: huang lin <hl@rock-chips.com>
>>
>> ---
>>
>>   drivers/video/backlight/pwm_bl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 3a145a6..dece351 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -319,6 +319,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>          }
>>
>>          bl->props.brightness = data->dft_brightness;
>> +
>> +       if (of_find_property(pdev->dev.of_node, "backlight-boot-off", NULL))
>> +               bl->props.power = FB_BLANK_POWERDOWN;
>> +
> You need to check this. Originally, Thierry proposed it.
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/84604
I have applied Thierry patch , and it can work. I think it should be 
merged, since i use three type of edp panels,
they have same issue: when the backlight probe, the panel will visual 
glitches.

>
>>          backlight_update_status(bl);
>>
>>          platform_set_drvdata(pdev, bl);
>> --
>> 1.9.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

-- 
黄林
福州瑞芯微电子有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区21号楼(350003)
Addr:No.21 Building, A District, No.89, software Boulevard Fuzhou, Fujian,PRC
Email:hl@rock-chips.com
Tel:+86-591-83991906/07
  
****************************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请
勿复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，
并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释
权，禁止任何未经授权许可的侵权行为。
  
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents
of this email and any attachments may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure, copying, distribution,
or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender
as soon as possible and destroy the material in its entirety in any format. Thank you.
********************************************************************************

