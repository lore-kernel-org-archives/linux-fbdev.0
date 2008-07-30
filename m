From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 4/5] metronomefb: convert
	printk to dev_dbg/err messages
Date: Wed, 30 Jul 2008 10:50:04 +0800
Message-ID: <f17812d70807291950y6f10fc2dk49e1fca82773e36a@mail.gmail.com>
References: <1217046774-13080-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217046774-13080-5-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KO1lO-0003SZ-8F for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:50:06 -0700
Received: from qw-out-1920.google.com ([74.125.92.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KO1lN-0002aD-K0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:50:06 -0700
Received: by qw-out-1920.google.com with SMTP id 5so210350qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 19:50:04 -0700 (PDT)
In-Reply-To: <1217046774-13080-5-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, Jul 26, 2008 at 12:32 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch converts the printk messages in metronomefb to dev_dbg/err type
> messages.
>

I think this is already Acked (except for the DEBUG definition), so it would
probably nice if you can re-order the patch series and put this in the front,
so the next time we can focus on those patches with concerns only, and
get things merged a bit quicker.

That will take you sometime, though. Sorry about that and thanks for the
good work.

> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/metronomefb.c |   49 +++++++++++++++++++-----------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index cc4c038..8ccd113 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -18,6 +18,8 @@
>  * is provided as am200epd.c
>  *
>  */
> +#define DEBUG 1
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -40,15 +42,6 @@
>
>  #include <asm/unaligned.h>
>
> -
> -#define DEBUG 1
> -#ifdef DEBUG
> -#define DPRINTK(f, a...) printk(KERN_DEBUG "%s: " f, __func__ , ## a)
> -#else
> -#define DPRINTK(f, a...)
> -#endif
> -
> -
>  /* Display specific information */
>  #define DPY_W 832
>  #define DPY_H 622
> @@ -135,8 +128,8 @@ static u16 calc_img_cksum(u16 *start, int length)
>
>  /* here we decode the incoming waveform file and populate metromem */
>  #define EXP_WFORM_SIZE 47001
> -static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
> -                               u8 *frame_count)
> +static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
> +                               struct metronomefb_par *par)
>  {
>        int tta;
>        int wmta;
> @@ -148,9 +141,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>        int wfm_idx, owfm_idx;
>        int mem_idx = 0;
>        struct waveform_hdr *wfm_hdr;
> +       u8 *metromem = par->metromem_wfm;
> +       struct device *dev = par->info->dev;
>
>        if (size != EXP_WFORM_SIZE) {
> -               printk(KERN_ERR "Error: unexpected size %d != %d\n", size,
> +               dev_err(dev, "Error: unexpected size %d != %d\n", size,
>                                        EXP_WFORM_SIZE);
>                return -EINVAL;
>        }
> @@ -158,16 +153,16 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>        wfm_hdr = (struct waveform_hdr *) mem;
>
>        if (wfm_hdr->fvsn != 1) {
> -               printk(KERN_ERR "Error: bad fvsn %x\n", wfm_hdr->fvsn);
> +               dev_err(dev, "Error: bad fvsn %x\n", wfm_hdr->fvsn);
>                return -EINVAL;
>        }
>        if (wfm_hdr->luts != 0) {
> -               printk(KERN_ERR "Error: bad luts %x\n", wfm_hdr->luts);
> +               dev_err(dev, "Error: bad luts %x\n", wfm_hdr->luts);
>                return -EINVAL;
>        }
>        cksum = calc_cksum(32, 47, mem);
>        if (cksum != wfm_hdr->wfm_cs) {
> -               printk(KERN_ERR "Error: bad cksum %x != %x\n", cksum,
> +               dev_err(dev, "Error: bad cksum %x != %x\n", cksum,
>                                        wfm_hdr->wfm_cs);
>                return -EINVAL;
>        }
> @@ -175,7 +170,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>        wfm_hdr->trc += 1;
>        for (i = 0; i < 5; i++) {
>                if (*(wfm_hdr->stuff2a + i) != 0) {
> -                       printk(KERN_ERR "Error: unexpected value in padding\n");
> +                       dev_err(dev, "Error: unexpected value in padding\n");
>                        return -EINVAL;
>                }
>        }
> @@ -200,7 +195,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>                return -EINVAL;
>        cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
>        if (cksum != mem[cksum_idx]) {
> -               printk(KERN_ERR "Error: bad temperature range table cksum"
> +               dev_err(dev, "Error: bad temperature range table cksum"
>                                " %x != %x\n", cksum, mem[cksum_idx]);
>                return -EINVAL;
>        }
> @@ -212,7 +207,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>                return -EINVAL;
>        cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
>        if (cksum != mem[cksum_idx]) {
> -               printk(KERN_ERR "Error: bad mode table address cksum"
> +               dev_err(dev, "Error: bad mode table address cksum"
>                                " %x != %x\n", cksum, mem[cksum_idx]);
>                return -EINVAL;
>        }
> @@ -224,7 +219,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>                return -EINVAL;
>        cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
>        if (cksum != mem[cksum_idx]) {
> -               printk(KERN_ERR "Error: bad temperature table address cksum"
> +               dev_err(dev, "Error: bad temperature table address cksum"
>                        " %x != %x\n", cksum, mem[cksum_idx]);
>                return -EINVAL;
>        }
> @@ -259,11 +254,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>                return -EINVAL;
>        cksum = calc_cksum(owfm_idx, cksum_idx, mem);
>        if (cksum != mem[cksum_idx]) {
> -               printk(KERN_ERR "Error: bad waveform data cksum"
> +               dev_err(dev, "Error: bad waveform data cksum"
>                                " %x != %x\n", cksum, mem[cksum_idx]);
>                return -EINVAL;
>        }
> -       *frame_count = (mem_idx/64);
> +       par->frame_count = (mem_idx/64);
>
>        return 0;
>  }
> @@ -662,15 +657,15 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>                b) process waveform and decode into metromem */
>        retval = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
>        if (retval < 0) {
> -               printk(KERN_ERR "metronomefb: couldn't get waveform\n");
> +               dev_err(&dev->dev, "Failed to get waveform\n");
>                goto err_dma_free;
>        }
>
> -       retval = load_waveform((u8 *) fw_entry->data, fw_entry->size,
> -                               par->metromem_wfm, 3, 31, &par->frame_count);
> +       retval = load_waveform((u8 *) fw_entry->data, fw_entry->size, 3, 31,
> +                               par);
>        release_firmware(fw_entry);
>        if (retval < 0) {
> -               printk(KERN_ERR "metronomefb: couldn't process waveform\n");
> +               dev_err(&dev->dev, "Failed processing waveform\n");
>                goto err_dma_free;
>        }
>
> @@ -688,7 +683,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>
>        retval = fb_alloc_cmap(&info->cmap, 8, 0);
>        if (retval < 0) {
> -               printk(KERN_ERR "Failed to allocate colormap\n");
> +               dev_err(&dev->dev, "Failed to allocate colormap\n");
>                goto err_fb_rel;
>        }
>
> @@ -704,7 +699,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>
>        platform_set_drvdata(dev, info);
>
> -       printk(KERN_INFO
> +       dev_dbg(&dev->dev,
>                "fb%d: Metronome frame buffer device, using %dK of video"
>                " memory\n", info->node, videomemorysize >> 10);
>
> --
> 1.5.3.6
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
