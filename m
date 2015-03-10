From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 07:54:26 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <20150310074226.GA12561@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 08:57:08PM +0000, Lorenzo Stoakes wrote:
>  
> +#include <asm/io.h>
> +
apart from what Dan Carpenter has said,
this is introducing one checkpatch warning, better to use #include <linux/io.h>
checkpatch is also giving warning about your patch subject

only one concern - if Greg first applies the patches i sent yesterday then this patch will not apply, and if this one is applied first then my series will not apply ...

regards
sudip

>  /* This is all the chips recognized by this library */
>  	mmio750 = addr;
>  	devId750 = devId;
> -- 
> 2.3.2
> 
