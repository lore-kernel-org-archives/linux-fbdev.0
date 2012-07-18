From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Wed, 18 Jul 2012 15:56:32 +0000
Subject: Re: [PATCH RESEND] video: da8xx-fb: enable sync lost interrupt
Message-Id: <5006DCB0.8010609@mvista.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342625417-6974-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342625417-6974-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello.

On 07/18/2012 07:30 PM, Manjunathappa, Prakash wrote:

> Patch enables sync lost interrupt and interrupt handler already
> takes care to handle it.

> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Resending as my earlier patch seems like not reached fbdev mailing list.

>  drivers/video/da8xx-fb.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 88e98ea..e9d2f6e 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -54,6 +54,7 @@
>  #define LCD_DMA_BURST_8			0x3
>  #define LCD_DMA_BURST_16		0x4
>  #define LCD_V1_END_OF_FRAME_INT_ENA	BIT(2)
> +#define LCD_V1_SYNC_LOST_ENA            BIT(5)

   Please indent the value with tabs, as the others.

>  #define LCD_V2_END_OF_FRAME0_INT_ENA	BIT(8)
>  #define LCD_V2_END_OF_FRAME1_INT_ENA	BIT(9)
>  #define LCD_DUAL_FRAME_BUFFER_ENABLE	BIT(0)

WBR, Sergei
