From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 13 Sep 2012 06:23:06 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <1749811.4qrG1GZfBf@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com> <1347515447.7471.12.camel@lappyti>
In-Reply-To: <1347515447.7471.12.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Thursday 13 September 2012 13:50:47 Tomi Valkeinen wrote:
> * PGP Signed by an unknown key
> 
> On Wed, 2012-09-12 at 18:57 +0900, Alexandre Courbot wrote:
> 
> > New revision of the power sequences, taking as usual the feedback that
> > was
> > kindly provided about the last version.
> > 
> > I think now is a good time to discuss integrating this and to start
> > looking for a maintainer who would be willing to merge this into his/her
> > tree (I am especially thinking about the power framework maintainers,
> > since this is where the code is right now. The second patch in this
> > series enables the pwm_backlight driver to be used with the device tree,
> > without relying on board-dependent callbacks to support complex power
> > sequences. We also plan to use power sequences in other Tegra drivers,
> > and other people have expressed interest in this work during earlier
> > reviews. See for instance
> > 
> > https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-
August/018532.html 
> > and
> > 
> > https://lkml.org/lkml/2012/9/6/270
> > 
> > There is probably some more details to fix and improve, but the current
> > shape should be enough to know if we want this and where - therefore any
> > sign from a maintainer would be greatly appreciated!
> 
> 
> I want to reiterate my opinion that I think power sequences in DT data
> is the wrong way to go. Powering sequences are device specific issues
> and should be handled in the device driver. But I also think that power
> sequences inside the drivers would probably be useful.

I understand the logic behind handling powering sequences in the device 
driver, but as we discussed for some classes of devices this might just not 
scale. I don't know how many different panels (each with different powering 
sequences) are relying on pwm_backlight, but the alternative of embedding 
support for all of them into the kernel (and bloating the kernel image) or 
having a 3 kilometers list in the kernel configuration to individually chose 
which panel to support (which would be cumbersome and make the kernel less 
portable across boards) does not look much appealing to me. With power 
sequences encoded in the DT, we could have one .dtsi file per panel that would 
be included from the board's .dts file - no bloat, no drivers explosion, 
portability preserved.

DT support is actually the main point of power sequences, as outside of the DT 
we can always work the old way and use callbacks. If we were to remove DT 
support, I am not sure this work would still be worth being merged.

Alex.

