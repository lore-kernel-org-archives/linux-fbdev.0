From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Fri, 12 Jun 2015 12:57:57 +0000
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for device defined in dt
Message-Id: <557AD755.5050409@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com> <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com> <20150612113114.GK19400@ulmo.nvidia.com>
In-Reply-To: <20150612113114.GK19400@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org

Hi Thierry,

On 12.06.2015 14:31, Thierry Reding wrote:
> On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
>> Platform PWM backlight data provided by board's device tree should be
>> complete enough to successfully request a pwm device using pwm_get() API.
>>
>> Based on initial implementation done by Dmitry Eremin-Solenikov.
>>
>> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jingoo Han <jg1.han@samsung.com>
>> Cc: Bryan Wu <cooloney@gmail.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> ---
>>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> This fell off my radar, but I think it's good. I used to have a local
> patch somewhere that solved the same problem by initializing the pwm_id
> field of platform_pwm_backlight_data to -1 in pwm_backlight_parse_dt(),
> but I like this variant better because it's more explicit and doesn't
> even attempt to request using the legacy API (which will inevitably fail
> in the DT case anyway).
> 
> Vladimir, do you think you'd have the time to rebase this patch on top
> of something recent and perhaps extend the commit message with some of
> the arguments that you brought forth in this thread? Specifically it'd
> be useful to mention that this enforces the DT binding and fixes a real
> bug where the legacy path would try to request a PWM that's not
> necessarily the right one.

sure, no problem, I'll find time to rebase on top of Lee's
backlight/for-backlight-next and resend the change this weekend.

Thank you for reviewing :)

--
With best wishes,
Vladimir
