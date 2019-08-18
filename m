From: Michael Kelley <mikelley@microsoft.com>
Date: Sun, 18 Aug 2019 20:06:10 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
Message-Id: <DM5PR21MB01378677679802BD9A6B160BD7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813095351.1780-1-weh@microsoft.com>
In-Reply-To: <20190813095351.1780-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Iouri Tarassov <iourit@microsoft.com>

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, August 13, 2019 2:55 AM
> 
> Beginning from Windows 10 RS5+, VM screen resolution is obtained from host.
> The "video=hyperv_fb" boot time option is not needed, but still can be
> used to overwrite the VM resolution. The VM resolution on the host could be

I would word this as "used to override what the host specifies."

> set by executing the powershell "set-vmvideo" command.
> 
> Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 136 +++++++++++++++++++++++++++++---
>  1 file changed, 125 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 00f5bdcc6c6f..1042f3311fa2 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -23,6 +23,14 @@
>   *
>   * Portrait orientation is also supported:
>   *     For example: video=hyperv_fb:864x1152
> + *
> + * When a Windows 10 RS5+ host is used, the virtual machine screen
> + * resolution is obtained from the host. The "video=hyperv_fb" option is
> + * not needed, but still can be used to overwrite the VM resolution. The

As above, "but still can be used to override what the host specifies."

