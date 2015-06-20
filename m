From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 20 Jun 2015 10:57:05 +0000
Subject: Re: [PATCH 1/4] staging: sm750fb: use tabs for indentation
Message-Id: <20150620104505.GB29626@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
 <1434790115-21683-1-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1434790115-21683-1-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, Jun 20, 2015 at 01:48:32AM -0700, Juston Li wrote:
> Replace spaces with tabs for indentation to fix the checkpatch.pl error
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line
> 
> Signed-off-by: Juston Li <juston.h.li@gmail.com>
> ---
<snip>
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index b6395b8..c09748c 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
<snip>
>  
> @@ -279,27 +279,25 @@ char *sii164GetChipString(void)
>   *  Input:
>   *      powerUp - Flag to set the power down or up
>   */
> -void sii164SetPower(
> -    unsigned char powerUp
> -)
> +void sii164SetPower(unsigned char powerUp)
is it that same patch again? different kind of change should go in a separate patch.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
