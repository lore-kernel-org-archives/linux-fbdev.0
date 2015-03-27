From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 27 Mar 2015 06:00:07 +0000
Subject: Re: [PATCH v2 06/12] staging: sm750: no braces for single stmt if blocks
Message-Id: <20150327060007.GZ10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9b7d1ab21e735024fec2d2586fb1e0550eaa6369.1427406762.git.michel.von.czettritz@gmail.com>
In-Reply-To: <9b7d1ab21e735024fec2d2586fb1e0550eaa6369.1427406762.git.michel.von.czettritz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 26, 2015 at 11:25:50PM +0100, Michel von Czettritz wrote:
> @@ -487,8 +484,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
>  		par = info->par;
>  		crtc = &par->crtc;
>  		cursor = &crtc->cursor;
> -		memset_io(cursor->vstart, 0x0, cursor->size);
> -		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
> +		memset(cursor->vstart, 0x0, cursor->size);
> +		memset(crtc->vScreen, 0x0, crtc->vidmem_size);
>  		lynxfb_ops_set_par(info);
>  		fb_set_suspend(info, 0);
>  	}

This is a bug.

regards,
dan carpenter

