From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 17:16:17 +0000
Subject: Re: [PATCH v2 1/7] fbdev: sm712fb: use type "u8" for 8-bit I/O.
Message-Id: <20190331171617.ebh7aozv3eleyqzb@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-2-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-2-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Teddy Wang <teddy.wang@siliconmotion.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:53PM +0800, Yifeng Li wrote:
> This commit converts "unsigned int" and "int" in I/O wrappers
> to "u8". It improves readability since it's consistent with
> the prototypes of readb() and writeb(). More importantly, it
> reduces readers' confusion, since the upcoming 2D acceleration
> code will use a different wordsize.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
