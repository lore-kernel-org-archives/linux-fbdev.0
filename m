From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 08 Jul 2013 02:04:06 +0000
Subject: Re: [PATCH V4 4/4] video: exynos_dp: Use the generic PHY driver
Message-Id: <001a01ce7b7f$6d7bdc60$48739520$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000d01ce7700$222a35a0$667ea0e0$@samsung.com>
 <1441230.DzaqAQ9HHT@flatron>
In-Reply-To: <1441230.DzaqAQ9HHT@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday, July 06, 2013 8:04 AM, Tomasz Figa wrote:
> 
> Hi Jingoo,
> 
> On Tuesday 02 of July 2013 17:42:49 Jingoo Han wrote:
> > Use the generic PHY API instead of the platform callback to control
> > the DP PHY.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  .../devicetree/bindings/video/exynos_dp.txt        |   23
> > +++++--------------- drivers/video/exynos/exynos_dp_core.c
> > |   16 ++++++++++---- drivers/video/exynos/exynos_dp_core.h
> >  |    2 ++
> >  3 files changed, 20 insertions(+), 21 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt
> > b/Documentation/devicetree/bindings/video/exynos_dp.txt index
> > 84f10c1..022f4b6 100644
> > --- a/Documentation/devicetree/bindings/video/exynos_dp.txt
> > +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
> > @@ -1,17 +1,6 @@
> >  The Exynos display port interface should be configured based on
> >  the type of panel connected to it.
> >
> > -We use two nodes:
> > -	-dp-controller node
> > -	-dptx-phy node(defined inside dp-controller node)
> > -
> > -For the DP-PHY initialization, we use the dptx-phy node.
> > -Required properties for dptx-phy:
> > -	-reg:
> > -		Base address of DP PHY register.
> > -	-samsung,enable-mask:
> > -		The bit-mask used to enable/disable DP PHY.
> > -
> 
> I wonder if this part shouldn't stay here, just marked as deprecated,
> because compatibility with old dtbs must be preserved (and rest of the
> patch looks like it is).

I would like to remove these properties from Documentation.
But, I will mark it as deprecated as you suggested..


Best regards,
Jingoo Han


