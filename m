From: Michael Kelley <mikelley@microsoft.com>
Date: Wed, 21 Aug 2019 23:48:42 +0000
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
Message-Id: <DM5PR21MB01370CB55C3011582F6F8C5CD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190821111007.3490-1-weh@microsoft.com>
In-Reply-To: <20190821111007.3490-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
Cc: Iouri Tarassov <iourit@microsoft.com>

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, August 21, 2019 4:11 AM
> 
> Beginning from Windows 10 RS5+, VM screen resolution is obtained from host.
> The "video=hyperv_fb" boot time option is not needed, but still can be
> used to overwrite what the host specifies. The VM resolution on the host
> could be set by executing the powershell "set-vmvideo" command.
> 
> v2:
> - Implemented fallback when version negotiation failed.
> - Defined full size for supported_resolution array.
> 
> Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: lines should not be added to patches until the reviewer
has actually given a "Reviewed-by:" statement, and I haven't done that
yet. :-)  Such statements are typically not given until review
comments have been addressed and re-reviewed as necessary.

> ---
>  drivers/video/fbdev/hyperv_fb.c | 145 +++++++++++++++++++++++++++++---
>  1 file changed, 133 insertions(+), 12 deletions(-)
> 
> +
> +struct synthvid_supported_resolution_resp {
> +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> +	u8 resolution_count;
> +	u8 default_resolution_index;
> +	u8 is_standard;
> +	struct hvd_screen_info
> +		supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT];

Is there extra whitespace on this line?  Just wondering why it doesn't
line up.

> +} __packed;
> +
> @@ -448,11 +542,27 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
>  	}
> 
>  	/* Negotiate the protocol version with host */
> -	if (vmbus_proto_version == VERSION_WS2008 ||
> -	    vmbus_proto_version == VERSION_WIN7)
> -		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> -	else
> +	switch (vmbus_proto_version) {
> +	case VERSION_WIN10:
> +	case VERSION_WIN10_V5:
> +		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		if (!ret)
> +			break;
> +		/* Fallthrough */
> +	case VERSION_WIN8:
> +	case VERSION_WIN8_1:
>  		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
> +		if (!ret)
> +			break;
> +		/* Fallthrough */
> +	case VERSION_WS2008:
> +	case VERSION_WIN7:
> +		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> +		break;
> +	default:
> +		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		break;

I'm tempted to put "default:" up with VERSION_WIN10 and VERISON_WIN10_V5
so that it can also fallback to earlier versions.  You would have a couple of less
lines of code.  But arguably newer versions should always go with
SYNTHVID_VERSION_WIN10 and not fallback.  I don't have a strong opinion
either way.

> +	}
> 
>  	if (ret) {
>  		pr_err("Synthetic video device version not accepted\n");
> @@ -464,6 +574,12 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
>  	else
>  		screen_depth = SYNTHVID_DEPTH_WIN8;
> 
> +	if (par->synthvid_version >= SYNTHVID_VERSION_WIN10) {

Unfortunately, this "greater than" comparison won't work correctly because
the minor version is stored in the high order bits.  Version 4.0 would compare
as less than version 3.5 (which is what SYNTHVID_VERSION_WIN10 is).

> +		ret = synthvid_get_supported_resolution(hdev);
> +		if (ret)
> +			pr_info("Failed to get supported resolution from host, use
> default\n");
> +	}
> +
>  	screen_fb_size = hdev->channel->offermsg.offer.
>  				mmio_megabytes * 1024 * 1024;
> 
> @@ -653,6 +769,8 @@ static void hvfb_get_option(struct fb_info *info)
>  	}
> 
>  	if (x < HVFB_WIDTH_MIN || y < HVFB_HEIGHT_MIN ||
> +	    (par->synthvid_version >= SYNTHVID_VERSION_WIN10 &&

Same comparison problem here.

> +	    (x > screen_width_max || y > screen_height_max)) ||
>  	    (par->synthvid_version == SYNTHVID_VERSION_WIN8 &&
>  	     x * y * screen_depth / 8 > SYNTHVID_FB_SIZE_WIN8) ||
>  	    (par->synthvid_version == SYNTHVID_VERSION_WIN7 &&
> @@ -689,8 +807,12 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  		}
> 
>  		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> -		    pci_resource_len(pdev, 0) < screen_fb_size)
> +		    pci_resource_len(pdev, 0) < screen_fb_size) {
> +			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> +			       (unsigned long) pci_resource_len(pdev, 0),
> +			       (unsigned long) screen_fb_size);
>  			goto err1;
> +		}

Michael
