From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Sun, 30 Jul 2017 17:14:15 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
In-Reply-To: <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org


Den 29.07.2017 21.40, skrev David Lechner:
> On 07/29/2017 02:17 PM, David Lechner wrote:
>> The goal of this series is to get the built-in LCD of the LEGO 
>> MINDSTORMS EV3
>> working. But, most of the content here is building up the 
>> infrastructure to do
>> that.
>>
>
> Some general comments/questions:
>
> I have noticed that DRM doesn't really have support for monochrome 
> displays. I'm guessing that is because no one really uses them anymore?
>

The repaper driver was the first monochrome drm driver and I chose to
present it to userspace as XRGB8888 and convert it to monochrome.
The reason for this is that everything, libraries, apps, plymouth (boot
splash, no rgb565) supports it. I didn't see any point in adding a new
monochrome drm format that didn't have, or probably wouldn't get
userspace support (by libraries at least). The application of course
needs to know this to get a good result.

tinydrm_xrgb8888_to_gray8() does the conversion:
https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/tinydrm?id79ea9a1a59a5a32c8db6f164e80a3fd00cb3781

> The LEGO EV3 display is just an LCD (not the backlit kind). It has two 
> modes of operation. It can to 2bbp grayscale or it can do 1bpp 
> monochrome. The grayscale isn't the best (looks splotchy in places), 
> so it would be nice to be able to choose between these two modes. How 
> would I implement something like that?
>

Do you expect anyone to use grayscale if it doesn't look good?
Maybe better to add it later if there's a demand for it.

> Also, how can I indicate to userspace that this display really is 
> monochrome/grayscale since the reported color depth 16bpp?
>

There isn't unless we add formats for it.
Since this display is in a Lego piece, doesn't it have custom userspace
that already know it's monochrome?

Noralf.

