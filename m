From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 05 Jul 2014 19:23:18 +0000
Subject: Re: [PATCH] video: fbdev: sis: init.c:  Cleaning up variable that is never used
Message-Id: <20140705192317.GD25934@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404564507-21718-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404564507-21718-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Chen, Gong" <gong.chen@linux.intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 05, 2014 at 02:48:27PM +0200, Rickard Strandqvist wrote:
> From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

These for lines are for when you are sending on someone else's behalf.

> 
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/video/fbdev/sis/init.c |   21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
> index bd40f5e..3ba446c 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -2649,7 +2649,7 @@ static void
>  SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
>  		unsigned short ModeIdIndex, unsigned short RRTI)
>  {
> -   unsigned short data, infoflag = 0, modeflag, resindex;
> +   unsigned short data, infoflag = 0, modeflag;
>  #ifdef CONFIG_FB_SIS_315
>     unsigned char  *ROMAddr  = SiS_Pr->VirtualRomBase;
>     unsigned short data2, data3;
> @@ -2660,7 +2660,7 @@ SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
>     if(SiS_Pr->UseCustomMode) {
>        infoflag = SiS_Pr->CInfoFlag;
>     } else {
> -      resindex = SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
> +      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);

Remove this whole line.

regards,
dan carpenter

