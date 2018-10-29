From: Prarit Bhargava <prarit@redhat.com>
Date: Mon, 29 Oct 2018 15:30:42 +0000
Subject: Re: [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <3173d2d2-0720-df50-8084-6e67d445a93b@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181029130232.31661-1-prarit@redhat.com>
 <20181029152419.GB30162@ulmo>
In-Reply-To: <20181029152419.GB30162@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <treding@nvidia.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Steven Rostedt <rostedt@goodmis.org>



On 10/29/2018 11:24 AM, Thierry Reding wrote:
> On Mon, Oct 29, 2018 at 09:02:32AM -0400, Prarit Bhargava wrote:
>> A variant of this patch has been in Fedora since at least 2010 and
>> AFAWCT there haven't been any complaints about the change in behavior.
>>
>> https://src.fedoraproject.org/cgit/rpms/kernel.git/tree/silence-fbcon-logo.patch
>>
>> P.
>>
>> ---8<---
>>
>> On text-based systems the 'quiet' boot option will show printk levels
>> higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
>> during boot can cause some consoles to lose display data and as a result
>> confuse the end user.
>>
>> Do not display the Tux logo on systems that are in 'quiet' boot.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Marko Myllynen <myllynen@redhat.com>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Cc: Yisheng Xie <ysxie@foxmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> ---
>>  drivers/video/fbdev/core/fbcon.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 75ebbbf0a1fb..a2f2c7ea11ef 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -650,11 +650,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>>  		kfree(save);
>>  	}
>>  
>> +	if (logo_shown = FBCON_LOGO_DONTSHOW) {
>> +		return;
>> +
> 
> You're missing a closing } here (well, you really shouldn't have the
> opening { in the first place since this is a single line block.
> 
> That's what's causing the warnings from the 0-day builder.

Will send v2.

P.

> 
> Thierry
> 
