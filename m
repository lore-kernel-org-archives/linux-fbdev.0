From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 23 Mar 2015 11:29:10 +0000
Subject: Re: [PATCH 13/13] staging: sm750: move assignment out of if cond
Message-Id: <20150323112910.GH10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322231516.GA17336@x230-arch.club.entropia.de>
In-Reply-To: <20150322231516.GA17336@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 12:15:16AM +0100, Michel von Czettritz wrote:
> This patch moves the assignments from the if conditions to the line before the condition.
> The 3 occurrence are return values and the checks for errors.
> 
> Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index c250882..a4a7fed 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -474,7 +474,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
>  
>  	console_lock();
>  
> -	if ((ret = pci_set_power_state(pdev, PCI_D0)) != 0) {
> +	ret = pci_set_power_state(pdev, PCI_D0);
> +	if (ret != 0) {

Use "if (ret) ".  The double negative is not not a waste of time.

regards,
dan carpenter

