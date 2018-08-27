From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 27 Aug 2018 15:04:29 +0000
Subject: Re: [PATCH V5 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-Id: <20180827150429.GM3048@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
 <20180827100448.GF31905@amd>
In-Reply-To: <20180827100448.GF31905@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Kiran Gunda <kgunda@codeaurora.org>, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Mon 27 Aug 03:04 PDT 2018, Pavel Machek wrote:

> On Fri 2018-08-24 15:57:43, Kiran Gunda wrote:
> > Rename the PM8941* references as WLED3 to make the driver
> > generic and have WLED support for other PMICs. Also rename
> > "i_boost_limit" and "i_limit" variables to "boost_i_limit"
> > and "string_i_limit" respectively to resemble the corresponding
> > register names.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > -MODULE_DESCRIPTION("pm8941 wled driver");
> > +MODULE_DESCRIPTION("Qualcomm WLED driver");
> 
> "... supporting pm8941, xxx devices" ?
> 

I would suggest not doing this. There's quite a long list of different
PMICs containing some version of this hardware block.

Regards,
Bjorn