> + * VM resolution on the host could be set by executing the powershell
> + * "set-vmvideo" command. For example
> + *     set-vmvideo -vmname name -horizontalresolution:1920 \
> + * -verticalresolution:1200 -resolutiontype single
>   */
> 
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -44,6 +52,7 @@
>  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
>  #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
>  #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
> +#define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
> 
>  #define SYNTHVID_DEPTH_WIN7 16
>  #define SYNTHVID_DEPTH_WIN8 32
> @@ -82,16 +91,25 @@ enum synthvid_msg_type {
>  	SYNTHVID_POINTER_SHAPE		= 8,
>  	SYNTHVID_FEATURE_CHANGE		= 9,
>  	SYNTHVID_DIRT			= 10,
> +	SYNTHVID_RESOLUTION_REQUEST	= 13,
> +	SYNTHVID_RESOLUTION_RESPONSE	= 14,
> 
> -	SYNTHVID_MAX			= 11
> +	SYNTHVID_MAX			= 15
>  };
> 
> +#define		SYNTHVID_EDID_BLOCK_SIZE	128
> +#define		SYNTHVID_MAX_RESOLUTION_COUNT	64
> +
> +struct hvd_screen_info {
> +	u16 width;
> +	u16 height;
> +} __packed;
> +
>  struct synthvid_msg_hdr {
>  	u32 type;
>  	u32 size;  /* size of this header + payload after this field*/
>  } __packed;
> 
> -
>  struct synthvid_version_req {
>  	u32 version;
>  } __packed;
> @@ -102,6 +120,18 @@ struct synthvid_version_resp {
>  	u8 max_video_outputs;
>  } __packed;
> 
> +struct synthvid_supported_resolution_req {
> +	u8 maximum_resolution_count;
> +} __packed;
> +
> +struct synthvid_supported_resolution_resp {
> +	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
> +	u8 resolution_count;
> +	u8 default_resolution_index;
> +	u8 is_standard;
> +	struct hvd_screen_info supported_resolution[1];

It seems like the array size should be SYNTHVID_MAX_RESOLUTION_COUNT.
Otherwise code might not factor in the full size of the data structure, such
as in the memset() call in synthvid_get_supported_resolution().

> +} __packed;
> +
>  struct synthvid_vram_location {
>  	u64 user_ctx;
>  	u8 is_vram_gpa_specified;
> @@ -187,6 +217,8 @@ struct synthvid_msg {
>  		struct synthvid_pointer_shape ptr_shape;
>  		struct synthvid_feature_change feature_chg;
>  		struct synthvid_dirt dirt;
> +		struct synthvid_supported_resolution_req resolution_req;
> +		struct synthvid_supported_resolution_resp resolution_resp;
>  	};
>  } __packed;
> 
> @@ -224,6 +256,8 @@ struct hvfb_par {
> 
>  static uint screen_width = HVFB_WIDTH;
>  static uint screen_height = HVFB_HEIGHT;
> +static uint screen_width_max = HVFB_WIDTH;
> +static uint screen_height_max = HVFB_HEIGHT;
>  static uint screen_depth;
>  static uint screen_fb_size;
> 
> @@ -354,6 +388,7 @@ static void synthvid_recv_sub(struct hv_device *hdev)
> 
>  	/* Complete the wait event */
>  	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
> +	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
>  	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
>  		memcpy(par->init_buf, msg, MAX_VMBUS_PKT_SIZE);
>  		complete(&par->wait);
> @@ -428,6 +463,64 @@ static int synthvid_negotiate_ver(struct hv_device *hdev, u32 ver)
>  	}
> 
>  	par->synthvid_version = ver;
> +	pr_info("Synthvid Version major %d, minor %d\n",
> +		ver & 0x0000ffff, (ver & 0xffff0000) >> 16);
> +
> +out:
> +	return ret;
> +}
> +
> +/* Get current resolution from the host */
> +static int synthvid_get_supported_resolution(struct hv_device *hdev)
> +{
> +	struct fb_info *info = hv_get_drvdata(hdev);
> +	struct hvfb_par *par = info->par;
> +	struct synthvid_msg *msg = (struct synthvid_msg *)par->init_buf;
> +	int ret = 0;
> +	unsigned long t;
> +	u8 index;
> +	int i;
> +
> +	memset(msg, 0, sizeof(struct synthvid_msg));
> +	msg->vid_hdr.type = SYNTHVID_RESOLUTION_REQUEST;
> +	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> +		sizeof(struct synthvid_supported_resolution_req);
> +
> +	msg->resolution_req.maximum_resolution_count =
> +		SYNTHVID_MAX_RESOLUTION_COUNT;
> +	synthvid_send(hdev, msg);
> +
> +	t = wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
> +	if (!t) {
> +		pr_err("Time out on waiting resolution response\n");
> +			ret = -ETIMEDOUT;
> +			goto out;
> +	}
> +
> +	if (msg->resolution_resp.resolution_count == 0) {
> +		pr_err("No supported resolutions\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	index = msg->resolution_resp.default_resolution_index;
> +	if (index >= msg->resolution_resp.resolution_count) {
> +		pr_err("Invalid resolution index: %d\n", index);
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < msg->resolution_resp.resolution_count; i++) {
> +		screen_width_max = max_t(unsigned int, screen_width_max,
> +		    msg->resolution_resp.supported_resolution[i].width);
> +		screen_height_max = max_t(unsigned int, screen_height_max,
> +		    msg->resolution_resp.supported_resolution[i].height);
> +	}
> +
> +	screen_width =
> +		msg->resolution_resp.supported_resolution[index].width;
> +	screen_height =
> +		msg->resolution_resp.supported_resolution[index].height;
> 
>  out:
>  	return ret;
> @@ -448,11 +541,21 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
>  	}
> 
>  	/* Negotiate the protocol version with host */
> -	if (vmbus_proto_version == VERSION_WS2008 ||
> -	    vmbus_proto_version == VERSION_WIN7)
> +	switch (vmbus_proto_version) {
> +	case VERSION_WS2008:
> +	case VERSION_WIN7:
>  		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
> -	else
> +		break;
> +	case VERSION_WIN8:
> +	case VERSION_WIN8_1:
>  		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
> +		break;
> +	case VERSION_WIN10:

I wonder if this does the right thing on a system with VERSION_WIN10.  The existing
code would treat this like VERSION_WIN8.  Your commit message says that the new
functionality of getting the resolution from the host came as part of RS5, and I suspect
there are host versions that report VERSION_WIN10 but that aren't RS5.  You may have
already clarified this with the Hyper-V people, but if not, we should do so.  The
version negotiation here doesn't fallback to an earlier version if Hyper-V doesn't accept
what this code requests.  However, the more robust approach might be to implement
fallback on the SYNTHVID_VERSION setting.

> +	case VERSION_WIN10_V5:
> +	default:
> +		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
> +		break;
> +	}
> 

Michael
