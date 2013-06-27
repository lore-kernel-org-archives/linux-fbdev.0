From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 27 Jun 2013 08:37:12 +0000
Subject: Re: [PATCH v3 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
Message-Id: <51CBF9B8.70103@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372258946-15607-1-git-send-email-s.nawrocki@samsung.com>
 <1372258946-15607-2-git-send-email-s.nawrocki@samsung.com>
 <20130627075223.GQ15455@arwen.pp.htv.fi>
In-Reply-To: <20130627075223.GQ15455@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/27/2013 09:52 AM, Felipe Balbi wrote:
> On Wed, Jun 26, 2013 at 05:02:22PM +0200, Sylwester Nawrocki wrote:
>> Add a PHY provider driver for the Samsung S5P/Exynos SoC MIPI CSI-2
>> receiver and MIPI DSI transmitter DPHYs.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thank you for your review and ack!

Just for the record, I have tested this driver as a loadable
module on Exynos4412 TRATS2 board and it all worked fine for
both the camera and display side.

--
Regards,
Sylwester

