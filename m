From: Ajay kumar <ajaynumb@gmail.com>
Date: Tue, 20 Sep 2011 14:58:00 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning structure
Message-Id: <CAEC9eQOTNaMcUWeSFN-DCTYrCJsVaDAO7uOZNQM=efjVdqtU2g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<1316517021.1949.13.camel@deskari>
In-Reply-To: <1316517021.1949.13.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Tue, Sep 20, 2011 at 4:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Tue, 2011-09-20 at 11:30 -0400, Ajay Kumar wrote:
>> This patch adds a data structure definiton to hold framebuffer windows/p=
lanes.
>> An ioctl number is also added to provide user access
>> to change window position dynamically.
>>
>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> =A0include/linux/fb.h | =A0 =A07 +++++++
>> =A01 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 1d6836c..2141941 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -39,6 +39,7 @@
>> =A0#define FBIOPUT_MODEINFO =A0 =A0 =A0 =A00x4617
>> =A0#define FBIOGET_DISPINFO =A0 =A0 =A0 =A00x4618
>> =A0#define FBIO_WAITFORVSYNC =A0 =A0_IOW('F', 0x20, __u32)
>> +#define FBIOPOS_OVERLAY_WIN =A0_IOW('F', 0x21, struct fb_overlay_win_po=
s)
>>
>> =A0#define FB_TYPE_PACKED_PIXELS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =
=A0 =A0 /* Packed Pixels =A0 =A0 =A0 =A0*/
>> =A0#define FB_TYPE_PLANES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =
=A0 =A0 =A0 /* Non interleaved planes */
>> @@ -366,6 +367,12 @@ struct fb_image {
>> =A0 =A0 =A0 struct fb_cmap cmap; =A0 =A0/* color map info */
>> =A0};
>>
>> +/* Window overlaying */
>> +struct fb_overlay_win_pos {
>> + =A0 =A0 __u32 win_pos_x; =A0 =A0 =A0 =A0/* x-offset from LCD(0,0) wher=
e window starts */
>> + =A0 =A0 __u32 win_pos_y; =A0 =A0 =A0 =A0/* y-offset from LCD(0,0) wher=
e window starts */
>> +};
>
> Shouldn't this also include the window size (in case scaling is
> supported)?

The "xres" and "yres" fields in fb_var_screeninfo are being used to
represent the size of the window (visible resolution). So we have,

win_pos_x: x-offset from LCD(0,0) where window starts.
win_pos_y: y-offset from LCD(0,0) where window starts.
(win_pos_x + xres) : x-offset from LCD(0,0) where window ends.
(win_pos_y + yres) : y-offset from LCD(0,0) where window ends.

> This also won't work for setups where the same framebuffer is used by
> multiple overlays. For example, this is the case on OMAP when the same
> content is cloned to, say, LCD and TV, each of which is showing an
> overlay.

These x and y position are used to configure the display controller
(for LCD only) and not to alter the data in physical buffer
(framebuffer). Could you elaborate the above use case you have
mentioned and how adding the x and y offsets would not meet that
requirement.

> =A0Tomi
>

Ajay
