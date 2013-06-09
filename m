From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 09 Jun 2013 12:01:35 +0000
Subject: Re: [V1 4/7] video: mmp: fix memcpy wrong size for mmp_addr issue
Message-Id: <51B46E9F.9020105@cogentembedded.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370767470-11615-1-git-send-email-jtzhou@marvell.com>
In-Reply-To: <1370767470-11615-1-git-send-email-jtzhou@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 09-06-2013 12:44, Jett.Zhou wrote:

> From: Jing Xiang <jxiang@marvell.com>

> Memcpy used wrong struct of mmp_addr, fix it.

     From the patch it follows that 'struct mmp_addr' is the right one. :-)

> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> ---
>   drivers/video/mmp/hw/mmp_ctrl.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
> index 8836053..92a5f44 100644
> --- a/drivers/video/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
> @@ -233,7 +233,7 @@ static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
>   	struct lcd_regs *regs = path_regs(overlay->path);
>
>   	/* FIXME: assert addr supported */
> -	memcpy(&overlay->addr, addr, sizeof(struct mmp_win));
> +	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
>   	writel(addr->phys[0], &regs->g_0);
>
>   	return overlay->addr.phys[0];

WBR, Sergei

