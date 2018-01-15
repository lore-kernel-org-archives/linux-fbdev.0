From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 15 Jan 2018 14:56:24 +0000
Subject: Re: [RFC PATCH V2] fbdev: mxsfb: use framebuffer_alloc in the correct way
Message-Id: <34458775.rnx4xjQx0Z@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180105103713.GA4196@panicking>
In-Reply-To: <20180105103713.GA4196@panicking>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sunday, January 07, 2018 11:10:08 AM Stefan Agner wrote:
> On 2018-01-05 11:37, Michael Trimarchi wrote:
> > framebuffer_alloc allocated the fb_info struct plus the extra
> > par and set fb_info->par pointer equal to this extra par. We
> > can refer the mxcfb_info from fb_info->par
> > 
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Looks good to me.
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> 
> And seems to work fine using i.MX 7.
> 
> Tested-by: Stefan Agner <stefan@agner.ch>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

