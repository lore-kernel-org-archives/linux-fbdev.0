From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 28 Jun 2013 05:58:38 +0000
Subject: Re: [PATCH 2/3] ARM: dts: Add DP PHY node to exynos5250.dtsi
Message-Id: <001b01ce73c4$88f45020$9adcf060$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001601ce73bf$9f2e9120$dd8bb360$@samsung.com>
 <51CD2214.10506@ti.com>
In-Reply-To: <51CD2214.10506@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, June 28, 2013 2:42 PM, Kishon Vijay Abraham I wrote:
> 
> Hi,
> 
> On Friday 28 June 2013 10:53 AM, Jingoo Han wrote:
> > Add PHY provider node for the DP PHY.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >   arch/arm/boot/dts/exynos5250.dtsi |   13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> > index 41cd625..d1d6e14 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -614,6 +614,12 @@
> >   		interrupts = <0 94 0>;
> >   	};
> >
> > +	dp_phy: video-phy@10040720 {
> > +		compatible = "samsung,exynos5250-dp-video-phy";
> > +		reg = <0x10040720 4>;
> > +		#phy-cells = <1>;
> 
> phy-cells can be '0' here since this phy_provider implements only one PHY.

Oh, thank you.
I will fix it.

Best regards,
Jingoo Han

> 
> Thanks
> Kishon

