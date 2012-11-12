From: Shaik Ameer Basha <shaik.samsung@gmail.com>
Date: Mon, 12 Nov 2012 18:23:19 +0000
Subject: Re: [PATCH 0/2] Adding devm_ functions and DT support to MIPI driver
Message-Id: <CAOD6ATpaGEdu_JKt660E3cVX6JFmErBEzBAXbEPNwy+tcg56Aw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352547285-12302-1-git-send-email-shaik.ameer@samsung.com>
In-Reply-To: <1352547285-12302-1-git-send-email-shaik.ameer@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On Mon, Nov 12, 2012 at 6:05 PM, Tomi Valkeinen <tomba@iki.fi> wrote:
> Hi,
>
> On 2012-11-10 13:34, Shaik Ameer Basha wrote:
>> In this patch series,
>>
>> First patch adds the devm_ functions to the driver code for automatic
>> code cleanup.
>>
>> Second patch adds the DT support for the exynos mipi-dsi driver.
>> for DT support, mipi device node should supply the following
>> information to the mipi-dsi driver.
>> 1] dsim_config information
>> 2] d-phy setting information
>> 3] lcd poweron, reset information
>> 4] fb_videomode information
>>
>> refer the documentation files for further details.
>>
>> Shaik Ameer Basha (2):
>>   exynos-mipi-dsi: using devm_ functions for automatic cleanup
>>   video: exynos-mipi-dsi: Adding DT support to exynos mipi driver
>
> MIPI is an organization. DSI is a protocol from MIPI. MIPI has many
> protocols. Thus it doesn't make sense to say "MIPI driver", "MIPI
> display", or use names like "samsung,exynos-mipi".
>
> It's either "MIPI DSI" if you want to be exact, or just "DSI", which I
> think is clear from the context.

Thanks for pointing this out, It's a fault from my side.
I will be specific/careful from next time on-wards...

>
> What is "dsim"?
>

As Sylwester mentioned, mipi-dsim stands for MIPI DSI Master.

>  Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
