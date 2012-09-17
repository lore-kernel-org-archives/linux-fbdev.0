From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 17 Sep 2012 09:52:01 +0000
Subject: Re: [PATCH Re-send] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <CAK9yfHxLbL_SgmhhFGwqqgbt3hkSULR0nDtEb7WRs-7hLbKrJA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347862847-2774-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347862847-2774-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 17 September 2012 15:03, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Mon, Sep 17, 2012 at 11:50:47AM +0530, Sachin Kamat wrote:
>> This file already makes use of device managed functions.
>> Convert pwm_get() too to use it.
>
> I find this description a bit confusing. pwm_get() is not converted, but
> rather the driver is converted to use devm_pwm_get() instead of
> pwm_get().
>
> How about this:
>
>         pwm-backlight: Use devm_pwm_get() instead of pwm_get()
>
>         Managed versions of the pwm_get() and pwm_put() functions were recently
>         added to the PWM framework. They can be used to simplify cleanup in the
>         error paths and the device removal callback.
>
> If that's okay with you, I can just replace it before pushing so there's
> no need for you to resend.

Your description sounds good. Please go ahead with it.
Thanks

>
> Thierry



-- 
With warm regards,
Sachin
