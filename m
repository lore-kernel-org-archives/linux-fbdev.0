From: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 02 Apr 2019 17:45:44 +0000
Subject: Re: [PATCH v5 2/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <87mul8pagn.fsf@igel.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190129134350.24049-1-prarit@redhat.com>
 <20190129134350.24049-3-prarit@redhat.com> <87ftr1ed4h.fsf@igel.home>
 <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com>
In-Reply-To: <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com> (Prarit
 Bhargava's message of "Tue, 2 Apr 2019 07:31:49 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On Apr 02 2019, Prarit Bhargava <prarit@redhat.com> wrote:

> On 4/1/19 3:31 PM, Andreas Schwab wrote:
>> On Jan 29 2019, Prarit Bhargava <prarit@redhat.com> wrote:
>> 
>>> @@ -1066,6 +1069,9 @@ static void fbcon_init(struct vc_data *vc, int init)
>>>  
>>>  	cap = info->flags;
>>>  
>>> +	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
>>> +		logo_shown = FBCON_LOGO_DONTSHOW;
>>> +
>>>  	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
>>>  	    (info->fix.type = FB_TYPE_TEXT))
>>>  		logo = 0;
>> 
>> This causes the scroll region to no longer be reset when the logo is
>> removed.
>> 
>
> Andreas, my apologies but I'm not sure what you mean.  Could you elaborate on
> the broken and expected behaviour?

If fbcon_init is called after the loglevel is reduced to
CONSOLE_LOGLEVEL_QUIET, the logo is not drawn, but the scrolling region
remains.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
