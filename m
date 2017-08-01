From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Tue, 01 Aug 2017 18:08:49 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
In-Reply-To: <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

(cc: Daniel Vetter)


Den 01.08.2017 18.51, skrev David Lechner:
> On 07/30/2017 12:14 PM, Noralf Tr=C3=B8nnes wrote:
>>
>> Den 29.07.2017 21.40, skrev David Lechner:
>>> On 07/29/2017 02:17 PM, David Lechner wrote:
>>>> The goal of this series is to get the built-in LCD of the LEGO=20
>>>> MINDSTORMS EV3
>>>> working. But, most of the content here is building up the=20
>>>> infrastructure to do
>>>> that.
>>>>
>>>
>>> Some general comments/questions:
>>>
>>> I have noticed that DRM doesn't really have support for monochrome=20
>>> displays. I'm guessing that is because no one really uses them anymore?
>>>
>>
>> The repaper driver was the first monochrome drm driver and I chose to
>> present it to userspace as XRGB8888 and convert it to monochrome.
>> The reason for this is that everything, libraries, apps, plymouth (boot
>> splash, no rgb565) supports it. I didn't see any point in adding a new
>> monochrome drm format that didn't have, or probably wouldn't get
>> userspace support (by libraries at least). The application of course
>> needs to know this to get a good result.
>>
>> tinydrm_xrgb8888_to_gray8() does the conversion:
>> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/tinydrm=
?id79ea9a1a59a5a32c8db6f164e80a3fd00cb3781=20
>>
>>
>>> The LEGO EV3 display is just an LCD (not the backlit kind). It has=20
>>> two modes of operation. It can to 2bbp grayscale or it can do 1bpp=20
>>> monochrome. The grayscale isn't the best (looks splotchy in places),=20
>>> so it would be nice to be able to choose between these two modes.=20
>>> How would I implement something like that?
>>>
>>
>> Do you expect anyone to use grayscale if it doesn't look good?
>> Maybe better to add it later if there's a demand for it.
>
> I don't expect many people to use it at all. The people that do will=20
> be hackers like me that want to see what it is capable of, so I think=20
> I will keep it grayscale by default.
>

It looks like the best way to satisfy your needs is to add specific formats.

Video for Linux have these:

include/uapi/linux/videodev2.h

/* Grey formats */
#define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8=20
Greyscale     */
#define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*  4=20
Greyscale     */
#define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6=20
Greyscale     */
#define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10=20
Greyscale     */
#define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12=20
Greyscale     */
#define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16=20
Greyscale     */
#define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16 =20
Greyscale BE  */


Maybe we can add formats like these:

include/uapi/drm/drm_fourcc.h

#define DRM_FORMAT_MONO        fourcc_code('Y', '0', '1', ' ') /* [0]=20
Monochrome */
or
#define DRM_FORMAT_Y1        fourcc_code('Y', '0', '1', ' ') /* [0]=20
Monochrome */

#define DRM_FORMAT_Y2        fourcc_code('Y', '0', '2', ' ') /* [1:0]=20
Greyscale */

Daniel, what do you think?

>>
>>> Also, how can I indicate to userspace that this display really is=20
>>> monochrome/grayscale since the reported color depth 16bpp?
>>>
>>
>> There isn't unless we add formats for it.
>> Since this display is in a Lego piece, doesn't it have custom userspace
>> that already know it's monochrome?
>
> The official LEGO software is like this, yes. But I am working on a=20
> project that supports other LEGO compatible devices that have color=20
> screens, so the same software needs to be able to detect at runtime=20
> which type of screen it is using. Currently I have a plain fbdev=20
> driver that provides FB_VISUAL_MONO10 for the EV3 display and so the=20
> software knows when it has a monochrome screen and when it doesn't.=20
> But since plain fbdev drivers can't be accepted into mainline, I need=20
> to find a different way to detect what type of screen this is so that=20
> my graphics library can treat it differently.
>
>

You can tell userspace about the preferred bitdepth:
drm->mode_config.preferred_depth


Noralf.

