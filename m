From: Tom Li <tomli@tomli.me>
Date: Mon, 01 Apr 2019 16:04:05 +0000
Subject: Re: [PATCH v2 2/7] fbdev: sm712fb: add 2D-related I/O headers and functions.
Message-Id: <20190401160404.GA15736@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-3-tomli@tomli.me>
 <20190331172558.ndvtilm7c2cy6xa4@debian>
In-Reply-To: <20190331172558.ndvtilm7c2cy6xa4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, Mar 31, 2019 at 06:25:58PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:54PM +0800, Yifeng Li wrote:
> > +#define DE_CTRL_COMMAND_SHIFT			16
> > +#define DE_CTRL_COMMAND_BITBLT			0x00
> > +#define DE_CTRL_COMMAND_SOLIDFILL		0x01
> > +#define DE_CTRL_COMMAND_HOSTWRITE		0x08
> > +#define DE_CTRL_ROP2_SELECT		0x00008000
> > +#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
> > +#define DE_CTRL_ROP2_SHIFT			0
> > +#define DE_CTRL_ROP2_COPY			0x0c
> > +#define DE_CTRL_HOST_SHIFT			22
> > +#define DE_CTRL_HOST_SRC_IS_MONO		0x01
> > +#define DE_CTRL_FORMAT_XY			0x00
> > +#define DE_CTRL_FORMAT_24BIT			0x30
> 
> Please fix the alignment. Some of them are right aligned and some are left.

Noted. It will be fixed in PATCH v3.

Thanks,
Tom Li
