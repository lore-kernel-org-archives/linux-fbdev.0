From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 01 Jul 2014 06:31:43 +0000
Subject: Re: [PATCH V2] MAINTAINERS: Update Framebuffer file patterns
Message-Id: <002501cf94f6$2016bb20$60443160$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000801cf94e0$d5856cb0$80904610$%han@samsung.com>
In-Reply-To: <000801cf94e0$d5856cb0$80904610$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, July 01, 2014 3:22 PM, Jingoo Han wrote:
> On 01/07/14 06:59, Jingoo Han wrote:
> > Since the commit f7018c2 "video: move fbdev to drivers/video/fbdev",
> > all framebuffer drivers were moved to fbdev directory. Thus, file
> > patterns of these framebuffer drivers should be updated correctly.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> > Changes since v1:
> > - Fix the typo from 'fbdevwmt_ge_rops.*' to 'fbdev/wmt_ge_rop/*', per Liu Ying
> >
> >  MAINTAINERS |   76 ++++++++++++++++++++++++++++++-----------------------------
> >  1 file changed, 39 insertions(+), 37 deletions(-)
> 
> Thanks! I was planning to do this but I seem to have forgotten about it...
> 
> <snip>
> 
> > @@ -3707,7 +3707,8 @@ FREESCALE DIU FRAMEBUFFER DRIVER
> >  M:	Timur Tabi <timur@tabi.org>
> >  L:	linux-fbdev@vger.kernel.org
> >  S:	Maintained
> > -F:	drivers/video/fsl-diu-fb.*
> > +F:	drivers/video/fbdev/fsl-diu-fb.c
> > +F:	include/linux/fsl-diu-fb.h
> 
> You have a few of extra changes like the above. I'd rather have the
> "update file patterns" patch doing only that, and make the new changes
> in a separate patch.

OK, I will only "update file patterns", and send v3 patch, soon.
After the patch is merged, I will send another patch to add extra
changes. Thank you for your comment. :-)

Best regards,
Jingoo Han

> 
>  Tomi
> 


