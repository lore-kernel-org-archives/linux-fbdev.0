From: Dima Zavin <dima@android.com>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 29 Jun 2009 16:06:40 -0700
Message-ID: <404ea8000906291606u600673f3r63a9ac0dfe02eea@mail.gmail.com>
References: <20090629111029.GA15514@elf.ucw.cz>
	 <20090629123840.1e20f17d.akpm@linux-foundation.org>
	 <a55d774e0906291300u3bb9b491r124f27fdf832b495@mail.gmail.com>
	 <20090629211931.GD6611@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759444AbZF2XGx@vger.kernel.org>
In-Reply-To: <20090629211931.GD6611@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Swetland <swetland@google.com>, Andrew Morton <akpm@linux-foundation.org>, Rebecca Schultz Zavin <rebecca@android.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Pavel,

Thanks for doing the clean up pass, it was long overdue.

>> > So you didn't wrote the code?
>> >
>> >> This adds support for framebuffer on HTC Dream smartphone (aka
>> >> T-Mobile G1, aka ADP1).
>> >>
>> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> >> Cc: Brian Swetland <swetland@google.com>
>> >
>> > Someone did. =A0Are the signoffs and attributions correct and
>> > appropriate? =A0Should we at least mention the driver's history in=
 the
>> > changelog?

The patch (though it was probably several patches) in our msm tree had
the proper author attribution (Rebecca Schultz Zavin
<rebecca@android.com>), so I think it would make the most sense to
keep that information.

>> > Will it have a maintainer?
>>
>> I did the original quick and dirty version for bringup. =A0Rebecca t=
ook
>> over and (re)wrote the bulk of the driver, getting things stable for
>> production ship of Dream and Sapphire, and Dima is currently adding
>> support for later Qualcomm chipsets (QSD8x50, etc). =A0Looping them =
into
>> this discussion.
>
> I can maintain it if noone else steps up. Of course, someone who
> actually knows the hw/has the docs would be preferable.

As Brian mentioned, I'm the last one to touch it here, so I now own
it. I've done a bunch refactoring to add support for the qsd8x50
devices. I'll post those up onto our experimental git tree (hopefully
sometime today), and once this patch goes in, I'll make sure that we
apply cleanly against it. Alternatively, if you like, I can
incorporate your comments into the refactoring work I'm doing, and can
push out the combined patch. In the future though, I'll try to be a
lot more aggressive at sending these out for review earlier so you
don't have to clean up our mess.

Please feel free to CC Rebecca and myself on all the msm_fb related
changes/discussions.

>> It would probably be worth referring to drivers like this as "for
>> Qualcomm MSM/QSD SoCs" or the like, since they do work with a lot of
>> hardware beyond just Dream.
>
> Well, the Dream is why I'm doing it, hence patch title. Of course,
> Kconfig should say 'Qualcomm MSM/QSD SoCs', too.

I second the request that the patches for qualcomm msm7k/qsd8k generic
support would have descriptions that refer to them as such, since the
htc dream specific code is only in the board files in
arch/arm/mach-msm. Note that the HTC Magic (aka the Ion, myTouch 3G,
etc.) uses the exact same fb code (i.e. it's also using the msm7201a
chipset). Mentioning in the body of the patch message that this is the
chipset used in the HTC Dream definitely makes sense, but the main
description should really refer to these as adding generic msm7k
support.

Thanks again for pushing this stuff up. Your help is much appreciated.

--Dima

