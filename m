From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 11 Jul 2018 15:14:20 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
In-Reply-To: <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Hi,

On 11-07-18 17:07, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>
>> What if you make lockless_register_fb visible to fbcon, and then we can
>> have a macro:
> 
> There are more of these macro invocations under drivers/tty/vt, which
> also mess up the log during debugging.

Hmm, so this option is already broken (in a way) then, my first reaction
to your mail was that we should just remove that option. But that seemed
a bit harsh to me so I've been working on a fix for the last 10 minutes
or so.

But if it is already broken I'm tempted to just remove the option and
be done with it.  We really need less cruft in the fbdev/fbcon code not
more.

> WARN_CONSOLE_UNLOCKED is already protected by an '#ifdef 1 ... #else
> ...' construct [1]. I thought about turning this into a config option.

Ah I noticed the #if but I did not notice that it was a "#if 1".

If you want to fix lockless_register_fb it really should be replaced
with a runtime check, not a Kconfig option. This would require having
some lockless variable in the console code itself, which then gets
set by the fbdev code during init based on its lockless_register_fb
setting.

But as said I think we should seriously consider just removing
lockless_register_fb.

Regards,

Hans






> 
> Best regards
> Thomas
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/console.h#n203
> 
>>
>> #define WARN_FB_CONSOLE_UNLOCKED() 			\
>> 	do {						\
>> 		if (unlikely(!lockless_register_fb))	\
>> 			WARN_CONSOLE_UNLOCKED();	\
>> 	} while (0)
>>
>> And use that instead?
>>
>> -- Steve
>>
>>
>>> Best regards
>>> Thomas
>>>
>>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v3:
>>>> -New patch in v3 of this patchset
>>>>
>>>> Changes in v4:
>>>> -Keep the comments about which fbcon functions need locks in place
>>>> ---
>>>>   drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>>> index c910e74d46ff..cd8d52a967aa 100644
>>>> --- a/drivers/video/fbdev/core/fbcon.c
>>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
>>>>   	struct fb_info *oldinfo = NULL;
>>>>    	int found, err = 0;
>>>>   
>>>> +	WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>   	if (oldidx = newidx)
>>>>   		return 0;
>>>>   
>>>> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>>   {
>>>>   	int i, new_idx = -1, ret = 0;
>>>>   
>>>> +	WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>   	if (!fbcon_has_console_bind)
>>>>   		return 0;
>>>>   
>>>> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>>>   {
>>>>   	int i, idx;
>>>>   
>>>> +	WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>   	idx = info->node;
>>>>   	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>>   		if (con2fb_map[i] = idx)
>>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>>>   static void fbcon_remap_all(int idx)
>>>>   {
>>>>   	int i;
>>>> +
>>>> +	WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>   	for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>>   		set_con2fb_map(i, idx, 0);
>>>>   
>>>> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *info)
>>>>   {
>>>>   	int ret = 0, i, idx;
>>>>   
>>>> +	WARN_CONSOLE_UNLOCKED();
>>>> +
>>>>   	idx = info->node;
>>>>   	fbcon_select_primary(info);
>>>>     
>>>
>>
> 
