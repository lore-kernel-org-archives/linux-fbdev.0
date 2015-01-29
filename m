From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Thu, 29 Jan 2015 13:02:09 +0000
Subject: Re: [PATCH 2/3 v3] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <87oaph7nam.fsf@vitty.brq.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422527056-24929-1-git-send-email-der.herr@hofr.at>
In-Reply-To: <1422527056-24929-1-git-send-email-der.herr@hofr.at> (Nicholas Mc
	Guire's message of "Thu, 29 Jan 2015 11:24:16 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-fbdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, devel@linuxdriverproject.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Nicholas Mc Guire <der.herr@hofr.at> writes:

> The return type of wait_for_completion_timeout is unsigned long not
> int. This patch fixes up the declarations only.
>
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

I would be slightly better to remove ".c" from your subject like,
anyway:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> ---
>
> v2: fixed subject line
> v3: fixed patch description as recommended by Dan Carpenter
>     <dan.carpenter@oracle.com>
>
> Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=y
> CONFIG_HYPERV=m, CONFIG_FB_HYPERV=m
>
> Patch is against 3.19.0-rc5 -next-20150123
>
>  drivers/video/fbdev/hyperv_fb.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 4254336..807ee22 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -415,7 +415,8 @@ static int synthvid_negotiate_ver(struct hv_device *hdev, u32 ver)
>  	struct fb_info *info = hv_get_drvdata(hdev);
>  	struct hvfb_par *par = info->par;
>  	struct synthvid_msg *msg = (struct synthvid_msg *)par->init_buf;
> -	int t, ret = 0;
> +	int ret = 0;
> +	unsigned long t;
>
>  	memset(msg, 0, sizeof(struct synthvid_msg));
>  	msg->vid_hdr.type = SYNTHVID_VERSION_REQUEST;
> @@ -488,7 +489,8 @@ static int synthvid_send_config(struct hv_device *hdev)
>  	struct fb_info *info = hv_get_drvdata(hdev);
>  	struct hvfb_par *par = info->par;
>  	struct synthvid_msg *msg = (struct synthvid_msg *)par->init_buf;
> -	int t, ret = 0;
> +	int ret = 0;
> +	unsigned long t;
>
>  	/* Send VRAM location */
>  	memset(msg, 0, sizeof(struct synthvid_msg));

-- 
  Vitaly
