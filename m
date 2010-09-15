From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 15 Sep 2010 22:42:12 +0000
Subject: Re: [PATCH] drivers/video/via/ioctl.c: prevent reading uninitialized
Message-Id: <4C914BC4.8070809@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1284587059.6275.101.camel@dan>
In-Reply-To: <1284587059.6275.101.camel@dan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Rosenberg <drosenberg@vsecurity.com>
Cc: JosephChan@via.com.tw, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org

Hi,

Dan Rosenberg schrieb:
> The VIAFB_GET_INFO device ioctl allows unprivileged users to read 1968
> bytes of uninitialized stack memory, because the "reserved" member of
> the viafb_ioctl_info struct declared on the stack is not altered or
> zeroed before being copied back to the user.  This patch takes care of
> it.

I am wondering about the number of bytes as sizeof(struct viafb_ioctl_info) = 
256 so it should be a bit less. But that's just nitpicking, the issue is 
certainly real. Your patch does the right thing but there is a bug in it:

> Signed-off-by: Dan Rosenberg <dan.j.rosenberg@gmail.com>
> 
> --- linux-2.6.35.4.orig/drivers/video/via/ioctl.c	2010-08-26 19:47:12.000000000 -0400
> +++ linux-2.6.35.4/drivers/video/via/ioctl.c	2010-09-15 11:53:29.997375748 -0400
> @@ -25,6 +25,8 @@ int viafb_ioctl_get_viafb_info(u_long ar
>  {
>  	struct viafb_ioctl_info viainfo;
>  
> +	memset(&viainfo, 0, sizeof(struct viafb_ioctl));

Shouldn't it be sizeof(struct viafb_ioctl_info) or sizeof(viainfo) ?
At least here it does not even compile otherwise....


Thanks,

Florian Tobias Schandinat
