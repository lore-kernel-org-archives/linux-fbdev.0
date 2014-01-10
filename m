From: 'Sascha Hauer' <s.hauer@pengutronix.de>
Date: Fri, 10 Jan 2014 09:07:40 +0000
Subject: Re: [PATCH] video: mmp: add device tree support
Message-Id: <20140110090739.GZ6750@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
 <20140109073158.GM6750@pengutronix.de>
 <000301cf0d0e$91f29090$b5d7b1b0$%han@samsung.com>
 <52CE9165.7050002@marvell.com>
In-Reply-To: <52CE9165.7050002-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Tomi Valkeinen' <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, 'Haojian Zhuang' <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jan 09, 2014 at 08:09:09PM +0800, Zhou Zhu wrote:
> Sascha/Jingoo,
> Thank you for your review!
> 
> On 01/09/2014 03:43 PM, Jingoo Han wrote:
> >On Thursday, January 09, 2014 4:32 PM, Sascha Hauer wrote:
> >>On Thu, Jan 09, 2014 at 01:13:14PM +0800, Zhou Zhu wrote:
> >>>add device tree support for mmp fb/controller
> >>>the description at Documentation/devicetree/bindings/fb/mmp-disp.txt
> >>>
> >>>Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> >>>---
> >>>  Documentation/devicetree/bindings/fb/mmp-disp.txt |   71 ++++++++++++
> >>>  drivers/video/mmp/fb/mmpfb.c                      |   71 ++++++++----
> >>>  drivers/video/mmp/hw/mmp_ctrl.c                   |  120 ++++++++++++++++-----
> >>>  3 files changed, 217 insertions(+), 45 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
> >>>
> 
> [...]
> 
> >>+fb: fb {
> >>+	compatible = "marvell,mmp-fb";
> >
> >This compatible should have the specific SoC name in it, not just
> >'mmp'. Otherwise you can't properly distinguish between this version and
> >future versions of the mmp core.
> >
> We are using a same display IP for all mmp serial SoCs, and there
> would be inside register to get version. So I am planning put same
> compatible here for all SoCs using this IP.
> Would it be ok if I update compatible to "marvell,mmpdcx-fb"?
> "mmpdcx" is the IP name.

Using the SoC name is really good practice. This way you can add SoC
specific data to the compatible entry in the driver. Most bindings I've
seen which bind to some more generic string tend to add some additional
properties to the binding like marvell,has-new-feature or
marvell,needs-workaround-for-xy which you don't need at all if you bind
to the specific SoC in the first place.

If you insist on a generic binding you can still do a

	compatible = "marvell,soc-xy-fb", "marvell,mmp-fb";

This way you at least have the SoC information around (even in old
devicetrees) should you need it in the future.

BTW I've seen often enough that the version register is at a different
location on newer generations which makes it pretty useless.

> >> +	interrupts = <0 41 0x4>;
> >> +	marvell,disp-name = "mmp_disp";
> >> +	marvell,path-num = <1>;
> >> +	marvell,clk-name = "LCDCIHCLK";
> >
> > Don't pass clk names like this. We have a documented clock binding, use
> > it.
> >
> The patches to add dt support in common clk in our platforms are not
> upstreamed yet. As there's only one clock in this device, could I
> remove clock name related codes and direct use: devm_clk_get(dev,
> NULL)?

The clock name is defined by the device you are implementing, *not*
the name of the clock in the SoC. So if you have:

                                     ----------------------
   ---------  LCDCIHCLK             |            MMP       |
  | OSC/PLL |-----------------------|>pixclk               |
  ----------                        |                      |
                                     ----------------------


You have to do clk_get(dev, "pixclk") because you want to get the
clock associated to the pixclk input. Doing clk_get(dev, "LCDCIHCLK")
is wrong because that may change in future SoCs.
If you do this correctly there is no need to put the clk name into the
devicetree. You only have to put the information "which clk is connected
to the pixclk input of the MMP" into the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
