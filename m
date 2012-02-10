From: Archit Taneja <a0393947@ti.com>
Date: Fri, 10 Feb 2012 06:17:46 +0000
Subject: Re: [PATCH] OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
Message-Id: <4F34B3BA.5030609@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328769888-24790-1-git-send-email-archit@ti.com> <1328788924.1909.67.camel@deskari>
In-Reply-To: <1328788924.1909.67.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org

On Thursday 09 February 2012 05:32 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Thu, 2012-02-09 at 12:14 +0530, Archit Taneja wrote:
>> For DSS clock domain to transition from idle to active state, it's necessary
>> to enable the optional clock DSS_FCLK before we enable the module using the
>> MODULEMODE bits in the DSS clock domain's CM_DSS_DSS_CLKCTRL register.
>>
>> This sequence was not followed correctly for the 'dss_hdmi' hwmod and it led
>> to DSS clock domain not getting out of idle when pm_runtime_get_sync() was
>> called for hdmi's platform device.
>>
>> Since the clock domain failed to change it's state to active, the hwmod code
>> disables any clocks it had enabled before for this hwmod. This led to the clock
>> 'dss_48mhz_clk' getting disabled.
>>
>> When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
>> correctly enables the DSS clock domain this time. But the clock 'dss_48mhz_clk'
>> disabled before is needed for HDMI's PHY to function. Hence, the driver fails
>
> There's something wrong with the "But the clock..." sentence above.
>
> The patch looks good, but I think it'd be better to add brief HACK
> comments in the code also. Otherwise it's too easy to forget about this.

I'll make the changes and repost.

Archit

>
>   Tomi
>

