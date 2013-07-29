From: Wang Huan-B18965 <B18965@freescale.com>
Date: Mon, 29 Jul 2013 06:13:51 +0000
Subject: RE: [PATCH v2 0/5] ARM: vf610: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <81BA6E5E0BC2344391CABCEE22D1B6D83C0479@039-SN1MPN1-002.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D83AA3AE@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <81BA6E5E0BC2344391CABCEE22D1B6D83AA3AE@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi, Jean-Christophe, Tomi,

       Do you have any comments for these patches?

       Thanks!


Best Regards,
Alison Wang

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Wang Huan-B18965
> Sent: Friday, July 19, 2013 11:49 AM
> To: plagnioj@jcrosoft.com; tomi.valkeinen@ti.com; shawn.guo@linaro.org;
> Estevam Fabio-R49496; linux-fbdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: Jin Zhengxiong-R64188
> Subject: RE: [PATCH v2 0/5] ARM: vf610: Add DCU framebuffer driver for
> Vybrid VF610 platform
> 
> Hi, Jean-Christophe,
> 
>       Could you please help to review these patches?
> 
>       Thanks a lot!
> 
> 
> Best Regards,
> Alison Wang
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-
> > bounces@lists.infradead.org] On Behalf Of Alison Wang
> > Sent: Friday, July 12, 2013 2:08 PM
> > To: plagnioj@jcrosoft.com; tomi.valkeinen@ti.com;
> > shawn.guo@linaro.org; Estevam Fabio-R49496;
> > linux-fbdev@vger.kernel.org; linux-arm- kernel@lists.infradead.org
> > Cc: Jin Zhengxiong-R64188
> > Subject: [PATCH v2 0/5] ARM: vf610: Add DCU framebuffer driver for
> > Vybrid VF610 platform
> >
> > This series contain DCU framebuffer driver for Freescale Vybrid VF610
> > platform.
> >
> > The Display Controller Unit (DCU) module is a system master that
> > fetches graphics stored in internal or external memory and displays
> > them on a TFT LCD panel. A wide range of panel sizes is supported and
> > the timing of the interface signals is highly configurable.
> > Graphics are read directly from memory and then blended in real-time,
> > which allows for dynamic content creation with minimal CPU
> intervention.
> >
> > The features:
> >
> > (1) Full RGB888 output to TFT LCD panel.
> > (2) For the current LCD panel, WQVGA "480x272" is tested.
> > (3) Blending of each pixel using up to 4 source layers dependent on
> > size of panel.
> > (4) Each graphic layer can be placed with one pixel resolution in
> > either axis.
> > (5) Each graphic layer support RGB565 and RGB888 direct colors
> without
> > alpha channel and BGRA8888 direct colors with an alpha channel.
> > (6) Each graphic layer support alpha blending with 8-bit resolution.
> >
> > Changes in v2:
> > - Add a document for DCU framebuffer driver under
> > Documentation/devicetree/bindings/fb/.
> >
> > ----------------------------------------------------------------
> > Alison Wang (5):
> >       ARM: dts: vf610: Add DCU and TCON nodes
> >       ARM: dts: vf610-twr: Enable DCU and TCON devices
> >       ARM: clk: vf610: Add DCU and TCON clock support
> >       fb: Add DCU framebuffer driver for Vybrid VF610 platform
> >       Documentation: DT: Add DCU framebuffer driver
> >
> >  Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt |   36 ++++
> >  arch/arm/boot/dts/vf610-twr.dts                     |   10 +
> >  arch/arm/boot/dts/vf610.dtsi                        |   19 +-
> >  arch/arm/mach-imx/clk-vf610.c                       |    5 +
> >  drivers/video/Kconfig                               |    9 +
> >  drivers/video/Makefile                              |    1 +
> >  drivers/video/fsl-dcu-fb.c                          | 1091
> >
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > +++++++++++++++++++++++++
> >  include/dt-bindings/clock/vf610-clock.h             |    3 +-
> >  8 files changed, 1172 insertions(+), 2 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
> >  create mode 100644 drivers/video/fsl-dcu-fb.c
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


