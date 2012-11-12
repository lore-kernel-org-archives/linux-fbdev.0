From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Nov 2012 13:08:44 +0000
Subject: Re: [PATCH 0/2] Adding devm_ functions and DT support to MIPI driver
Message-Id: <50A0F4DC.2020002@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352547285-12302-1-git-send-email-shaik.ameer@samsung.com>
In-Reply-To: <1352547285-12302-1-git-send-email-shaik.ameer@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 11/12/2012 01:35 PM, Tomi Valkeinen wrote:
>> Shaik Ameer Basha (2):
>>   exynos-mipi-dsi: using devm_ functions for automatic cleanup
>>   video: exynos-mipi-dsi: Adding DT support to exynos mipi driver
> 
> MIPI is an organization. DSI is a protocol from MIPI. MIPI has many
> protocols. Thus it doesn't make sense to say "MIPI driver", "MIPI
> display", or use names like "samsung,exynos-mipi".

True.

> It's either "MIPI DSI" if you want to be exact, or just "DSI", which I
> think is clear from the context.
> 
> What is "dsim"?

In the Samsung SoCs documentation MIPI DSIM stands for MIPI DSI Master
and similarly MIPI CSIS stands for MIPI CSI Slave.

-- 

Regards,
Sylwester
