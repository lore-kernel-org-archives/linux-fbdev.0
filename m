From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 20 Dec 2013 14:46:20 +0000
Subject: Re: [PATCH v4] x86: sysfb: remove sysfb when probing real hw
Message-Id: <CANq1E4QsSje7ZD01EucKt_dGo5UuMyWNeB1Xnnx+p2bMRCNn-A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387448038-8260-1-git-send-email-dh.herrmann@gmail.com>
	<1387473881-26179-1-git-send-email-dh.herrmann@gmail.com>
	<20131219183310.GF32508@gmail.com>
In-Reply-To: <20131219183310.GF32508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, stable <stable@vger.kernel.org>

Hi

On Thu, Dec 19, 2013 at 7:33 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * David Herrmann <dh.herrmann@gmail.com> wrote:
>
>> +/*
>> + * Unregister the sysfb and prevent new sysfbs from getting registered. Can be
>> + * called from any context except recursively or from sysfb_register().
>> + * Used by remove_conflicting_framebuffers() and friends.
>> + */
>> +void sysfb_unregister(const struct apertures_struct *apert, bool primary)
>> +{
>> +     mutex_lock(&sysfb_lock);
>> +     if (!IS_ERR(sysfb_dev) && sysfb_dev) {
>> +             if (sysfb_match(apert, primary)) {
>> +                     platform_device_unregister(sysfb_dev);
>> +                     sysfb_dev = ERR_PTR(-EALREADY);
>> +             }
>> +     } else {
>> +             /* if !sysfb_dev, set err so no new sysfb is probed later */
>> +             sysfb_dev = ERR_PTR(-EALREADY);
>
> Just a small detail: we can get into this 'else' branch not just with
> NULL, but also with IS_ERR(sysfb_dev). In that case we override
> whatever error code is contained in sysfb_dev and overwrite it with
> ERR_PTR(-EALREADY).
>
> (Probably not a big deal, because we don't actually ever seem to
> extract the error code from the pointer, but wanted to mention it.)

Yepp, I know, but that's just fine.

>> +#ifdef CONFIG_X86_SYSFB
>> +#include <asm/sysfb.h>
>> +#endif
>
> Pet peeve, this looks sexier:
>
> #ifdef CONFIG_X86_SYSFB
> # include <asm/sysfb.h>
> #endif
>
>> @@ -1604,6 +1607,17 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>>       }
>>  }
>>
>> +static void remove_conflicting_sysfb(const struct apertures_struct *apert,
>> +                                  bool primary)
>> +{
>> +     if (!apert)
>> +             return;
>> +
>> +#ifdef CONFIG_X86_SYSFB
>> +     sysfb_unregister(apert, primary);
>> +#endif
>> +}
>
> So why not make sysfb_unregister() accept a !apert parameter (it would
> simply return), at which point remove_conflicting_sysfb() could be
> eliminated and just be replaced with a direct sysfb_unregister() call
> - with no #ifdefs.
>
> We only need #ifdefs for the sysfb_unregister() declaration in the .h
> file.

I can do that but we still need the #ifdef. sysfb is an x86-asm header
so it's not available on other archs. Even with #ifdef in the header I
still need it around the actual function call.

Thanks
David

> At first sight this looks simpler and cleaner for the fix itself - no
> need for extra cleanups for this detail.
>
> Thanks,
>
>         Ingo
