From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 23 Jul 2015 03:56:43 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: ddk750_power.c: Remove optionnal parentheses.
Message-Id: <20150723035643.GA29377@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437138274-23146-1-git-send-email-antoine.blin@lip6.fr>
In-Reply-To: <1437138274-23146-1-git-send-email-antoine.blin@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antoine BLIN <antoine.blin@lip6.fr>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org

On Fri, Jul 17, 2015 at 03:04:33PM +0200, Antoine BLIN wrote:
> Fix up "return is not a function, parentheses are not required" error found by
> the checkpatch.pl script.
> 
> Signed-off-by: Antoine BLIN <antoine.blin@lip6.fr>
> ---
>  drivers/staging/sm750fb/ddk750_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Someone else already sent this fix in just before you did, sorry.

thanks,

greg k-h
