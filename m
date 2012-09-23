From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:43:14 +0000
Subject: Re: [PATCH 7/10] drivers/video/sis/initextlfb.c: removes unnecessary semicolon
Message-Id: <505F6652.7050207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346947757-10481-1-git-send-email-peter.senna@gmail.com> <1346947757-10481-8-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1346947757-10481-8-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/06/2012 04:09 PM, Peter Senna Tschudin wrote:
> From: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> removes unnecessary semicolon
> 
> Found by Coccinelle: http://coccinelle.lip6.fr/
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/sis/initextlfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/video/sis/initextlfb.c b/drivers/video/sis/initextlfb.c
> --- a/drivers/video/sis/initextlfb.c
> +++ b/drivers/video/sis/initextlfb.c
> @@ -65,7 +65,7 @@ sisfb_mode_rate_to_dclock(struct SiS_Pri
>      }
>  #endif
>  
> -    if(!(SiS_SearchModeID(SiS_Pr, &ModeNo, &ModeIdIndex))) {;
> +    if(!(SiS_SearchModeID(SiS_Pr, &ModeNo, &ModeIdIndex))) {
>         printk(KERN_ERR "Could not find mode %x\n", ModeNo);
>         return 65000;
>      }
> 
> 

