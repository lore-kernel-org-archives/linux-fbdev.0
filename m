From: Archit Taneja <a0393947@ti.com>
Date: Tue, 14 Aug 2012 13:27:14 +0000
Subject: Re: [PATCH v2 07/13] OMAPDSS: HDMI: Add a get_timing function for HDMI interface
Message-Id: <502A4F62.5050400@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>  <1344512989-4071-1-git-send-email-archit@ti.com>  <1344512989-4071-8-git-send-email-archit@ti.com> <1344949348.4845.46.camel@lappyti>
In-Reply-To: <1344949348.4845.46.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Tuesday 14 August 2012 06:32 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
>> Add function omapdss_hdmi_display_get_timing() which returns the timings
>> maintained by the HDMI interface driver in it's hdmi_config field. This
>> prevents the need for the panel driver to configure default timings in it's
>> probe.
>>
>> This function is just intended to be used once during the panel driver's probe.
>> It makes sense for those interfaces which can be configured to a default timing.
>
> I'm not sure about this patch. So I think the basic idea here is that
> HDMI will use VGA video mode if, for whatever reason, no better mode is
> found out.
>
> After this change, the panel driver doesn't seem to do that. Instead it
> uses whatever mode was used previously by the hdmi output driver.
>
> Is the only reason for this patch to clean up the hdmi_panel driver? We
> could have a dss helper function which returns the timings for VGA
> (well, just a public const variable would be enough), and the panel
> driver could use that to initialize the timings struct.

Yes, that's the only reason, basically, to sync the panel with the 
timings to which the hdmi output driver configured itself during it's 
probe. We don't use hdmi_get_timing anywhere apart from here.

I thought it would be clean to retrieve the timings by taking whatever 
is stored in the hdmi output driver, but we could leave it to a 
hardcoded VGA as before.

I have done the same for venc, let me know if you think these should be 
removed.

Archit
