From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Thu, 16 Nov 2017 16:55:10 +0000
Subject: Re: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <20171116165510.GP28761@minitux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:

> WLED driver provides the interface to the display driver to
> adjust the brightness of the display backlight.
> 

Hi Kiran,

This driver has a lot in common with the already upstream pm8941-wled.c,
because it's just a new revision of the same block.

Please extend the existing driver rather than providing a new one
(and yes, renaming the file is okay).

Regards,
Bjorn
