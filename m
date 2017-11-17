From: kgunda@codeaurora.org
Date: Fri, 17 Nov 2017 06:48:05 +0000
Subject: Re: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <208c7332234581909f159ddb33ede32b@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
 <20171116165510.GP28761@minitux>
In-Reply-To: <20171116165510.GP28761@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2017-11-16 22:25, Bjorn Andersson wrote:
> On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:
> 
>> WLED driver provides the interface to the display driver to
>> adjust the brightness of the display backlight.
>> 
> 
> Hi Kiran,
> 
> This driver has a lot in common with the already upstream 
> pm8941-wled.c,
> because it's just a new revision of the same block.
> 
> Please extend the existing driver rather than providing a new one
> (and yes, renaming the file is okay).
> 
> Regards,
> Bjorn

Hi Bjorn,

Yes this driver design is similar to pm8941, however the WLED HW block 
has undergone quite a few changes in
analog and digital from PM8941 to PM8998. Few of them include splitting 
one module into wled-ctrl
and wled-sink peripherals, changes in the register offsets and the bit 
interpretation. Hence we
concluded that it was better to have a new driver to support this new 
gen WELD module and decouple
it from the pm8941. Also, going forward this driver will support AMOLED 
AVDD rail (not supported by pm8941)
touching a few more registers/configuration and newer PMICs. So spinning 
off a new driver would make it
cleaner and easier to extend further.

Thanks,
Kiran

> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
