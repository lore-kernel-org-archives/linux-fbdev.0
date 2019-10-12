From: Joe Perches <joe@perches.com>
Date: Sat, 12 Oct 2019 02:07:06 +0000
Subject: Re: [PATCH] staging: sm750fb: align arguments with open parenthesis
Message-Id: <8886b98ca936e7150abf36aa3c9d167073eaba86.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>, outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org

On Fri, 2019-10-11 at 22:19 -0300, Gabriela Bittencourt wrote:
> Cleans up checks of "Alignment should match open parenthesis" in tree sm750fb
[]
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
[]
> @@ -289,7 +289,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
>  }
>  
>  int sm750_hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> +		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
>  		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */

checkpatch only warns on the first unaligned argument, but
all statement lines are meant to align to the open parenthesis.

>  		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
>  		 u32 dBase,    /* Address of destination: offset in frame buffer */
