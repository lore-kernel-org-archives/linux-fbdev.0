From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 20 Jun 2015 07:36:02 +0000
Subject: Re: [PATCH 6/8] Staging: sm750fb: ddk750_sii164.c: Place braces on previous lines
Message-Id: <20150620072402.GA15195@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434743301-14774-1-git-send-email-isaac.a.travers@gmail.com>
 <1434743301-14774-7-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1434743301-14774-7-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com

On Fri, Jun 19, 2015 at 12:48:19PM -0700, Isaac Assegai wrote:
> Place braces on previous lines in ddk750_sii164.c to
> rectify the following checkpatch errors:
> ERROR: that open brace { should be on the previous line
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index 7f58fbe..64d4291 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -136,8 +136,7 @@ long sii164InitChip(
>  #endif
>  
>  	/* Check if SII164 Chip exists */
> -	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
> -	{
> +	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID) {
												^^^^
you have not build tested it :(
In function ‘sii164InitChip’:
error: expected ‘)’ before ‘{’ token

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
