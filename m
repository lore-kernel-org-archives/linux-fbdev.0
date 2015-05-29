From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 29 May 2015 13:13:42 +0000
Subject: Re: [PATCHv3 1/4] phy: phy-core: Make GENERIC_PHY an invisible option
Message-Id: <55686606.1010701@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1429743853-10254-2-git-send-email-arun.ramamurthy@broadcom.com>
 <55685D7E.9000700@ti.com>
In-Reply-To: <55685D7E.9000700@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 29/05/15 14:37, Kishon Vijay Abraham I wrote:
> Tejun, Maxime, Sylwester, Kyungmin
> 
> On Thursday 23 April 2015 04:34 AM, Arun Ramamurthy wrote:
>> Most of the phy providers use "select" to enable GENERIC_PHY. Since select
>> is only recommended when the config is not visible, GENERIC_PHY is changed
>> an invisible option. To maintain consistency, all phy providers are changed
>> to "select" GENERIC_PHY and all non-phy drivers use "depends on" when the
>> phy framework is explicity required. USB_MUSB_OMAP2PLUS has a cyclic
>> dependency, so it is left as "select".
>>
>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> 
> Need your ACK for this patch.

For
	drivers/media/platform/exynos4-is/Kconfig
	drivers/video/fbdev/exynos/Kconfig

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

--
Thanks,
Sylwester
