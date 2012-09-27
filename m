From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Thu, 27 Sep 2012 13:44:40 +0000
Subject: Re: [PATCH V3] video: exynos_dp: Add device tree support to DP driver
Message-Id: <50645848.6080102@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348515385-22332-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1348515385-22332-1-git-send-email-ajaykumar.rs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ajay Kumar <ajaykumar.rs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org

Hi,

Cc: devicetree-discuss@lists.ozlabs.org

On 09/24/2012 09:36 PM, Ajay Kumar wrote:
> This patch enables device tree based discovery support for DP driver.
> The driver is modified to handle platform data in both the cases:
> with DT and non-DT.
> Documentation is also added for the DT bindings.
> 
> DP-PHY should be regarded as a seperate device node while
> being passed from device tree list, and device node for
> DP should contain DP-PHY as child node with property name "dp-phy"
> associated with it.
> 
> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
> ---
>   .../devicetree/bindings/video/exynos_dp.txt        |   83 ++++++++++
>   drivers/video/exynos/exynos_dp_core.c              |  168 ++++++++++++++++++--
>   drivers/video/exynos/exynos_dp_core.h              |    2 +
>   3 files changed, 239 insertions(+), 14 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
> new file mode 100644
> index 0000000..c27f892
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
> @@ -0,0 +1,83 @@
> +Exynos Displayport driver should configure the displayport interface

Don't we need a whitespace between 'display' and 'port' ?

> +based on the type of panel connected to it.
> +
> +We use two nodes:
> +	-dptx_phy node
> +	-display-port-controller node
> +
> +For the dp-phy initialization, we use a dptx_phy node.
> +Required properties for dptx_phy:
> +	-compatible:
> +		Should be "samsung,dp-phy".
> +	-samsung,dptx_phy_reg:
> +		Base address of DP PHY register.

Couldn't just 'reg' be used for this one ?

> +	-samsung,enable_bit:
> +		The bit used to enable/disable DP PHY.

Is this the bit mask or the bit index ? In the code it's used as 
a bitmask. But from description it is not clear whether it is 
an index or a mask. Is it different across various SoCs ?

Perhaps it's better to name it samsung,enable_mask (in case some
SoC need more than one bit) ?

> +
> +For the Panel initialization, we read data from display-port-controller node.
> +Required properties for display-port-controller:
> +	-compatible:
> +		Should be "samsung,exynos5-dp".
> +	-reg:
> +		physical base address of the controller and length
> +		of memory mapped region.
> +	-interrupts:
> +		Internet combiner values.

what? :)

> +	-interrupt-parent:
> +		Address of Interrupt combiner node.
> +	-dp_phy:
> +		Address of dptx_phy node.

"A phandle to dptx_phy node" ?

> +	-samsung,color_space:
> +		input video data format.
> +			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2

Can this be changed at run time ?

> +	-samsung,dynamic_range:
> +		dynamic range for input video data.
> +			VESA = 0, CEA = 1

Why is it in the device tree ? Shouldn't it be configurable at runtime ?
My apologies if this an obvious question, I don't have much experience 
with DP.

> +	-samsung,ycbcr_coeff:
> +		YCbCr co-efficients for input video.
> +			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> +	-samsung,color_depth:
> +		Bit per color component.

"Number of bits per colour component" ? Also same remark as above.

> +			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> +	-samsung,link_rate:
> +		link rates supportd by the panel.

typo: supportd -> supported

> +			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A

Is this really a property of a panel ? Why it is in the PHY node ?
Also I can see this is just a single property, so "link rates" is a bit 
misleading.

> +	-samsung,lane_count:
> +		number of lanes supported by the panel.
> +			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4

What do these symbolic names are needed for ? Is lane_count a number or a 
mask, is this really a _maximum_ number of lanes ? What are the valid values, 
1, 2 and 4 ? Or maybe 0x3 is also valid which  would indicate that we can 
use 1 or 2 data lanes ?

> +	-samsung,interlaced:
> +		Interlace scan mode.
> +			Progressive if defined, Interlaced if not defined

Why do we need this in the device tree ? Is this really a default scan mode ?
Can it be the changed at runtime ?

> +	-samsung,v_sync_polarity:
> +		VSYNC polarity configuration.
> +			High if defined, Low if not defined
> +	-samsung,h_sync_polarity:
> +		HSYNC polarity configuration.
> +			High if defined, Low if not defined
> +
> +Example:
> +
> +SOC specific portion:
> +	dptx_phy: dptx_phy@0x10040720 {
> +		compatible = "samsung,dp-phy";
> +		samsung,dptx_phy_reg =<0x10040720>;
> +		samsung,enable_bit =<1>;
> +	};
> +
> +	display-port-controller {
> +		compatible = "samsung,exynos5-dp";
> +		reg =<0x145B0000 0x10000>;
> +		interrupts =<10 3>;
> +		interrupt-parent =<&combiner>;
> +		dp_phy =<&dptx_phy>;

Shouldn't it be "samsung,dp_phy" ?

> +        };
> +
> +Board Specific portion:
> +	display-port-controller {
> +		samsung,color_space =<0>;
> +		samsung,dynamic_range =<0>;
> +		samsung,ycbcr_coeff =<0>;
> +		samsung,color_depth =<1>;
> +		samsung,link_rate =<0x0a>;
> +		samsung,lane_count =<2>;
> +	};

--

Regards,
Sylwester
