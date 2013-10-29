From: Dave Airlie <airlied@gmail.com>
Date: Tue, 29 Oct 2013 03:52:57 +0000
Subject: outcome of DRM/KMS DT bindings session
Message-Id: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel <dri-devel@lists.freedesktop.org>, ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

So we had a sessions at kernel summit to discuss the driver model and
DT interactions for a display pipeline,

we had good attendance from a few sides and I hope to summarise the
recommendations below,

a) Device Tree bindings

We should create a top-level virtual device binding that a top level
driver can bind to, like alsa asoc does.

We should separate the CDF device tree model from CDF as a starting
point and refine it outside of CDF, and produce a set of bindings that
cover the current drivers we have, exynos, imx, tegra, msm, armada
etc. This set of bindings should not be tied on CDF being merged or
anything else.

Display pipelines should be modelered in the device tree, but the
level of detail required for links between objects may be left up to
the SoC developer, esp wrt tightly coupled SoCs.

Externally linked devices like bridges and panels should be explicitly linked.

b) Driver Model

The big thing here is that the device tree description we use should
not dictate the driver model we use. This is the biggest thing I
learned, so what does it mean?

We aren't required to write a device driver per device tree object.

We shouldn't be writing device drivers per device tree object.

For tightly-coupled SoCs where the blocks come from one vendor and are
reused a lot, a top level driver should use the DT as configuration
information source for the list of blocks it needs to initialise on
the card, not as a list of separate drivers. There may be some
external drivers required and the code should deal with this, like how
alsa asoc does.

To share code between layers we should refactor it into a helper
library not a separate driver, the kms/v4l/fbdev can use the library.

This should allow us to move forward a bit clearer esp with new
drivers and following these recommendations, and I think porting
current drivers to a sane model, especially exynos and imx.

Now I saw we here but I'm only going to be donating my use of a big
stick and review abilities to making this happen, but I'm quite
willing to enforce some of these rules going forward as I think it
will make life easier.

After looking at some of the ordering issues we've had with x86 GPUs
(which are really just a tightly coupled SoC) I don't want separate
drivers all having their own init, suspend/resume paths in them as I
know we'll have to start making special vtable entry points etc to
solve some random ordering issues that crop up.

Dave.
