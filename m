From: Archit Taneja <a0393947@ti.com>
Date: Thu, 16 Aug 2012 11:58:42 +0000
Subject: Re: [PATCH 3/6] OMAPDSS: DSI: Maintain copy of video mode timings in driver data
Message-Id: <502CE016.6060404@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <343817088-29645-1-git-send-email-archit@ti.com>  <1345102594-6222-1-git-send-email-archit@ti.com>  <1345102594-6222-4-git-send-email-archit@ti.com> <1345116666.15132.4.camel@lappyti>
In-Reply-To: <1345116666.15132.4.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 16 August 2012 05:01 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
>> The DSI driver currently relies on the omap_dss_device struct to receive the
>> video mode timings requested by the panel driver. This makes the DSI interface
>> driver dependent on the omap_dss_device struct.
>>
>> Make the DSI driver data maintain it's own video mode timings field. The panel
>> driver is expected to call omapdss_dsi_set_videomode_timings() to configure the
>> video mode timings before the interface is enabled. The function takes in a
>> void pointer rather than a pointer to omap_dss_dsi_videomode_timings struct.
>> This is because this function will finally be an output op shared across
>> different outputs to set custom or private timings.
>
> I don't think the function should take a void * in any case. If we want
> to share the function, it should take a struct that perhaps contains an
> union of rfbi and dsi timings.
>
> But I'm not sure if there's any benefit for that...
>
> So do you see us having just one set_timings, which would take either
> the normal video timings, rfbi timings or dsi timings?

I thought of having 2 timing ops, one is a standard "modeline like" 
set_timings(), and the other a vague-ish set_custom_timings(). For 
us(OMAP), we need to use it for DSI videomode and RFBI, we may reduce 
that to only RFBI later if we calculate for DSI timings automatically.

For these extra timings to be consistent across SoCs, we would need to 
align to get a common struct of some sort, which could then have unions 
as you said. For now, I thought having a void pointer might suffice.

Archit

