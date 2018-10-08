From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:51:54 +0000
Subject: Re: [PATCH] video: fbdev: sis: Remove unnecessary parentheses and commented code
Message-Id: <20181008105156eucas1p106251d3dc728ce13a4710b94ac02f1ba~bnKHB1gLf1421814218eucas1p1p@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180920202232epcas2p115e690a9ab4b8d70c2c710addb8fbb1e@epcas2p1.samsung.com>
        <20180920202217.27304-1-natechancellor@gmail.com>
In-Reply-To: <20180920202217.27304-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 09/20/2018 10:22 PM, Nathan Chancellor wrote:
> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
> 
> drivers/video/fbdev/sis/init301.c:851:42: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS = 1) /* ||
>                  ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> drivers/video/fbdev/sis/init301.c:851:42: note: remove extraneous
> parentheses around the comparison to silence this warning
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS = 1) /* ||
>                 ~                        ^   ~
> drivers/video/fbdev/sis/init301.c:851:42: note: use '=' to turn this
> equality comparison into an assignment
>       } else if((SiS_Pr->SiS_IF_DEF_LVDS = 1) /* ||
>                                          ^~
>                                          > 1 warning generated.
> 
> Remove the parentheses and while we're at it, clean up the commented
> code, which has been here since the beginning of git history.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/118
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
