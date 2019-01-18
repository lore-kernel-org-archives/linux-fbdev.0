From: Joe Perches <joe@perches.com>
Date: Fri, 18 Jan 2019 19:51:20 +0000
Subject: Re: [PATCH] video/hdmi: Change strncpy() into memcpy() in hdmi_spd_infoframe_init
Message-Id: <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190118193248.535-1-malat@debian.org>
In-Reply-To: <20190118193248.535-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 20:32 +0100, Mathieu Malaterre wrote:
> Using strncpy() is less than perfect since the destination buffers do not
> need to be NUL terminated. Replace strncpy() with memcpy() to address a
> warning triggered by gcc using W=1 and optimize the code a bit.
> 
> This commit removes the following warnings:
> 
>   drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
>   drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
[]
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
[]
> @@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>  	frame->version = 1;
>  	frame->length = HDMI_SPD_INFOFRAME_SIZE;
>  
> -	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> -	strncpy(frame->product, product, sizeof(frame->product));
> +	memcpy(frame->vendor, vendor, sizeof(frame->vendor));
> +	memcpy(frame->product, product, sizeof(frame->product));

This is not good.

vendor can be any location and shorter than sizeof(frame->vendor)
so this can copy from invalid memory locations.

You probably want strscpy.

This is called with at least "mediatek" and "broadcom", so perhaps
it's better still to change the struct vendor size to something a
bit larger.  Maybe change vendor[8] to vendor[16];

include/linux/hdmi.h:struct hdmi_spd_infoframe {
include/linux/hdmi.h-   enum hdmi_infoframe_type type;
include/linux/hdmi.h-   unsigned char version;
include/linux/hdmi.h-   unsigned char length;
include/linux/hdmi.h-   char vendor[8];
include/linux/hdmi.h-   char product[16];
include/linux/hdmi.h-   enum hdmi_spd_sdi sdi;
include/linux/hdmi.h-};
