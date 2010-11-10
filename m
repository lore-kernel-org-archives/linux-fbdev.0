From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 04:09:09 +0000
Subject: Re: [PATCH 3/4 v2] fbdev: when parsing E-EDID blocks, also use SVD entries
Message-Id: <20101110040909.GA30715@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011021143480.4552@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011021143480.4552@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 02, 2010 at 11:47:40AM +0100, Guennadi Liakhovetski wrote:
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 38b3c30..943bcff 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -973,6 +973,45 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  	DPRINTK("====================\n");
>  }
>  
> +const struct fb_videomode cea_modes[] = {

This wants to be in drivers/video/modedb.c nested under
CONFIG_FB_MODE_HELPERS, you can simply follow the vesa_modes
example. Given that this can also be modular, you'll need a symbol export
for cea_modes in addition to a prototype in include/linux/fb.h.
