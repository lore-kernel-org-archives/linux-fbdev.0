From: Dave Airlie <airlied@gmail.com>
Date: Fri, 01 Nov 2013 00:10:41 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
	<20131030120229.GF24559@pengutronix.de>
In-Reply-To: <20131030120229.GF24559@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

>> After looking at some of the ordering issues we've had with x86 GPUs
>> (which are really just a tightly coupled SoC) I don't want separate
>> drivers all having their own init, suspend/resume paths in them as I
>> know we'll have to start making special vtable entry points etc to
>> solve some random ordering issues that crop up.
>
> The DRM device has to be initialized/suspended/resumed as a whole, no
> doubt about that. If that's not the case you indeed open up the door for
> all kinds of ordering issues.
>
> Still the different components can be multiple devices, just initialize
> the drm device once all components are probed. Remove it again once a
> component is removed. Handle suspend in the DRM device, not in
> the individual component drivers. The suspend in the component drivers
> would only be called after the DRM device is completely quiesced.
> Similarly the resume in the component drivers would not reenable the
> components, this instead would be done in the DRM device when all
> components are there again.

But why? why should we have separate drivers for each component of a
tightly coupled SoC?

it makes no sense, having a driver node per every block in the chip
isn't an advantage, it complicates
things for no advantage at all. If we don't have hotplug hw removing
one device shouldn't be possible
this idea that removing a sub-driver should teardown the drm is crazy as well.

>
> This way all components could be proper (driver model)devices with
> proper drivers without DRM even noticing that multiple components are
> involved.
>
> Side note: We have no choice anyway. All SoCs can (sometimes must)
> be extended with external I2C devices. On every SoC the I2C bus master
> is a separate device, so we have a multicomponent device (in the sense
> of driver model) already in many cases.
>

Having off-chip i2c devices being part of the driver model is fine,
stuff works like that everywhere,
having each SoC block part of the device model isn't fine unless you
can really prove re-use and
why having separate driver templating for each block is helpful.

I'm not willing to have overly generic sub drivers that provide no
advantage and only add lots
of disadvantage like init and suspend/resume ordering. I know there is
going to be SoC ordering
issues at init time that will end up circular between two separate
drivers each deferring because
they want another driver up. Don't dig us into that hole, i2c has a
well defined ordering of init,
I don't think internal SoC devices are so well defined.

Dave.
