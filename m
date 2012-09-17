From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 17 Sep 2012 06:25:11 +0000
Subject: Re: [PATCH] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <CAK9yfHwNResR9b_7v_7rAHmwi2q2Z_Zgas9JTvT=K_OoocWA8A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Thierry,

On 17 September 2012 11:34, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Wed, Sep 12, 2012 at 09:55:48AM +0900, Jingoo Han wrote:
>> On Tuesday, September 11, 2012 5:42 PM Sachin Kamat wrote
>> >
>> > This file already makes use of device managed functions.
>> > Convert pwm_get() too to use it.
>> >
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>
>> CC'ed Thierry Reding.
>>
>> Acked-by: Jingoo Han <jg1.han@samsung.com>
>
> Hi Sachin,
>
> As discussed elsewhere I'm taking over maintenance of the pwm-backlight
> driver as part of the PWM subsystem.

That is really nice :)

 I hadn't been Cc'ed on your first
> send and I'm not subscribed to linux-fbdev so I didn't receive a copy of
> the patch.

Yes. I obtained the list from get_maintainers.pl, so missed out CCing you.
I will re-send the patch with you in CC now.


>
> Thanks,
> Thierry



-- 
With warm regards,
Sachin
