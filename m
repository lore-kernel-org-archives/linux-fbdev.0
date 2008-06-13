From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 09/10] metronomefb: convert
 printk to dev_dbg/err messages
Date: Fri, 13 Jun 2008 10:22:15 +0800
Message-ID: <4851D9D7.9040905@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-10-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6yvn-00054Q-C3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 19:22:23 -0700
Received: from ti-out-0910.google.com ([209.85.142.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6yvl-0004UI-IU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 19:22:23 -0700
Received: by ti-out-0910.google.com with SMTP id y6so1403755tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 19:22:20 -0700 (PDT)
In-Reply-To: <1213289961-1562-10-git-send-email-jayakumar.lkml@gmail.com>
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

Jaya Kumar wrote:
> This patch converts the printk messages in metronomefb to dev_dbg/err type
> messages.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Acked-by: Eric Miao <eric.miao@marvell.com>

Except that you may want to disable DEBUG by default when pushing upstream.

> ---
>  drivers/video/metronomefb.c |   49 +++++++++++++++++++-----------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index cc4c038..8ccd113 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -18,6 +18,8 @@
>   * is provided as am200epd.c
>   *
>   */
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
> -				u8 *frame_count)
> +static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
> +				struct metronomefb_par *par)
>  {
>  	int tta;
>  	int wmta;
> @@ -148,9 +141,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  	int wfm_idx, owfm_idx;
>  	int mem_idx = 0;
>  	struct waveform_hdr *wfm_hdr;
> +	u8 *metromem = par->metromem_wfm;
> +	struct device *dev = par->info->dev;
>  
>  	if (size != EXP_WFORM_SIZE) {
> -		printk(KERN_ERR "Error: unexpected size %d != %d\n", size,
> +		dev_err(dev, "Error: unexpected size %d != %d\n", size,
>  					EXP_WFORM_SIZE);
>  		return -EINVAL;
>  	}
> @@ -158,16 +153,16 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  	wfm_hdr = (struct waveform_hdr *) mem;
>  
>  	if (wfm_hdr->fvsn != 1) {
> -		printk(KERN_ERR "Error: bad fvsn %x\n", wfm_hdr->fvsn);
> +		dev_err(dev, "Error: bad fvsn %x\n", wfm_hdr->fvsn);
>  		return -EINVAL;
>  	}
>  	if (wfm_hdr->luts != 0) {
> -		printk(KERN_ERR "Error: bad luts %x\n", wfm_hdr->luts);
> +		dev_err(dev, "Error: bad luts %x\n", wfm_hdr->luts);
>  		return -EINVAL;
>  	}
>  	cksum = calc_cksum(32, 47, mem);
>  	if (cksum != wfm_hdr->wfm_cs) {
> -		printk(KERN_ERR "Error: bad cksum %x != %x\n", cksum,
> +		dev_err(dev, "Error: bad cksum %x != %x\n", cksum,
>  					wfm_hdr->wfm_cs);
>  		return -EINVAL;
>  	}
> @@ -175,7 +170,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  	wfm_hdr->trc += 1;
>  	for (i = 0; i < 5; i++) {
>  		if (*(wfm_hdr->stuff2a + i) != 0) {
> -			printk(KERN_ERR "Error: unexpected value in padding\n");
> +			dev_err(dev, "Error: unexpected value in padding\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -200,7 +195,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  		return -EINVAL;
>  	cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
>  	if (cksum != mem[cksum_idx]) {
> -		printk(KERN_ERR "Error: bad temperature range table cksum"
> +		dev_err(dev, "Error: bad temperature range table cksum"
>  				" %x != %x\n", cksum, mem[cksum_idx]);
>  		return -EINVAL;
>  	}
> @@ -212,7 +207,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  		return -EINVAL;
>  	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
>  	if (cksum != mem[cksum_idx]) {
> -		printk(KERN_ERR "Error: bad mode table address cksum"
> +		dev_err(dev, "Error: bad mode table address cksum"
>  				" %x != %x\n", cksum, mem[cksum_idx]);
>  		return -EINVAL;
>  	}
> @@ -224,7 +219,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  		return -EINVAL;
>  	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
>  	if (cksum != mem[cksum_idx]) {
> -		printk(KERN_ERR "Error: bad temperature table address cksum"
> +		dev_err(dev, "Error: bad temperature table address cksum"
>  			" %x != %x\n", cksum, mem[cksum_idx]);
>  		return -EINVAL;
>  	}
> @@ -259,11 +254,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
>  		return -EINVAL;
>  	cksum = calc_cksum(owfm_idx, cksum_idx, mem);
>  	if (cksum != mem[cksum_idx]) {
> -		printk(KERN_ERR "Error: bad waveform data cksum"
> +		dev_err(dev, "Error: bad waveform data cksum"
>  				" %x != %x\n", cksum, mem[cksum_idx]);
>  		return -EINVAL;
>  	}
> -	*frame_count = (mem_idx/64);
> +	par->frame_count = (mem_idx/64);
>  
>  	return 0;
>  }
> @@ -662,15 +657,15 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>  		b) process waveform and decode into metromem */
>  	retval = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
>  	if (retval < 0) {
> -		printk(KERN_ERR "metronomefb: couldn't get waveform\n");
> +		dev_err(&dev->dev, "Failed to get waveform\n");
>  		goto err_dma_free;
>  	}
>  
> -	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size,
> -				par->metromem_wfm, 3, 31, &par->frame_count);
> +	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size, 3, 31,
> +				par);
>  	release_firmware(fw_entry);
>  	if (retval < 0) {
> -		printk(KERN_ERR "metronomefb: couldn't process waveform\n");
> +		dev_err(&dev->dev, "Failed processing waveform\n");
>  		goto err_dma_free;
>  	}
>  
> @@ -688,7 +683,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>  
>  	retval = fb_alloc_cmap(&info->cmap, 8, 0);
>  	if (retval < 0) {
> -		printk(KERN_ERR "Failed to allocate colormap\n");
> +		dev_err(&dev->dev, "Failed to allocate colormap\n");
>  		goto err_fb_rel;
>  	}
>  
> @@ -704,7 +699,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>  
>  	platform_set_drvdata(dev, info);
>  
> -	printk(KERN_INFO
> +	dev_dbg(&dev->dev,
>  		"fb%d: Metronome frame buffer device, using %dK of video"
>  		" memory\n", info->node, videomemorysize >> 10);
>  


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
