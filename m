From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 01:46:31 +0000
Subject: RE: [PATCH 1/3] Move FIMD register headers to include/video/
Message-Id: <02e501cd6f87$79d9aff0$6d8d0fd0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com

Leela Krishna Amudala wrote:
> 
> Moved the contents of regs-fb-v4.h and regs-fb.h from arch side
> to include/video/samsung_fimd.h
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
>  arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
>  include/video/samsung_fimd.h                    |  533
+++++++++++++++++++++++
>  3 files changed, 533 insertions(+), 562 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
>  delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
>  create mode 100644 include/video/samsung_fimd.h
> 

+ I have some comments on this.

[...]

> +/* VIDCON0 */

I don't think above comment is needed because everybody knows that from the
name of VIDCON0_.

> +
> +#define VIDCON0					(0x00)
> +#define VIDCON0_INTERLACE			(1 << 29)
> +#define VIDCON0_VIDOUT_MASK			(0x3 << 26)
> +#define VIDCON0_VIDOUT_SHIFT			(26)

I think, you can use either of the following.

+#define VIDCON0_VIDOUT_SHIFT			(26)
+#define VIDCON0_VIDOUT_MASK			(0x3 <<
VIDCON0_VIDOUT_SHIFT)

Or just without XXX_SHIFT if the XXX_SHIFT is not used somewhere else,

+#define VIDCON0_VIDOUT_MASK			(0x3 << 26)

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

