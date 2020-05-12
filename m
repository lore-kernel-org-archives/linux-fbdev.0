From: Dave Airlie <airlied@gmail.com>
Date: Tue, 12 May 2020 20:37:19 +0000
Subject: Re: bug: kernel bug when unbinding EFI framebuffer
Message-Id: <CAPM=9tyhjUEYcsU6Ab7Cmw8KDd9NVtgMg8J3WpULS=L8o7XcRQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
In-Reply-To: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 13 May 2020 at 06:03, Dave Airlie <airlied@gmail.com> wrote:
>
> On Sat, 2 May 2020 at 22:36, Fabian Mastenbroek <mail.fabian.m@gmail.com> wrote:
> >
> > Hi,
> >
> > When I try to unbind the EFI framebuffer via:
> >
> >         echo -n efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
>
> Can I ask why?
>
> nouveau kicks the efifb off the hw, and unregisters it, but when you
> unbind it it tries to unregister again.
>
> It might be possible to block this, but not sure of the point, efifb
> is a built-in, you can't unload the module to save memory.


diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 65491ae74808..87405545a903 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -598,7 +598,8 @@ static int efifb_remove(struct platform_device *pdev)
 {
        struct fb_info *info = platform_get_drvdata(pdev);

-       unregister_framebuffer(info);
+       if (info->dev)
+               unregister_framebuffer(info);
        sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
        framebuffer_release(info);

something like that (applied by hand, this is just pasted out into
gmail so won't apply), might stop the oops.

Dave.
>
> Dave.
