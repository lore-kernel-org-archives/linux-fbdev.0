From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 19:08:01 +0000
Subject: Re: [PATCH v2 7/7] MAINTAINERS: sm712fb: list myself as one maintainer.
Message-Id: <20190331190801.hxl57om56jskku5s@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-8-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-8-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Teddy Wang <teddy.wang@siliconmotion.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:59PM +0800, Yifeng Li wrote:
> I have working on the sm712fb driver for a while and have some familiarity
> with this hardware, I'll be helping working on and testing problems of this
> driver, so add myself to the MAINTAINERS file.

Technically I donot have any problem with this, you seem to know more
about SM712 than I know. But Teddy Wang is also an existing maintainer
and I think there should be an ack from him before this is accepted.

> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dce5c099f43c..3f6686f0f020 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13871,6 +13871,7 @@ F:	drivers/input/touchscreen/silead.c
>  F:	drivers/platform/x86/touchscreen_dmi.c
>  
>  SILICON MOTION SM712 FRAME BUFFER DRIVER
> +M:	Tom Li <tomli@tomli.me>

Sorry, I am confused. Is your name "Tom Li"? Then why is your
Signed-off-by: and From: name different?

--
Regards
Sudip
