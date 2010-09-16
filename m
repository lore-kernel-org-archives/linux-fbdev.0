From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 16 Sep 2010 16:07:45 +0000
Subject: Re: [PATCH] drivers/video/via/ioctl.c: prevent reading
Message-Id: <20100916160745.GC14318@home.goodmis.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1284587059.6275.101.camel@dan>
In-Reply-To: <1284587059.6275.101.camel@dan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Rosenberg <drosenberg@vsecurity.com>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org

On Wed, Sep 15, 2010 at 05:44:19PM -0400, Dan Rosenberg wrote:
> The VIAFB_GET_INFO device ioctl allows unprivileged users to read 1968
> bytes of uninitialized stack memory, because the "reserved" member of
> the viafb_ioctl_info struct declared on the stack is not altered or
> zeroed before being copied back to the user.  This patch takes care of
> it.
> 
> Signed-off-by: Dan Rosenberg <dan.j.rosenberg@gmail.com>
> 
> --- linux-2.6.35.4.orig/drivers/video/via/ioctl.c	2010-08-26 19:47:12.000000000 -0400
> +++ linux-2.6.35.4/drivers/video/via/ioctl.c	2010-09-15 11:53:29.997375748 -0400
> @@ -25,6 +25,8 @@ int viafb_ioctl_get_viafb_info(u_long ar
>  {
>  	struct viafb_ioctl_info viainfo;
>  
> +	memset(&viainfo, 0, sizeof(struct viafb_ioctl));
> +

Again, this could probably be better off as:

-  	struct viafb_ioctl_info viainfo;
+  	struct viafb_ioctl_info viainfo = {
+  		.viafb_id = VIAID,
+ 		.vendor_id = PCI_VIA_VENDOR_ID,
+	};

-  	viainfo.viafb_id = VIAID;
-  	viainfo.vendor_id = PCI_VIA_VENDOR_ID;

-- Steve

>  	viainfo.viafb_id = VIAID;
>  	viainfo.vendor_id = PCI_VIA_VENDOR_ID;
>  
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
