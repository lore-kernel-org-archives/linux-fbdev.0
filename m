From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 15 Jan 2015 12:26:35 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <20150115122635.GC6201@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 15, 2015 at 01:56:58PM +0200, Tomi Valkeinen wrote:
> 
> Here's a fix for the cea_array size. Does it silence the static checker?
> 

No.

>  	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
>  		int idx = svd[i - specs->modedb_len - num];
> -		if (!idx || idx > 63) {
> +		if (!idx || idx > 64) {
>  			pr_warning("Reserved SVD code %d\n", idx);
>  		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
>  			pr_warning("Unimplemented SVD code %d\n", idx);

This static check ignores the value of "idx".

It is only looking at "idx > ARRAY_SIZE(cea_modes)" which is off by one
and "idx" is used as an index in "!cea_modes[idx].xres".

The thinking behind this static checker warnings is that off-by-one bugs
are an easy way to boost your patch count even if it's impossible to hit
them in real life.  :)  The value of "idx" is deliberately ignored.

regards,
dan carpenter