> Sorry for world record in checkpatch warnings. I checked .c files, bu=
t
> somehow forgot about .h files.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
>
> ---
>
> Fix checkpatch warnings in HTC Dream display driver.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> diff --git a/drivers/video/msm/mddi_hw.h b/drivers/video/msm/mddi_hw.=
h
> index 0cb55eb..45cc01f 100644
> --- a/drivers/video/msm/mddi_hw.h
> +++ b/drivers/video/msm/mddi_hw.h
> @@ -199,39 +199,39 @@ struct __attribute__((packed)) mddi_video_strea=
m {
> =A0 =A0 =A0 =A0uint16_t client_id; /* 0 */
>
> =A0 =A0 =A0 =A0uint16_t video_data_format_descriptor;
> - =A0 =A0 =A0 /* format of each pixel in the Pixel Data in the presen=
t stream in the
> - =A0 =A0 =A0 =A0* present packet.
> - =A0 =A0 =A0 =A0* If bits [15:13] =3D 000 monochrome
> - =A0 =A0 =A0 =A0* If bits [15:13] =3D 001 color pixels (palette).
> - =A0 =A0 =A0 =A0* If bits [15:13] =3D 010 color pixels in raw RGB
> - =A0 =A0 =A0 =A0* If bits [15:13] =3D 011 data in 4:2:2 Y Cb Cr form=
at
> - =A0 =A0 =A0 =A0* If bits [15:13] =3D 100 Bayer pixels
> - =A0 =A0 =A0 =A0*/
> +/* format of each pixel in the Pixel Data in the present stream in t=
he
> + * present packet.
> + * If bits [15:13] =3D 000 monochrome
> + * If bits [15:13] =3D 001 color pixels (palette).
> + * If bits [15:13] =3D 010 color pixels in raw RGB
> + * If bits [15:13] =3D 011 data in 4:2:2 Y Cb Cr format
> + * If bits [15:13] =3D 100 Bayer pixels
> + */
>
> =A0 =A0 =A0 =A0uint16_t pixel_data_attributes;
> - =A0 =A0 =A0 /* interpreted as follows:
> - =A0 =A0 =A0 =A0* Bits [1:0] =3D 11 =A0pixel data is displayed to bo=
th eyes
> - =A0 =A0 =A0 =A0* Bits [1:0] =3D 10 =A0pixel data is routed to the l=
eft eye only.
> - =A0 =A0 =A0 =A0* Bits [1:0] =3D 01 =A0pixel data is routed to the r=
ight eye only.
> - =A0 =A0 =A0 =A0* Bits [1:0] =3D 00 =A0pixel data is routed to the a=
lternate display.
> - =A0 =A0 =A0 =A0* Bit 2 is 0 =A0Pixel Data is in the standard progre=
ssive format.
> - =A0 =A0 =A0 =A0* Bit 2 is 1 =A0Pixel Data is in interlace format.
> - =A0 =A0 =A0 =A0* Bit 3 is 0 =A0Pixel Data is in the standard progre=
ssive format.
> - =A0 =A0 =A0 =A0* Bit 3 is 1 =A0Pixel Data is in alternate pixel for=
mat.
> - =A0 =A0 =A0 =A0* Bit 4 is 0 =A0Pixel Data is to or from the display=
 frame buffer.
> - =A0 =A0 =A0 =A0* Bit 4 is 1 =A0Pixel Data is to or from the camera.
> - =A0 =A0 =A0 =A0* Bit 5 is 0 =A0pixel data contains the next consecu=
tive row of pixels.
> - =A0 =A0 =A0 =A0* Bit 5 is 1 =A0X Left Edge, Y Top Edge, X Right Edg=
e, Y Bottom Edge,
> - =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 X Start, and Y Start param=
eters are not defined and
> - =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0 =A0 =A0 shall be ignored by the cl=
ient.
> - =A0 =A0 =A0 =A0* Bits [7:6] =3D 01 =A0Pixel data is written to the =
offline image buffer.
> - =A0 =A0 =A0 =A0* Bits [7:6] =3D 00 =A0Pixel data is written to the =
buffer to refresh display.
> - =A0 =A0 =A0 =A0* Bits [7:6] =3D 11 =A0Pixel data is written to all =
image buffers.
> - =A0 =A0 =A0 =A0* Bits [7:6] =3D 10 =A0Invalid. Reserved for future =
use.
> - =A0 =A0 =A0 =A0* Bits 8 through 11 alternate display number.
> - =A0 =A0 =A0 =A0* Bits 12 through 14 are reserved for future use and=
 shall be set to zero.
> - =A0 =A0 =A0 =A0* Bit 15 is 1 the row of pixels is the last row of p=
ixels in a frame.
> - =A0 =A0 =A0 =A0*/
> +/* interpreted as follows:
> + * Bits [1:0] =3D 11 =A0pixel data is displayed to both eyes
> + * Bits [1:0] =3D 10 =A0pixel data is routed to the left eye only.
> + * Bits [1:0] =3D 01 =A0pixel data is routed to the right eye only.
> + * Bits [1:0] =3D 00 =A0pixel data is routed to the alternate displa=
y.
> + * Bit 2 is 0 =A0Pixel Data is in the standard progressive format.
> + * Bit 2 is 1 =A0Pixel Data is in interlace format.
> + * Bit 3 is 0 =A0Pixel Data is in the standard progressive format.
> + * Bit 3 is 1 =A0Pixel Data is in alternate pixel format.
> + * Bit 4 is 0 =A0Pixel Data is to or from the display frame buffer.
> + * Bit 4 is 1 =A0Pixel Data is to or from the camera.
> + * Bit 5 is 0 =A0pixel data contains the next consecutive row of pix=
els.
> + * Bit 5 is 1 =A0X Left Edge, Y Top Edge, X Right Edge, Y Bottom Edg=
e,
> + * =A0 =A0 =A0 =A0 =A0 =A0 X Start, and Y Start parameters are not d=
efined and
> + * =A0 =A0 =A0 =A0 =A0 =A0 shall be ignored by the client.
> + * Bits [7:6] =3D 01 =A0Pixel data is written to the offline image b=
uffer.
> + * Bits [7:6] =3D 00 =A0Pixel data is written to the buffer to refre=
sh display.
> + * Bits [7:6] =3D 11 =A0Pixel data is written to all image buffers.
> + * Bits [7:6] =3D 10 =A0Invalid. Reserved for future use.
> + * Bits 8 through 11 alternate display number.
> + * Bits 12 through 14 are reserved for future use and shall be set t=
o zero.
> + * Bit 15 is 1 the row of pixels is the last row of pixels in a fram=
e.
> + */
>
> =A0 =A0 =A0 =A0uint16_t x_left_edge;
> =A0 =A0 =A0 =A0uint16_t y_top_edge;
> @@ -239,17 +239,19 @@ struct __attribute__((packed)) mddi_video_strea=
m {
>
> =A0 =A0 =A0 =A0uint16_t x_right_edge;
> =A0 =A0 =A0 =A0uint16_t y_bottom_edge;
> - =A0 =A0 =A0 /* =A0X,Y coordinate of the bottom right edge of the wi=
ndow being updated. */
> + =A0 =A0 =A0 /* X,Y coordinate of the bottom right edge of the windo=
w being
> + =A0 =A0 =A0 =A0* updated. */
>
> =A0 =A0 =A0 =A0uint16_t x_start;
> =A0 =A0 =A0 =A0uint16_t y_start;
> - =A0 =A0 =A0 /* =A0(X Start, Y Start) is the first pixel in the Pixe=
l Data field below. */
> + =A0 =A0 =A0 /* (X Start, Y Start) is the first pixel in the Pixel D=
ata field
> + =A0 =A0 =A0 =A0* below. */
>
> =A0 =A0 =A0 =A0uint16_t pixel_count;
> - =A0 =A0 =A0 /* =A0number of pixels in the Pixel Data field below. *=
/
> + =A0 =A0 =A0 /* number of pixels in the Pixel Data field below. */
>
> =A0 =A0 =A0 =A0uint16_t parameter_CRC;
> - =A0 =A0 =A0 /* =A016-bit CRC of all bytes from the Packet Length to=
 the Pixel Count. */
> + =A0 =A0 =A0 /* 16-bit CRC of all bytes from the Packet Length to th=
e Pixel Count. */
>
> =A0 =A0 =A0 =A0uint16_t reserved;
> =A0 =A0 =A0 =A0/* 16-bit variable to make structure align on 4 byte b=
oundary */
> diff --git a/drivers/video/msm/mdp_hw.h b/drivers/video/msm/mdp_hw.h
> index d78dafa..4e3deb4 100644
> --- a/drivers/video/msm/mdp_hw.h
> +++ b/drivers/video/msm/mdp_hw.h
> @@ -20,7 +20,7 @@
>
> =A0struct mdp_info {
> =A0 =A0 =A0 =A0struct mdp_device mdp_dev;
> - =A0 =A0 =A0 char* __iomem base;
> + =A0 =A0 =A0 char * __iomem base;
> =A0 =A0 =A0 =A0int irq;
> =A0};
> =A0struct mdp_blit_req;
> @@ -32,149 +32,149 @@ int mdp_ppp_blit(const struct mdp_info *mdp, st=
ruct mdp_blit_req *req,
> =A0#define mdp_writel(mdp, value, offset) writel(value, mdp->base + o=
ffset)
> =A0#define mdp_readl(mdp, offset) readl(mdp->base + offset)
>
> -#define MDP_SYNC_CONFIG_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00000)
> -#define MDP_SYNC_CONFIG_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00004)
> -#define MDP_SYNC_CONFIG_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00008)
> -#define MDP_SYNC_STATUS_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x0000c)
> -#define MDP_SYNC_STATUS_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00010)
> -#define MDP_SYNC_STATUS_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00014)
> -#define MDP_SYNC_THRESH_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00018)
> -#define MDP_SYNC_THRESH_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x0001c)
> -#define MDP_INTR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00020=
)
> -#define MDP_INTR_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00024=
)
> -#define MDP_INTR_CLEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x00028=
)
> -#define MDP_DISPLAY0_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x00030)
> -#define MDP_DISPLAY1_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x00034)
> -#define MDP_DISPLAY_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x00038)
> -#define MDP_EBI2_LCD0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x000=
3c)
> -#define MDP_EBI2_LCD1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x000=
40)
> -#define MDP_DISPLAY0_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00054)
> -#define MDP_DISPLAY1_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00058)
> -#define MDP_EBI2_PORTMAP_MODE =A0 =A0 =A0 =A0 =A0 =A0( 0x0005c)
> -#define MDP_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0=
x00060)
> -#define MDP_TV_OUT_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x00064)
> -#define MDP_HW_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x00070=
)
> -#define MDP_SW_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x000=
74)
> -#define MDP_AXI_ERROR_MASTER_STOP =A0 =A0 =A0 =A0( 0x00078)
> -#define MDP_SEL_CLK_OR_HCLK_TEST_BUS =A0 =A0 ( 0x0007c)
> -#define MDP_PRIMARY_VSYNC_OUT_CTRL =A0 =A0 =A0 ( 0x00080)
> -#define MDP_SECONDARY_VSYNC_OUT_CTRL =A0 =A0 ( 0x00084)
> -#define MDP_EXTERNAL_VSYNC_OUT_CTRL =A0 =A0 =A0( 0x00088)
> -#define MDP_VSYNC_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x0008c=
)
> -#define MDP_CGC_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x0=
0100)
> -#define MDP_CMD_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x10008=
)
> -#define MDP_PROFILE_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x10010=
)
> -#define MDP_PROFILE_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x10014)
> -#define MDP_DMA_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x100=
44)
> -#define MDP_FULL_BYPASS_WORD0 =A0 =A0 =A0 =A0 =A0 =A0( 0x10100)
> -#define MDP_FULL_BYPASS_WORD1 =A0 =A0 =A0 =A0 =A0 =A0( 0x10104)
> -#define MDP_COMMAND_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x10104)
> -#define MDP_FULL_BYPASS_WORD2 =A0 =A0 =A0 =A0 =A0 =A0( 0x10108)
> -#define MDP_FULL_BYPASS_WORD3 =A0 =A0 =A0 =A0 =A0 =A0( 0x1010c)
> -#define MDP_FULL_BYPASS_WORD4 =A0 =A0 =A0 =A0 =A0 =A0( 0x10110)
> -#define MDP_FULL_BYPASS_WORD6 =A0 =A0 =A0 =A0 =A0 =A0( 0x10118)
> -#define MDP_FULL_BYPASS_WORD7 =A0 =A0 =A0 =A0 =A0 =A0( 0x1011c)
> -#define MDP_FULL_BYPASS_WORD8 =A0 =A0 =A0 =A0 =A0 =A0( 0x10120)
> -#define MDP_FULL_BYPASS_WORD9 =A0 =A0 =A0 =A0 =A0 =A0( 0x10124)
> -#define MDP_PPP_SOURCE_CONFIG =A0 =A0 =A0 =A0 =A0 =A0( 0x10124)
> -#define MDP_FULL_BYPASS_WORD10 =A0 =A0 =A0 =A0 =A0 ( 0x10128)
> -#define MDP_FULL_BYPASS_WORD11 =A0 =A0 =A0 =A0 =A0 ( 0x1012c)
> -#define MDP_FULL_BYPASS_WORD12 =A0 =A0 =A0 =A0 =A0 ( 0x10130)
> -#define MDP_FULL_BYPASS_WORD13 =A0 =A0 =A0 =A0 =A0 ( 0x10134)
> -#define MDP_FULL_BYPASS_WORD14 =A0 =A0 =A0 =A0 =A0 ( 0x10138)
> -#define MDP_PPP_OPERATION_CONFIG =A0 =A0 =A0 =A0 ( 0x10138)
> -#define MDP_FULL_BYPASS_WORD15 =A0 =A0 =A0 =A0 =A0 ( 0x1013c)
> -#define MDP_FULL_BYPASS_WORD16 =A0 =A0 =A0 =A0 =A0 ( 0x10140)
> -#define MDP_FULL_BYPASS_WORD17 =A0 =A0 =A0 =A0 =A0 ( 0x10144)
> -#define MDP_FULL_BYPASS_WORD18 =A0 =A0 =A0 =A0 =A0 ( 0x10148)
> -#define MDP_FULL_BYPASS_WORD19 =A0 =A0 =A0 =A0 =A0 ( 0x1014c)
> -#define MDP_FULL_BYPASS_WORD20 =A0 =A0 =A0 =A0 =A0 ( 0x10150)
> -#define MDP_PPP_DESTINATION_CONFIG =A0 =A0 =A0 ( 0x10150)
> -#define MDP_FULL_BYPASS_WORD21 =A0 =A0 =A0 =A0 =A0 ( 0x10154)
> -#define MDP_FULL_BYPASS_WORD22 =A0 =A0 =A0 =A0 =A0 ( 0x10158)
> -#define MDP_FULL_BYPASS_WORD23 =A0 =A0 =A0 =A0 =A0 ( 0x1015c)
> -#define MDP_FULL_BYPASS_WORD24 =A0 =A0 =A0 =A0 =A0 ( 0x10160)
> -#define MDP_FULL_BYPASS_WORD25 =A0 =A0 =A0 =A0 =A0 ( 0x10164)
> -#define MDP_FULL_BYPASS_WORD26 =A0 =A0 =A0 =A0 =A0 ( 0x10168)
> -#define MDP_FULL_BYPASS_WORD27 =A0 =A0 =A0 =A0 =A0 ( 0x1016c)
> -#define MDP_FULL_BYPASS_WORD29 =A0 =A0 =A0 =A0 =A0 ( 0x10174)
> -#define MDP_FULL_BYPASS_WORD30 =A0 =A0 =A0 =A0 =A0 ( 0x10178)
> -#define MDP_FULL_BYPASS_WORD31 =A0 =A0 =A0 =A0 =A0 ( 0x1017c)
> -#define MDP_FULL_BYPASS_WORD32 =A0 =A0 =A0 =A0 =A0 ( 0x10180)
> -#define MDP_DMA_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x10180=
)
> -#define MDP_FULL_BYPASS_WORD33 =A0 =A0 =A0 =A0 =A0 ( 0x10184)
> -#define MDP_FULL_BYPASS_WORD34 =A0 =A0 =A0 =A0 =A0 ( 0x10188)
> -#define MDP_FULL_BYPASS_WORD35 =A0 =A0 =A0 =A0 =A0 ( 0x1018c)
> -#define MDP_FULL_BYPASS_WORD37 =A0 =A0 =A0 =A0 =A0 ( 0x10194)
> -#define MDP_FULL_BYPASS_WORD39 =A0 =A0 =A0 =A0 =A0 ( 0x1019c)
> -#define MDP_FULL_BYPASS_WORD40 =A0 =A0 =A0 =A0 =A0 ( 0x101a0)
> -#define MDP_FULL_BYPASS_WORD41 =A0 =A0 =A0 =A0 =A0 ( 0x101a4)
> -#define MDP_FULL_BYPASS_WORD43 =A0 =A0 =A0 =A0 =A0 ( 0x101ac)
> -#define MDP_FULL_BYPASS_WORD46 =A0 =A0 =A0 =A0 =A0 ( 0x101b8)
> -#define MDP_FULL_BYPASS_WORD47 =A0 =A0 =A0 =A0 =A0 ( 0x101bc)
> -#define MDP_FULL_BYPASS_WORD48 =A0 =A0 =A0 =A0 =A0 ( 0x101c0)
> -#define MDP_FULL_BYPASS_WORD49 =A0 =A0 =A0 =A0 =A0 ( 0x101c4)
> -#define MDP_FULL_BYPASS_WORD50 =A0 =A0 =A0 =A0 =A0 ( 0x101c8)
> -#define MDP_FULL_BYPASS_WORD51 =A0 =A0 =A0 =A0 =A0 ( 0x101cc)
> -#define MDP_FULL_BYPASS_WORD52 =A0 =A0 =A0 =A0 =A0 ( 0x101d0)
> -#define MDP_FULL_BYPASS_WORD53 =A0 =A0 =A0 =A0 =A0 ( 0x101d4)
> -#define MDP_FULL_BYPASS_WORD54 =A0 =A0 =A0 =A0 =A0 ( 0x101d8)
> -#define MDP_FULL_BYPASS_WORD55 =A0 =A0 =A0 =A0 =A0 ( 0x101dc)
> -#define MDP_FULL_BYPASS_WORD56 =A0 =A0 =A0 =A0 =A0 ( 0x101e0)
> -#define MDP_FULL_BYPASS_WORD57 =A0 =A0 =A0 =A0 =A0 ( 0x101e4)
> -#define MDP_FULL_BYPASS_WORD58 =A0 =A0 =A0 =A0 =A0 ( 0x101e8)
> -#define MDP_FULL_BYPASS_WORD59 =A0 =A0 =A0 =A0 =A0 ( 0x101ec)
> -#define MDP_FULL_BYPASS_WORD60 =A0 =A0 =A0 =A0 =A0 ( 0x101f0)
> -#define MDP_VSYNC_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x101f0)
> -#define MDP_FULL_BYPASS_WORD61 =A0 =A0 =A0 =A0 =A0 ( 0x101f4)
> -#define MDP_FULL_BYPASS_WORD62 =A0 =A0 =A0 =A0 =A0 ( 0x101f8)
> -#define MDP_FULL_BYPASS_WORD63 =A0 =A0 =A0 =A0 =A0 ( 0x101fc)
> -#define MDP_TFETCH_TEST_MODE =A0 =A0 =A0 =A0 =A0 =A0 ( 0x20004)
> -#define MDP_TFETCH_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x20008)
> -#define MDP_TFETCH_TILE_COUNT =A0 =A0 =A0 =A0 =A0 =A0( 0x20010)
> -#define MDP_TFETCH_FETCH_COUNT =A0 =A0 =A0 =A0 =A0 ( 0x20014)
> -#define MDP_TFETCH_CONSTANT_COLOR =A0 =A0 =A0 =A0( 0x20040)
> -#define MDP_CSC_BYPASS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0x40004=
)
> -#define MDP_SCALE_COEFF_LSB =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0x5fffc)
> -#define MDP_TV_OUT_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xc0000=
)
> -#define MDP_TV_OUT_FIR_COEFF =A0 =A0 =A0 =A0 =A0 =A0 ( 0xc0004)
> -#define MDP_TV_OUT_BUF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xc0008)
> -#define MDP_TV_OUT_CC_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xc000c)
> -#define MDP_TV_OUT_SOBEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xc0010)
> -#define MDP_TV_OUT_Y_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xc0018)
> -#define MDP_TV_OUT_CB_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xc001c)
> -#define MDP_TV_OUT_CR_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xc0020)
> -#define MDP_TEST_MODE_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xd0000)
> -#define MDP_TEST_MISR_RESET_CLK =A0 =A0 =A0 =A0 =A0( 0xd0004)
> -#define MDP_TEST_EXPORT_MISR_CLK =A0 =A0 =A0 =A0 ( 0xd0008)
> -#define MDP_TEST_MISR_CURR_VAL_CLK =A0 =A0 =A0 ( 0xd000c)
> -#define MDP_TEST_MODE_HCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xd0100)
> -#define MDP_TEST_MISR_RESET_HCLK =A0 =A0 =A0 =A0 ( 0xd0104)
> -#define MDP_TEST_EXPORT_MISR_HCLK =A0 =A0 =A0 =A0( 0xd0108)
> -#define MDP_TEST_MISR_CURR_VAL_HCLK =A0 =A0 =A0( 0xd010c)
> -#define MDP_TEST_MODE_DCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xd0200)
> -#define MDP_TEST_MISR_RESET_DCLK =A0 =A0 =A0 =A0 ( 0xd0204)
> -#define MDP_TEST_EXPORT_MISR_DCLK =A0 =A0 =A0 =A0( 0xd0208)
> -#define MDP_TEST_MISR_CURR_VAL_DCLK =A0 =A0 =A0( 0xd020c)
> -#define MDP_TEST_CAPTURED_DCLK =A0 =A0 =A0 =A0 =A0 ( 0xd0210)
> -#define MDP_TEST_MISR_CAPT_VAL_DCLK =A0 =A0 =A0( 0xd0214)
> -#define MDP_LCDC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe00=
00)
> -#define MDP_LCDC_HSYNC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe0004)
> -#define MDP_LCDC_VSYNC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe0008)
> -#define MDP_LCDC_ACTIVE_HCTL =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe000c)
> -#define MDP_LCDC_ACTIVE_VCTL =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe0010)
> -#define MDP_LCDC_BORDER_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe0014)
> -#define MDP_LCDC_H_BLANK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe0018)
> -#define MDP_LCDC_V_BLANK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 0xe001c)
> -#define MDP_LCDC_UNDERFLOW_CLR =A0 =A0 =A0 =A0 =A0 ( 0xe0020)
> -#define MDP_LCDC_HSYNC_SKEW =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe0024)
> -#define MDP_LCDC_TEST_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe0028)
> -#define MDP_LCDC_LINE_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe002c)
> -#define MDP_LCDC_CTL_POLARITY =A0 =A0 =A0 =A0 =A0 =A0( 0xe0030)
> -#define MDP_LCDC_DMA_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe1000)
> -#define MDP_LCDC_DMA_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( 0xe1004)
> -#define MDP_LCDC_DMA_IBUF_ADDR =A0 =A0 =A0 =A0 =A0 ( 0xe1008)
> -#define MDP_LCDC_DMA_IBUF_Y_STRIDE =A0 =A0 =A0 ( 0xe100c)
> +#define MDP_SYNC_CONFIG_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00000)
> +#define MDP_SYNC_CONFIG_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00004)
> +#define MDP_SYNC_CONFIG_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00008)
> +#define MDP_SYNC_STATUS_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0000c)
> +#define MDP_SYNC_STATUS_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00010)
> +#define MDP_SYNC_STATUS_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00014)
> +#define MDP_SYNC_THRESH_0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00018)
> +#define MDP_SYNC_THRESH_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0001c)
> +#define MDP_INTR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00020)
> +#define MDP_INTR_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00024)
> +#define MDP_INTR_CLEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00028)
> +#define MDP_DISPLAY0_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00030)
> +#define MDP_DISPLAY1_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00034)
> +#define MDP_DISPLAY_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00038)
> +#define MDP_EBI2_LCD0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0003=
c)
> +#define MDP_EBI2_LCD1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0004=
0)
> +#define MDP_DISPLAY0_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00054)
> +#define MDP_DISPLAY1_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00058)
> +#define MDP_EBI2_PORTMAP_MODE =A0 =A0 =A0 =A0 =A0 =A0(0x0005c)
> +#define MDP_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x=
00060)
> +#define MDP_TV_OUT_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00064)
> +#define MDP_HW_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00070)
> +#define MDP_SW_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0007=
4)
> +#define MDP_AXI_ERROR_MASTER_STOP =A0 =A0 =A0 =A0(0x00078)
> +#define MDP_SEL_CLK_OR_HCLK_TEST_BUS =A0 =A0 (0x0007c)
> +#define MDP_PRIMARY_VSYNC_OUT_CTRL =A0 =A0 =A0 (0x00080)
> +#define MDP_SECONDARY_VSYNC_OUT_CTRL =A0 =A0 (0x00084)
> +#define MDP_EXTERNAL_VSYNC_OUT_CTRL =A0 =A0 =A0(0x00088)
> +#define MDP_VSYNC_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0008c)
> +#define MDP_CGC_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x00=
100)
> +#define MDP_CMD_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10008)
> +#define MDP_PROFILE_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10010)
> +#define MDP_PROFILE_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x10014)
> +#define MDP_DMA_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1004=
4)
> +#define MDP_FULL_BYPASS_WORD0 =A0 =A0 =A0 =A0 =A0 =A0(0x10100)
> +#define MDP_FULL_BYPASS_WORD1 =A0 =A0 =A0 =A0 =A0 =A0(0x10104)
> +#define MDP_COMMAND_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10104)
> +#define MDP_FULL_BYPASS_WORD2 =A0 =A0 =A0 =A0 =A0 =A0(0x10108)
> +#define MDP_FULL_BYPASS_WORD3 =A0 =A0 =A0 =A0 =A0 =A0(0x1010c)
> +#define MDP_FULL_BYPASS_WORD4 =A0 =A0 =A0 =A0 =A0 =A0(0x10110)
> +#define MDP_FULL_BYPASS_WORD6 =A0 =A0 =A0 =A0 =A0 =A0(0x10118)
> +#define MDP_FULL_BYPASS_WORD7 =A0 =A0 =A0 =A0 =A0 =A0(0x1011c)
> +#define MDP_FULL_BYPASS_WORD8 =A0 =A0 =A0 =A0 =A0 =A0(0x10120)
> +#define MDP_FULL_BYPASS_WORD9 =A0 =A0 =A0 =A0 =A0 =A0(0x10124)
> +#define MDP_PPP_SOURCE_CONFIG =A0 =A0 =A0 =A0 =A0 =A0(0x10124)
> +#define MDP_FULL_BYPASS_WORD10 =A0 =A0 =A0 =A0 =A0 (0x10128)
> +#define MDP_FULL_BYPASS_WORD11 =A0 =A0 =A0 =A0 =A0 (0x1012c)
> +#define MDP_FULL_BYPASS_WORD12 =A0 =A0 =A0 =A0 =A0 (0x10130)
> +#define MDP_FULL_BYPASS_WORD13 =A0 =A0 =A0 =A0 =A0 (0x10134)
> +#define MDP_FULL_BYPASS_WORD14 =A0 =A0 =A0 =A0 =A0 (0x10138)
> +#define MDP_PPP_OPERATION_CONFIG =A0 =A0 =A0 =A0 (0x10138)
> +#define MDP_FULL_BYPASS_WORD15 =A0 =A0 =A0 =A0 =A0 (0x1013c)
> +#define MDP_FULL_BYPASS_WORD16 =A0 =A0 =A0 =A0 =A0 (0x10140)
> +#define MDP_FULL_BYPASS_WORD17 =A0 =A0 =A0 =A0 =A0 (0x10144)
> +#define MDP_FULL_BYPASS_WORD18 =A0 =A0 =A0 =A0 =A0 (0x10148)
> +#define MDP_FULL_BYPASS_WORD19 =A0 =A0 =A0 =A0 =A0 (0x1014c)
> +#define MDP_FULL_BYPASS_WORD20 =A0 =A0 =A0 =A0 =A0 (0x10150)
> +#define MDP_PPP_DESTINATION_CONFIG =A0 =A0 =A0 (0x10150)
> +#define MDP_FULL_BYPASS_WORD21 =A0 =A0 =A0 =A0 =A0 (0x10154)
> +#define MDP_FULL_BYPASS_WORD22 =A0 =A0 =A0 =A0 =A0 (0x10158)
> +#define MDP_FULL_BYPASS_WORD23 =A0 =A0 =A0 =A0 =A0 (0x1015c)
> +#define MDP_FULL_BYPASS_WORD24 =A0 =A0 =A0 =A0 =A0 (0x10160)
> +#define MDP_FULL_BYPASS_WORD25 =A0 =A0 =A0 =A0 =A0 (0x10164)
> +#define MDP_FULL_BYPASS_WORD26 =A0 =A0 =A0 =A0 =A0 (0x10168)
> +#define MDP_FULL_BYPASS_WORD27 =A0 =A0 =A0 =A0 =A0 (0x1016c)
> +#define MDP_FULL_BYPASS_WORD29 =A0 =A0 =A0 =A0 =A0 (0x10174)
> +#define MDP_FULL_BYPASS_WORD30 =A0 =A0 =A0 =A0 =A0 (0x10178)
> +#define MDP_FULL_BYPASS_WORD31 =A0 =A0 =A0 =A0 =A0 (0x1017c)
> +#define MDP_FULL_BYPASS_WORD32 =A0 =A0 =A0 =A0 =A0 (0x10180)
> +#define MDP_DMA_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10180)
> +#define MDP_FULL_BYPASS_WORD33 =A0 =A0 =A0 =A0 =A0 (0x10184)
> +#define MDP_FULL_BYPASS_WORD34 =A0 =A0 =A0 =A0 =A0 (0x10188)
> +#define MDP_FULL_BYPASS_WORD35 =A0 =A0 =A0 =A0 =A0 (0x1018c)
> +#define MDP_FULL_BYPASS_WORD37 =A0 =A0 =A0 =A0 =A0 (0x10194)
> +#define MDP_FULL_BYPASS_WORD39 =A0 =A0 =A0 =A0 =A0 (0x1019c)
> +#define MDP_FULL_BYPASS_WORD40 =A0 =A0 =A0 =A0 =A0 (0x101a0)
> +#define MDP_FULL_BYPASS_WORD41 =A0 =A0 =A0 =A0 =A0 (0x101a4)
> +#define MDP_FULL_BYPASS_WORD43 =A0 =A0 =A0 =A0 =A0 (0x101ac)
> +#define MDP_FULL_BYPASS_WORD46 =A0 =A0 =A0 =A0 =A0 (0x101b8)
> +#define MDP_FULL_BYPASS_WORD47 =A0 =A0 =A0 =A0 =A0 (0x101bc)
> +#define MDP_FULL_BYPASS_WORD48 =A0 =A0 =A0 =A0 =A0 (0x101c0)
> +#define MDP_FULL_BYPASS_WORD49 =A0 =A0 =A0 =A0 =A0 (0x101c4)
> +#define MDP_FULL_BYPASS_WORD50 =A0 =A0 =A0 =A0 =A0 (0x101c8)
> +#define MDP_FULL_BYPASS_WORD51 =A0 =A0 =A0 =A0 =A0 (0x101cc)
> +#define MDP_FULL_BYPASS_WORD52 =A0 =A0 =A0 =A0 =A0 (0x101d0)
> +#define MDP_FULL_BYPASS_WORD53 =A0 =A0 =A0 =A0 =A0 (0x101d4)
> +#define MDP_FULL_BYPASS_WORD54 =A0 =A0 =A0 =A0 =A0 (0x101d8)
> +#define MDP_FULL_BYPASS_WORD55 =A0 =A0 =A0 =A0 =A0 (0x101dc)
> +#define MDP_FULL_BYPASS_WORD56 =A0 =A0 =A0 =A0 =A0 (0x101e0)
> +#define MDP_FULL_BYPASS_WORD57 =A0 =A0 =A0 =A0 =A0 (0x101e4)
> +#define MDP_FULL_BYPASS_WORD58 =A0 =A0 =A0 =A0 =A0 (0x101e8)
> +#define MDP_FULL_BYPASS_WORD59 =A0 =A0 =A0 =A0 =A0 (0x101ec)
> +#define MDP_FULL_BYPASS_WORD60 =A0 =A0 =A0 =A0 =A0 (0x101f0)
> +#define MDP_VSYNC_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x101f0)
> +#define MDP_FULL_BYPASS_WORD61 =A0 =A0 =A0 =A0 =A0 (0x101f4)
> +#define MDP_FULL_BYPASS_WORD62 =A0 =A0 =A0 =A0 =A0 (0x101f8)
> +#define MDP_FULL_BYPASS_WORD63 =A0 =A0 =A0 =A0 =A0 (0x101fc)
> +#define MDP_TFETCH_TEST_MODE =A0 =A0 =A0 =A0 =A0 =A0 (0x20004)
> +#define MDP_TFETCH_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x20008)
> +#define MDP_TFETCH_TILE_COUNT =A0 =A0 =A0 =A0 =A0 =A0(0x20010)
> +#define MDP_TFETCH_FETCH_COUNT =A0 =A0 =A0 =A0 =A0 (0x20014)
> +#define MDP_TFETCH_CONSTANT_COLOR =A0 =A0 =A0 =A0(0x20040)
> +#define MDP_CSC_BYPASS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x40004)
> +#define MDP_SCALE_COEFF_LSB =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x5fffc)
> +#define MDP_TV_OUT_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xc0000)
> +#define MDP_TV_OUT_FIR_COEFF =A0 =A0 =A0 =A0 =A0 =A0 (0xc0004)
> +#define MDP_TV_OUT_BUF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xc0008)
> +#define MDP_TV_OUT_CC_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xc000c)
> +#define MDP_TV_OUT_SOBEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xc0010)
> +#define MDP_TV_OUT_Y_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xc0018)
> +#define MDP_TV_OUT_CB_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xc001c)
> +#define MDP_TV_OUT_CR_CLAMP =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xc0020)
> +#define MDP_TEST_MODE_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xd0000)
> +#define MDP_TEST_MISR_RESET_CLK =A0 =A0 =A0 =A0 =A0(0xd0004)
> +#define MDP_TEST_EXPORT_MISR_CLK =A0 =A0 =A0 =A0 (0xd0008)
> +#define MDP_TEST_MISR_CURR_VAL_CLK =A0 =A0 =A0 (0xd000c)
> +#define MDP_TEST_MODE_HCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xd0100)
> +#define MDP_TEST_MISR_RESET_HCLK =A0 =A0 =A0 =A0 (0xd0104)
> +#define MDP_TEST_EXPORT_MISR_HCLK =A0 =A0 =A0 =A0(0xd0108)
> +#define MDP_TEST_MISR_CURR_VAL_HCLK =A0 =A0 =A0(0xd010c)
> +#define MDP_TEST_MODE_DCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xd0200)
> +#define MDP_TEST_MISR_RESET_DCLK =A0 =A0 =A0 =A0 (0xd0204)
> +#define MDP_TEST_EXPORT_MISR_DCLK =A0 =A0 =A0 =A0(0xd0208)
> +#define MDP_TEST_MISR_CURR_VAL_DCLK =A0 =A0 =A0(0xd020c)
> +#define MDP_TEST_CAPTURED_DCLK =A0 =A0 =A0 =A0 =A0 (0xd0210)
> +#define MDP_TEST_MISR_CAPT_VAL_DCLK =A0 =A0 =A0(0xd0214)
> +#define MDP_LCDC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xe000=
0)
> +#define MDP_LCDC_HSYNC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xe0004)
> +#define MDP_LCDC_VSYNC_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xe0008)
> +#define MDP_LCDC_ACTIVE_HCTL =A0 =A0 =A0 =A0 =A0 =A0 (0xe000c)
> +#define MDP_LCDC_ACTIVE_VCTL =A0 =A0 =A0 =A0 =A0 =A0 (0xe0010)
> +#define MDP_LCDC_BORDER_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe0014)
> +#define MDP_LCDC_H_BLANK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xe0018)
> +#define MDP_LCDC_V_BLANK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xe001c)
> +#define MDP_LCDC_UNDERFLOW_CLR =A0 =A0 =A0 =A0 =A0 (0xe0020)
> +#define MDP_LCDC_HSYNC_SKEW =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe0024)
> +#define MDP_LCDC_TEST_CTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe0028)
> +#define MDP_LCDC_LINE_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe002c)
> +#define MDP_LCDC_CTL_POLARITY =A0 =A0 =A0 =A0 =A0 =A0(0xe0030)
> +#define MDP_LCDC_DMA_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe1000)
> +#define MDP_LCDC_DMA_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xe1004)
> +#define MDP_LCDC_DMA_IBUF_ADDR =A0 =A0 =A0 =A0 =A0 (0xe1008)
> +#define MDP_LCDC_DMA_IBUF_Y_STRIDE =A0 =A0 =A0 (0xe100c)
>
>
> =A0#define MDP_DMA2_TERM 0x1
> @@ -246,11 +246,11 @@ int mdp_ppp_blit(const struct mdp_info *mdp, st=
ruct mdp_blit_req *req,
> =A0/* MDP_VSYNC_CTRL */
> =A0#define DISP0_VSYNC_MAP_VSYNC0 0
> =A0#define DISP0_VSYNC_MAP_VSYNC1 (1<<0)
> -#define DISP0_VSYNC_MAP_VSYNC2 (1<<0)|(1<<1)
> +#define DISP0_VSYNC_MAP_VSYNC2 ((1<<0)|(1<<1))
>
> =A0#define DISP1_VSYNC_MAP_VSYNC0 0
> =A0#define DISP1_VSYNC_MAP_VSYNC1 (1<<2)
> -#define DISP1_VSYNC_MAP_VSYNC2 (1<<2)|(1<<3)
> +#define DISP1_VSYNC_MAP_VSYNC2 ((1<<2)|(1<<3))
>
> =A0#define PRIMARY_LCD_SYNC_EN (1<<4)
> =A0#define PRIMARY_LCD_SYNC_DISABLE 0
> @@ -368,7 +368,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
> =A0#define PPP_OP_BG_CHROMA_RGB 0
> =A0#define PPP_OP_BG_CHROMA_H2V1 (1<<25)
> =A0#define PPP_OP_BG_CHROMA_H1V2 (1<<26)
> -#define PPP_OP_BG_CHROMA_420 (1<<25)|(1<<26)
> +#define PPP_OP_BG_CHROMA_420 ((1<<25)|(1<<26))
> =A0#define PPP_OP_BG_CHROMA_SITE_COSITE 0
> =A0#define PPP_OP_BG_CHROMA_SITE_OFFSITE (1<<27)
>
> @@ -417,25 +417,25 @@ int mdp_ppp_blit(const struct mdp_info *mdp, st=
ruct mdp_blit_req *req,
> =A0#define PPP_DST_MDDI_EXTERNAL (1<<22)
>
> =A0/* image configurations by image type */
> -#define PPP_CFG_MDP_RGB_565(dir) =A0 =A0 =A0 PPP_##dir##_C2R_5BIT | =
\
> +#define PPP_CFG_MDP_RGB_565(dir) =A0 =A0 =A0 (PPP_##dir##_C2R_5BIT |=
 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_6BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_5BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_BPP_2BYTES | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_3COMPONENTS | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD)
>
> -#define PPP_CFG_MDP_RGB_888(dir) =A0 =A0 =A0 PPP_##dir##_C2R_8BIT | =
\
> +#define PPP_CFG_MDP_RGB_888(dir) =A0 =A0 =A0 (PPP_##dir##_C2R_8BIT |=
 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_BPP_3BYTES | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_3COMPONENTS | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD)
