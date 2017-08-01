From: David Lechner <david@lechnology.com>
Date: Tue, 01 Aug 2017 16:51:23 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
In-Reply-To: <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

On 07/30/2017 12:14 PM, Noralf Tr=C3=B8nnes wrote:
>=20
> Den 29.07.2017 21.40, skrev David Lechner:
>> On 07/29/2017 02:17 PM, David Lechner wrote:
>>> The goal of this series is to get the built-in LCD of the LEGO=20
>>> MINDSTORMS EV3
>>> working. But, most of the content here is building up the=20
>>> infrastructure to do
>>> that.
>>>
>>
>> Some general comments/questions:
>>
>> I have noticed that DRM doesn't really have support for monochrome=20
>> displays. I'm guessing that is because no one really uses them anymore?
>>
>=20
> The repaper driver was the first monochrome drm driver and I chose to
> present it to userspace as XRGB8888 and convert it to monochrome.
> The reason for this is that everything, libraries, apps, plymouth (boot
> splash, no rgb565) supports it. I didn't see any point in adding a new
> monochrome drm format that didn't have, or probably wouldn't get
> userspace support (by libraries at least). The application of course
> needs to know this to get a good result.
>=20
> tinydrm_xrgb8888_to_gray8() does the conversion:
> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/tinydrm?=
id79ea9a1a59a5a32c8db6f164e80a3fd00cb3781=20
>=20
>=20
>> The LEGO EV3 display is just an LCD (not the backlit kind). It has two=20
>> modes of operation. It can to 2bbp grayscale or it can do 1bpp=20
>> monochrome. The grayscale isn't the best (looks splotchy in places),=20
>> so it would be nice to be able to choose between these two modes. How=20
>> would I implement something like that?
>>
>=20
> Do you expect anyone to use grayscale if it doesn't look good?
> Maybe better to add it later if there's a demand for it.

I don't expect many people to use it at all. The people that do will be=20
hackers like me that want to see what it is capable of, so I think I=20
will keep it grayscale by default.

>=20
>> Also, how can I indicate to userspace that this display really is=20
>> monochrome/grayscale since the reported color depth 16bpp?
>>
>=20
> There isn't unless we add formats for it.
> Since this display is in a Lego piece, doesn't it have custom userspace
> that already know it's monochrome?

The official LEGO software is like this, yes. But I am working on a=20
project that supports other LEGO compatible devices that have color=20
screens, so the same software needs to be able to detect at runtime=20
which type of screen it is using. Currently I have a plain fbdev driver=20
that provides FB_VISUAL_MONO10 for the EV3 display and so the software=20
knows when it has a monochrome screen and when it doesn't. But since=20
plain fbdev drivers can't be accepted into mainline, I need to find a=20
different way to detect what type of screen this is so that my graphics=20
library can treat it differently.



