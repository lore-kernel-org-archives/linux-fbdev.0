From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Mon, 11 Feb 2013 09:31:44 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5118BA80.1020604@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com> <5114FD86.2020400@stericsson.com> <5115055B.2080509@ti.com> <511511B3.3060404@stericsson.com> <5118AA00.2000505@ti.com>
In-Reply-To: <5118AA00.2000505@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

On 02/11/2013 09:21 AM, Tomi Valkeinen wrote:
> On 2013-02-08 16:54, Marcus Lorentzon wrote:
>> On 02/08/2013 03:02 PM, Tomi Valkeinen wrote:
>>> On 2013-02-08 15:28, Marcus Lorentzon wrote:
>>>
>>>> When we do that we stop->setup->start during blanking. So our "DSS" is
>>>> optimized to be able to do that without getting blocked. All DSI video
>>>> mode panels (and DPI) products we have done so far have not had any
>>>> issue with that (as long as DSI HS clock is set to continuous). I think
>>>> this approach is less platform dependant, as long as there is no SoC
>>>> that take more than a blanking period to reconfigure.
>>> So do you stop, setup and start the link with CPU, and this has to be
>>> happen during blanking? Isn't that prone to errors? Or did you mean that
>>> the hardware handles that automatically?
>>>
>>> In OMAP DSS there are so called shadow registers, that can be programmed
>>> at any time. The you set a bit (GO bit), which tells the hardware to
>>> take the new settings into use at the next vblank.
>>>
>>>   From DSI driver's perspective the link is never stopped when
>>> reconfiguring the video timings. However, many other settings have to be
>>> configured when the link is disabled.
>> Yeah, you lucky guys with the GO bit ;). No, we actually do CPU
>> stop,setup,start. But since it is video mode, master is driving the sync
>> so it is not a hard deadline. It is enough to restart before pixels
>> start to degrade. On an LCD that is not so much time, but on an OLED it
>> could be 10 secs :). Anyway, we have had several mass products with this
>> soft solution and it has worked well.
> Ah, ok. But in that case what you said in an earlier mail is not quite
> correct: "I think this approach is less platform dependant, as long as
> there is no SoC that take more than a blanking period to reconfigure.".
> So in your approach the reconfiguration doesn't have to be done inside
> the blanking period, but before the panel's picture starts to fade?
>
> I don't know... It's early Monday morning, and not enough coffee yet,
> but I get a bit uneasy feeling if I think that your method of
> reconfiguring would be the only think allowed by the CDF API.
>
> Some SoCs do support reconfiguring on the fly, without disabling the
> link. It would not be nice if we didn't allow this to happen. And
> actually, we're not only talking about SoCs here, but also any display
> devices, like external buffer chips etc. They may also offer means to
> change configs on the fly.
>
> Well, I don't have any hard point about this at the moment, but I think
> we should think different approaches how the configuration can be done.

Ok, so what about a compromise which I think would work for "both" HWs 
... we allow the "configure" operation during video on, then each HW 
driver could decide if this means you have to stop or not to do the 
changes required. But then it is also important that we keep all config 
in one struct and not split it up. Otherwise HW like ours that has so be 
stopped could need to stop once for each setting/operation called.
So in short, allow configure(bus_params) during video on, keep all 
bus_params in the struct. It is in kernel struct so it can easily be 
changed/refactored.
>
>> I understand, but removing the omap prefix doesn't mean it has to go in
>> the panel slave port/bus settings. I still can't see why this should be
>> configuration on the panel driver and not the DSI master driver. Number
>> of pins might be useful since you might start with one lane and then
>> activate the rest. But partial muxing (pre pinmux) doesn't seem to be
>> something the panel should control or know anything about. Sounds like
>> normal platform/DT data per product/board.
> I think one case where this kind of pin configuration is needed, and
> which also dictates that all panel related configuration has to be in
> the panel's data, not in the DSI master's data, is hotplug.
>
> If you have a board that has two panels connected to the same video
> output, probably via some kind of mux, at least for the sensitive pins
> like DSI, only one of the panels can be enabled at a time. The panels
> can have different wiring, and thus the panel driver would need to
> configure everything related to the bus when it's starting up.
>
> The same also happens if you have a true hotplug, i.e. you can remove
> the panel totally and plug in a new one. Again the wiring can be
> different, and needs to be set up.
>
> And, as I said, this means that all relevant data about the video bus
> has to be in the panel's data, so that each panel can have its own set
> of, say, pin configuration.
>
> Hotplug is not a use case we should aim to support for the CDF v1, but I
> think we should strive not to prevent hotplug either. So if we can
> design the API so that hotplug is possible, I say let's do that.
>
Again, this probing and bus muxing is platform/bus specific and not 
panel specific. Any panel of that type will only ever work on Omap (or 
someone else implementing the same muxing features) as I see it. So why 
not just put that config on the bus master, dispc? I still can't see how 
this is panel config. You are only pushing CDF API and meta data to 
describe something that is only needed by one bus master. I have never 
seen any DSI slave that can change their pin config. And since there is 
no generic hot plug detect of DSI panels, at least not before DSI bus is 
available, I have to assume this probing it very platform specific. We 
have some products that provide 1-2 gpios to specify what panel is 
available, some use I2C sensor probing to then assume the panel plugged.
At least in the first step I don't think this type of hot plug should be 
in the API. Then once the base panel driver is in we could discuss 
different solutions for you hot plug scenario.

/BR
/Marcus
