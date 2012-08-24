From: Archit Taneja <a0393947@ti.com>
Date: Fri, 24 Aug 2012 09:29:59 +0000
Subject: Re: [PATCH 6/8] OMAPDSS: DSI: calculate dsi clock
Message-Id: <503746C7.6030702@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>  <1345729514-2441-7-git-send-email-tomi.valkeinen@ti.com>  <50371C47.30708@ti.com> <1345798540.2614.17.camel@deskari>
In-Reply-To: <1345798540.2614.17.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 24 August 2012 02:25 PM, Tomi Valkeinen wrote:
> On Fri, 2012-08-24 at 11:46 +0530, Archit Taneja wrote:
>> On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
>
>>> +	/* pck = TxByteClkHS * datalanes * 8 / bitsperpixel */
>>
>> This formula looks a bit simplified, we aren't considering the header
>> and footers of long packets that will add to the DDR clock. But I guess
>> not considering these would only give a higher pixel clock than needed,
>> which isn't that bad.
>
> Hmm. The TRM (omap4460) gives this formula in "10.3.4.5.12 How to
> Configure the DSI PLL in Video Mode". The headers/footers etc. are
> handled with adjusting the blanking periods so that DISPC and DSI Tline
> times match.
>
> But obviously they are not used for command mode transfers, so perhaps
> you have a point there. Then again, at least in theory, in command mode
> the DISPC pck should be configurable as high as possible because the
> stall mechanism should stop DISPC when DSI has had enough. And so the
> pck calculation is a bit unneeded for cmd mode, we could just configure
> pck to max.
>
> But if it's correct for video mode, and very close for cmd mode, I guess
> it should be fine?

Yes, it's fine, and we shouldn't try to have an unnecessarily high pixel 
clock in command mode anyway, that would reduce the amount of 
downscaling we could do.

Archit

