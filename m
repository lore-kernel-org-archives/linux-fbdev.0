From: Sylwester Nawrocki <snjw23@gmail.com>
Date: Wed, 22 Jun 2011 20:33:24 +0000
Subject: Re: [PATCH V5 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD
Message-Id: <4E025194.5040603@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308724904-31521-1-git-send-email-jg1.han@samsung.com>	<002901cc30c1$5ac6ef70$1054ce50$%szyprowski@samsung.com>	<BANLkTimPjo+WefApQLe=HKbYLCwmo_gGRw@mail.gmail.com> <BANLkTi=iS3H8xYhouvZZwP5_daxoGSBwLA@mail.gmail.com>
In-Reply-To: <BANLkTi=iS3H8xYhouvZZwP5_daxoGSBwLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anand Kumar N <anand.kn@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Jonghun Han <jonghun.han@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>

On 06/22/2011 03:25 PM, Anand Kumar N wrote:
> Instead of hardcoding the parent clock in platform/bootloader code ,is
> it not possible to select/set the
> parent clock based on the pixel clk(plat data) having the least delta
> with the 9 src clks.with this change I have checked it for WA101S.

While at first sight this may look as an awesome idea I don't really 
believe it is. There might be other criteria that need to be considered,
like continuous clock availability or frequency stability. 
That said we could possibly have the driver setting sclk_fimd frequency
based on display planes' properties (this was my initial suggestion) 
but sclk_fimd parent should be fixed either by bootloader or board
initialization code.



