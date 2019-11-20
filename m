From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 20 Nov 2019 14:01:30 +0000
Subject: Re: [PATCH] video: Fix Kconfig indentation
Message-Id: <836ebffa-3074-7c98-c8f1-43227eacdaa1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120133838.13132-1-krzk@kernel.org>
        <20191120134546.GA2654@pine>
        <CGME20191120135021eucas1p206063d872dc96d25d0f10fc99ab41124@eucas1p2.samsung.com>
        <20191120135012.GA17348@kozik-lap>
In-Reply-To: <20191120135012.GA17348@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org


[ added Jiri to Cc: ]

On 11/20/19 2:50 PM, Krzysztof Kozlowski wrote:
> On Wed, Nov 20, 2019 at 08:45:46AM -0500, Daniel Thompson wrote:
>> On Wed, Nov 20, 2019 at 09:38:38PM +0800, Krzysztof Kozlowski wrote:
>>> Adjust indentation from spaces to tab (+optional two spaces) as in
>>> coding style with command like:
>>> 	$ sed -e 's/^        /\t/' -i */Kconfig
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> No particular objections but I wonder if this would be better sent to
>> trivial@kernel.org .
> 
> Thanks for feedback.
> 
> I sent to trivial and kernel-janitors my previous version of this
> patchset which was not split per-subsystem and there was no feedback.
> Few other patches already came through maintainers. If there will be no
> reply, I'll send next version through trivial.

If anyone wants to merge it through backlight or trivial tree:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Otherwise I'll queue this through drm-misc tree for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
