From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 01 Nov 2013 15:28:40 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <CAAQKjZOM03QhqiCyFqP9v2oW2s0dwg=zb2UoV8TnJTsnc_77Dg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
	<20131030120229.GF24559@pengutronix.de>
	<CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
In-Reply-To: <CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

2013/11/1 Dave Airlie <airlied@gmail.com>:
>>> After looking at some of the ordering issues we've had with x86 GPUs
>>> (which are really just a tightly coupled SoC) I don't want separate
>>> drivers all having their own init, suspend/resume paths in them as I
>>> know we'll have to start making special vtable entry points etc to
>>> solve some random ordering issues that crop up.
>>
>> The DRM device has to be initialized/suspended/resumed as a whole, no
>> doubt about that. If that's not the case you indeed open up the door for
>> all kinds of ordering issues.
>>
>> Still the different components can be multiple devices, just initialize
>> the drm device once all components are probed. Remove it again once a
>> component is removed. Handle suspend in the DRM device, not in
>> the individual component drivers. The suspend in the component drivers
>> would only be called after the DRM device is completely quiesced.
>> Similarly the resume in the component drivers would not reenable the
>> components, this instead would be done in the DRM device when all
>> components are there again.
>
> But why? why should we have separate drivers for each component of a
> tightly coupled SoC?
>
> it makes no sense, having a driver node per every block in the chip
> isn't an advantage, it complicates
> things for no advantage at all. If we don't have hotplug hw removing
> one device shouldn't be possible
> this idea that removing a sub-driver should teardown the drm is crazy as well.
>
>>
>> This way all components could be proper (driver model)devices with
>> proper drivers without DRM even noticing that multiple components are
>> involved.
>>
>> Side note: We have no choice anyway. All SoCs can (sometimes must)
>> be extended with external I2C devices. On every SoC the I2C bus master
>> is a separate device, so we have a multicomponent device (in the sense
>> of driver model) already in many cases.
>>
>
> Having off-chip i2c devices being part of the driver model is fine,
> stuff works like that everywhere,
> having each SoC block part of the device model isn't fine unless you
> can really prove re-use and
> why having separate driver templating for each block is helpful.
>
> I'm not willing to have overly generic sub drivers that provide no
> advantage and only add lots
> of disadvantage like init and suspend/resume ordering. I know there is
> going to be SoC ordering
> issues at init time that will end up circular between two separate
> drivers each deferring because
> they want another driver up. Don't dig us into that hole, i2c has a
> well defined ordering of init,
> I don't think internal SoC devices are so well defined.
>

It seems that the main reason we should go to a single drm driver is
the probe ordering issue of sub drivers and the power ordering issue
of them.

First, I'd like to ask qustions to myself and other people. Do we
really need to define the display pipeline node? Is there really any
good way to can use only existing device nodes?

Please suppose the below things,
1. crtc and encoder/connector can be created when KMS driver and
display driver are probed regardless of the ordering
2. A crtc and a connector are connected when last one is created. This
means that a framebuffer will be created and the framebuffer's image
will be transferred to display via KMS driver.


And let see how hardware pipe lines can be linked each other,
1. Top level
CRTC -------- Encoder ---------- Connector

2. CRTC
Display controller or HDMI
Display controller or HDMI ----------  Image Enhancement chips or other

3. Encoder/Connector
LCD Panel
Display bus(mipi, dp)  ------- LCD panel or TV
Display bus(mipi, dp)  ------- bridge device(lvds) ------- LCD panel or TV


As you can see the above, if a crtc and a connector could be connected
each other regardless of the probe order - actually possible, and we
are already using this way in internal project - then I think it's
enough to consider display pipeline node to CRTC, and to
Encoder/Connector individually. DT binding of CRTC including Image
Enhancement chips can be done at top level of drm driver, and DT
binding of Encoder/Connector including bridge device and panel can be
done at probe of separated encoder/connector driver. Of course, for
avoiding power ordering issue, each encoder/connector drivers
shouldn't have their resume/suspend interfaces, and their pm should be
handled by dpms callback at top level of drm driver.

This way I think we could simplify to compose the display pipeline
node as device tree,and also we could have a separated device driver
as driver model.

Thanks,
Inki Dae


> Dave.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
