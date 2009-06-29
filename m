From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 29 Jun 2009 23:19:32 +0200
Message-ID: <20090629211931.GD6611@elf.ucw.cz>
References: <20090629111029.GA15514@elf.ucw.cz> <20090629123840.1e20f17d.akpm@linux-foundation.org> <a55d774e0906291300u3bb9b491r124f27fdf832b495@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758712AbZF2VTx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a55d774e0906291300u3bb9b491r124f27fdf832b495@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Brian Swetland <swetland@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rebecca Schultz Zavin <rebecca@android.com>, Dima Zavin <dima@android.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon 2009-06-29 13:00:33, Brian Swetland wrote:
> On Mon, Jun 29, 2009 at 12:38 PM, Andrew
> Morton<akpm@linux-foundation.org> wrote:
> > On Mon, 29 Jun 2009 13:10:30 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> >> I cleaned up dead code, a lot of debugging infastructure and horri=
fic
> >> logo code. I had to remove earlysuspend support, because neccessar=
y
> >> headers are not in mainline. The driver still works :-).
> >
> > So you didn't wrote the code?
> >
> >> This adds support for framebuffer on HTC Dream smartphone (aka
> >> T-Mobile G1, aka ADP1).
> >>
> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >> Cc: Brian Swetland <swetland@google.com>
> >
> > Someone did. =A0Are the signoffs and attributions correct and
> > appropriate? =A0Should we at least mention the driver's history in =
the
> > changelog?

> > Will it have a maintainer?
>=20
> I did the original quick and dirty version for bringup.  Rebecca took
> over and (re)wrote the bulk of the driver, getting things stable for
> production ship of Dream and Sapphire, and Dima is currently adding
> support for later Qualcomm chipsets (QSD8x50, etc).  Looping them int=
o
> this discussion.

I can maintain it if noone else steps up. Of course, someone who
actually knows the hw/has the docs would be preferable.

> It would probably be worth referring to drivers like this as "for
> Qualcomm MSM/QSD SoCs" or the like, since they do work with a lot of
> hardware beyond just Dream.

Well, the Dream is why I'm doing it, hence patch title. Of course,
Kconfig should say 'Qualcomm MSM/QSD SoCs', too.

Sorry for world record in checkpatch warnings. I checked .c files, but
somehow forgot about .h files.
									Pavel

---

