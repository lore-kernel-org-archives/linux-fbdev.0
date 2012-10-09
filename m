From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Tue, 09 Oct 2012 21:29:11 +0000
Subject: Re: [PATCH V4 2/2] video: exynos_dp: device tree documentation
Message-Id: <50749727.1020103@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349824101-32574-1-git-send-email-ajaykumar.rs@samsung.com> <1349824101-32574-3-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1349824101-32574-3-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com, devicetree-discuss@lists.ozlabs.org, FlorianSchandinat@gmx.de, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com, thomas.ab@samsung.com

Hi Ajay,

On 10/10/2012 01:08 AM, Ajay Kumar wrote:
> Add documentation for the DT bindings in exynos display port driver.
> 
> Signed-off-by: Ajay Kumar<ajaykumar.rs@samsung.com>
> ---
>   .../devicetree/bindings/video/exynos_dp.txt        |   83 ++++++++++++++++++++
>   1 files changed, 83 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
> new file mode 100644
> index 0000000..a021963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
> @@ -0,0 +1,83 @@
> +Exynos display port driver should configure the display port interface
> +based on the type of panel connected to it.

The bindings are supposed to describe devices, not drivers. So it
might be better to say:

"The Exynos display port interface should be configured based on the 
type of panel connected to it."

From this documentation it is not clear which properties are required 
and which are optional for each node.

I think, in the property names dashes should be used, rather than 
underscores. Dashes are much more common among existing bindings.

> +We use two nodes:
> +	-dptx_phy node
> +	-display-port-controller node
> +
> +For the dp-phy initialization, we use a dptx_phy node.
> +Required properties for dptx_phy:
> +	-compatible:
> +		Should be "samsung,dp-phy".

Is there a separate dptx-phy driver that is being matched with this 
compatible property ? Is the dptx-node going to be referenced by other
nodes than display-port-controller ? If not, then you could likely drop 
the compatible property entirely and make the dptx-phy node a child 
node of display-port-controller, i.e.

	display-port-controller {
		compatible = "samsung,exynos5-dp";
		reg = <0x145b0000 0x10000>;
		interrupts =<10 3>;
		interrupt-parent =<&combiner>;

		dptx-phy {
			reg = <0x10040720>;
			samsung,enable_mask = <1>;
		};
       };

Then the driver could just look for a child node named "dptx-phy" with
e.g. of_find_node_by_name().

> +	-samsung,dptx_phy_reg:

I think it's fine to use just 'reg' instead of this vendor specific name.

> +		Base address of DP PHY register.
> +	-samsung,enable_mask:
> +		The bit-mask used to enable/disable DP PHY.
> +
> +For the Panel initialization, we read data from display-port-controller node.
> +Required properties for display-port-controller:
> +	-compatible:
> +		Should be "samsung,exynos5-dp".
> +	-reg:
> +		physical base address of the controller and length
> +		of memory mapped region.
> +	-interrupts:
> +		Interrupt combiner values.
> +	-interrupt-parent:
> +		phandle to Interrupt combiner node.
> +	-samsung,dp_phy:
> +		phandle to dptx_phy node.
> +	-samsung,color_space:
> +		input video data format.
> +			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> +	-samsung,dynamic_range:
> +		dynamic range for input video data.
> +			VESA = 0, CEA = 1
> +	-samsung,ycbcr_coeff:
> +		YCbCr co-efficients for input video.
> +			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> +	-samsung,color_depth:
> +		Number of bits per colour component.
> +			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> +	-samsung,link_rate:
> +		link rate supported by the panel.
> +			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
> +	-samsung,lane_count:
> +		number of lanes supported by the panel.
> +			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
> +	-samsung,interlaced:
> +		Interlace scan mode.
> +			Progressive if defined, Interlaced if not defined
> +	-samsung,v_sync_polarity:
> +		VSYNC polarity configuration.
> +			High if defined, Low if not defined
> +	-samsung,h_sync_polarity:
> +		HSYNC polarity configuration.
> +			High if defined, Low if not defined

So there is no common video bindings for things like these two ?
In V4L2 we decided to use vsync-active, hsync-active [1], the video
timings bindings [2] use hsync-active-high, hsync-active-high boolean
properties. Perhaps it is worth to pick some of those standard 
definitions and use instead of the vendor specific ones ?

> +
> +Example:
> +
> +SOC specific portion:
> +	dptx_phy: dptx_phy@0x10040720 {
> +		compatible = "samsung,dp-phy";
> +		samsung,dptx_phy_reg =<0x10040720>;

		reg = <0x10040720>;

> +		samsung,enable_mask =<1>;
> +	};
> +
> +	display-port-controller {
> +		compatible = "samsung,exynos5-dp";
> +		reg =<0x145B0000 0x10000>;

I think lower case is preferred.

> +		interrupts =<10 3>;
> +		interrupt-parent =<&combiner>;
> +		samsung,dp_phy =<&dptx_phy>;
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

Thanks,
Sylwester

[1] http://www.mail-archive.com/linux-media@vger.kernel.org/msg52743.html
[2] http://www.mail-archive.com/linux-media@vger.kernel.org/msg53323.html
