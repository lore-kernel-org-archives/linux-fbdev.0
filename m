From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 10 May 2015 13:17:39 +0000
Subject: Re: [PATCH V3 RESEND] staging: sm750: Fix lynxfb_ops_imageblit() if image->depth != 1
Message-Id: <20150510131739.GA4922@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431075868-15746-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1431075868-15746-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, May 08, 2015 at 05:04:28PM +0800, Huacai Chen wrote:
> If image->depth != 1, lynxfb_ops_imageblit() should fallback to call
> cfb_imageblit(), not return directly. Otherwise it can't display the
> boot logo.
> 
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  V2: Coding style ajustment.
>  V3: Add TODO comments.
> 
>  drivers/staging/sm750fb/TODO    |    1 +
>  drivers/staging/sm750fb/sm750.c |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)

Doesn't apply without fuzz, so something isn't synced up properly here.
Please refresh it against my tree and resend.

thanks,

greg k-h
