From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 17 Jan 2014 11:13:19 +0000
Subject: Re: [PATCH 2/2] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <CAK9yfHwJUWj8ebVdsum3i3nvY51tEV-U33dSuYUnSq0nY3so8Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 17 January 2014 15:52, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2014-01-17 06:32, Sachin Kamat wrote:
>> Enable S6E8AX0 LCD driver only if LCD_CLASS_DEVICE is a built-in driver.
>> Else we get the following errors due to missing symbols:
>> drivers/built-in.o: In function `s6e8ax0_probe':
>> :(.text+0x51aec): undefined reference to `lcd_device_register'
>> :(.text+0x51c44): undefined reference to `lcd_device_unregister'
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/video/exynos/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
>> index 976594d578a9..7e19b467b8f7 100644
>> --- a/drivers/video/exynos/Kconfig
>> +++ b/drivers/video/exynos/Kconfig
>> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
>>
>>  config EXYNOS_LCD_S6E8AX0
>>       bool "S6E8AX0 MIPI AMOLED LCD Driver"
>> -     depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD_CLASS_DEVICE)
>> +     depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
>> +     depends on (LCD_CLASS_DEVICE != m)
>
> Hmm, doesn't that say that LCD_CLASS_DEVICE can be y or n (i.e. != m),
> so it could be disabled also?

Yes you are right. Not sure how I got it right while testing. Thanks
for catching.
It should just be (LCD_CLASS_DEVICE = y).
Will resend.



-- 
With warm regards,
Sachin
