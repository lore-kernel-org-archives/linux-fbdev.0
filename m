From: David Lechner <david@lechnology.com>
Date: Wed, 02 Aug 2017 16:05:58 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <abbd75ac-67f6-e189-5093-ee4a8f44ba6e@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <937aa71c-1415-4645-7e04-6be43dd33174@tronnes.org>
In-Reply-To: <937aa71c-1415-4645-7e04-6be43dd33174@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 08/02/2017 03:05 AM, Noralf Trønnes wrote:
> 
> Den 02.08.2017 00.26, skrev David Lechner:
>> On 08/01/2017 01:08 PM, Noralf Trønnes wrote:
>>> (cc: Daniel Vetter)
>>>
>>>
>>> Den 01.08.2017 18.51, skrev David Lechner:
>>>> On 07/30/2017 12:14 PM, Noralf Trønnes wrote:
>>>>>
>>>>> Den 29.07.2017 21.40, skrev David Lechner:
>>>>>> On 07/29/2017 02:17 PM, David Lechner wrote:
>>>>>>> The goal of this series is to get the built-in LCD of the LEGO 
>>>>>>> MINDSTORMS EV3
>>>>>>> working. But, most of the content here is building up the 
>>>>>>> infrastructure to do
>>>>>>> that.
>>>>>>>
>>>>>>
>>>>>> Some general comments/questions:
>>>>>>
>>>>>> I have noticed that DRM doesn't really have support for monochrome 
>>>>>> displays. I'm guessing that is because no one really uses them 
>>>>>> anymore?
>>>>>>
>>>>>
>>>>> The repaper driver was the first monochrome drm driver and I chose to
>>>>> present it to userspace as XRGB8888 and convert it to monochrome.
>>>>> The reason for this is that everything, libraries, apps, plymouth 
>>>>> (boot
>>>>> splash, no rgb565) supports it. I didn't see any point in adding a new
>>>>> monochrome drm format that didn't have, or probably wouldn't get
>>>>> userspace support (by libraries at least). The application of course
>>>>> needs to know this to get a good result.
>>>>>
>>>>> tinydrm_xrgb8888_to_gray8() does the conversion:
>>>>> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/tinydrm?id79ea9a1a59a5a32c8db6f164e80a3fd00cb3781 
>>>>>
>>>>>
>>>>>> The LEGO EV3 display is just an LCD (not the backlit kind). It has 
>>>>>> two modes of operation. It can to 2bbp grayscale or it can do 1bpp 
>>>>>> monochrome. The grayscale isn't the best (looks splotchy in 
>>>>>> places), so it would be nice to be able to choose between these 
>>>>>> two modes. How would I implement something like that?
>>>>>>
>>>>>
>>>>> Do you expect anyone to use grayscale if it doesn't look good?
>>>>> Maybe better to add it later if there's a demand for it.
>>>>
>>>> I don't expect many people to use it at all. The people that do will 
>>>> be hackers like me that want to see what it is capable of, so I 
>>>> think I will keep it grayscale by default.
>>>>
>>>
>>> It looks like the best way to satisfy your needs is to add specific 
>>> formats.
>>>
>>> Video for Linux have these:
>>>
>>> include/uapi/linux/videodev2.h
>>>
>>> /* Grey formats */
>>> #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /* 8 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /* 4 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /* 6 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16 
>>> Greyscale     */
>>> #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16 
>>> Greyscale BE  */
>>>
>>>
>>> Maybe we can add formats like these:
>>>
>>> include/uapi/drm/drm_fourcc.h
>>>
>>> #define DRM_FORMAT_MONO        fourcc_code('Y', '0', '1', ' ') /* [0] 
>>> Monochrome */
>>> or
>>> #define DRM_FORMAT_Y1        fourcc_code('Y', '0', '1', ' ') /* [0] 
>>> Monochrome */
>>>
>>> #define DRM_FORMAT_Y2        fourcc_code('Y', '0', '2', ' ') /* [1:0] 
>>> Greyscale */
>>>
>>> Daniel, what do you think?
>>
>> 2 of the first 3 tinydrm drivers are monochrome (and I would like to 
>> write a driver for the Seeed/Grove I2C OLED displays which are also 
>> monochrome), so I think the 1bpp modes would definitely be useful. I 
>> think there is enough userspace code still around that knows about 
>> FB_VISUAL_MONO01 and FB_VISUAL_MONO10 that could use these.
>>
> 
> Can you elaborate, would you use the display trough monochrome fbdev
> or through drm?

I have a small collection of programs and libraries that work using 
monochrome fbdev. I would like to just keep using them without having to 
convert everything to drm.


>> I don't think a Y02 mode would be useful though. There is pretty much 
>> nothing out there (that I could find) that uses such a mode.
>>
>> A Y08 mode for 8bpp grayscale would be useful though. This is another 
>> more commonly used format.
>>
> 
> Another source of fourcc's is FFmpeg which has these:
> 
>      { AV_PIX_FMT_GRAY8,    MKTAG('Y', '8', '0', '0') },
>      { AV_PIX_FMT_GRAY8,    MKTAG('Y', '8', ' ', ' ') },
>      { AV_PIX_FMT_GRAY8,   MKTAG('G', 'R', 'E', 'Y') },
> 
>      { AV_PIX_FMT_MONOWHITE,MKTAG('B', '1', 'W', '0') },
>      { AV_PIX_FMT_MONOBLACK,MKTAG('B', '0', 'W', '1') },
> 
> AV_PIX_FMT_GRAY8
> Y , 8bpp.
> AV_PIX_FMT_MONOWHITE
> Y , 1bpp, 0 is white, 1 is black,
>      in each byte pixels are ordered from the msb to the lsb.
> AV_PIX_FMT_MONOBLACK
> Y , 1bpp, 0 is black, 1 is white,
>      in each byte pixels are ordered from the msb to the lsb.
> 
> 
> __drm_format_info() provides details about formats:
>      { .format = DRM_FORMAT_MONO,    .depth = 1,  .num_planes = 1, .cpp 
> = { 0, 0, 0 }, .hsub = 1, .vsub = 1 },
>      { .format = DRM_FORMAT_GREY,    .depth = 8,  .num_planes = 1, .cpp 
> = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
> 
> framebuffer_check() and drm_fb_cma_create_with_funcs() use cpp for
> validation and they don't expect it to be zero.
> 
> 
> Noralf.
> 
>>>
>>>>>
>>>>>> Also, how can I indicate to userspace that this display really is 
>>>>>> monochrome/grayscale since the reported color depth 16bpp?
>>>>>>
>>>>>
>>>>> There isn't unless we add formats for it.
>>>>> Since this display is in a Lego piece, doesn't it have custom 
>>>>> userspace
>>>>> that already know it's monochrome?
>>>>
>>>> The official LEGO software is like this, yes. But I am working on a 
>>>> project that supports other LEGO compatible devices that have color 
>>>> screens, so the same software needs to be able to detect at runtime 
>>>> which type of screen it is using. Currently I have a plain fbdev 
>>>> driver that provides FB_VISUAL_MONO10 for the EV3 display and so the 
>>>> software knows when it has a monochrome screen and when it doesn't. 
>>>> But since plain fbdev drivers can't be accepted into mainline, I 
>>>> need to find a different way to detect what type of screen this is 
>>>> so that my graphics library can treat it differently.
>>>>
>>>>
>>>
>>> You can tell userspace about the preferred bitdepth:
>>> drm->mode_config.preferred_depth
>>>
>>>
>>> Noralf.
>>>
>>
> 

