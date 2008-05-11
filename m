From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: pxafb and am200epd question
Date: Sun, 11 May 2008 01:52:05 -0400
Message-ID: <45a44e480805102252n5a1c84ap740433641eb0dd9e@mail.gmail.com>
References: <45a44e480805060505r2b280717p60d0046e083adf98@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1C3CB@msiexch01.marvell.com>
	<45a44e480805070807x7be5da5q632da9c25c66139a@mail.gmail.com>
	<45a44e480805080903m1acde0b2j73012646ef8da17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jv4Te-0002bq-Ue for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 22:52:07 -0700
Received: from wf-out-1314.google.com ([209.85.200.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jv4Td-0002ic-Kx
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 May 2008 22:52:06 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1801632wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 May 2008 22:52:05 -0700 (PDT)
In-Reply-To: <45a44e480805080903m1acde0b2j73012646ef8da17e@mail.gmail.com>
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

On Thu, May 8, 2008 at 12:03 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> Hi Eric,
>
> I'm thinking something along the lines of the following. Not a real
> patch, just a draft.
>

Hi Eric,

After starting to test, a few more changes came up:

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d6c05b6..f7fcb5e 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -127,6 +127,7 @@ struct platform_device pxa_device_fb = {
        .num_resources  = ARRAY_SIZE(pxafb_resources),
        .resource       = pxafb_resources,
 };
+EXPORT_SYMBOL_GPL(pxa_device_fb);

this is so that am200epd can access pxa_device_fb and pass it as the
platform_dev to pxafb when it is loaded. If I use a duplicate copy of
the struct, then pxafb can't get the LCDCLK.

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3ab6e3d..c9c7eea 100644

@@ -1613,24 +1661,28 @@ MODULE_PARM_DESC(options, "LCD parameters (see
Documentation/fb/pxafb.txt)");
 #define pxafb_setup_options()          (0)
 #endif


-static int __init pxafb_probe(struct platform_device *dev)
+static int __devinit pxafb_probe(struct platform_device *dev)

This was needed to solve that memory overlap on insmod issue. I think
__devinit is the right setting for pxafb_probe since it is called only
at probe().

@@ -778,8 +794,9 @@ static void setup_parallel_timing(struct pxafb_info *fbi,
 {
        unsigned int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);

        fbi->reg_lccr1 =
-               LCCR1_DisWdth(var->xres) +
+               LCCR1_DisWdth(var->xres/2) +

This one is dirty and I'm trying to find a different solution now.
Basically, it is there because the metronome controller accepts only
16-bit transfers on the AMLCD. To get pxa to do that, I have to set
16bpp on lccr3. But the pixels are 8bpp which is why the lccr1 pixels
per line needs to actually be half what the actual ppl is. I'm
planning to spend some time looking at how pxa and metronome transfers
are done and see if I can find a better way to do this.

-               LCCR1_DisWdth(var->xres) +
+               LCCR1_DisWdth(var->xres/fbi->custom_ppl_div) +

Above would be the worst case, adding an entry like custom_ppl_div to
handle this 16bpp transfer with 8bpp lines. I'll try my best to avoid
that.

        if (fbi->map_cpu) {
                /* prevent initial garbage on screen */
                memset(fbi->map_cpu, 0, fbi->map_size);
-               fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
-               fbi->screen_dma = fbi->map_dma + fbi->video_offset;
+               fbi->fb.screen_base = fbi->map_cpu;
+               fbi->screen_dma = fbi->map_dma;

@@ -1273,14 +1306,18 @@ static int __init
pxafb_map_video_memory(struct pxafb_info *fbi)
                fbi->fb.fix.smem_start = fbi->screen_dma;
                fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;
-               fbi->dma_buff = (void *) fbi->map_cpu;
-               fbi->dma_buff_phys = fbi->map_dma;
+               fbi->dma_buff = (void *) fbi->map_cpu + fbi->map_size
- fbi->video_offset;
+               fbi->dma_buff_phys = fbi->map_dma + fbi->map_size -
fbi->video_offset;

I moved the dma descriptors to the end of the framebuffer rather than
at the top. The reason is that way metronomefb can lay out the memory
in the framebuffer as: cmd, waveform, image data.

I'm sorry for the inconveniences that this may cause and really
appreciate your help in getting this right.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
