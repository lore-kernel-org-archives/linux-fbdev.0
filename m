From: Archit Taneja <archit@ti.com>
Date: Fri, 13 Dec 2013 08:44:21 +0000
Subject: Re: [PATCH 05/26] ARM: OMAP2+: add omapdss_init_of()
Message-Id: <52AAC615.504@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-6-git-send-email-tomi.valkeinen@ti.com> <2199639.FbGhznOLP9@avalon> <52A96603.5030709@ti.com>
In-Reply-To: <52A96603.5030709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

On Thursday 12 December 2013 01:00 PM, Tomi Valkeinen wrote:
> On 2013-12-12 01:10, Laurent Pinchart wrote:
>> Hi Tomi,
>>
>> On Wednesday 04 December 2013 14:28:32 Tomi Valkeinen wrote:
>>> omapdss driver uses a omapdss platform device to pass platform specific
>>> function pointers and DSS hardware version from the arch code to the
>>> driver. This device is needed also when booting with DT.
>>>
>>> This patch adds omapdss_init_of() function, called from board-generic at
>>> init time, which creates the omapdss device.
>>
>> Is this a temporary solution that you plan to later replace with DT-only
>> device instantiation ?
>
> It's a long term task to remove the "virtual" omapdss device. Removing
> the platform data that we pass has been very difficult.

Even if we remove the platform data, what would be the right place to 
register the drm, fb and vout devices? We need to make sure their 
drivers are probed only after omapdss is initialised.

>
> For example, we need to get the OMAP revision to know which OMAP DSS
> hardware we have. We can't get that information from the DSS hardware
> (thank you, HW designers! ;).
>

> Another is DSI pin muxing. I think we need a new pinmuxing driver for
> that, or maybe change pinmux-single quite a bit. The DSI pinmuxing is
> very simple, but the register fields are varying lengths and at varying
> positions, so pinmux-single doesn't work for it.

I have seen other OMAP drivers passing control module register info to 
their DT node. Instead of having a pinmux driver for a single register, 
we might want to consider just passing the control module register, and 
take care of the reg fields and masks in the OMAP DSI driver itself.

The parsing of the DSI pins from DT, however, can be kept generic.

Archit

