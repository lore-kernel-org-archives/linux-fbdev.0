From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Aug 2020 13:52:01 +0000
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon / ARM: Prepare for multiplatform S3C
Message-Id: <7caa287e-5e02-95d1-0397-5ae74e3138a1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
 <CGME20200820155923eucas1p2f73e16e6321e3592bd702ea657ff0709@eucas1p2.samsung.com>
 <20200820155913.GA21395@kozik-lap>
In-Reply-To: <20200820155913.GA21395@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org


[ trimmed Cc: list ]

On 8/20/20 5:59 PM, Krzysztof Kozlowski wrote:
> On Thu, Aug 06, 2020 at 08:19:32PM +0200, Krzysztof Kozlowski wrote:
>> Hi All,
>>
>> Shortly
>> ===>> This is a continuation of Arnd's work from 2019 [1].  The goal is to
>> cleanup, merge and finally make the Samsung S3C24xx and S3C64xx
>> architectures multiplatform.  The multiplatform did not happen yet
>> here... just cleaning up and merging into one mach-s3c.
>>
>> I intend to take it through Samsung SoC tree so all Acks are welcomed.
>>
>> Changes since v1
>> ========
>> 1. Rebased,
>> 2. Addressed comments (including mine),
>> 3. Few new patches.
>>
>> Please see individual changelogs (per patch).
>>
>> [1] https://patchwork.kernel.org/project/linux-samsung-soc/list/?series5855&state=*
>>
> 
> Hi All,

Hi Krzysztof,

> I applied second part of the set which finishes this step of S3C
> cleanup. Thanks to Arnd for the work!

Thank you (& Arnd) for working on this!

PS I've checked fbdev related changes now and they all look good to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> Krzysztof
