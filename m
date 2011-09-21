From: Ajay kumar <ajaynumb@gmail.com>
Date: Wed, 21 Sep 2011 07:27:38 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning structure
Message-Id: <CAEC9eQNZX3vKWV20c4mcWQGWC=zXLohmgw2L4R24dDnr-5Gp8w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<1316517021.1949.13.camel@deskari>
	<CAEC9eQOTNaMcUWeSFN-DCTYrCJsVaDAO7uOZNQM=efjVdqtU2g@mail.gmail.com>
	<1316533193.18781.12.camel@deskari> <4E78C579.9060305@gmx.de>
In-Reply-To: <4E78C579.9060305@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Florian,

On Tue, Sep 20, 2011 at 10:25 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> On 09/20/2011 03:39 PM, Tomi Valkeinen wrote:
>> On Tue, 2011-09-20 at 20:16 +0530, Ajay kumar wrote:
>>> Hi Tomi,
>>>
>>> On Tue, Sep 20, 2011 at 4:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>>>> On Tue, 2011-09-20 at 11:30 -0400, Ajay Kumar wrote:
>>>>> This patch adds a data structure definiton to hold framebuffer window=
s/planes.
>>>>> An ioctl number is also added to provide user access
>>>>> to change window position dynamically.
>
> Ajay, do you need this urgently or can we delay this one merge window? I =
don't
> think that a week or so is enough to get a consistent API that gets every=
thing
> right. So if you have a pressing need to have it within the 3.2 kernel I'd
> prefer to do it only for your driver now and adjust it when we get the th=
ing
> done, probably in 3.3.

No. I am not in a hurry, and I do not have any issue even if it takes
more time to get a consistent API.

>>>>>
>>>>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>>>>> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
>>>>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> ---
>>>>> =A0include/linux/fb.h | =A0 =A07 +++++++
>>>>> =A01 files changed, 7 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>>>>> index 1d6836c..2141941 100644
>>>>> --- a/include/linux/fb.h
>>>>> +++ b/include/linux/fb.h
>>>>> @@ -39,6 +39,7 @@
>>>>> =A0#define FBIOPUT_MODEINFO =A0 =A0 =A0 =A00x4617
>>>>> =A0#define FBIOGET_DISPINFO =A0 =A0 =A0 =A00x4618
>>>>> =A0#define FBIO_WAITFORVSYNC =A0 =A0_IOW('F', 0x20, __u32)
>>>>> +#define FBIOPOS_OVERLAY_WIN =A0_IOW('F', 0x21, struct fb_overlay_win=
_pos)
>>>>>
>>>>> =A0#define FB_TYPE_PACKED_PIXELS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 /* Packed Pixels =A0 =A0 =A0 =A0*/
>>>>> =A0#define FB_TYPE_PLANES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1 =A0 =A0 =A0 /* Non interleaved planes */
>>>>> @@ -366,6 +367,12 @@ struct fb_image {
>>>>> =A0 =A0 =A0 struct fb_cmap cmap; =A0 =A0/* color map info */
>>>>> =A0};
>>>>>
>>>>> +/* Window overlaying */
>>>>> +struct fb_overlay_win_pos {
>>>>> + =A0 =A0 __u32 win_pos_x; =A0 =A0 =A0 =A0/* x-offset from LCD(0,0) w=
here window starts */
>>>>> + =A0 =A0 __u32 win_pos_y; =A0 =A0 =A0 =A0/* y-offset from LCD(0,0) w=
here window starts */
>>>>> +};
>>>>
>>>> Shouldn't this also include the window size (in case scaling is
>>>> supported)?
>>>
>>> The "xres" and "yres" fields in fb_var_screeninfo are being used to
>>> represent the size of the window (visible resolution). So we have,
>>>
>>> win_pos_x: x-offset from LCD(0,0) where window starts.
>>> win_pos_y: y-offset from LCD(0,0) where window starts.
>>> (win_pos_x + xres) : x-offset from LCD(0,0) where window ends.
>>> (win_pos_y + yres) : y-offset from LCD(0,0) where window ends.
>>
>> Sure, but the xres and yres tell the _input_ resolution, i.e. how many
>> pixels are read from the memory. What is missing is the _output_
>> resolution, which is the size of the window. These are not necessarily
>> the same, if the system supports scaling.
>
> I agree, scaling is an issue that should get solved on the way. So adding
> u32 width, height;
> with an initial/special value of 0 which means just take what the source
> width/height is.

Do you mean to say the "width" and the "height" fields which you are
suggesting, will represent the "output resolution" which OMAP needs?

>>>> This also won't work for setups where the same framebuffer is used by
>>>> multiple overlays. For example, this is the case on OMAP when the same
>>>> content is cloned to, say, LCD and TV, each of which is showing an
>>>> overlay.
>>>
>>> These x and y position are used to configure the display controller
>>> (for LCD only) and not to alter the data in physical buffer
>>> (framebuffer). Could you elaborate the above use case you have
>>> mentioned and how adding the x and y offsets would not meet that
>>> requirement.
>>
>> Nothing wrong with adding x/y offsets, but the problem is in configuring
>> the two overlays. If the framebuffer data is used by two overlays, each
>> overlay should be configured separately. And your ioctl does not have
>> any way to define which overlay is being affected.
>
> Did you have a look at the (existing) API [1] Laurent proposed for discov=
ering
> the internal connections between the framebuffers (or with any other devi=
ces)?
> If you agree that it'd be a good idea to use it I feel that we should mak=
e the
> windowing API more compatible with it. So basically what we want to have =
as a
> window is one or more sunk pads so the pad-index should be also part of t=
he
> interface. I'm still confused with how OMAP works when it does not have a=
 "root"
> window/framebuffer. Normally I feel that the window position should be a
> property of the parent window as this is what the position is relative to=
o. But
> if the parent is no framebuffer, should we also include the entity into t=
he
> interface to allow configuring things that are nor even framebuffers?
> Also I think we need a z-index in case overlays overlap (might happen or?=
) and
> enforcing that all z-indexes are different for the same entity.
>
>> Of course, if we specify that a single framebuffer will ever go only to
>> one output, the problem disappears.
>>
>> However, even if we specify so, this will make the fbdev a bit weird:
>> what is x/yres after this patch? In the current fbdev x/yres is the size
>> of the output, and x/yres are part of video timings. After this patch
>> this is no longer the case: x/yres will be the size of the overlay. But
>> the old code will still use x/yres as part of video timings, making
>> things confusing.
>
> As I see it xres/yres (together with xoffset/yoffset) is always the visib=
le part
> of the framebuffer. Typically that's also part of the timings as they def=
ine
> what is visible. With the introduction of overlays (and maybe even for so=
me
> hardware anyway) it is no longer always true to have any timings at all. =
So on
> all framebuffer that do not have physical timings the timing interpretati=
on is
> useless anyway (I'm thinking about adding a FB_CAP_NOTIMING) and what rem=
ains is
> the interpretation of xres/yres as visible screen region.
>
>> And generally I can't really make my mind about adding these more
>> complex features. On one hand it would be very nice to have fbdev
>> supporting overlays and whatnot, but on the other hand, I can't figure
>> out how to add them properly.
>
> I don't see it as adding new features, rather unifying what is already th=
ere for
> easier use. Sure it should be done in a consistent way.
>
>
> Best regards,
>
> Florian Tobias Schandinat
>

Ajay

> [1] http://linuxtv.org/downloads/v4l-dvb-apis/media_common.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-s=
oc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
