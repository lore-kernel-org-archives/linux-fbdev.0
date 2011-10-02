From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 02 Oct 2011 00:18:03 +0000
Subject: Re: [PATCH v2 2/2] fb: add events for early fb event support.
Message-Id: <4E87ADBB.9080509@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317047842-12220-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1317047842-12220-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/27/2011 04:48 AM, Inki Dae wrote:
> 
>> -----Original Message-----
>> From: Inki Dae [mailto:inki.dae@samsung.com]
>> Sent: Monday, September 26, 2011 11:37 PM
>> To: FlorianSchandinat@gmx.de; linux-fbdev@vger.kernel.org
>> Cc: kyungmin.park@samsung.com; lars@metafoo.de; Inki Dae
>> Subject: [PATCH v2 2/2] fb: add events for early fb event support.
>>
>> this patch adds FB_EARLY_EVENT_BLANK and FB_R_EARLY_EVENT_BLANK
>> event mode supports. first, fb_notifier_call_chain() is called with
>> FB_EARLY_EVENT_BLANK and fb_blank() of specific fb driver is called
>> and then fb_notifier_call_chain() is called with FB_EVENT_BLANK again
>> at fb_blank(). and if fb_blank() was failed then fb_nitifier_call_chain()
>> would be called with FB_R_EARLY_EVENT_BLANK to revert the previous
> effects.

Is my assumption correct that the framebuffer driver is independent of the
specific LCD driver and therefore they can be used independently (at least in
theory)? If the answer is yes and there is no direct dependance this looks like
the right solution. I could take this patch (or rather the fixed up version when
you send it) but I'm unsure how to progress with the LCD part, would be nice to
get Richard's Ack on it.


Best regards,

Florian Tobias Schandinat

>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/video/fbmem.c |   21 +++++++++++++++------
>>  include/linux/fb.h    |    4 ++++
>>  2 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index ad93629..a2bd17b 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -1032,20 +1032,29 @@ fb_set_var(struct fb_info *info, struct
>> fb_var_screeninfo *var)
>>  int
>>  fb_blank(struct fb_info *info, int blank)
>>  {
>> - 	int ret = -EINVAL;
>> +	struct fb_event event;
>> +	int ret = -EINVAL, early_ret;
>>
>>   	if (blank > FB_BLANK_POWERDOWN)
>>   		blank = FB_BLANK_POWERDOWN;
>>
>> +	event.info = info;
>> +	event.data = &blank;
>> +
>> +	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
>> +
>>  	if (info->fbops->fb_blank)
>>   		ret = info->fbops->fb_blank(blank, info);
>>
>> - 	if (!ret) {
>> -		struct fb_event event;
>> -
>> -		event.info = info;
>> -		event.data = &blank;
>> +	if (!ret)
>>  		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
>> +	else {
>> +		/*
>> +		 * if fb_blank is failed then revert effects of
>> +		 * the early blank event.
>> +		 */
>> +		if (early_ret < 0)
> 
> Ah, this is condition wrong so I will fix it to "if (!early_ret)".
> 
>> +			fb_notifier_call_chain(FB_R_EARLY_EVENT_BLANK,
> &event);
>>  	}
>>
>>   	return ret;
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 1d6836c..29f53d5 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -549,6 +549,10 @@ struct fb_cursor_user {
>>  #define FB_EVENT_FB_UNBIND              0x0E
>>  /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga
>> switcheroo */
>>  #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
>> +/*      A hardware display blank early change occured */
>> +#define FB_EARLY_EVENT_BLANK		0x10
>> +/*      A hardware display blank revert early change occured */
>> +#define FB_R_EARLY_EVENT_BLANK		0x11
>>
>>  struct fb_event {
>>  	struct fb_info *info;
>> --
>> 1.7.4.1
> 
