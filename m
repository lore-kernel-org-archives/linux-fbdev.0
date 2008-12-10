From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH 2/4 v2] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Wed, 10 Dec 2008 16:26:33 +0300
Message-ID: <493FC389.1010406@gmail.com>
References: <Pine.LNX.4.64.0812101122250.4578@axis700.grange> <Pine.LNX.4.64.0812101130400.4578@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755779AbYLJN06@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812101130400.4578@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

Hi,

Guennadi Liakhovetski wrote:
> From: Guennadi Liakhovetski <lg@denx.de>
>
> i.MX3x SoCs contain an Image Processing Unit, consisting of a Control
> Module (CM), Display Interface (DI), Synchronous Display Controller (SDC),
> Asynchronous Display Controller (ADC), Image Converter (IC), Post-Filter
> (PF), Camera Sensor Interface (CSI), and an Image DMA Controller (IDMAC).
> CM contains, among other blocks, an Interrupt Generator (IG) and a Clock
> and Reset Control Unit (CRCU). This driver serves IDMAC and IG. They are
> supported over dmaengine and irq-chip APIs respectively.
>
> IDMAC is a specialised DMA controller, its DMA channels cannot be used for
> general-purpose operations, even though it might be possible to configure
> a memory-to-memory channel for memcpy operation. This driver will not work
> with generic dmaengine clients, clients, wishing to use it must use
> respective wrapper structures, they also must specify which channels they
> require, as channels are hard-wired to specific IPU functions.
>
> Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
> ---
>  arch/arm/plat-mxc/include/mach/ipu.h  |  180 ++++
>  arch/arm/plat-mxc/include/mach/mx31.h |  139 +++-
>  drivers/mfd/Kconfig                   |   16 +
>  drivers/mfd/Makefile                  |    4 +-
>  drivers/mfd/ipu/Makefile              |    5 +
>  drivers/mfd/ipu/ipu_idmac.c           | 1617 +++++++++++++++++++++++++++++++++
>  drivers/mfd/ipu/ipu_intern.h          |  172 ++++
>  drivers/mfd/ipu/ipu_irq.c             |  277 ++++++
why do you think drivers/mfd is an appropriate location for this driver?
IPU is on-chip device, but it is not a separate multifunction device so
it should not be placed in drivers/mfd.

arch/arm/plat-mxc/ or drivers/video/ipu seem better places for this driver.


Dmitry



>  8 files changed, 2408 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/ipu.h
>  create mode 100644 drivers/mfd/ipu/Makefile
>  create mode 100644 drivers/mfd/ipu/ipu_idmac.c
>  create mode 100644 drivers/mfd/ipu/ipu_intern.h
>  create mode 100644 drivers/mfd/ipu/ipu_irq.c
