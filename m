From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 11 Nov 2011 16:15:15 +0000
Subject: Re: [RFC] drivers/video: fsl-diu-fb: combine several allocated buffers
Message-Id: <4EBD4A13.8040302@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1320793445-29562-1-git-send-email-timur@freescale.com>
In-Reply-To: <1320793445-29562-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11/08/2011 11:04 PM, Timur Tabi wrote:
> (Florian: this patch is the first of my changes for 3.3, but because it's
> so extensive, I wanted to get your feedback before I continue with the rest
> of my changes).

In general this looks good to me. Just keep in mind that multiple small patches
are preferred.

> The DIU driver allocates several different objects separately, many of
> which are accessed directly by the hardware and must be aligned on various
> boundaries.  This results in multiple allocations and awkward data
> structures used to keep track of all the pointers and physical addresses.
> 
> Instead, merge all of these objects into the fsl_diu_data structure, and
> enforce the alignment within the structure.  Only one physical address
> needs to be remember, and a macro is used to calculate the physical
> address of any field.  Frame buffers are still allocated separately,
> since their sizes vary with the resolutions.

The idea to merge multiple DMA objects sounds good. But I think you might want
to have a look at what you put in the DMA area. I think it would be better and
cleaner to put things that should be never accessed by the device, like
fsl_diu_info, irq, reg_lock and so on, in a separate structure.

> Documentation for some affected data structures and variables is added.

You could do this in an separate patch as it's independent of your idea to merge
the DMA objects. Well, I do not care very much in this case.

> The code assume that dma_alloc_coherent() will always return an aligned
> memory block.  This function uses a page allocator on every architecture
> that has a DIU, so this is safe.  The alternative is to allocate an extra
> 31 bytes that will never be used, and keep track of offsets that will
> always be zero.  However, to be future-proof, we still validate the
> alignement.

Okay.


Best regards,

Florian Tobias Schandinat

> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  drivers/video/fsl-diu-fb.c |  264 ++++++++++++++++++++------------------------
>  1 files changed, 118 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index a16beeb..68f24a5 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -36,11 +36,9 @@
>  #include <linux/fsl-diu-fb.h>
>  #include "edid.h"
> 
> -#define FSL_AOI_NUM	6	/* 5 AOIs and one dummy AOI */
> -				/* 1 for plane 0, 2 for plane 1&2 each */
> +#define NUM_AOIS	5	/* 1 for plane 0, 2 for planes 1 & 2 each */
> 
> -/* HW cursor parameters */
> -#define MAX_CURS		32
> +#define MAX_CURS	32	/* HW cursor is 32 * 32 pixels, 16 bpp */
> 
>  /* INT_STATUS/INT_MASK field descriptions */
>  #define INT_VSYNC	0x01	/* Vsync interrupt  */
> @@ -49,12 +47,6 @@
>  #define INT_PARERR	0x08	/* Display parameters error interrupt */
>  #define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
> 
> -struct diu_addr {
> -	void *vaddr;		/* Virtual address */
> -	dma_addr_t paddr;	/* Physical address */
> -	__u32 offset;
> -};
> -
>  /*
>   * List of supported video modes
>   *
> @@ -330,22 +322,43 @@ static unsigned int d_cache_line_size;
> 
>  static DEFINE_SPINLOCK(diu_lock);
> 
> +/**
> + * struct fsl_diu_data - per-DIU data structure
> + * @phys: physical address of this structure
> + * @fsl_diu_info: fb_info objects, one per AOI
> + * @dev_attr: sysfs structure
> + * @irq: IRQ
> + * @fb_enabled: TRUE if the DIU is enabled, FALSE if not
> + * @monitor_port: the monitor port this DIU is connected to
> + * @diu_reg: pointer to the DIU hardware registers
> + * @reg_lock: spinlock for register access
> + * @dummy_aoi: video buffer for the 4x4 32-bit dummy AOI
> + * dummy_ad: DIU Area Descriptor for the dummy AOI
> + * @ad[]: Area Descriptors for each real AOI
> + * @gamma: gamma color table
> + * @cursor: hardware cursor data
> + *
> + * This data structure must be allocated with 32-byte alignment, so that the
> + * internal fields can be aligned properly.
> + */
>  struct fsl_diu_data {
> -	struct fb_info *fsl_diu_info[FSL_AOI_NUM - 1];
> -				/*FSL_AOI_NUM has one dummy AOI */
> +	dma_addr_t phys;
> +	struct fb_info *fsl_diu_info[NUM_AOIS];
>  	struct device_attribute dev_attr;
> -	struct diu_ad *dummy_ad;
> -	void *dummy_aoi_virt;
>  	unsigned int irq;
>  	int fb_enabled;
>  	enum fsl_diu_monitor_port monitor_port;
>  	struct diu __iomem *diu_reg;
>  	spinlock_t reg_lock;
> -	struct diu_addr ad;
> -	struct diu_addr gamma;
> -	struct diu_addr pallete;
> -	struct diu_addr cursor;
> -};
> +	u8 dummy_aoi[4 * 4 * 4];
> +	struct diu_ad dummy_ad __aligned(8);
> +	struct diu_ad ad[NUM_AOIS] __aligned(8);
> +	u8 gamma[256 * 3] __aligned(32);
> +	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
> +} __aligned(32);
> +
> +/* Determine the physical address of a member of the fsl_diu_data structure */
> +#define PHYS_ADDR(p, f) ((p)->phys + offsetof(struct fsl_diu_data, f))
> 
>  enum mfb_index {
>  	PLANE0 = 0,	/* Plane 0, only one AOI that fills the screen */
> @@ -355,6 +368,21 @@ enum mfb_index {
>  	PLANE2_AOI1,	/* Plane 2, second AOI */
>  };
> 
> +/**
> + * struct mfb_info - per-AOI data structure
> + * @index: the AOI index
> + * @id: the name of this AOI
> + * @registered: TRUE = this framebuffer has been registed with fbdev
> + * @pseudo_palette: the pseudo-palette
> + * @ad: pointer to the Area Descriptor for this AOI
> + * @cursor_reset: unusued
> + * @g_alpha: the global alpha value, can be set by ioctl
> + * @count: the number of times this framebuffer has been opened
> + * @x_aoi_d: X-offset of the AOI.  0 is the left edge of the physical screen
> + * @y_aoi_d: Y-offset of the AOI.  0 is the top edge of the physical screen
> + * @parent: pointer to fsl_diu_data structure
> + * @edid_data: EDID data
> + */
>  struct mfb_info {
>  	enum mfb_index index;
>  	char *id;
> @@ -364,8 +392,8 @@ struct mfb_info {
>  	int cursor_reset;
>  	unsigned char g_alpha;
>  	unsigned int count;
> -	int x_aoi_d;		/* aoi display x offset to physical screen */
> -	int y_aoi_d;		/* aoi display y offset to physical screen */
> +	int x_aoi_d;
> +	int y_aoi_d;
>  	struct fsl_diu_data *parent;
>  	u8 *edid_data;
>  };
> @@ -528,7 +556,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
>  	case PLANE1_AOI1:
>  		pmfbi = machine_data->fsl_diu_info[1]->par;
>  		ad->next_ad = 0;
> -		if (hw->desc[1] = machine_data->dummy_ad->paddr)
> +		if (hw->desc[1] = machine_data->dummy_ad.paddr)
>  			wr_reg_wa(&hw->desc[1], ad->paddr);
>  		else					/* AOI0 open */
>  			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
> @@ -536,7 +564,7 @@ static void fsl_diu_enable_panel(struct fb_info *info)
>  	case PLANE2_AOI1:
>  		pmfbi = machine_data->fsl_diu_info[3]->par;
>  		ad->next_ad = 0;
> -		if (hw->desc[2] = machine_data->dummy_ad->paddr)
> +		if (hw->desc[2] = machine_data->dummy_ad.paddr)
>  			wr_reg_wa(&hw->desc[2], ad->paddr);
>  		else				/* AOI0 was open */
>  			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
> @@ -553,8 +581,8 @@ static void fsl_diu_disable_panel(struct fb_info *info)
> 
>  	switch (mfbi->index) {
>  	case PLANE0:
> -		if (hw->desc[0] != machine_data->dummy_ad->paddr)
> -			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad->paddr);
> +		if (hw->desc[0] != machine_data->dummy_ad.paddr)
> +			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad.paddr);
>  		break;
>  	case PLANE1_AOI0:
>  		cmfbi = machine_data->fsl_diu_info[2]->par;
> @@ -562,7 +590,7 @@ static void fsl_diu_disable_panel(struct fb_info *info)
>  			wr_reg_wa(&hw->desc[1], cmfbi->ad->paddr);
>  					/* move AOI1 to the first */
>  		else			/* AOI1 was closed */
> -			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
> +			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
>  					/* close AOI 0 */
>  		break;
>  	case PLANE2_AOI0:
> @@ -571,7 +599,7 @@ static void fsl_diu_disable_panel(struct fb_info *info)
>  			wr_reg_wa(&hw->desc[2], cmfbi->ad->paddr);
>  					/* move AOI1 to the first */
>  		else			/* AOI1 was closed */
> -			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
> +			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
>  					/* close AOI 0 */
>  		break;
>  	case PLANE1_AOI1:
> @@ -582,7 +610,7 @@ static void fsl_diu_disable_panel(struct fb_info *info)
>  					/* AOI0 is open, must be the first */
>  				pmfbi->ad->next_ad = 0;
>  		} else			/* AOI1 is the first in the chain */
> -			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
> +			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad.paddr);
>  					/* close AOI 1 */
>  		break;
>  	case PLANE2_AOI1:
> @@ -593,7 +621,7 @@ static void fsl_diu_disable_panel(struct fb_info *info)
>  				/* AOI0 is open, must be the first */
>  				pmfbi->ad->next_ad = 0;
>  		} else		/* AOI1 is the first in the chain */
> -			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
> +			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad.paddr);
>  				/* close AOI 1 */
>  		break;
>  	}
> @@ -812,15 +840,15 @@ static void update_lcdc(struct fb_info *info)
>  	struct fsl_diu_data *machine_data = mfbi->parent;
>  	struct diu __iomem *hw;
>  	int i, j;
> -	char __iomem *cursor_base, *gamma_table_base;
> +	u8 *gamma_table_base;
> 
>  	u32 temp;
> 
>  	hw = machine_data->diu_reg;
> 
>  	diu_ops.set_monitor_port(machine_data->monitor_port);
> -	gamma_table_base = machine_data->gamma.vaddr;
> -	cursor_base = machine_data->cursor.vaddr;
> +	gamma_table_base = machine_data->gamma;
> +
>  	/* Prep for DIU init  - gamma table, cursor table */
> 
>  	for (i = 0; i <= 2; i++)
> @@ -828,14 +856,14 @@ static void update_lcdc(struct fb_info *info)
>  			*gamma_table_base++ = j;
> 
>  	diu_ops.set_gamma_table(machine_data->monitor_port,
> -				machine_data->gamma.vaddr);
> +		machine_data->gamma);
> 
>  	disable_lcdc(info);
> 
>  	/* Program DIU registers */
> 
> -	out_be32(&hw->gamma, machine_data->gamma.paddr);
> -	out_be32(&hw->cursor, machine_data->cursor.paddr);
> +	out_be32(&hw->gamma, PHYS_ADDR(machine_data, gamma));
> +	out_be32(&hw->cursor, PHYS_ADDR(machine_data, cursor));
> 
>  	out_be32(&hw->bgnd, 0x007F7F7F); 	/* BGND */
>  	out_be32(&hw->bgnd_wb, 0); 		/* BGND_WB */
> @@ -1423,37 +1451,6 @@ static int fsl_diu_resume(struct platform_device *ofdev)
>  #define fsl_diu_resume NULL
>  #endif				/* CONFIG_PM */
> 
> -/* Align to 64-bit(8-byte), 32-byte, etc. */
> -static int allocate_buf(struct device *dev, struct diu_addr *buf, u32 size,
> -			u32 bytes_align)
> -{
> -	u32 offset;
> -	dma_addr_t mask;
> -
> -	buf->vaddr > -		dma_alloc_coherent(dev, size + bytes_align, &buf->paddr,
> -				   GFP_DMA | __GFP_ZERO);
> -	if (!buf->vaddr)
> -		return -ENOMEM;
> -
> -	mask = bytes_align - 1;
> -	offset = buf->paddr & mask;
> -	if (offset) {
> -		buf->offset = bytes_align - offset;
> -		buf->paddr = buf->paddr + offset;
> -	} else
> -		buf->offset = 0;
> -
> -	return 0;
> -}
> -
> -static void free_buf(struct device *dev, struct diu_addr *buf, u32 size,
> -		     u32 bytes_align)
> -{
> -	dma_free_coherent(dev, size + bytes_align, buf->vaddr,
> -			  buf->paddr - buf->offset);
> -}
> -
>  static ssize_t store_monitor(struct device *device,
>  	struct device_attribute *attr, const char *buf, size_t count)
>  {
> @@ -1499,28 +1496,54 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct mfb_info *mfbi;
> -	phys_addr_t dummy_ad_addr = 0;
> -	int ret, i, error = 0;
>  	struct fsl_diu_data *machine_data;
>  	int diu_mode;
> +	dma_addr_t phys_addr;	/* physical addr of machine_data struct */
> +	unsigned int i;
> +	int ret;
> 
> -	machine_data = kzalloc(sizeof(struct fsl_diu_data), GFP_KERNEL);
> +	machine_data = dma_alloc_coherent(&pdev->dev,
> +		sizeof(struct fsl_diu_data), &phys_addr, GFP_DMA | __GFP_ZERO);
>  	if (!machine_data)
>  		return -ENOMEM;
> +	machine_data->phys = phys_addr;
> +
> +	/*
> +	 * dma_alloc_coherent() uses a page allocator, so the address is
> +	 * always page-aligned.  We need the memory to be 32-byte aligned,
> +	 * so that's good.  However, if one day the allocator changes, we
> +	 * need to catch that.  It's not worth the effort to handle unaligned
> +	 * alloctions now because it's highly unlikely to ever be a problem.
> +	 */
> +	if ((unsigned long)machine_data & 31) {
> +		dev_err(&pdev->dev, "misaligned allocation");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> 
>  	spin_lock_init(&machine_data->reg_lock);
> 
> -	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
> +	for (i = 0; i < NUM_AOIS; i++) {
>  		machine_data->fsl_diu_info[i] >  			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
>  		if (!machine_data->fsl_diu_info[i]) {
>  			dev_err(&pdev->dev, "cannot allocate memory\n");
>  			ret = -ENOMEM;
> -			goto error2;
> +			goto error;
>  		}
> +		/*
> +		 * We store the physical address of the AD in the reserved
> +		 * 'paddr' field of the AD itself.
> +		 */
> +		machine_data->ad[i].paddr = PHYS_ADDR(machine_data, ad[i]);
> +
> +		machine_data->fsl_diu_info[i]->fix.smem_start = 0;
> +
> +		/* Initialize the AOI data structure */
>  		mfbi = machine_data->fsl_diu_info[i]->par;
>  		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
>  		mfbi->parent = machine_data;
> +		mfbi->ad = &machine_data->ad[i];
> 
>  		if (mfbi->index = PLANE0) {
>  			const u8 *prop;
> @@ -1538,7 +1561,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  	if (!machine_data->diu_reg) {
>  		dev_err(&pdev->dev, "cannot map DIU registers\n");
>  		ret = -EFAULT;
> -		goto error2;
> +		goto error;
>  	}
> 
>  	diu_mode = in_be32(&machine_data->diu_reg->diu_mode);
> @@ -1555,41 +1578,16 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  	}
>  	machine_data->monitor_port = monitor_port;
> 
> -	/* Area descriptor memory pool aligns to 64-bit boundary */
> -	if (allocate_buf(&pdev->dev, &machine_data->ad,
> -			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8))
> -		return -ENOMEM;
> -
> -	/* Get memory for Gamma Table  - 32-byte aligned memory */
> -	if (allocate_buf(&pdev->dev, &machine_data->gamma, 768, 32)) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	/* For performance, cursor bitmap buffer aligns to 32-byte boundary */
> -	if (allocate_buf(&pdev->dev, &machine_data->cursor,
> -			 MAX_CURS * MAX_CURS * 2, 32)) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	i = ARRAY_SIZE(machine_data->fsl_diu_info);
> -	machine_data->dummy_ad = (struct diu_ad *)((u32)machine_data->ad.vaddr +
> -			machine_data->ad.offset) + i;
> -	machine_data->dummy_ad->paddr = machine_data->ad.paddr +
> -			i * sizeof(struct diu_ad);
> -	machine_data->dummy_aoi_virt = fsl_diu_alloc(64, &dummy_ad_addr);
> -	if (!machine_data->dummy_aoi_virt) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -	machine_data->dummy_ad->addr = cpu_to_le32(dummy_ad_addr);
> -	machine_data->dummy_ad->pix_fmt = 0x88882317;
> -	machine_data->dummy_ad->src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
> -	machine_data->dummy_ad->aoi_size = cpu_to_le32((4 << 16) |  2);
> -	machine_data->dummy_ad->offset_xyi = 0;
> -	machine_data->dummy_ad->offset_xyd = 0;
> -	machine_data->dummy_ad->next_ad = 0;
> +	/* Initialize the dummy Area Descriptor */
> +	machine_data->dummy_ad.addr > +		cpu_to_le32(PHYS_ADDR(machine_data, dummy_aoi));
> +	machine_data->dummy_ad.pix_fmt = 0x88882317;
> +	machine_data->dummy_ad.src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
> +	machine_data->dummy_ad.aoi_size = cpu_to_le32((4 << 16) |  2);
> +	machine_data->dummy_ad.offset_xyi = 0;
> +	machine_data->dummy_ad.offset_xyd = 0;
> +	machine_data->dummy_ad.next_ad = 0;
> +	machine_data->dummy_ad.paddr = PHYS_ADDR(machine_data, dummy_ad);
> 
>  	/*
>  	 * Let DIU display splash screen if it was pre-initialized
> @@ -1597,18 +1595,12 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  	 */
>  	if (diu_mode = MFB_MODE0)
>  		out_be32(&machine_data->diu_reg->desc[0],
> -			 machine_data->dummy_ad->paddr);
> +			 machine_data->dummy_ad.paddr);
> 
> -	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad->paddr);
> -	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad->paddr);
> +	out_be32(&machine_data->diu_reg->desc[1], machine_data->dummy_ad.paddr);
> +	out_be32(&machine_data->diu_reg->desc[2], machine_data->dummy_ad.paddr);
> 
> -	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++) {
> -		machine_data->fsl_diu_info[i]->fix.smem_start = 0;
> -		mfbi = machine_data->fsl_diu_info[i]->par;
> -		mfbi->ad = (struct diu_ad *)((u32)machine_data->ad.vaddr
> -					+ machine_data->ad.offset) + i;
> -		mfbi->ad->paddr > -			machine_data->ad.paddr + i * sizeof(struct diu_ad);
> +	for (i = 0; i < NUM_AOIS; i++) {
>  		ret = install_fb(machine_data->fsl_diu_info[i]);
>  		if (ret) {
>  			dev_err(&pdev->dev, "could not register fb %d\n", i);
> @@ -1626,9 +1618,8 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
>  	machine_data->dev_attr.attr.mode = S_IRUGO|S_IWUSR;
>  	machine_data->dev_attr.show = show_monitor;
>  	machine_data->dev_attr.store = store_monitor;
> -	error = device_create_file(machine_data->fsl_diu_info[0]->dev,
> -				  &machine_data->dev_attr);
> -	if (error) {
> +	ret = device_create_file(&pdev->dev, &machine_data->dev_attr);
> +	if (ret) {
>  		dev_err(&pdev->dev, "could not create sysfs file %s\n",
>  			machine_data->dev_attr.attr.name);
>  	}
> @@ -1640,52 +1631,33 @@ error:
>  	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
>  		uninstall_fb(machine_data->fsl_diu_info[i]);
> 
> -	if (machine_data->ad.vaddr)
> -		free_buf(&pdev->dev, &machine_data->ad,
> -			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
> -	if (machine_data->gamma.vaddr)
> -		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
> -	if (machine_data->cursor.vaddr)
> -		free_buf(&pdev->dev, &machine_data->cursor,
> -			 MAX_CURS * MAX_CURS * 2, 32);
> -	if (machine_data->dummy_aoi_virt)
> -		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
>  	iounmap(machine_data->diu_reg);
> 
> -error2:
>  	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
>  		if (machine_data->fsl_diu_info[i])
>  			framebuffer_release(machine_data->fsl_diu_info[i]);
> -	kfree(machine_data);
> +
> +	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
> +		machine_data, machine_data->phys);
> 
>  	return ret;
>  }
> 
>  static int fsl_diu_remove(struct platform_device *pdev)
>  {
> -	struct fsl_diu_data *machine_data;
> -	int i;
> +	struct fsl_diu_data *machine_data = dev_get_drvdata(&pdev->dev);
> +	unsigned int i;
> 
> -	machine_data = dev_get_drvdata(&pdev->dev);
>  	disable_lcdc(machine_data->fsl_diu_info[0]);
>  	free_irq_local(machine_data);
>  	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
>  		uninstall_fb(machine_data->fsl_diu_info[i]);
> -	if (machine_data->ad.vaddr)
> -		free_buf(&pdev->dev, &machine_data->ad,
> -			 sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
> -	if (machine_data->gamma.vaddr)
> -		free_buf(&pdev->dev, &machine_data->gamma, 768, 32);
> -	if (machine_data->cursor.vaddr)
> -		free_buf(&pdev->dev, &machine_data->cursor,
> -			 MAX_CURS * MAX_CURS * 2, 32);
> -	if (machine_data->dummy_aoi_virt)
> -		fsl_diu_free(machine_data->dummy_aoi_virt, 64);
>  	iounmap(machine_data->diu_reg);
>  	for (i = 0; i < ARRAY_SIZE(machine_data->fsl_diu_info); i++)
>  		if (machine_data->fsl_diu_info[i])
>  			framebuffer_release(machine_data->fsl_diu_info[i]);
> -	kfree(machine_data);
> +	dma_free_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
> +		machine_data, machine_data->phys);
> 
>  	return 0;
>  }
> --
> 1.7.3.4
> 
> 
> 