>
> -#define PPP_CFG_MDP_ARGB_8888(dir) =A0 =A0 PPP_##dir##_C2R_8BIT | \
> +#define PPP_CFG_MDP_ARGB_8888(dir) =A0 =A0 (PPP_##dir##_C2R_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C3A_8BIT | \
> @@ -444,13 +444,13 @@ int mdp_ppp_blit(const struct mdp_info *mdp, st=
ruct mdp_blit_req *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_4COMPONENTS | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD)
>
> =A0#define PPP_CFG_MDP_XRGB_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
> =A0#define PPP_CFG_MDP_RGBA_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
> =A0#define PPP_CFG_MDP_BGRA_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
>
> -#define PPP_CFG_MDP_Y_CBCR_H2V2(dir) =A0 PPP_##dir##_C2R_8BIT | \
> +#define PPP_CFG_MDP_Y_CBCR_H2V2(dir) =A0 (PPP_##dir##_C2R_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C3A_8BIT | \
> @@ -458,11 +458,11 @@ int mdp_ppp_blit(const struct mdp_info *mdp, st=
ruct mdp_blit_req *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_2COMPONENTS | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_PSEUDOPLNR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_PSEUDOPLNR)
>
> =A0#define PPP_CFG_MDP_Y_CRCB_H2V2(dir) =A0 PPP_CFG_MDP_Y_CBCR_H2V2(d=
ir)
>
> -#define PPP_CFG_MDP_YCRYCB_H2V1(dir) =A0 PPP_##dir##_C2R_8BIT | \
> +#define PPP_CFG_MDP_YCRYCB_H2V1(dir) =A0 (PPP_##dir##_C2R_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C3A_8BIT | \
> @@ -470,9 +470,9 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_4COMPONENTS | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB |\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_INTERLVD)
>
> -#define PPP_CFG_MDP_Y_CBCR_H2V1(dir) =A0 PPP_##dir##_C2R_8BIT | \
> +#define PPP_CFG_MDP_Y_CBCR_H2V1(dir) =A0 (PPP_##dir##_C2R_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C0G_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C1B_8BIT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_C3A_8BIT | \
> @@ -480,7 +480,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_INTERLVD_2COMPONENTS | =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_TIGHT | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PPP_##dir##_PACK_ALIGN_LSB | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_PSEUDOPLNR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 PPP_##dir##_PLANE_PSEUDOPLNR)
>
> =A0#define PPP_CFG_MDP_Y_CRCB_H2V1(dir) =A0 PPP_CFG_MDP_Y_CBCR_H2V1(d=
ir)
>
> @@ -549,7 +549,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (img =3D=3D MDP_ARGB_8888) | =
(img =3D=3D MDP_RGBA_8888) | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (img =3D=3D MDP_XRGB_8888) | =
(img =3D=3D MDP_BGRA_8888))
> =A0#define HAS_ALPHA(img) ((img =3D=3D MDP_ARGB_8888) | (img =3D=3D M=
DP_RGBA_8888) | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (img =3D=3D MDP_BGRA_88=
88))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (img =3D=3D MDP_BGRA_88=
88))
>
> =A0#define IS_PSEUDOPLNR(img) ((img =3D=3D MDP_Y_CRCB_H2V2) | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(img =3D=3D MD=
P_Y_CBCR_H2V2) | \
> diff --git a/drivers/video/msm/mdp_scale_tables.h b/drivers/video/msm=
/mdp_scale_tables.h
> index 4e19a25..34077b1 100644
> --- a/drivers/video/msm/mdp_scale_tables.h
> +++ b/drivers/video/msm/mdp_scale_tables.h
> @@ -31,8 +31,8 @@ enum {
> =A0 =A0 =A0 =A0MDP_DOWNSCALE_MAX,
> =A0};
>
> -extern struct mdp_table_entry* mdp_downscale_x_table[MDP_DOWNSCALE_M=
AX];
> -extern struct mdp_table_entry* mdp_downscale_y_table[MDP_DOWNSCALE_M=
AX];
> +extern struct mdp_table_entry *mdp_downscale_x_table[MDP_DOWNSCALE_M=
AX];
> +extern struct mdp_table_entry *mdp_downscale_y_table[MDP_DOWNSCALE_M=
AX];
> =A0extern struct mdp_table_entry mdp_gaussian_blur_table[];
>
> -#endif =A0//_MDP_SCALE_TABLES_H_
> +#endif
>
>
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
