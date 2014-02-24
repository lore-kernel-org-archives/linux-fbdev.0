From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Mon, 24 Feb 2014 22:06:36 +0000
Subject: RE: [PATCH v3 4/4] hyperv-fb: kick off efifb early
Message-Id: <771a0b10157b48bab970b5360ec54956@DFM-DB3MBX15-08.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
 <1393247831-5271-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393247831-5271-5-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, "Abhishek Gupta (LIS)" <abgupta@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Monday, February 24, 2014 8:17 AM
> To: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan;
> Abhishek Gupta (LIS); Haiyang Zhang; jasowang@redhat.com;
> tomi.valkeinen@ti.com; devel@linuxdriverproject.org; Gerd Hoffmann; Jean-
> Christophe Plagniol-Villard
> Subject: [PATCH v3 4/4] hyperv-fb: kick off efifb early
> 
> Remove firmware framebuffer before initializing hyperv-fb.  Needed
> on gen2 virtual machines.   Letting register_framebuffer handle the
> switchover results in efifb still being active while hyperv graphics are
> initialized, which in turn can make the linux kernel hang.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/hyperv_fb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c index
> 135d8cd..a570836 100644
> --- a/drivers/video/hyperv_fb.c
> +++ b/drivers/video/hyperv_fb.c
> @@ -683,6 +683,7 @@ static int hvfb_getmem(struct fb_info *info)
>  		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
>  		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
>  	}
> +	remove_conflicting_framebuffers(info->apertures, "hyperv-fb", false);

Please use KBUILD_MODNAME, so that the naming is consistent.

Thanks,
- Haiyang

> 
>  	info->fix.smem_start = par->mem.start;
>  	info->fix.smem_len = screen_fb_size;
> --
> 1.8.3.1

