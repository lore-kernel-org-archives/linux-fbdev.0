From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 17 Feb 2012 07:30:07 +0000
Subject: Re: [patch] viafb: NULL dereference on allocation failure in query_edid()
Message-Id: <4F3E01FF.4040003@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120217064501.GD3666@elgon.mountain>
In-Reply-To: <20120217064501.GD3666@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 02/17/2012 06:45 AM, Dan Carpenter wrote:
> We should handle the allocation here, if only to keep the static
> checkers happy.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ah, thanks for noticing it and sorry that I introduced it in the first place.
Applied.


Thanks,

Florian Tobias Schandinat

> 
> diff --git a/drivers/video/via/via_aux_edid.c b/drivers/video/via/via_aux_edid.c
> index 03f7a41..754d450 100644
> --- a/drivers/video/via/via_aux_edid.c
> +++ b/drivers/video/via/via_aux_edid.c
> @@ -36,10 +36,13 @@ static void query_edid(struct via_aux_drv *drv)
>  	unsigned char edid[EDID_LENGTH];
>  	bool valid = false;
>  
> -	if (spec)
> +	if (spec) {
>  		fb_destroy_modedb(spec->modedb);
> -	else
> +	} else {
>  		spec = kmalloc(sizeof(*spec), GFP_KERNEL);
> +		if (!spec)
> +			return;
> +	}
>  
>  	spec->version = spec->revision = 0;
>  	if (via_aux_read(drv, 0x00, edid, EDID_LENGTH)) {
> 

