From: Liviu Dudau <Liviu.Dudau@arm.com>
Date: Thu, 20 Sep 2012 10:29:44 +0000
Subject: Re: [RFC PATCH 3/3] ARM: vexpress: configure CLCD driver device tree support for A9 CoreTile
Message-Id: <20120920102943.GH32603@e102652-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-4-git-send-email-ryan.harkin@linaro.org>
In-Reply-To: <1348070666-9153-4-git-send-email-ryan.harkin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 19, 2012 at 05:04:26PM +0100, Ryan Harkin wrote:
> Configuration for the amba-clcd PL111 driver is added to the A9 CoreTile's DTS
> file.
>
> Configuration of the motherboard CLCD driver is removed from the DTSI files to
> prevent duplicate CLCD drivers being registered.
>
> A generic set of CLCD panel descriptions has been split into its own DTSI file.
> Currently, only XVGA and VGA monitors are described.

Hi Ryan,

For this and [2/3] patch:

Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>


>
> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
> ---
>  arch/arm/boot/dts/clcd-panels.dtsi      |   52 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |    8 ++---
>  arch/arm/boot/dts/vexpress-v2m.dtsi     |    8 ++---
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts  |    6 ++++
>  4 files changed, 62 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/clcd-panels.dtsi b/arch/arm/boot/dts/clcd-panels.dtsi
> new file mode 100644
> index 0000000..0b0ff6e
> --- /dev/null
> +++ b/arch/arm/boot/dts/clcd-panels.dtsi
> @@ -0,0 +1,52 @@
> +/*
> + * ARM Ltd. Versatile Express
> + *
> + */
> +
> +/ {
> +     panels {
> +             panel@0 {
> +                     compatible      = "panel";
> +                     mode            = "VGA";
> +                     refresh         = <60>;
> +                     xres            = <640>;
> +                     yres            = <480>;
> +                     pixclock        = <39721>;
> +                     left_margin     = <40>;
> +                     right_margin    = <24>;
> +                     upper_margin    = <32>;
> +                     lower_margin    = <11>;
> +                     hsync_len       = <96>;
> +                     vsync_len       = <2>;
> +                     sync            = <0>;
> +                     vmode           = "FB_VMODE_NONINTERLACED";
> +
> +                     tim2            = "TIM2_BCD", "TIM2_IPC";
> +                     cntl            = "CNTL_LCDTFT", "CNTL_BGR", "CNTL_LCDVCOMP(1)";
> +                     caps            = "CLCD_CAP_5551", "CLCD_CAP_565", "CLCD_CAP_888";
> +                     bpp             = <16>;
> +             };
> +
> +             panel@1 {
> +                     compatible      = "panel";
> +                     mode            = "XVGA";
> +                     refresh         = <60>;
> +                     xres            = <1024>;
> +                     yres            = <768>;
> +                     pixclock        = <15748>;
> +                     left_margin     = <152>;
> +                     right_margin    = <48>;
> +                     upper_margin    = <23>;
> +                     lower_margin    = <3>;
> +                     hsync_len       = <104>;
> +                     vsync_len       = <4>;
> +                     sync            = <0>;
> +                     vmode           = "FB_VMODE_NONINTERLACED";
> +
> +                     tim2            = "TIM2_BCD", "TIM2_IPC";
> +                     cntl            = "CNTL_LCDTFT", "CNTL_BGR", "CNTL_LCDVCOMP(1)";
> +                     caps            = "CLCD_CAP_5551", "CLCD_CAP_565", "CLCD_CAP_888";
> +                     bpp             = <16>;
> +             };
> +     };
> +};
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index d8a827b..301d3f6 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -17,6 +17,8 @@
>   * CHANGES TO vexpress-v2m.dtsi!
>   */
>
> +/include/ "clcd-panels.dtsi"
> +
>  / {
>       aliases {
>               arm,v2m_timer = &v2m_timer01;
> @@ -193,12 +195,6 @@
>                                      0x1a0100 0xf00>;
>                               reg-shift = <2>;
>                       };
> -
> -                     clcd@1f0000 {
> -                             compatible = "arm,pl111", "arm,primecell";
> -                             reg = <0x1f0000 0x1000>;
> -                             interrupts = <14>;
> -                     };
>               };
>
>               v2m_fixed_3v3: fixedregulator@0 {
> diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
> index dba53fd..43cd86f 100644
> --- a/arch/arm/boot/dts/vexpress-v2m.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
> @@ -17,6 +17,8 @@
>   * CHANGES TO vexpress-v2m-rs1.dtsi!
>   */
>
> +/include/ "clcd-panels.dtsi"
> +
>  / {
>       aliases {
>               arm,v2m_timer = &v2m_timer01;
> @@ -192,12 +194,6 @@
>                                      0x1a100 0xf00>;
>                               reg-shift = <2>;
>                       };
> -
> -                     clcd@1f000 {
> -                             compatible = "arm,pl111", "arm,primecell";
> -                             reg = <0x1f000 0x1000>;
> -                             interrupts = <14>;
> -                     };
>               };
>
>               v2m_fixed_3v3: fixedregulator@0 {
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 3f0c736..2ebb132 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -9,6 +9,8 @@
>
>  /dts-v1/;
>
> +/memreserve/ 0x9f000000 0x01000000;
> +
>  / {
>       model = "V2P-CA9";
>       arm,hbi = <0x191>;
> @@ -70,6 +72,10 @@
>               compatible = "arm,pl111", "arm,primecell";
>               reg = <0x10020000 0x1000>;
>               interrupts = <0 44 4>;
> +             mode = "XVGA";
> +             arm,vexpress-osc = <1>;
> +             use_dma = <1>;
> +             framebuffer = <0x9f000000 0x01000000>;
>       };
>
>       memory-controller@100e0000 {
> --
> 1.7.9.5
>
>

--
==========
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

