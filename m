From: David Lechner <david@lechnology.com>
Date: Thu, 03 Aug 2017 15:18:44 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <cf740449-c952-08d4-d63c-d92e71fa3092@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <b8ec0511-afd1-2a1b-6ffe-dfe951d79bf7@tronnes.org>
In-Reply-To: <b8ec0511-afd1-2a1b-6ffe-dfe951d79bf7@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

On 08/03/2017 09:07 AM, Noralf Trønnes wrote:
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
>> monochrome), so I think the 1bpp modes would definitely be useful.
> 
> David, I'm curious about those displays what controller/interface they use.
> I have been hoping that it would be possible to use regmap as an
> abstraction for many of these controllers and their registers.

The particular display I have is this one: 
http://wiki.seeed.cc/Grove-OLED_Display_1.12inch/

It looks like it uses a command/data scheme like the MIPI displays, but 
doesn't use any of the standard values for the commands. The controller 
can do parallel, SPI and I2C, but the display I have is wired for I2C.

> 
> For MIPI DCS it wasn't possible because it's command oriented with
> arguments. Since zero arguments is possible, a register with no value
> is nonsense, even though the regmap implementation happily let me do it.
> There's also the problem that regmap doesn't support registers with
> different widths. Which is a problem if all registers are 8-bit wide,
> except the GRAM register being 16-bit on RGB565 formats.
> 
> regmap is especially helpful with controllers that also have
> gpios/keypad/touch/pwm, since the mfd (multi function device) subsystem
> has good support for sharing regmaps between drivers. Multi function
> devices are split into several drivers.
> 
> Noralf.
> 

