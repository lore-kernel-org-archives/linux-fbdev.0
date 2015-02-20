From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 20 Feb 2015 14:01:10 +0000
Subject: Re: [PATCH] video: fbdev: use msecs_to_jiffies for time conversion
Message-Id: <20150220140110.GA25767@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423214041-15818-1-git-send-email-hofrat@osadl.org> <54E72774.1070809@ti.com>
In-Reply-To: <54E72774.1070809@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 20 Feb 2015, Tomi Valkeinen wrote:

> On 06/02/15 11:14, Nicholas Mc Guire wrote:
> > This is only an API consolidation and should make things more readable
> > it replaces var * HZ / 1000 by msecs_to_jiffies(var).
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > Patch was only compile tested with viper_defconfig (implies CONFIG_FB_PXA=m)
> > 
> > Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
> > 
> >  drivers/video/fbdev/pxafb.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> > index da2431e..d8b4743 100644
> > --- a/drivers/video/fbdev/pxafb.c
> > +++ b/drivers/video/fbdev/pxafb.c
> > @@ -1285,7 +1285,7 @@ static int pxafb_smart_thread(void *arg)
> >  		mutex_unlock(&fbi->ctrlr_lock);
> >  
> >  		set_current_state(TASK_INTERRUPTIBLE);
> > -		schedule_timeout(30 * HZ / 1000);
> > +		schedule_timeout(msecs_to_jiffies(30));
> >  	}
> >  
> >  	pr_debug("%s(): task ending\n", __func__);
> > @@ -1460,7 +1460,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
> >  #ifdef CONFIG_FB_PXA_SMARTPANEL
> >  	if (fbi->lccr0 & LCCR0_LCDT) {
> >  		wait_for_completion_timeout(&fbi->refresh_done,
> > -				200 * HZ / 1000);
> > +				msecs_to_jiffies(200);
> 
> That will not compile.
>

Just reran it on linux-next 3.19.0 -next-20150220

for viper_defconfig using gcc version 4.9.2 20140904 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09)


root@debian:~/linux-next# patch -p1  < 0001-video-fbdev-use-msecs_to_jiffies-for-time-convrsion.patch 
patching file drivers/video/fbdev/pxafb.c
root@debian:~/linux-next# make viper_defconfig ARCH=arm
#
# configuration written to .config
#
root@debian:~/linux-next# LANG=en_US make modules ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
...
  CC [M]  drivers/video/console/softcursor.o
  CC [M]  drivers/video/fbdev/pxafb.o
  CC [M]  drivers/video/fbdev/core/cfbfillrect.o
  CC [M]  drivers/video/fbdev/core/cfbcopyarea.o
  CC [M]  drivers/video/fbdev/core/cfbimgblt.o
  CC [M]  sound/sound_core.o
  LD [M]  sound/soundcore.o
...
  CC      drivers/video/console/softcursor.mod.o
  LDFINAL [M]  drivers/video/console/softcursor.ko
  CC      drivers/video/fbdev/core/cfbcopyarea.mod.o
  LDFINAL [M]  drivers/video/fbdev/core/cfbcopyarea.ko
  CC      drivers/video/fbdev/core/cfbfillrect.mod.o
  LDFINAL [M]  drivers/video/fbdev/core/cfbfillrect.ko
  CC      drivers/video/fbdev/core/cfbimgblt.mod.o
  LDFINAL [M]  drivers/video/fbdev/core/cfbimgblt.ko
  CC      drivers/video/fbdev/pxafb.mod.o
  LDFINAL [M]  drivers/video/fbdev/pxafb.ko
  CC      fs/configfs/configfs.mod.o
  LDFINAL [M]  fs/configfs/configfs.ko
...

 No compile warning or errors

 could you send me the compile error message and the toolchain you
 are using - this change should not really have any noticable impact.

 Is this a toolchain issue ?

thx!
hofrat
