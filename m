From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 29 Jan 2013 00:22:38 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <20130128162238.7fba92fe.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50F2A310.5010006@ahsoftware.de>
	<1359139768-32294-1-git-send-email-holler@ahsoftware.de>
	<1359139768-32294-2-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1359139768-32294-2-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

On Fri, 25 Jan 2013 19:49:27 +0100
Alexander Holler <holler@ahsoftware.de> wrote:

> When a device was disconnected the driver may hang at waiting for urbs it never
> will get. Fix this by using a timeout while waiting for the used semaphore.
> 
> There is still a memory leak if a timeout happens, but at least the driver
> now continues his disconnect routine.
> 
> ...
>
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -1832,8 +1832,9 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
>  	/* keep waiting and freeing, until we've got 'em all */
>  	while (count--) {
>  
> -		/* Getting interrupted means a leak, but ok at disconnect */
> -		ret = down_interruptible(&dev->urbs.limit_sem);
> +		/* Timeout likely occurs at disconnect (resulting in a leak) */
> +		ret = down_timeout_killable(&dev->urbs.limit_sem,
> +						FREE_URB_TIMEOUT);
>  		if (ret)
>  			break;

This is rather a hack.  Do you have an understanding of the underlying
bug?  Why is the driver waiting for things which will never happen?

