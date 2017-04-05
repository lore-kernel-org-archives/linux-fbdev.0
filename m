From: Juergen Gross <jgross@suse.com>
Date: Wed, 05 Apr 2017 08:18:21 +0000
Subject: Re: [PATCH] xen, fbfront: fix connecting to backend
Message-Id: <3226cec6-8f68-6d15-4427-eb8f2d1944a1@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170323125252.11763-1-jgross@suse.com>
In-Reply-To: <20170323125252.11763-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com
Cc: boris.ostrovsky@oracle.com, stable@vger.kernel.org

On 23/03/17 13:52, Juergen Gross wrote:
> Connecting to the backend isn't working reliably in xen-fbfront: in
> case XenbusStateInitWait of the backend has been missed the backend
> transition to XenbusStateConnected will trigger the connected state
> only without doing the actions required when the backend has
> connected.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>

Bartlomiej, any comments? Can you please take this patch or should I
carry it through the Xen tree?


Juergen

> ---
>  drivers/video/fbdev/xen-fbfront.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index d0115a7..3ee309c 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -643,7 +643,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>  		break;
>  
>  	case XenbusStateInitWait:
> -InitWait:
>  		xenbus_switch_state(dev, XenbusStateConnected);
>  		break;
>  
> @@ -654,7 +653,8 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>  		 * get Connected twice here.
>  		 */
>  		if (dev->state != XenbusStateConnected)
> -			goto InitWait; /* no InitWait seen yet, fudge it */
> +			/* no InitWait seen yet, fudge it */
> +			xenbus_switch_state(dev, XenbusStateConnected);
>  
>  		if (xenbus_read_unsigned(info->xbdev->otherend,
>  					 "request-update", 0))
> 

