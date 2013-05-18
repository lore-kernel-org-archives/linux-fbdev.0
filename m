From: Andy Chernyak <andy.chernyak@gmail.com>
Date: Sat, 18 May 2013 13:41:45 +0000
Subject: Re: [PATCH 4/4] fb: vt8500: Add VGA output support to wm8505fb driver.
Message-Id: <51978519.7090907@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368868514-18975-1-git-send-email-linux@prisktech.co.nz>
 <1368868514-18975-5-git-send-email-linux@prisktech.co.nz>
 <CABjd4Yxrk3hXnB5f6u+1HcJjymDZbtQ1F1HXkZ2dzF3dwCrWhg@mail.gmail.com>
In-Reply-To: <CABjd4Yxrk3hXnB5f6u+1HcJjymDZbtQ1F1HXkZ2dzF3dwCrWhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/18/2013 03:28 PM, Alexey Charkov wrote:
> 2013/5/18 Tony Prisk <linux@prisktech.co.nz>:
>
>>         /* Virtual buffer size */
>> @@ -167,7 +176,12 @@ static int wm8505fb_init_hw(struct fb_info *info)
>>
>>         /* black magic ;) */
>>         writel(0xf,                    fbi->regbase + REG_GOVRH_FHI);
>> -       writel(4,                      fbi->regbase + REG_GOVRH_DVO_SET);
>> +
>> +       if (fbi->interface = INTERFACE_VGA)
>> +               writel(0xe, fbi->regbase + REG_GOVRH_DVO_SET);
>> +       else
>> +               writel(4, fbi->regbase + REG_GOVRH_DVO_SET);
> I don't remember if HDMI is yet another option for this register or
> not... If it is, it would probably warrant defining fbi->interface as
> an enum and changing this if-else into a switch statement to let the
> compiler add its checks/warnings.
HDMI output can work simultaneously with LCD (on 8850 at least), which
fbi->interface in its current form would not allow to express.

> +       if (fbi->interface = INTERFACE_VGA)
> +               writel(h_sync,  fbi->regbase + REG_GOVRH_VGA_HSYNW);
> Will it misbehave on LCD if you write to the VGA register unconditionally?
>
Can we have 3 flags, something like LCD_ON, VGA_ON, HDMI_ON instead of
enum for video interface selection?

Regards,
Andy.
