From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 20 Sep 2018 16:23:49 +0000
Subject: Re: Re: [PATCH] backlight: pwm_bl: Fix brightness levels for non-DT case.
Message-Id: <9cc21df6-67f2-e210-33b8-e0e14f052e7e@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180824155402.2822-1-enric.balletbo@collabora.com>
 <87h8ji98jp.fsf@belgarion.home>
In-Reply-To: <87h8ji98jp.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@collabora.com, lee.jones@linaro.org

On 25/08/18 01:04, Robert Jarzmik wrote:
> Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:
> 
>> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
>> linearly to human eye")' allows the possibility to compute a default
>> brightness table when there isn't the brightness-levels property in the
>> DT. Unfortunately the changes made broke the pwm backlight for the
>> non-DT boards.
>>
>> Usually, the non-DT boards don't pass the brightness levels via platform
>> data, instead, they set the max_brightness in their platform data and the
>> driver calculates the level without a table. The ofending patch assumed
>> that when there is no brightness levels table we should create one, but this
>> is clearly wrong for the non-DT case.
>>
>> After this patch the code handles the DT and the non-DT case taking in
>> consideration also if max_brightness is set or not. The default table is
>> only created when neither, brightness-levels and max_brightness, are
>> set.
>>
>> The patch also fixes another issue found by Robert. Before this patch
>> looks like a division by 0 was possible when state.period returned 0 by
>> pwm_get_state(). This is because pwm_get_state() was called before
>> pwm_apply_args() so state.period was not initialized. The patch moves
>> the pwm_apply_args() call before any call to pwm_get_state().
>>
>> Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
>> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

(and sorry for the delay)


Daniel.
