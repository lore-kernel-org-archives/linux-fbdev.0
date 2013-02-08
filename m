From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Fri, 08 Feb 2013 13:28:38 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5114FD86.2020400@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com>
In-Reply-To: <5114F7C9.4040803@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, "rob@ti.com" <rob@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

On 02/08/2013 02:04 PM, Tomi Valkeinen wrote:
> On 2013-02-08 14:40, Marcus Lorentzon wrote:
>
>> I agree, but I think it should be
>> setup->enable->video_on->video_off->disable->setup->...
>> I don't think there is any interface parameters that should be changed
>> while link is enabled. And if there are, they should be identified and
>> split out into a separate operation.
> Hmm. At least on OMAP and DSI video mode, it is possible to change at
> least timings on the fly. But yes, generally the link has to be disabled
> first before changing any parameters.

When we do that we stop->setup->start during blanking. So our "DSS" is 
optimized to be able to do that without getting blocked. All DSI video 
mode panels (and DPI) products we have done so far have not had any 
issue with that (as long as DSI HS clock is set to continuous). I think 
this approach is less platform dependant, as long as there is no SoC 
that take more than a blanking period to reconfigure.
>>> In OMAP you can configure the DSI pins quite freely. We have the
>>> following struct:
>>>
>>> struct omap_dsi_pin_config {
>>>      int num_pins;
>>>      /*
>>>       * pin numbers in the following order:
>>>       * clk+, clk-
>>>       * data1+, data1-
>>>       * data2+, data2-
>>>       * ...
>>>       */
>>>      int pins[OMAP_DSS_MAX_DSI_PINS];
>>> };
>>>
>> Do you reroute after boot? Or is this just "board/product setup". We
>> have some pinmuxing as well and DPhy sharing, but we have never used it
>> after init/boot. If not runtime, I think this could be put in DT config
>> for product instead of under dynamic control from panel.
> The pin config with the struct above is done later, when the panel
> driver configures the DSI bus. So in OMAP we have two distinct things
> that need to be configured:
>
> - The actual pin muxing, i.e. selecting the functions for pin N on the
> OMAP package. The functions for a single pin could be for example GPIO
> 70, DSI DX0, UART1_CTS, etc. This is normally done once during board init.
>
> - DSI pin configuration in the display subsystem. This is used to map
> the pins to DSI functions. I.e. DSI DX0 pin is mapped to DATA1+. This is
> done by the DSS driver, when the panel driver gives it the parameters.
>
> So the first muxing basically assigns the pin to DSI in general, and
> then DSI will internally route the pin to a an actual DSI function.
>
> Whether the muxing needs to changed during runtime... I'm not sure. On
> OMAP the DSI pin config also tells how many lanes are used. So if a DSI
> panel would first want to use only one lane, and later change it to n
> lanes, we'd need this kind of function.
>
> I think it conceptually fits better if the pin config data is passed to
> the panel via DT data, and the panel then gives the config to the DSI
> master. It's just a part of the DSI bus parameters, like, say, clock
> speed or whether to use HS or LP. That way the DT node for the panel
> contains the information about the panel. (versus having pin config data
> in the DSI master, in which case the DSI master's node contains data
> about a specific DSI panel).
>
I think it still is OMAP specifics and doesn't belong in the panel 
drivers any longer. If you revisit this requirement in the CDF context 
where DSI ifc parameters should describe how to interface with a panel 
outside the SoC, there can't really be any dependencies on SoC internal 
routing. As you say, this is inside pinmux, so how can that affect the 
SoC external interface? I would suggest moving this to dispc-dsilink DT 
settings that are activated on dsilink->enable/disable. At least that is 
how I plan to solve similar STE SoC specific DSI config settings that 
are not really CDF panel generic, like some DPhy trim settings. They do 
depend on the panel and clock speed, but they are more product specific 
than panel driver specific. Then if there are these type of settings 
that every SoC have, then we could look at standardize those. But for 
starters I would try to keep it in product/board-DT per DSI link. So we 
should try to differentiate between DSI host and slave bus params and 
keep slave params in panel driver.

/BR
/Marcus

