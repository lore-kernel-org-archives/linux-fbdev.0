From: kgunda@codeaurora.org
Date: Mon, 23 Jul 2018 06:28:19 +0000
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <038029fded9ee724097685a3f0e8bdf9@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
 <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
 <20180720212128.GA13883@amd>
In-Reply-To: <20180720212128.GA13883@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 2018-07-21 02:51, Pavel Machek wrote:
> Hi!
> 
>> >@@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
>> >  }
>> >  #define	WLED3	3
>> >+#define	WLED4	4
>> 
>> Are these macros always going to define 3 to be 3 and 4 to be 4. If so 
>> we
>> probably don't need them (and they should be removed from patch 5/8 
>> too).
>> 
>> There is a degree of nitpicking here however. The rest looks OK to me.
> 
> Really nitpicking, and I don't care much either way, but as natural
> numbering would be 0-based, I'd keep the defines.
> 									Pavel
Thanks Pavale/Daniel! I will remove the macros and use the number 3 and 
4 instead.
