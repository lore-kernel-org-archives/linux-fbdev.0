From: Archit Taneja <a0393947@ti.com>
Date: Wed, 23 Nov 2011 12:25:45 +0000
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd mode
Message-Id: <4ECCE379.9000506@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>	 <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>	 <4ECCC68C.7070106@ti.com> <1322044977.28917.57.camel@deskari>	 <4ECCD44A.2070008@ti.com> <1322047652.28917.64.camel@deskari>
In-Reply-To: <1322047652.28917.64.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Wednesday 23 November 2011 04:57 PM, Tomi Valkeinen wrote:
> On Wed, 2011-11-23 at 16:38 +0530, Archit Taneja wrote:
>>
>> I think it would be best to stuff the 'video mode enabling and
>> manager
>> enabling' functionality in omapdss_dsi_display_enable() itself, the
>> panel driver shouldn't need to call a function separately to enable
>> video mode for the panel. This way we would be more along the lines
>> of
>> the dpi driver, where dpi_display_enable() enables the manager in the
>> end.
>
> But we need to configure the panel between enabling the DSI interface
> and enabling the video output, so we can't combine those two functions.

Oh okay, that's right, we can't start video mode before preparing the panel.

Archit

>
> For DPI things are simpler, as enabling the interface and the video
> output are more or less the same thing.
>
>   Tomi
>

