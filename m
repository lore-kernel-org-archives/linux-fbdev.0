From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 10:57:17 +0000
Subject: Re: [PATCH v2 4/6] staging: sm750fb: Remove unused function
Message-Id: <20150311105708.GG4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426070749-32024-1-git-send-email-lstoakes@gmail.com>
 <1426070749-32024-2-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426070749-32024-2-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 10:45:48AM +0000, Lorenzo Stoakes wrote:
> This patch removes the unused hw712_fillrect function. This patch fixes
> the following sparse warning:-
> 
> drivers/staging/sm750fb/sm750_accel.c:95:5: warning: symbol 'hw712_fillrect' was not declared. Should it be static?
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 78 -----------------------------------
>  1 file changed, 78 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 6521c3b..c5a3726 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c

but function prototype still remains in sm750_accel.h 

regards
sudip
