From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 25 Jun 2015 12:29:29 +0000
Subject: Re: [PATCH v3 16/19] staging: sm750fb: fix brace placement
Message-Id: <20150625121729.GD13366@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
 <1435163120-3253-16-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1435163120-3253-16-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Wed, Jun 24, 2015 at 09:25:17AM -0700, Juston Li wrote:
> Fix brace placement errors caught by checkpatch.pl
> ERROR: that open brace { should be on the previous line
> 
> Signed-off-by: Juston Li <juston.h.li@gmail.com>
> ---
<snip>
> @@ -71,14 +66,11 @@ static void setDisplayControl(int ctrl, int dispState)
>  			POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
>  		}
>  
> -	}
>  	/* Set the secondary display control */
> -	else
> -	{
> +	} else {
just a thought. The comment previously was at the beginning of the else
block, but now it will be placed inside the if block - at the end.
will it confuse code readers afterwards?

regards
sudip
