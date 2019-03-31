From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 17:25:58 +0000
Subject: Re: [PATCH v2 2/7] fbdev: sm712fb: add 2D-related I/O headers and functions.
Message-Id: <20190331172558.ndvtilm7c2cy6xa4@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-3-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-3-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Mar 22, 2019 at 01:17:54PM +0800, Yifeng Li wrote:
> This commit adds I/O macros and functions related to 2D opeartions.
> A hunk of hardware register definitions are taken verbatim from
> OpenBSD.
> 
> In addition, a utility function pad_to_dword() is added to help
> padding data for the 2D engine. It  accepts 3, 2, or 1 byte(s) of
> data, and pads it to a 32-bit word suitable for 2D Drawing Engine.
> 
> Yes, we can set info->pixmap.scan_align/buf_align = 4 and forget
> about padding, but it's incompatible with cfb_imageblit() w/
> depth = 1. In case we need to fallback (e.g. debugging), it would
> be inconvenient, so we pad it manually.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  drivers/video/fbdev/sm712.h | 96 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
> index 89e446db2ac7..4892fd485f08 100644
> --- a/drivers/video/fbdev/sm712.h
> +++ b/drivers/video/fbdev/sm712.h
> @@ -91,6 +91,102 @@ static inline u8 smtc_seqr(u8 reg)
>  	return smtc_mmiorb(0x3c5);
>  }
>  
> +/*
> + * DPR (2D drawing engine)
> + */
> +#define DPR_COORDS(x, y)		(((x) << 16) | (y))
> +
<snip>
> +#define DPR_SRC_WINDOW			0x3c
> +#define DPR_SRC_BASE			0x40
> +#define DPR_DST_BASE			0x44
> +
> +#define DE_CTRL_START			0x80000000
> +#define DE_CTRL_RTOL			0x08000000
> +#define DE_CTRL_COMMAND_MASK		0x001f0000
> +#define DE_CTRL_COMMAND_SHIFT			16
> +#define DE_CTRL_COMMAND_BITBLT			0x00
> +#define DE_CTRL_COMMAND_SOLIDFILL		0x01
> +#define DE_CTRL_COMMAND_HOSTWRITE		0x08
> +#define DE_CTRL_ROP2_SELECT		0x00008000
> +#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
> +#define DE_CTRL_ROP2_SHIFT			0
> +#define DE_CTRL_ROP2_COPY			0x0c
> +#define DE_CTRL_HOST_SHIFT			22
> +#define DE_CTRL_HOST_SRC_IS_MONO		0x01
> +#define DE_CTRL_FORMAT_XY			0x00
> +#define DE_CTRL_FORMAT_24BIT			0x30

Please fix the alignment. Some of them are right aligned and some are left.

--
Regards
Sudip
