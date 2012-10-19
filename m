From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Fri, 19 Oct 2012 13:00:11 +0000
Subject: Re: [PATCH 4/5] xen-fbfront: handle backend CLOSED without CLOSING
Message-Id: <20121019130011.GD26830@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <507FD39F.4060601@citrix.com>
 <1350554618-14582-4-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1350554618-14582-4-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <david.vrabel@citrix.com>, FlorianSchandinat@gmx.de
Cc: xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Oct 18, 2012 at 11:03:37AM +0100, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Backend drivers shouldn't transistion to CLOSED unless the frontend is
> CLOSED.  If a backend does transition to CLOSED too soon then the
> frontend may not see the CLOSING state and will not properly shutdown.
> 
> So, treat an unexpected backend CLOSED state the same as CLOSING.
> 
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
> Cc: linux-fbdev@vger.kernel.org
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Hey Florian,

Should I prep a git pull for you with this or would it be OK
if I just have your Ack to put this in my git pull for Linus?

Thanks!
> ---
>  drivers/video/xen-fbfront.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
> index b7f5173..917bb56 100644
> --- a/drivers/video/xen-fbfront.c
> +++ b/drivers/video/xen-fbfront.c
> @@ -641,7 +641,6 @@ static void xenfb_backend_changed(struct xenbus_device *dev,
>  	case XenbusStateReconfiguring:
>  	case XenbusStateReconfigured:
>  	case XenbusStateUnknown:
> -	case XenbusStateClosed:
>  		break;
>  
>  	case XenbusStateInitWait:
> @@ -670,6 +669,10 @@ InitWait:
>  		info->feature_resize = val;
>  		break;
>  
> +	case XenbusStateClosed:
> +		if (dev->state = XenbusStateClosed)
> +			break;
> +		/* Missed the backend's CLOSING state -- fallthrough */
>  	case XenbusStateClosing:
>  		xenbus_frontend_closed(dev);
>  		break;
> -- 
> 1.7.2.5
