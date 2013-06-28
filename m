From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 28 Jun 2013 10:02:36 +0000
Subject: Re: [PATCH 1/3] phy: Add driver for Exynos DP PHY
Message-Id: <51CD5F3C.4010504@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501ce73bf$87c49c00$974dd400$@samsung.com>
 <51CD57EF.5010808@ti.com>
In-Reply-To: <51CD57EF.5010808@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 06/28/2013 11:31 AM, Kishon Vijay Abraham I wrote:
>> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
>> b/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
>> new file mode 100644
>> index 0000000..8b6fa79
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos5250-dp-video-phy.txt
> 
> How about creating a single Documentation file for all samsung video phys? 
> Sylwester?

Yes, makes sense. There are quite a few various PHYs on the Exynos SoC.
Let me resend my series with the binding description file name changed
to samsung-phy.txt. I need to add couple fixes to that series anyway.

Regards,
Sylwester
