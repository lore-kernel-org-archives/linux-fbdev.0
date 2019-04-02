From: Prarit Bhargava <prarit@redhat.com>
Date: Tue, 02 Apr 2019 11:31:49 +0000
Subject: Re: [PATCH v5 2/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190129134350.24049-1-prarit@redhat.com>
 <20190129134350.24049-3-prarit@redhat.com> <87ftr1ed4h.fsf@igel.home>
In-Reply-To: <87ftr1ed4h.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Marko Myllynen <myllynen@redhat.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>



On 4/1/19 3:31 PM, Andreas Schwab wrote:
> On Jan 29 2019, Prarit Bhargava <prarit@redhat.com> wrote:
> 
>> @@ -1066,6 +1069,9 @@ static void fbcon_init(struct vc_data *vc, int init)
>>  
>>  	cap = info->flags;
>>  
>> +	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
>> +		logo_shown = FBCON_LOGO_DONTSHOW;
>> +
>>  	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
>>  	    (info->fix.type = FB_TYPE_TEXT))
>>  		logo = 0;
> 
> This causes the scroll region to no longer be reset when the logo is
> removed.
> 

Andreas, my apologies but I'm not sure what you mean.  Could you elaborate on
the broken and expected behaviour?

I'm absolutely not disputing that there's a bug.

Thanks,

P.

> Andreas.
> 
