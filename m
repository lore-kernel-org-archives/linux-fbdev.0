From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 29 May 2012 15:05:45 +0000
Subject: Re: [patch] fb: handle NULL pointers in framebuffer release
Message-Id: <4FC4E5C9.1070408@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120514205837.GE20836@elgon.mountain>
In-Reply-To: <20120514205837.GE20836@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/14/2012 08:58 PM, Dan Carpenter wrote:
> This function is called with a potential NULL pointer in
> picolcd_init_framebuffer() and it causes a static checker warning.  This
> used to handle NULL pointers when the picolcd code was written, but a
> couple months later we added the "info->apertures" dereference.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> index 67afa9c..a55e366 100644
> --- a/drivers/video/fbsysfs.c
> +++ b/drivers/video/fbsysfs.c
> @@ -80,6 +80,8 @@ EXPORT_SYMBOL(framebuffer_alloc);
>   */
>  void framebuffer_release(struct fb_info *info)
>  {
> +	if (!info)
> +		return;
>  	kfree(info->apertures);
>  	kfree(info);
>  }
> 

