From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 28 Jun 2013 12:04:55 +0000
Subject: Re: [PATCH V2 3/3] video: exynos_dp: Use the generic PHY driver
Message-Id: <51CD7BE7.90204@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002101ce73cf$ac989b70$05c9d250$@samsung.com>
 <20130628093459.GD11297@arwen.pp.htv.fi>
 <20130628102702.GK305@game.jcrosoft.org>
In-Reply-To: <20130628102702.GK305@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 06/28/2013 12:27 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:35 Fri 28 Jun     , Felipe Balbi wrote:
>> > On Fri, Jun 28, 2013 at 04:18:23PM +0900, Jingoo Han wrote:
>>> > > Use the generic PHY API instead of the platform callback to control
>>> > > the DP PHY. The 'phy_label' field is added to the platform data
>>> > > structure to allow PHY lookup on non-dt platforms.
>>> > > 
>>> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>>> > > ---
[...]
>>> > > diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
>>> > > index 84f10c1..a8320e3 100644
>>> > > --- a/Documentation/devicetree/bindings/video/exynos_dp.txt
>>> > > +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
>>> > > @@ -1,17 +1,6 @@
>>> > >  The Exynos display port interface should be configured based on
>>> > >  the type of panel connected to it.
>>> > >  
>>> > > -We use two nodes:
>>> > > -	-dp-controller node
>>> > > -	-dptx-phy node(defined inside dp-controller node)
>>> > > -
>>> > > -For the DP-PHY initialization, we use the dptx-phy node.
>>> > > -Required properties for dptx-phy:
>>> > > -	-reg:
>>> > > -		Base address of DP PHY register.
>>> > > -	-samsung,enable-mask:
>>> > > -		The bit-mask used to enable/disable DP PHY.
>>> > > -
>>> > >  For the Panel initialization, we read data from dp-controller node.
>>> > >  Required properties for dp-controller:
>>> > >  	-compatible:
>>> > > @@ -67,12 +56,6 @@ SOC specific portion:
>>> > >  		interrupt-parent = <&combiner>;
>>> > >  		clocks = <&clock 342>;
>>> > >  		clock-names = "dp";
>>> > > -
>>> > > -		dptx-phy {
>>> > > -			reg = <0x10040720>;
>>> > > -			samsung,enable-mask = <1>;
>>> > > -		};
>
> I've an issue here you break dt compatibilty

Indeed. Ideally the PHYs should be detachable from the controllers.
I'd assume such a change could be acceptable, given that the driver
still supports the original binding.

--
Thanks,
Sylwester
