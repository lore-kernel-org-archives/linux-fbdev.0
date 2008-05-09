From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: Debugging pxafb and am200epd
Date: Fri, 9 May 2008 13:37:53 -0400
Message-ID: <45a44e480805091037q43942e20s28a7960cfb53c4ae@mail.gmail.com>
References: <45a44e480805081306v17421858w3fbde163d43118e8@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1CDD5@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuWXb-00014a-Jk for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 10:37:55 -0700
Received: from wf-out-1314.google.com ([209.85.200.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuWXa-0007dr-JX
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 10:37:55 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1234056wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 May 2008 10:37:53 -0700 (PDT)
In-Reply-To: <E913911567467945BBEB9277E27868B0C1CDD5@msiexch01.marvell.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <ymiao3@marvell.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 9, 2008 at 5:20 AM, Eric Miao <ymiao3@marvell.com> wrote:
> Hi Jaya,
>
>> -----Original Message-----
>> From: Jaya Kumar [mailto:jayakumar.lkml@gmail.com]
>> Sent: Friday, May 09, 2008 4:07 AM
>> To: Eric Miao
>> Cc: Linux Frame Buffer Device Development
>> Subject: Debugging pxafb and am200epd
>>
>> Hi Eric,
>>
>> Just some quick questions and notes while trying to implement am200epd
>> sharing pxafb's framebuffer.
>>
>> 1. pxafb_init is set to __devinit, but it is only called from
>> module_init. Is my understanding correct that it should be __init?
>
> Yes indeed, it is not a HOTPLUG device obviously, there are some
> variables associated, like g_options[], so will have another look
> into this.
>
>> 2. pxafb currently doesn't implement module unloading support.  Is
>> there a reason for this?
>>
>
> From technical, I don't think so, yet there might be some if u want :)
>  - this driver really has a long history, and
>  - most uses it as builtin and never unload it
>
>> 3. I'm seeing weird behavior with insmod of am200epd on my test system
>> on a gumstix. Probably something that I'm doing wrong but I wanted to

Hi Eric,

It looks like the issue is tied to the __devinit used on pxafb_init. I
switched pxafb_init to __init and the problem goes away. Here's my
current result from testing:

# grep pxafb_probe /proc/kallsyms
bf01401c t pxafb_probe  [pxafb]
# grep bf01401c /proc/kallsyms
bf01401c t pxafb_probe  [pxafb]
bf01401c t $a   [pxafb]
# insmod arch/arm/mach-pxa/am200epd.ko
# grep bf01401c /proc/kallsyms
bf01401c t pxafb_probe  [pxafb]
bf01401c t $a   [pxafb]
# grep am200_exit /proc/kallsyms
bf014000 t am200_exit   [am200epd]

So it looks okay now. I didn't quite analyze why the setting of
__devinit on pxafb_init seems to affect pxafb_probe but maybe there's
a relationship there.

While I was doing this, I cooked up the following patch to pxafb to
make it unloadable. I've appended the code below. If it looks okay to
you, I would like to test it a bit and then submit it as a patch.

Thanks,
jaya

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3ab6e3d..ffbce49 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1778,8 +1797,35 @@ failed:
        return ret;
 }

+static int __devexit pxafb_remove(struct platform_device *dev)
+{
+       struct pxafb_info *fbi = platform_get_drvdata(dev);
+       struct resource *r;
+       int irq;
+
+       if (fbi) {
+               struct fb_info *info = &fbi->fb;
+
+               irq = platform_get_irq(dev, 0);
+               free_irq(irq, fbi);
+
+               r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+               release_mem_region(r->start, r->end - r->start + 1);
+
+               iounmap(fbi->mmio_base);
+
+               dma_free_writecombine(&dev->dev, fbi->map_size,
+                                       fbi->map_cpu, fbi->map_dma);
+               fb_dealloc_cmap(&info->cmap);
+               unregister_framebuffer(info);
+               kfree(fbi);
+       }
+       return 0;
+}
+
 static struct platform_driver pxafb_driver = {
        .probe          = pxafb_probe,
+       .remove         = pxafb_remove,
        .suspend        = pxafb_suspend,
        .resume         = pxafb_resume,
        .driver         = {
@@ -1787,7 +1833,7 @@ static struct platform_driver pxafb_driver = {
        },
 };

-static int __devinit pxafb_init(void)
+static int __init pxafb_init(void)
 {
        if (pxafb_setup_options())
                return -EINVAL;
@@ -1795,7 +1841,13 @@ static int __devinit pxafb_init(void)
        return platform_driver_register(&pxafb_driver);
 }

+static void __exit pxafb_exit(void)
+{
+       platform_driver_unregister(&pxafb_driver);
+}
+
 module_init(pxafb_init);
+module_exit(pxafb_exit);

 MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
 MODULE_LICENSE("GPL");

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
