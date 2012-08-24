From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 24 Aug 2012 09:24:54 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <6044581.2jEzZBWCu1@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com> <20120821091306.GA4819@avionic-0098.mockup.avionic-design.de> <1345542860.4085.40.camel@deskari>
In-Reply-To: <1345542860.4085.40.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@nvidia.com>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <leelakrishna.a@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Tuesday 21 August 2012 17:54:20 Tomi Valkeinen wrote:
> > However this also means we'll essentially just be moving the board code.
> 
> 
> What do you mean "just"? Wasn't the point of the whole "arm board file
> mess" to get rid of the code from the board files? If the code in the
> board file is device specific code, not board specific, then the driver
> of the device is a logical place to place it.

I think Tomi has a point here - these sequences were not belonging to the 
board code in the first place. They are definitely tied to the device, hence 
should have been handled by the driver all along, with the board code 
assigning the correct resources to the device (like the vast majority of 
device drivers do).

> And as I said, I don't have any problems with some kind of generic power
> sequences. So the code in the board file could be moved and converted to
> use the power sequences, if that is better than just plain c code.

My concern now is, provided that all drivers to their job and handle how their 
devices are switched on and off, when (if at all) are encoded power sequences 
better than their equivalent C code? There is the matching database size issue 
that you mentionned, is it a sufficient concern to justify a new kernel feature?

On the other hand some devices like panels are typically not used in many 
different appliances, so maybe it is not worth to separate them from their 
board definition. As Mark mentionned, having .dtsi files for the DT (and their 
equivalent .h for kernels that use platform data) might be a good middle 
ground.

But the line is really tight between what is code and what is data here.

Alex.

