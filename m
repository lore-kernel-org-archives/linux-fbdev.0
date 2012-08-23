From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:48:25 +0000
Subject: Re: [PATCH 8/14] drivers/video/sunxvr2500.c: fix error return code
Message-Id: <50369719.9050306@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr> <1345365870-29831-9-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1345365870-29831-9-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/19/2012 08:44 AM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize return variable before exiting on an error path.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/sunxvr2500.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
> index 5848436..7fbcba8 100644
> --- a/drivers/video/sunxvr2500.c
> +++ b/drivers/video/sunxvr2500.c
> @@ -181,8 +181,10 @@ static int __devinit s3d_pci_register(struct pci_dev *pdev,
>  	sp->fb_size = info->fix.line_length * sp->height;
>  
>  	sp->fb_base = ioremap(sp->fb_base_phys, sp->fb_size);
> -	if (!sp->fb_base)
> +	if (!sp->fb_base) {
> +		err = -ENOMEM;
>  		goto err_release_pci;
> +	}
>  
>  	err = s3d_set_fbinfo(sp);
>  	if (err)
> 
> 

