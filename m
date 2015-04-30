From: Kevin Hilman <khilman@kernel.org>
Date: Thu, 30 Apr 2015 15:44:49 +0000
Subject: Re: [RFT PATCH] drm/exynos: Enable DP clock to fix display on Exynos5250 and other
Message-Id: <7h8ud9pqmm.fsf@deeprootsystems.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427471856-20918-1-git-send-email-k.kozlowski@samsung.com>
	<7h8udau9he.fsf@deeprootsystems.com>
	<CAJKOXPc6Epy_L+djManggcaYLaOrQ_c2S0=_GgU=dikuY1UU0g@mail.gmail.com>
In-Reply-To: <CAJKOXPc6Epy_L+djManggcaYLaOrQ_c2S0=_GgU=dikuY1UU0g@mail.gmail.com>
	(Krzysztof Kozlowski's message of "Thu, 30 Apr 2015 08:56:50 +0900")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, David Airlie <airlied@linux.ie>, Jingoo Han <jg1.han@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, stable@vger.kernel.org, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> 2015-04-30 2:31 GMT+09:00 Kevin Hilman <khilman@kernel.org>:
>> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
>>
>>> After adding display power domain for Exynos5250 in commit
>>> 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250") the
>>> display on Chromebook Snow and others stopped working after boot.
>>>
>>> The reason for this suggested Andrzej Hajda: the DP clock was disabled.
>>> This clock is required by Display Port and is enabled by bootloader.
>>> However when FIMD driver probing was deferred, the display power domain
>>> was turned off. This effectively reset the value of DP clock enable
>>> register.
>>>
>>> When exynos-dp is later probed, the clock is not enabled and display is
>>> not properly configured:
>>>
>>> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
>>> exynos-dp 145b0000.dp-controller: unable to config video
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
>>> Cc: <stable@vger.kernel.org>
>>>
>>> ---
>>>
>>> This should fix issue reported by Javier [1][2].
>>>
>>> Tested on Chromebook Snow (Exynos 5250). More testing would be great,
>>> especially on other Exynos 5xxx products.
>>
>> I hoped to try this on my exynos5 boards, but it doesn't seem to apply
>> to linux-next or to Linus' master branch.
>>
>> Are there some other dependencies here?
>
> It is already applied:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id363c7cccf64128087002b0779986ad16aff6dc

Er, yup.  That would explain it. ;)

Sorry for the noise,

Kevin
