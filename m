From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 15 May 2018 16:06:35 +0000
Subject: Re: [PATCH v1] video: fbdev: pxafb: Convert to use match_string() helper
Message-Id: <2633575.9g1uB693TI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, May 15, 2018 02:17:35 PM Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, May 15, 2018 02:59:20 PM Andy Shevchenko wrote:
> > On Tue, 2018-05-15 at 13:54 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday, May 15, 2018 02:35:03 PM Andy Shevchenko wrote:
> > > > On Tue, 2018-05-15 at 12:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Thursday, May 03, 2018 09:04:23 PM Andy Shevchenko wrote:
> > > > > > The new helper returns index of the matching string in an array.
> > > > > > We are going to use it here.
> > > > > > 
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.co
> > > > > > m>
> > > > > 
> > > > > Patch queued for 4.18, thanks.
> > > > 
> > > > I went through it again and found a bug, the type "unknown" should
> > > > be
> > > > left untouched.
> > > 
> > > Indeed, could you provide incremental fix?
> > 
> > Is it late enough to drop patch completely? If so, I do a fix asap.
> 
> It is already merged in publicly available tree (which is not being
> rebased) so it is too late to drop it completely.

OK, I fixed it myself with the patch below.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: pxafb: match_string() conversion fixup

"unknown" lcd_types[] entry is needed for proper operation of
the driver, add it back.

Fixes: 6d09dfe70f8f ("video: fbdev: pxafb: Convert to use match_string() helper")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/pxafb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/pxafb.c
=================================--- a/drivers/video/fbdev/pxafb.c	2018-05-15 17:41:00.922315366 +0200
+++ b/drivers/video/fbdev/pxafb.c	2018-05-15 17:42:27.474317546 +0200
@@ -2099,7 +2099,7 @@ static void pxafb_check_options(struct d
 
 #if defined(CONFIG_OF)
 static const char * const lcd_types[] = {
-	"mono-stn", "mono-dstn", "color-stn", "color-dstn",
+	"unknown", "mono-stn", "mono-dstn", "color-stn", "color-dstn",
 	"color-tft", "smart-panel", NULL
 };
 