=46ix checkpatch warnings in HTC Dream display driver.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/video/msm/mddi_hw.h b/drivers/video/msm/mddi_hw.h
index 0cb55eb..45cc01f 100644
--- a/drivers/video/msm/mddi_hw.h
+++ b/drivers/video/msm/mddi_hw.h
@@ -199,39 +199,39 @@ struct __attribute__((packed)) mddi_video_stream =
{
 	uint16_t client_id; /* 0 */
=20
 	uint16_t video_data_format_descriptor;
-	/* format of each pixel in the Pixel Data in the present stream in th=
e
-	 * present packet.
-	 * If bits [15:13] =3D 000 monochrome
-	 * If bits [15:13] =3D 001 color pixels (palette).
-	 * If bits [15:13] =3D 010 color pixels in raw RGB
-	 * If bits [15:13] =3D 011 data in 4:2:2 Y Cb Cr format
-	 * If bits [15:13] =3D 100 Bayer pixels
-	 */
+/* format of each pixel in the Pixel Data in the present stream in the
+ * present packet.
+ * If bits [15:13] =3D 000 monochrome
+ * If bits [15:13] =3D 001 color pixels (palette).
+ * If bits [15:13] =3D 010 color pixels in raw RGB
+ * If bits [15:13] =3D 011 data in 4:2:2 Y Cb Cr format
+ * If bits [15:13] =3D 100 Bayer pixels
+ */
=20
 	uint16_t pixel_data_attributes;
-	/* interpreted as follows:
-	 * Bits [1:0] =3D 11  pixel data is displayed to both eyes
-	 * Bits [1:0] =3D 10  pixel data is routed to the left eye only.
-	 * Bits [1:0] =3D 01  pixel data is routed to the right eye only.
-	 * Bits [1:0] =3D 00  pixel data is routed to the alternate display.
-	 * Bit 2 is 0  Pixel Data is in the standard progressive format.
-	 * Bit 2 is 1  Pixel Data is in interlace format.
-	 * Bit 3 is 0  Pixel Data is in the standard progressive format.
-	 * Bit 3 is 1  Pixel Data is in alternate pixel format.
-	 * Bit 4 is 0  Pixel Data is to or from the display frame buffer.
-	 * Bit 4 is 1  Pixel Data is to or from the camera.
-	 * Bit 5 is 0  pixel data contains the next consecutive row of pixels=
=2E
-	 * Bit 5 is 1  X Left Edge, Y Top Edge, X Right Edge, Y Bottom Edge,
-	 *             X Start, and Y Start parameters are not defined and
-	 *             shall be ignored by the client.
-	 * Bits [7:6] =3D 01  Pixel data is written to the offline image buff=
er.
-	 * Bits [7:6] =3D 00  Pixel data is written to the buffer to refresh =
display.
-	 * Bits [7:6] =3D 11  Pixel data is written to all image buffers.
-	 * Bits [7:6] =3D 10  Invalid. Reserved for future use.
-	 * Bits 8 through 11 alternate display number.
-	 * Bits 12 through 14 are reserved for future use and shall be set to=
 zero.
-	 * Bit 15 is 1 the row of pixels is the last row of pixels in a frame=
=2E
-	 */
+/* interpreted as follows:
+ * Bits [1:0] =3D 11  pixel data is displayed to both eyes
+ * Bits [1:0] =3D 10  pixel data is routed to the left eye only.
+ * Bits [1:0] =3D 01  pixel data is routed to the right eye only.
+ * Bits [1:0] =3D 00  pixel data is routed to the alternate display.
+ * Bit 2 is 0  Pixel Data is in the standard progressive format.
+ * Bit 2 is 1  Pixel Data is in interlace format.
+ * Bit 3 is 0  Pixel Data is in the standard progressive format.
+ * Bit 3 is 1  Pixel Data is in alternate pixel format.
+ * Bit 4 is 0  Pixel Data is to or from the display frame buffer.
+ * Bit 4 is 1  Pixel Data is to or from the camera.
+ * Bit 5 is 0  pixel data contains the next consecutive row of pixels.
+ * Bit 5 is 1  X Left Edge, Y Top Edge, X Right Edge, Y Bottom Edge,
+ *             X Start, and Y Start parameters are not defined and
+ *             shall be ignored by the client.
+ * Bits [7:6] =3D 01  Pixel data is written to the offline image buffe=
r.
+ * Bits [7:6] =3D 00  Pixel data is written to the buffer to refresh d=
isplay.
+ * Bits [7:6] =3D 11  Pixel data is written to all image buffers.
+ * Bits [7:6] =3D 10  Invalid. Reserved for future use.
+ * Bits 8 through 11 alternate display number.
+ * Bits 12 through 14 are reserved for future use and shall be set to =
zero.
+ * Bit 15 is 1 the row of pixels is the last row of pixels in a frame.
+ */
=20
 	uint16_t x_left_edge;
 	uint16_t y_top_edge;
@@ -239,17 +239,19 @@ struct __attribute__((packed)) mddi_video_stream =
{
=20
 	uint16_t x_right_edge;
 	uint16_t y_bottom_edge;
-	/*  X,Y coordinate of the bottom right edge of the window being updat=
ed. */
+	/* X,Y coordinate of the bottom right edge of the window being
+	 * updated. */
=20
 	uint16_t x_start;
 	uint16_t y_start;
-	/*  (X Start, Y Start) is the first pixel in the Pixel Data field bel=
ow. */
+	/* (X Start, Y Start) is the first pixel in the Pixel Data field
+	 * below. */
=20
 	uint16_t pixel_count;
-	/*  number of pixels in the Pixel Data field below. */
+	/* number of pixels in the Pixel Data field below. */
=20
 	uint16_t parameter_CRC;
-	/*  16-bit CRC of all bytes from the Packet Length to the Pixel Count=
=2E */
+	/* 16-bit CRC of all bytes from the Packet Length to the Pixel Count.=
 */
=20
 	uint16_t reserved;
 	/* 16-bit variable to make structure align on 4 byte boundary */
diff --git a/drivers/video/msm/mdp_hw.h b/drivers/video/msm/mdp_hw.h
index d78dafa..4e3deb4 100644
--- a/drivers/video/msm/mdp_hw.h
+++ b/drivers/video/msm/mdp_hw.h
@@ -20,7 +20,7 @@
=20
 struct mdp_info {
 	struct mdp_device mdp_dev;
-	char* __iomem base;
+	char * __iomem base;
 	int irq;
 };
 struct mdp_blit_req;
@@ -32,149 +32,149 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
 #define mdp_writel(mdp, value, offset) writel(value, mdp->base + offse=
t)
 #define mdp_readl(mdp, offset) readl(mdp->base + offset)
=20
-#define MDP_SYNC_CONFIG_0                ( 0x00000)
-#define MDP_SYNC_CONFIG_1                ( 0x00004)
-#define MDP_SYNC_CONFIG_2                ( 0x00008)
-#define MDP_SYNC_STATUS_0                ( 0x0000c)
-#define MDP_SYNC_STATUS_1                ( 0x00010)
-#define MDP_SYNC_STATUS_2                ( 0x00014)
-#define MDP_SYNC_THRESH_0                ( 0x00018)
-#define MDP_SYNC_THRESH_1                ( 0x0001c)
-#define MDP_INTR_ENABLE                  ( 0x00020)
-#define MDP_INTR_STATUS                  ( 0x00024)
-#define MDP_INTR_CLEAR                   ( 0x00028)
-#define MDP_DISPLAY0_START               ( 0x00030)
-#define MDP_DISPLAY1_START               ( 0x00034)
-#define MDP_DISPLAY_STATUS               ( 0x00038)
-#define MDP_EBI2_LCD0                    ( 0x0003c)
-#define MDP_EBI2_LCD1                    ( 0x00040)
-#define MDP_DISPLAY0_ADDR                ( 0x00054)
-#define MDP_DISPLAY1_ADDR                ( 0x00058)
-#define MDP_EBI2_PORTMAP_MODE            ( 0x0005c)
-#define MDP_MODE                         ( 0x00060)
-#define MDP_TV_OUT_STATUS                ( 0x00064)
-#define MDP_HW_VERSION                   ( 0x00070)
-#define MDP_SW_RESET                     ( 0x00074)
-#define MDP_AXI_ERROR_MASTER_STOP        ( 0x00078)
-#define MDP_SEL_CLK_OR_HCLK_TEST_BUS     ( 0x0007c)
-#define MDP_PRIMARY_VSYNC_OUT_CTRL       ( 0x00080)
-#define MDP_SECONDARY_VSYNC_OUT_CTRL     ( 0x00084)
-#define MDP_EXTERNAL_VSYNC_OUT_CTRL      ( 0x00088)
-#define MDP_VSYNC_CTRL                   ( 0x0008c)
-#define MDP_CGC_EN                       ( 0x00100)
-#define MDP_CMD_STATUS                   ( 0x10008)
-#define MDP_PROFILE_EN                   ( 0x10010)
-#define MDP_PROFILE_COUNT                ( 0x10014)
-#define MDP_DMA_START                    ( 0x10044)
-#define MDP_FULL_BYPASS_WORD0            ( 0x10100)
-#define MDP_FULL_BYPASS_WORD1            ( 0x10104)
-#define MDP_COMMAND_CONFIG               ( 0x10104)
-#define MDP_FULL_BYPASS_WORD2            ( 0x10108)
-#define MDP_FULL_BYPASS_WORD3            ( 0x1010c)
-#define MDP_FULL_BYPASS_WORD4            ( 0x10110)
-#define MDP_FULL_BYPASS_WORD6            ( 0x10118)
-#define MDP_FULL_BYPASS_WORD7            ( 0x1011c)
-#define MDP_FULL_BYPASS_WORD8            ( 0x10120)
-#define MDP_FULL_BYPASS_WORD9            ( 0x10124)
-#define MDP_PPP_SOURCE_CONFIG            ( 0x10124)
-#define MDP_FULL_BYPASS_WORD10           ( 0x10128)
-#define MDP_FULL_BYPASS_WORD11           ( 0x1012c)
-#define MDP_FULL_BYPASS_WORD12           ( 0x10130)
-#define MDP_FULL_BYPASS_WORD13           ( 0x10134)
-#define MDP_FULL_BYPASS_WORD14           ( 0x10138)
-#define MDP_PPP_OPERATION_CONFIG         ( 0x10138)
-#define MDP_FULL_BYPASS_WORD15           ( 0x1013c)
-#define MDP_FULL_BYPASS_WORD16           ( 0x10140)
-#define MDP_FULL_BYPASS_WORD17           ( 0x10144)
-#define MDP_FULL_BYPASS_WORD18           ( 0x10148)
-#define MDP_FULL_BYPASS_WORD19           ( 0x1014c)
-#define MDP_FULL_BYPASS_WORD20           ( 0x10150)
-#define MDP_PPP_DESTINATION_CONFIG       ( 0x10150)
-#define MDP_FULL_BYPASS_WORD21           ( 0x10154)
-#define MDP_FULL_BYPASS_WORD22           ( 0x10158)
-#define MDP_FULL_BYPASS_WORD23           ( 0x1015c)
-#define MDP_FULL_BYPASS_WORD24           ( 0x10160)
-#define MDP_FULL_BYPASS_WORD25           ( 0x10164)
-#define MDP_FULL_BYPASS_WORD26           ( 0x10168)
-#define MDP_FULL_BYPASS_WORD27           ( 0x1016c)
-#define MDP_FULL_BYPASS_WORD29           ( 0x10174)
-#define MDP_FULL_BYPASS_WORD30           ( 0x10178)
-#define MDP_FULL_BYPASS_WORD31           ( 0x1017c)
-#define MDP_FULL_BYPASS_WORD32           ( 0x10180)
-#define MDP_DMA_CONFIG                   ( 0x10180)
-#define MDP_FULL_BYPASS_WORD33           ( 0x10184)
-#define MDP_FULL_BYPASS_WORD34           ( 0x10188)
-#define MDP_FULL_BYPASS_WORD35           ( 0x1018c)
-#define MDP_FULL_BYPASS_WORD37           ( 0x10194)
-#define MDP_FULL_BYPASS_WORD39           ( 0x1019c)
-#define MDP_FULL_BYPASS_WORD40           ( 0x101a0)
-#define MDP_FULL_BYPASS_WORD41           ( 0x101a4)
-#define MDP_FULL_BYPASS_WORD43           ( 0x101ac)
-#define MDP_FULL_BYPASS_WORD46           ( 0x101b8)
-#define MDP_FULL_BYPASS_WORD47           ( 0x101bc)
-#define MDP_FULL_BYPASS_WORD48           ( 0x101c0)
-#define MDP_FULL_BYPASS_WORD49           ( 0x101c4)
-#define MDP_FULL_BYPASS_WORD50           ( 0x101c8)
-#define MDP_FULL_BYPASS_WORD51           ( 0x101cc)
-#define MDP_FULL_BYPASS_WORD52           ( 0x101d0)
-#define MDP_FULL_BYPASS_WORD53           ( 0x101d4)
-#define MDP_FULL_BYPASS_WORD54           ( 0x101d8)
-#define MDP_FULL_BYPASS_WORD55           ( 0x101dc)
-#define MDP_FULL_BYPASS_WORD56           ( 0x101e0)
-#define MDP_FULL_BYPASS_WORD57           ( 0x101e4)
-#define MDP_FULL_BYPASS_WORD58           ( 0x101e8)
-#define MDP_FULL_BYPASS_WORD59           ( 0x101ec)
-#define MDP_FULL_BYPASS_WORD60           ( 0x101f0)
-#define MDP_VSYNC_THRESHOLD              ( 0x101f0)
-#define MDP_FULL_BYPASS_WORD61           ( 0x101f4)
-#define MDP_FULL_BYPASS_WORD62           ( 0x101f8)
-#define MDP_FULL_BYPASS_WORD63           ( 0x101fc)
-#define MDP_TFETCH_TEST_MODE             ( 0x20004)
-#define MDP_TFETCH_STATUS                ( 0x20008)
-#define MDP_TFETCH_TILE_COUNT            ( 0x20010)
-#define MDP_TFETCH_FETCH_COUNT           ( 0x20014)
-#define MDP_TFETCH_CONSTANT_COLOR        ( 0x20040)
-#define MDP_CSC_BYPASS                   ( 0x40004)
-#define MDP_SCALE_COEFF_LSB              ( 0x5fffc)
-#define MDP_TV_OUT_CTL                   ( 0xc0000)
-#define MDP_TV_OUT_FIR_COEFF             ( 0xc0004)
-#define MDP_TV_OUT_BUF_ADDR              ( 0xc0008)
-#define MDP_TV_OUT_CC_DATA               ( 0xc000c)
-#define MDP_TV_OUT_SOBEL                 ( 0xc0010)
-#define MDP_TV_OUT_Y_CLAMP               ( 0xc0018)
-#define MDP_TV_OUT_CB_CLAMP              ( 0xc001c)
-#define MDP_TV_OUT_CR_CLAMP              ( 0xc0020)
-#define MDP_TEST_MODE_CLK                ( 0xd0000)
-#define MDP_TEST_MISR_RESET_CLK          ( 0xd0004)
-#define MDP_TEST_EXPORT_MISR_CLK         ( 0xd0008)
-#define MDP_TEST_MISR_CURR_VAL_CLK       ( 0xd000c)
-#define MDP_TEST_MODE_HCLK               ( 0xd0100)
-#define MDP_TEST_MISR_RESET_HCLK         ( 0xd0104)
-#define MDP_TEST_EXPORT_MISR_HCLK        ( 0xd0108)
-#define MDP_TEST_MISR_CURR_VAL_HCLK      ( 0xd010c)
-#define MDP_TEST_MODE_DCLK               ( 0xd0200)
-#define MDP_TEST_MISR_RESET_DCLK         ( 0xd0204)
-#define MDP_TEST_EXPORT_MISR_DCLK        ( 0xd0208)
-#define MDP_TEST_MISR_CURR_VAL_DCLK      ( 0xd020c)
-#define MDP_TEST_CAPTURED_DCLK           ( 0xd0210)
-#define MDP_TEST_MISR_CAPT_VAL_DCLK      ( 0xd0214)
-#define MDP_LCDC_CTL                     ( 0xe0000)
-#define MDP_LCDC_HSYNC_CTL               ( 0xe0004)
-#define MDP_LCDC_VSYNC_CTL               ( 0xe0008)
-#define MDP_LCDC_ACTIVE_HCTL             ( 0xe000c)
-#define MDP_LCDC_ACTIVE_VCTL             ( 0xe0010)
-#define MDP_LCDC_BORDER_CLR              ( 0xe0014)
-#define MDP_LCDC_H_BLANK                 ( 0xe0018)
-#define MDP_LCDC_V_BLANK                 ( 0xe001c)
-#define MDP_LCDC_UNDERFLOW_CLR           ( 0xe0020)
-#define MDP_LCDC_HSYNC_SKEW              ( 0xe0024)
-#define MDP_LCDC_TEST_CTL                ( 0xe0028)
-#define MDP_LCDC_LINE_IRQ                ( 0xe002c)
-#define MDP_LCDC_CTL_POLARITY            ( 0xe0030)
-#define MDP_LCDC_DMA_CONFIG              ( 0xe1000)
-#define MDP_LCDC_DMA_SIZE                ( 0xe1004)
-#define MDP_LCDC_DMA_IBUF_ADDR           ( 0xe1008)
-#define MDP_LCDC_DMA_IBUF_Y_STRIDE       ( 0xe100c)
+#define MDP_SYNC_CONFIG_0                (0x00000)
+#define MDP_SYNC_CONFIG_1                (0x00004)
+#define MDP_SYNC_CONFIG_2                (0x00008)
+#define MDP_SYNC_STATUS_0                (0x0000c)
+#define MDP_SYNC_STATUS_1                (0x00010)
+#define MDP_SYNC_STATUS_2                (0x00014)
+#define MDP_SYNC_THRESH_0                (0x00018)
+#define MDP_SYNC_THRESH_1                (0x0001c)
+#define MDP_INTR_ENABLE                  (0x00020)
+#define MDP_INTR_STATUS                  (0x00024)
+#define MDP_INTR_CLEAR                   (0x00028)
+#define MDP_DISPLAY0_START               (0x00030)
+#define MDP_DISPLAY1_START               (0x00034)
+#define MDP_DISPLAY_STATUS               (0x00038)
+#define MDP_EBI2_LCD0                    (0x0003c)
+#define MDP_EBI2_LCD1                    (0x00040)
+#define MDP_DISPLAY0_ADDR                (0x00054)
+#define MDP_DISPLAY1_ADDR                (0x00058)
+#define MDP_EBI2_PORTMAP_MODE            (0x0005c)
+#define MDP_MODE                         (0x00060)
+#define MDP_TV_OUT_STATUS                (0x00064)
+#define MDP_HW_VERSION                   (0x00070)
+#define MDP_SW_RESET                     (0x00074)
+#define MDP_AXI_ERROR_MASTER_STOP        (0x00078)
+#define MDP_SEL_CLK_OR_HCLK_TEST_BUS     (0x0007c)
+#define MDP_PRIMARY_VSYNC_OUT_CTRL       (0x00080)
+#define MDP_SECONDARY_VSYNC_OUT_CTRL     (0x00084)
+#define MDP_EXTERNAL_VSYNC_OUT_CTRL      (0x00088)
+#define MDP_VSYNC_CTRL                   (0x0008c)
+#define MDP_CGC_EN                       (0x00100)
+#define MDP_CMD_STATUS                   (0x10008)
+#define MDP_PROFILE_EN                   (0x10010)
+#define MDP_PROFILE_COUNT                (0x10014)
+#define MDP_DMA_START                    (0x10044)
+#define MDP_FULL_BYPASS_WORD0            (0x10100)
+#define MDP_FULL_BYPASS_WORD1            (0x10104)
+#define MDP_COMMAND_CONFIG               (0x10104)
+#define MDP_FULL_BYPASS_WORD2            (0x10108)
+#define MDP_FULL_BYPASS_WORD3            (0x1010c)
+#define MDP_FULL_BYPASS_WORD4            (0x10110)
+#define MDP_FULL_BYPASS_WORD6            (0x10118)
+#define MDP_FULL_BYPASS_WORD7            (0x1011c)
+#define MDP_FULL_BYPASS_WORD8            (0x10120)
+#define MDP_FULL_BYPASS_WORD9            (0x10124)
+#define MDP_PPP_SOURCE_CONFIG            (0x10124)
+#define MDP_FULL_BYPASS_WORD10           (0x10128)
+#define MDP_FULL_BYPASS_WORD11           (0x1012c)
+#define MDP_FULL_BYPASS_WORD12           (0x10130)
+#define MDP_FULL_BYPASS_WORD13           (0x10134)
+#define MDP_FULL_BYPASS_WORD14           (0x10138)
+#define MDP_PPP_OPERATION_CONFIG         (0x10138)
+#define MDP_FULL_BYPASS_WORD15           (0x1013c)
+#define MDP_FULL_BYPASS_WORD16           (0x10140)
+#define MDP_FULL_BYPASS_WORD17           (0x10144)
+#define MDP_FULL_BYPASS_WORD18           (0x10148)
+#define MDP_FULL_BYPASS_WORD19           (0x1014c)
+#define MDP_FULL_BYPASS_WORD20           (0x10150)
+#define MDP_PPP_DESTINATION_CONFIG       (0x10150)
+#define MDP_FULL_BYPASS_WORD21           (0x10154)
+#define MDP_FULL_BYPASS_WORD22           (0x10158)
+#define MDP_FULL_BYPASS_WORD23           (0x1015c)
+#define MDP_FULL_BYPASS_WORD24           (0x10160)
+#define MDP_FULL_BYPASS_WORD25           (0x10164)
+#define MDP_FULL_BYPASS_WORD26           (0x10168)
+#define MDP_FULL_BYPASS_WORD27           (0x1016c)
+#define MDP_FULL_BYPASS_WORD29           (0x10174)
+#define MDP_FULL_BYPASS_WORD30           (0x10178)
+#define MDP_FULL_BYPASS_WORD31           (0x1017c)
+#define MDP_FULL_BYPASS_WORD32           (0x10180)
+#define MDP_DMA_CONFIG                   (0x10180)
+#define MDP_FULL_BYPASS_WORD33           (0x10184)
+#define MDP_FULL_BYPASS_WORD34           (0x10188)
+#define MDP_FULL_BYPASS_WORD35           (0x1018c)
+#define MDP_FULL_BYPASS_WORD37           (0x10194)
+#define MDP_FULL_BYPASS_WORD39           (0x1019c)
+#define MDP_FULL_BYPASS_WORD40           (0x101a0)
+#define MDP_FULL_BYPASS_WORD41           (0x101a4)
+#define MDP_FULL_BYPASS_WORD43           (0x101ac)
+#define MDP_FULL_BYPASS_WORD46           (0x101b8)
+#define MDP_FULL_BYPASS_WORD47           (0x101bc)
+#define MDP_FULL_BYPASS_WORD48           (0x101c0)
+#define MDP_FULL_BYPASS_WORD49           (0x101c4)
+#define MDP_FULL_BYPASS_WORD50           (0x101c8)
+#define MDP_FULL_BYPASS_WORD51           (0x101cc)
+#define MDP_FULL_BYPASS_WORD52           (0x101d0)
+#define MDP_FULL_BYPASS_WORD53           (0x101d4)
+#define MDP_FULL_BYPASS_WORD54           (0x101d8)
+#define MDP_FULL_BYPASS_WORD55           (0x101dc)
+#define MDP_FULL_BYPASS_WORD56           (0x101e0)
+#define MDP_FULL_BYPASS_WORD57           (0x101e4)
+#define MDP_FULL_BYPASS_WORD58           (0x101e8)
+#define MDP_FULL_BYPASS_WORD59           (0x101ec)
+#define MDP_FULL_BYPASS_WORD60           (0x101f0)
+#define MDP_VSYNC_THRESHOLD              (0x101f0)
+#define MDP_FULL_BYPASS_WORD61           (0x101f4)
+#define MDP_FULL_BYPASS_WORD62           (0x101f8)
+#define MDP_FULL_BYPASS_WORD63           (0x101fc)
+#define MDP_TFETCH_TEST_MODE             (0x20004)
+#define MDP_TFETCH_STATUS                (0x20008)
+#define MDP_TFETCH_TILE_COUNT            (0x20010)
+#define MDP_TFETCH_FETCH_COUNT           (0x20014)
+#define MDP_TFETCH_CONSTANT_COLOR        (0x20040)
+#define MDP_CSC_BYPASS                   (0x40004)
+#define MDP_SCALE_COEFF_LSB              (0x5fffc)
+#define MDP_TV_OUT_CTL                   (0xc0000)
+#define MDP_TV_OUT_FIR_COEFF             (0xc0004)
+#define MDP_TV_OUT_BUF_ADDR              (0xc0008)
+#define MDP_TV_OUT_CC_DATA               (0xc000c)
+#define MDP_TV_OUT_SOBEL                 (0xc0010)
+#define MDP_TV_OUT_Y_CLAMP               (0xc0018)
+#define MDP_TV_OUT_CB_CLAMP              (0xc001c)
+#define MDP_TV_OUT_CR_CLAMP              (0xc0020)
+#define MDP_TEST_MODE_CLK                (0xd0000)
+#define MDP_TEST_MISR_RESET_CLK          (0xd0004)
+#define MDP_TEST_EXPORT_MISR_CLK         (0xd0008)
+#define MDP_TEST_MISR_CURR_VAL_CLK       (0xd000c)
+#define MDP_TEST_MODE_HCLK               (0xd0100)
+#define MDP_TEST_MISR_RESET_HCLK         (0xd0104)
+#define MDP_TEST_EXPORT_MISR_HCLK        (0xd0108)
+#define MDP_TEST_MISR_CURR_VAL_HCLK      (0xd010c)
+#define MDP_TEST_MODE_DCLK               (0xd0200)
+#define MDP_TEST_MISR_RESET_DCLK         (0xd0204)
+#define MDP_TEST_EXPORT_MISR_DCLK        (0xd0208)
+#define MDP_TEST_MISR_CURR_VAL_DCLK      (0xd020c)
+#define MDP_TEST_CAPTURED_DCLK           (0xd0210)
+#define MDP_TEST_MISR_CAPT_VAL_DCLK      (0xd0214)
+#define MDP_LCDC_CTL                     (0xe0000)
+#define MDP_LCDC_HSYNC_CTL               (0xe0004)
+#define MDP_LCDC_VSYNC_CTL               (0xe0008)
+#define MDP_LCDC_ACTIVE_HCTL             (0xe000c)
+#define MDP_LCDC_ACTIVE_VCTL             (0xe0010)
+#define MDP_LCDC_BORDER_CLR              (0xe0014)
+#define MDP_LCDC_H_BLANK                 (0xe0018)
+#define MDP_LCDC_V_BLANK                 (0xe001c)
+#define MDP_LCDC_UNDERFLOW_CLR           (0xe0020)
+#define MDP_LCDC_HSYNC_SKEW              (0xe0024)
+#define MDP_LCDC_TEST_CTL                (0xe0028)
+#define MDP_LCDC_LINE_IRQ                (0xe002c)
+#define MDP_LCDC_CTL_POLARITY            (0xe0030)
+#define MDP_LCDC_DMA_CONFIG              (0xe1000)
+#define MDP_LCDC_DMA_SIZE                (0xe1004)
+#define MDP_LCDC_DMA_IBUF_ADDR           (0xe1008)
+#define MDP_LCDC_DMA_IBUF_Y_STRIDE       (0xe100c)
=20
=20
 #define MDP_DMA2_TERM 0x1
@@ -246,11 +246,11 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
 /* MDP_VSYNC_CTRL */
 #define DISP0_VSYNC_MAP_VSYNC0 0
 #define DISP0_VSYNC_MAP_VSYNC1 (1<<0)
-#define DISP0_VSYNC_MAP_VSYNC2 (1<<0)|(1<<1)
+#define DISP0_VSYNC_MAP_VSYNC2 ((1<<0)|(1<<1))
=20
 #define DISP1_VSYNC_MAP_VSYNC0 0
 #define DISP1_VSYNC_MAP_VSYNC1 (1<<2)
-#define DISP1_VSYNC_MAP_VSYNC2 (1<<2)|(1<<3)
+#define DISP1_VSYNC_MAP_VSYNC2 ((1<<2)|(1<<3))
=20
 #define PRIMARY_LCD_SYNC_EN (1<<4)
 #define PRIMARY_LCD_SYNC_DISABLE 0
@@ -368,7 +368,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, struct=
 mdp_blit_req *req,
 #define PPP_OP_BG_CHROMA_RGB 0
 #define PPP_OP_BG_CHROMA_H2V1 (1<<25)
 #define PPP_OP_BG_CHROMA_H1V2 (1<<26)
-#define PPP_OP_BG_CHROMA_420 (1<<25)|(1<<26)
+#define PPP_OP_BG_CHROMA_420 ((1<<25)|(1<<26))
 #define PPP_OP_BG_CHROMA_SITE_COSITE 0
 #define PPP_OP_BG_CHROMA_SITE_OFFSITE (1<<27)
=20
@@ -417,25 +417,25 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
 #define PPP_DST_MDDI_EXTERNAL (1<<22)
=20
 /* image configurations by image type */
-#define PPP_CFG_MDP_RGB_565(dir)	PPP_##dir##_C2R_5BIT | \
+#define PPP_CFG_MDP_RGB_565(dir)       (PPP_##dir##_C2R_5BIT | \
 					PPP_##dir##_C0G_6BIT | \
 					PPP_##dir##_C1B_5BIT | \
 					PPP_##dir##_BPP_2BYTES | \
 					PPP_##dir##_INTERLVD_3COMPONENTS | \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB | \
-					PPP_##dir##_PLANE_INTERLVD
+					PPP_##dir##_PLANE_INTERLVD)
=20
-#define PPP_CFG_MDP_RGB_888(dir)	PPP_##dir##_C2R_8BIT | \
+#define PPP_CFG_MDP_RGB_888(dir)       (PPP_##dir##_C2R_8BIT | \
 					PPP_##dir##_C0G_8BIT | \
 					PPP_##dir##_C1B_8BIT | \
 					PPP_##dir##_BPP_3BYTES | \
 					PPP_##dir##_INTERLVD_3COMPONENTS | \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB | \
-					PPP_##dir##_PLANE_INTERLVD
+					PPP_##dir##_PLANE_INTERLVD)
=20
-#define PPP_CFG_MDP_ARGB_8888(dir)	PPP_##dir##_C2R_8BIT | \
+#define PPP_CFG_MDP_ARGB_8888(dir)     (PPP_##dir##_C2R_8BIT | \
 					PPP_##dir##_C0G_8BIT | \
 					PPP_##dir##_C1B_8BIT | \
 					PPP_##dir##_C3A_8BIT | \
@@ -444,13 +444,13 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
 					PPP_##dir##_INTERLVD_4COMPONENTS | \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB | \
-					PPP_##dir##_PLANE_INTERLVD
+					PPP_##dir##_PLANE_INTERLVD)
=20
 #define PPP_CFG_MDP_XRGB_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
 #define PPP_CFG_MDP_RGBA_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
 #define PPP_CFG_MDP_BGRA_8888(dir) PPP_CFG_MDP_ARGB_8888(dir)
=20
-#define PPP_CFG_MDP_Y_CBCR_H2V2(dir)	PPP_##dir##_C2R_8BIT | \
+#define PPP_CFG_MDP_Y_CBCR_H2V2(dir)   (PPP_##dir##_C2R_8BIT | \
 					PPP_##dir##_C0G_8BIT | \
 					PPP_##dir##_C1B_8BIT | \
 					PPP_##dir##_C3A_8BIT | \
@@ -458,11 +458,11 @@ int mdp_ppp_blit(const struct mdp_info *mdp, stru=
ct mdp_blit_req *req,
 					PPP_##dir##_INTERLVD_2COMPONENTS | \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB | \
-					PPP_##dir##_PLANE_PSEUDOPLNR
+					PPP_##dir##_PLANE_PSEUDOPLNR)
=20
 #define PPP_CFG_MDP_Y_CRCB_H2V2(dir)	PPP_CFG_MDP_Y_CBCR_H2V2(dir)
=20
-#define PPP_CFG_MDP_YCRYCB_H2V1(dir)	PPP_##dir##_C2R_8BIT | \
+#define PPP_CFG_MDP_YCRYCB_H2V1(dir)   (PPP_##dir##_C2R_8BIT | \
 					PPP_##dir##_C0G_8BIT | \
 					PPP_##dir##_C1B_8BIT | \
 					PPP_##dir##_C3A_8BIT | \
@@ -470,9 +470,9 @@ int mdp_ppp_blit(const struct mdp_info *mdp, struct=
 mdp_blit_req *req,
 					PPP_##dir##_INTERLVD_4COMPONENTS | \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB |\
-					PPP_##dir##_PLANE_INTERLVD
+					PPP_##dir##_PLANE_INTERLVD)
=20
-#define PPP_CFG_MDP_Y_CBCR_H2V1(dir)	PPP_##dir##_C2R_8BIT | \
+#define PPP_CFG_MDP_Y_CBCR_H2V1(dir)   (PPP_##dir##_C2R_8BIT | \
 					PPP_##dir##_C0G_8BIT | \
 					PPP_##dir##_C1B_8BIT | \
 					PPP_##dir##_C3A_8BIT | \
@@ -480,7 +480,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, struct=
 mdp_blit_req *req,
 					PPP_##dir##_INTERLVD_2COMPONENTS |  \
 					PPP_##dir##_PACK_TIGHT | \
 					PPP_##dir##_PACK_ALIGN_LSB | \
-					PPP_##dir##_PLANE_PSEUDOPLNR
+					PPP_##dir##_PLANE_PSEUDOPLNR)
=20
 #define PPP_CFG_MDP_Y_CRCB_H2V1(dir)	PPP_CFG_MDP_Y_CBCR_H2V1(dir)
=20
@@ -549,7 +549,7 @@ int mdp_ppp_blit(const struct mdp_info *mdp, struct=
 mdp_blit_req *req,
 		     (img =3D=3D MDP_ARGB_8888) | (img =3D=3D MDP_RGBA_8888) | \
 		     (img =3D=3D MDP_XRGB_8888) | (img =3D=3D MDP_BGRA_8888))
 #define HAS_ALPHA(img) ((img =3D=3D MDP_ARGB_8888) | (img =3D=3D MDP_R=
GBA_8888) | \
-		        (img =3D=3D MDP_BGRA_8888))
+			(img =3D=3D MDP_BGRA_8888))
=20
 #define IS_PSEUDOPLNR(img) ((img =3D=3D MDP_Y_CRCB_H2V2) | \
 			    (img =3D=3D MDP_Y_CBCR_H2V2) | \
diff --git a/drivers/video/msm/mdp_scale_tables.h b/drivers/video/msm/m=
dp_scale_tables.h
index 4e19a25..34077b1 100644
--- a/drivers/video/msm/mdp_scale_tables.h
+++ b/drivers/video/msm/mdp_scale_tables.h
@@ -31,8 +31,8 @@ enum {
 	MDP_DOWNSCALE_MAX,
 };
=20
-extern struct mdp_table_entry* mdp_downscale_x_table[MDP_DOWNSCALE_MAX=
];
-extern struct mdp_table_entry* mdp_downscale_y_table[MDP_DOWNSCALE_MAX=
];
+extern struct mdp_table_entry *mdp_downscale_x_table[MDP_DOWNSCALE_MAX=
];
+extern struct mdp_table_entry *mdp_downscale_y_table[MDP_DOWNSCALE_MAX=
];
 extern struct mdp_table_entry mdp_gaussian_blur_table[];
=20
-#endif  //_MDP_SCALE_TABLES_H_
+#endif




--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
