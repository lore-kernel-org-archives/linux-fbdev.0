From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Fri, 08 Feb 2013 14:54:43 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <511511B3.3060404@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com> <5114FD86.2020400@stericsson.com> <5115055B.2080509@ti.com>
In-Reply-To: <5115055B.2080509@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, "rob@ti.com" <rob@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

On 02/08/2013 03:02 PM, Tomi Valkeinen wrote:
> On 2013-02-08 15:28, Marcus Lorentzon wrote:
>
>> When we do that we stop->setup->start during blanking. So our "DSS" is
>> optimized to be able to do that without getting blocked. All DSI video
>> mode panels (and DPI) products we have done so far have not had any
>> issue with that (as long as DSI HS clock is set to continuous). I think
>> this approach is less platform dependant, as long as there is no SoC
>> that take more than a blanking period to reconfigure.
> So do you stop, setup and start the link with CPU, and this has to be
> happen during blanking? Isn't that prone to errors? Or did you mean that
> the hardware handles that automatically?
>
> In OMAP DSS there are so called shadow registers, that can be programmed
> at any time. The you set a bit (GO bit), which tells the hardware to
> take the new settings into use at the next vblank.
>
>  From DSI driver's perspective the link is never stopped when
> reconfiguring the video timings. However, many other settings have to be
> configured when the link is disabled.

Yeah, you lucky guys with the GO bit ;). No, we actually do CPU 
stop,setup,start. But since it is video mode, master is driving the sync 
so it is not a hard deadline. It is enough to restart before pixels 
start to degrade. On an LCD that is not so much time, but on an OLED it 
could be 10 secs :). Anyway, we have had several mass products with this 
soft solution and it has worked well.
>>>>> In OMAP you can configure the DSI pins quite freely. We have the
>>>>> following struct:
>>>>>
>>>>> struct omap_dsi_pin_config {
>>>>>       int num_pins;
>>>>>       /*
>>>>>        * pin numbers in the following order:
>>>>>        * clk+, clk-
>>>>>        * data1+, data1-
>>>>>        * data2+, data2-
>>>>>        * ...
>>>>>        */
>>>>>       int pins[OMAP_DSS_MAX_DSI_PINS];
>>>>> };
>>>>>
>> I think it still is OMAP specifics and doesn't belong in the panel
>> drivers any longer. If you revisit this requirement in the CDF context
>> where DSI ifc parameters should describe how to interface with a panel
>> outside the SoC, there can't really be any dependencies on SoC internal
>> routing. As you say, this is inside pinmux, so how can that affect the
>> SoC external interface? I would suggest moving this to dispc-dsilink DT
>> settings that are activated on dsilink->enable/disable. At least that is
>> how I plan to solve similar STE SoC specific DSI config settings that
>> are not really CDF panel generic, like some DPhy trim settings. They do
>> depend on the panel and clock speed, but they are more product specific
>> than panel driver specific. Then if there are these type of settings
>> that every SoC have, then we could look at standardize those. But for
>> starters I would try to keep it in product/board-DT per DSI link. So we
>> should try to differentiate between DSI host and slave bus params and
>> keep slave params in panel driver.
> Ok, I think I was being a bit vague here. I explained the OMAP DSI
> routing not because I meant that this API is specific to that, but
> because it explains why this kind of routing info is needed, and a
> bitmask is not enough.
>
> If you look at the omap_dsi_pin_config struct, there's nothing OMAP
> specific there (except the names =). All it tells is that this device
> uses N DSI pins, and the device's clk+ function should be connected to
> pin X on the DSI master, clk- should be connected to pin Y, etc. X and Y
> are integers, and what they mean is specific to the DSI master.
>
> When the DSI master is OMAP's DSI, the OMAP DSI driver does the pin
> configuration as I explained. When the DSI master is something else,
> say, a DSI bridge, it does whatever it needs to do (which could be
> nothing) to assign a particular DSI function to a pin.
>
I understand, but removing the omap prefix doesn't mean it has to go in 
the panel slave port/bus settings. I still can't see why this should be 
configuration on the panel driver and not the DSI master driver. Number 
of pins might be useful since you might start with one lane and then 
activate the rest. But partial muxing (pre pinmux) doesn't seem to be 
something the panel should control or know anything about. Sounds like 
normal platform/DT data per product/board.

/BR
/Marcus

