From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 16 Sep 2016 08:25:37 +0000
Subject: Re: [PATCH v2 2/2] ARM: exynos_defconfig: Remove old non-working MIPI driver
Message-Id: <7a214673-b40c-d901-a0cf-133b28521b86@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
 <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
 <2b3688bb-8dcb-24d4-8112-a0cc56573e48@ti.com>
 <CGME20160916082538eucas1p159a895a88dcfd33ef45a62ef66508fae@eucas1p1.samsung.com>
In-Reply-To: <2b3688bb-8dcb-24d4-8112-a0cc56573e48@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/07/2016 10:14 AM, Tomi Valkeinen wrote:
> On 01/09/16 14:49, Krzysztof Kozlowski wrote:
>> The Exynos MIPI driver does not work anymore (it is board file only) so
>> it is removed.  Remove also config option.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Changes since v1:
>> 1. New patch.
>> ---
>>  arch/arm/configs/exynos_defconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 4e484f406419..fea8edef1534 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -168,7 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
>>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
>>  CONFIG_DRM_NXP_PTN3460=y
>>  CONFIG_DRM_PARADE_PS8622=y
>> -CONFIG_EXYNOS_VIDEO=y
>>  CONFIG_EXYNOS_MIPI_DSI=y
> 
> EXYNOS_MIPI_DSI too?

Yes, this one too. I'll send a v2. I think these patches can safely go
through different trees (removal of driver through your tree and
defconfig through arm-soc).

Best regards,
Krzysztof


