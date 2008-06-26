From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/4] video: sh7760fb: SH7760/SH7763
 LCDC framebuffer driver part 1/3
Date: Thu, 26 Jun 2008 14:31:47 +0900
Message-ID: <486329C3.2020806@renesas.com>
References: <20080625082914.E208721C824@f28.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <20080625082914.E208721C824@f28.poczta.interia.pl>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: krzysztof.h1@poczta.fm
Cc: "Linux-fbdev-devel@lists.sourceforge.net" <Linux-fbdev-devel@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

krzysztof.h1@poczta.fm wrote:
>> Main source code of Driver for the LCDC interface on the SH7760 and SH7763
>> SoCs.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>> ---
>>  drivers/video/sh7760fb.c |  717
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 717 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/video/sh7760fb.c
>>
>> diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
<snip>

>> +#define LDCNTR		0x428
>> +#define LDCNTR_DON	(1 << 0)
>> +#define LDCNTR_DON2	(1 << 4)
>> +#ifdef CONFIG_CPU_SUBTYPE_SH7763
>> +# define LDLIRNR	0x440
>> +#endif
>> +
> 
> These definitions should be moved to the header file. Part of bits definitions are there and I suppose these bits are related to registers.
> 
>> +/*
>> + * some bits of the colormap registers should be written as zero.
>> + * create a mask for that.
>> + */
>> +#define SH7760FB_PALETTE_MASK    0x00f8fcf8
>> +
>> +/* The LCDC dma engine always sets bits 27-26 to 1: this is Area3 */
>> +#define SH7760FB_DMA_MASK      0x0C000000
>> +
>> +struct sh7760fb_par {
>> +	void __iomem *base;
>> +	struct sh7760fb_platdata *pd;	/* display information */
>> +
>> +	/* framebuffer memory information */
>> +	void *fbmem;		/* alloced framebuffer */
>> +	dma_addr_t fbdma;	/* physical address */
>> +	unsigned long vram;	/* size, in bytes */
> 
> The fields fbmem and vram are redundant as you can use smem_start/smem_len or or screen_base/screen_size to store the same information (and you do it anyway).
> 
>> +	unsigned long stride;
>> +
> 
> The line_length field is the same (redundant).
> 
<snip>

>> +	if (blank == FB_BLANK_UNBLANK) {
>> +		cntr = LDCNTR_DON2 | LDCNTR_DON;
>> +		lps = 3;
>> +		if (pd->blank)
>> +			pd->blank(blank);
> 
> Probably pd->blank can be moved outside the if-else stantement.
> 
>> +
>> +	if (par->disp_set)
>> +		return 0;
>> +
> 
> Is there any specific reason you cannot do disp_set twice? It means that the framebuffer is not able to change display depth at runtime. Probably you can drop the disp_set field completely. If the registers are programmed twice to the same values it should do no harm.
> 
<snip>

>> +
>> +	bpp = gray = 0;
> 
> There is no reason to set the bpp (it is set in all cases).
<snip>

>> +
>> +	var->bits_per_pixel = bpp;
>> +
> 
> The changes in fbinfo->var is allowed only in the check_var function (see skeletonfb.c foe explanations). You should move the code which changes the var structure into the check_var functions and get some code reduction.
<snip>

>> +
>> +	par->fbmem = NULL;
>> +	par->fbdma = 0;
>> +	info->screen_base = NULL;
>> +	info->screen_size = 0;
> 
> Just use the screen_base/screen_size instead of the fbmem/vram fields.
<snip>

>> +	OUT16(par, LDCNTR_DON2, LDCNTR);
>> +	info->fbops = &sh7760fb_ops;
>> +	fb_alloc_cmap(&info->cmap, 256, 0);
>> +
> 
> Check if the cmap was correctly allocated and release it on error below (if the framebuffer is not registered).
> 
Thank you for your check and comments.
I will fix and update all.

Best regards,
  Nobuhiro
