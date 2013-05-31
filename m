From: Richard Genoud <richard.genoud@gmail.com>
Date: Fri, 31 May 2013 15:41:07 +0000
Subject: Re: [PATCH 2/2] atmel_lcdfb: blank the backlight on remove
Message-Id: <CACQ1gAh5HL8ouhe3YeGe4B9AO+L02C+wF5a2pUvka01PbupCDg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370010519-18691-1-git-send-email-richard.genoud@gmail.com>
 <1370010519-18691-2-git-send-email-richard.genoud@gmail.com> <20130531151926.GR19468@game.jcrosoft.org>
In-Reply-To: <20130531151926.GR19468@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

2013/5/31 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> On 16:28 Fri 31 May     , Richard Genoud wrote:
>> When removing atmel_lcdfb module, the backlight is unregistered but not
>> blanked. (only for CONFIG_BACKLIGHT_ATMEL_LCDC case).
>> This can result in the screen going full white depending on how the PWM
>> is wired.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  drivers/video/atmel_lcdfb.c |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
>> index 6e6491f..e00318f 100644
>> --- a/drivers/video/atmel_lcdfb.c
>> +++ b/drivers/video/atmel_lcdfb.c
>> @@ -223,8 +223,13 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
>>
>>  static void exit_backlight(struct atmel_lcdfb_info *sinfo)
>>  {
>> -     if (sinfo->backlight)
>> +     if (sinfo->backlight) {
> if (!sinfo->backlight)
>         return;
>
Well, I usually prefer to have a single exit point (when it doesn't
make the code go beyond the 80chars limit).

but if you prefer something like:

if (!sinfo->backlight)
	return;

if (sinfo->backlight->ops) {
	sinfo->backlight->props.power = FB_BLANK_POWERDOWN;
	sinfo->backlight->ops->update_status(sinfo->backlight);
}
backlight_device_unregister(sinfo->backlight);

I'll send the modified patch.

>         other look ok
>
> if you want ot hte next RC you have 3h to send a v2 before I work off for few
> days

ok, bonnes vacances !

>
> Best Regards,
> J.
