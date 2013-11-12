From: Dmitry Artamonow <mad_soft@inbox.lv>
Date: Tue, 12 Nov 2013 12:00:59 +0000
Subject: Re: [PATCH 4/5] arm: sa1100: add a clock alias for sa1111 pcmcia device
Message-Id: <5282187B.7040402@inbox.lv>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
 <1384227132-10501-4-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1384227132-10501-4-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

12.11.2013 07:32, Dmitry Eremin-Solenikov wrote:
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>   arch/arm/mach-sa1100/clock.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
> index abf1dc1..cd4762d 100644
> --- a/arch/arm/mach-sa1100/clock.c
> +++ b/arch/arm/mach-sa1100/clock.c
> @@ -124,6 +124,7 @@ static struct clk_lookup sa11xx_clkregs[] = {
>   	CLKDEV_INIT("sa1100-rtc", NULL, NULL),
>   	CLKDEV_INIT("sa11x0-fb", NULL, &clk_cpu),
>   	CLKDEV_INIT("sa11x0-pcmcia", NULL, &clk_cpu),
> +	CLKDEV_INIT("1600", NULL, &clk_cpu), /* sa1111 pcmcia */

Shouldn't it be "1800" here? As I can see device name for sa1111 devices is
initialized from offset in sa1111_init_one_child():
         dev_set_name(&dev->dev, "%4.4lx", info->offset);

And the offset for SA1111_PCMCIA is 0x1800:

         {
                 .offset         = 0x1800,
                 .skpcr_mask     = 0,
                 .devid          = SA1111_DEVID_PCMCIA,
                 .irq = {
                         IRQ_S0_READY_NINT,
                         IRQ_S0_CD_VALID,
                         IRQ_S0_BVD1_STSCHG,
                         IRQ_S1_READY_NINT,
                         IRQ_S1_CD_VALID,
                         IRQ_S1_BVD1_STSCHG,
                 },
         },

Also it would be nice if you could add some words about this strange 
sa1111 device
naming convention in commit changelog. It's really puzzling to see 
string like
"1600" in clock's devid.

--
Best regards,
Dmitry
