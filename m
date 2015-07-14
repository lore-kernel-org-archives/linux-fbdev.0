From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 14 Jul 2015 13:20:19 +0000
Subject: Re: [PATCH] staging: sm750fb: ddk750_chip: use consistent spacing
Message-Id: <20150714130819.GA18186@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436854857-12622-1-git-send-email-shshahu@gmail.com>
In-Reply-To: <1436854857-12622-1-git-send-email-shshahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 14, 2015 at 11:50:57AM +0530, Sunil Shahu wrote:
> Remove all checkpatch error by using consistent spacing.
> 
> Signed-off-by: Sunil Shahu <shshahu@gmail.com>
> ---
<snip>
>  			/* round step */
> -			M += (fl_quo*X % 10000)>5000?1:0;
> +			M += (fl_quo*X % 10000) > 5000 ? 1 : 0;
you missed the spacing around this '*'.

regards
sudip
