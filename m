From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 24 Apr 2015 07:14:13 +0000
Subject: Re: [PATCH] staging: sm750fb: cleanup white space and indent
Message-Id: <20150424070213.GD3489@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429823048-9094-1-git-send-email-charles.rose.linux@gmail.com>
In-Reply-To: <1429823048-9094-1-git-send-email-charles.rose.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Charles Rose <charles.rose.linux@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Apr 23, 2015 at 05:04:08PM -0400, Charles Rose wrote:
> This patch fixes "space prohibited" errors reported by checkpatch.pl
> and related indentation. The module builds without error.
> 
> Signed-off-by: Charles Rose <charles.rose.linux@gmail.com>
<snip>
> -	if ( x = 800 && y = 600 )
> -    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
> +	if (x = 800 && y = 600)
> +		dispControl = FIELD_SET(dispControl,
> +				CRT_DISPLAY_CTRL, CLK, PLL41);

Alignment should match open parenthesis

regards
sudip
