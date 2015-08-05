From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2015 19:01:53 +0000
Subject: Re: [PATCH] staging: sm750fb: fix sparse warning for lock
Message-Id: <20150805190153.GB2856@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438781204-13283-1-git-send-email-van.freenix@gmail.com>
In-Reply-To: <1438781204-13283-1-git-send-email-van.freenix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peng Fan <van.freenix@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 05, 2015 at 09:26:44PM +0800, Peng Fan wrote:
> Use __acquire() and __release() in the right place to silence the sparse
> lock checking warning.
> 
> drivers/staging/sm750fb/sm750.c:177:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:243:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:247:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/sm750fb/sm750.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8e201f1..5ba1c06 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -203,6 +203,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
>  	 */
>  	if (share->dual)
>  		spin_lock(&share->slock);
> +	else
> +		__acquire(&share->slock);

That's horrid, please don't do stuff like this just to make a static
checker "quiet".

greg k-h
