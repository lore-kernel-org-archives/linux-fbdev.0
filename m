From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Wed, 30 Oct 2013 18:26:14 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <3796125.vSG7qeYk2f@flatron>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
	<20131030120229.GF24559@pengutronix.de>
In-Reply-To: <20131030120229.GF24559@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Wednesday 30 of October 2013 13:02:29 Sascha Hauer wrote:
> On Tue, Oct 29, 2013 at 01:52:57PM +1000, Dave Airlie wrote:
> > So we had a sessions at kernel summit to discuss the driver model and
> > DT interactions for a display pipeline,
> > 
> > we had good attendance from a few sides and I hope to summarise the
> > recommendations below,
> > 
> > a) Device Tree bindings
> > 
> > We should create a top-level virtual device binding that a top level
> > driver can bind to, like alsa asoc does.
> > 
> > We should separate the CDF device tree model from CDF as a starting
> > point and refine it outside of CDF, and produce a set of bindings that
> > cover the current drivers we have, exynos, imx, tegra, msm, armada
> > etc. This set of bindings should not be tied on CDF being merged or
> > anything else.
> > 
> > Display pipelines should be modelered in the device tree, but the
> > level of detail required for links between objects may be left up to
> > the SoC developer, esp wrt tightly coupled SoCs.
> > 
> > Externally linked devices like bridges and panels should be explicitly
> > linked.
> > 
> > b) Driver Model
> > 
> > The big thing here is that the device tree description we use should
> > not dictate the driver model we use. This is the biggest thing I
> > learned, so what does it mean?
> > 
> > We aren't required to write a device driver per device tree object.
> > 
> > We shouldn't be writing device drivers per device tree object.
> > 
> > For tightly-coupled SoCs where the blocks come from one vendor and are
> > reused a lot, a top level driver should use the DT as configuration
> > information source for the list of blocks it needs to initialise on
> > the card, not as a list of separate drivers. There may be some
> > external drivers required and the code should deal with this, like how
> > alsa asoc does.
> > 
> > To share code between layers we should refactor it into a helper
> > library not a separate driver, the kms/v4l/fbdev can use the library.
> > 
> > This should allow us to move forward a bit clearer esp with new
> > drivers and following these recommendations, and I think porting
> > current drivers to a sane model, especially exynos and imx.
> > 
> > Now I saw we here but I'm only going to be donating my use of a big
> > stick and review abilities to making this happen, but I'm quite
> > willing to enforce some of these rules going forward as I think it
> > will make life easier.
> > 
> > After looking at some of the ordering issues we've had with x86 GPUs
> > (which are really just a tightly coupled SoC) I don't want separate
> > drivers all having their own init, suspend/resume paths in them as I
> > know we'll have to start making special vtable entry points etc to
> > solve some random ordering issues that crop up.
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
>
> This way all components could be proper (driver model)devices with
> proper drivers without DRM even noticing that multiple components are
> involved.
> 
> Side note: We have no choice anyway. All SoCs can (sometimes must)
> be extended with external I2C devices. On every SoC the I2C bus master
> is a separate device, so we have a multicomponent device (in the sense
> of driver model) already in many cases.

+1

Best regards,
Tomasz

