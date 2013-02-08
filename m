From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Fri, 08 Feb 2013 12:40:04 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5114F224.6010201@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com>
In-Reply-To: <5114E412.5030806@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, "rob@ti.com" <rob@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

On 02/08/2013 12:40 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 2013-02-03 21:17, Tomasz Figa wrote:
>> Hi Laurent,
>>
>> On Saturday 02 of February 2013 11:39:59 Laurent Pinchart wrote:
>>> Hi Tomasz,
>>>
>>> Thank you for your RFC.
>>>
>>> On Wednesday 30 January 2013 16:38:59 Tomasz Figa wrote:
>>>> Changes done to Tomi's edition of CDF:
>>>>   - Replaced set_operation_mode, set_pixel_format and set_size video
>>>>   source>
>>>>     operations with get_params display entity operation, as it was
>>>>     originally in Laurent's version.
>>>>     
>>>>     We have discussed this matter on the mailing list and decided that
>>>>     it
>>>>     would be better to have the source ask the sink for its parameter
>>>>     structure and do whatever appropriate with it.
>>> Could you briefly outline the rationale behind this ?
>> Display interfaces may be described by an arbitrary number of parameters.
>> Some will require just video timings, others like DSI will require a
>> significant number of additional bus-specific ones.
>>
>> Separating all the parameters (all of which are usually set at the same
>> time) into a lot of ops setting single parameter will just add unnecessary
>> complexity.
> I have nothing against combining the parameters that way. I think the
> important thing here is just that we have to allow changing of the
> parameters, whenever the display device needs that. So the bus
> parameters cannot be a one time constant setting.

I agree, but I think it should be 
setup->enable->video_on->video_off->disable->setup->...
I don't think there is any interface parameters that should be changed 
while link is enabled. And if there are, they should be identified and 
split out into a separate operation.
>>> I'm wondering whether get_params could limit us if a device needs to
>>> modify parameters at runtime. For instance a panel might need to change
>>> clock frequencies or number of used data lane depending on various
>>> runtime conditions. I don't have a real use case here, so it might just
>>> be a bit of over-engineering.
>> Hmm, isn't it in the opposite direction (the user requests the display
>> interface to change, for example, video mode, which in turn reconfigures
>> the link and requests the panel to update its settings)?
> Well, now, that's the question.
>
> Let's consider a simplified case with DSI output from the SoC, and a DSI
> panel. If the panel is a rather simple one, you could well call a method
> in the API in the DSI output driver, which would do necessary
> configuration and inform the panel driver to do any configuration it
> needs to do, based on the parameters.
>
> However, in my experience display devices, DSI devices in particular,
> are often quite "interesting". If the control of the operation in
> question is in the DSI output side, we are limited about what kind of
> DSI panels we can use, as the DSI output driver has to know all the
> tricks needed to make the panels work.
>
> I'm having hard time trying to explain this, so let's try an example.
> Consider the initial powering up of the bus. If the DSI output driver is
> in control, something like the following probably happens:
>
> - output driver asks for the parameters from the panel driver
> - output driver programs the DSI output according to these parameters
> - output driver informs the panel that the bus is now up and running
>
> Then consider a totally invented case, but which perhaps describes the
> problem with the above approach: The DSI panel requires the DSI bus
> first to be started in HS mode, but with a certain predefined bus speed,
> and only one lane used. This predefined bus setup is used to send
> configuration commands to the panel hardware, and only after that can
> you reconfigure the bus with proper speed and lanes.
>
> That kind of thing is a bit difficult to manage with the DSI output
> driver is in control. However, if the DSI panel driver is in control,
> it's simple:
>
> - panel driver calls config methods in the DSI output driver, setting
> the predefined speed and one lane
> - panel driver sends configuration commands to the panel
> - panel driver calls config methods in the DSI output driver, setting
> the final bus config

We have similar use cases and so I agree (and have implemented) the 
latter approach where panel driver is in control. I think it is 
important to separate the panel calling dispc (which it should not) from 
panel calling bus/videosource ops. Compare to I2C, no one would expect 
panel to call dispc to do I2C ops, instead panel call bus ops directly 
in response to the CDF ops request panel is running.
>>>>     5. Mask of used data lanes (each bit represents single lane).
>>>  From my experience with MIPI CSI (Camera Serial Interface, similar to
>>> DSI) some transceivers can reroute data lanes internally. Is that true
>>> for DSI as well ? In that case we would need a list of data lanes, not
>>> just a mask.
>> Hmm, I don't remember at the moment, will have to look to the
>> specification. Exynos DSI master doesn't support such feature.
> In OMAP you can configure the DSI pins quite freely. We have the
> following struct:
>
> struct omap_dsi_pin_config {
> 	int num_pins;
> 	/*
> 	 * pin numbers in the following order:
> 	 * clk+, clk-
> 	 * data1+, data1-
> 	 * data2+, data2-
> 	 * ...
> 	 */
> 	int pins[OMAP_DSS_MAX_DSI_PINS];
> };
>
Do you reroute after boot? Or is this just "board/product setup". We 
have some pinmuxing as well and DPhy sharing, but we have never used it 
after init/boot. If not runtime, I think this could be put in DT config 
for product instead of under dynamic control from panel.

/BR
/Marcus

