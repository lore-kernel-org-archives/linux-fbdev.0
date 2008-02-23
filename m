From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v3
Date: Sat, 23 Feb 2008 00:07:00 -0800
Message-ID: <20080223000700.dc19a7e5.akpm@linux-foundation.org>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSpRQ-0008BA-Jl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 00:09:04 -0800
Received: from smtp1.linux-foundation.org ([207.189.120.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JSpRO-0004xv-50
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 00:09:04 -0800
In-Reply-To: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
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
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org

On Mon, 18 Feb 2008 08:41:26 -0500 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> Hi Tony, Geert, fbdev,
> 
> This patch implements support for the E-Ink Metronome controller. It
> provides an mmapable interface to the controller using defio support.
> 
> I welcome your feedback. Please let me know if it looks okay to apply.
>
> ...
>
> @@ -31,7 +31,7 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
>  	unsigned long offset;
>  	struct page *page;
>  	struct fb_info *info = vma->vm_private_data;
> -	/* info->screen_base is in System RAM */
> +	/* info->screen_base is virtual memory */
>  	void *screen_base = (void __force *) info->screen_base;
>  
>  	offset = vmf->pgoff << PAGE_SHIFT;
> @@ -43,6 +43,15 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
>  		return VM_FAULT_SIGBUS;
>  
>  	get_page(page);
> +
> +	if (vma->vm_file)
> +		page->mapping = vma->vm_file->f_mapping;
> +	else
> +		printk(KERN_ERR "no mapping available\n");
> +
> +	BUG_ON(!page->mapping);
> +	page->index = vmf->pgoff;
> +
>  	vmf->page = page;
>  	return 0;
>  }

What locking prevents `page' from being stripped off its mapping here?  y
say munmap or truncate (if it's supported here, which it presumably isn't).

> @@ -138,11 +147,20 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_init);
>  
>  void fb_deferred_io_cleanup(struct fb_info *info)
>  {
> +	void *screen_base = (void __force *) info->screen_base;
>  	struct fb_deferred_io *fbdefio = info->fbdefio;
> +	struct page *page;
> +	int i;
>  
>  	BUG_ON(!fbdefio);
>  	cancel_delayed_work(&info->deferred_work);
>  	flush_scheduled_work();
> +
> +	/* clear out the mapping that we setup */
> +	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
> +		page = vmalloc_to_page(screen_base + i);
> +		page->mapping = NULL;
> +	}
>  }

ie: a race with this function?

> +int load_waveform(u8 *mem, u8 *metromem, int m, int t, u8 *frame_count)

This didn't need to be a global symbol.  It would be a poorly chosen
idenfitier if it was global.

> +{
> +	int tta;
> +	int wmta;
> +	int trn = 0;
> +	int i;
> +	unsigned char v;
> +	u8 cksum;
> +	int cksum_idx;
> +	int wfm_idx, owfm_idx;
> +	int mem_idx = 0;
> +	struct waveform_hdr *wfm_hdr;
> +
> +	wfm_hdr = (struct waveform_hdr *) mem;
> +
> +	if (wfm_hdr->fvsn != 1) {
> +		printk(KERN_ERR "Error: bad fvsn %x\n", wfm_hdr->fvsn);
> +		return -EINVAL;
> +	}
> +	if (wfm_hdr->luts != 0) {
> +		printk(KERN_ERR "Error: bad luts %x\n", wfm_hdr->luts);
> +		return -EINVAL;
> +	}
> +	cksum = calc_cksum(32, 47, mem);
> +	if (cksum != wfm_hdr->wfm_cs) {
> +		printk(KERN_ERR "Error: bad cksum %x != %x\n", cksum,
> +					wfm_hdr->wfm_cs);
> +		return -EINVAL;
> +	}
> +	wfm_hdr->mc += 1;
> +	wfm_hdr->trc += 1;
> +	for (i = 0; i < 5; i++) {
> +		if (*(wfm_hdr->stuff2a + i) != 0) {
> +			printk(KERN_ERR "Error: unexpected value in padding\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* calculating trn. trn is something used to index into
> +	the waveform. presumably selecting the right one for the
> +	desired temperature. it works out the offset of the first
> +	v that exceeds the specified temperature */
> +	for (i = sizeof(*wfm_hdr); i <= sizeof(*wfm_hdr) + wfm_hdr->trc; i++) {
> +		if (mem[i] > t) {
> +			trn = i - sizeof(*wfm_hdr) - 1;
> +			break;
> +		}
> +	}
> +
> +	/* check temperature range table checksum */
> +	cksum_idx = sizeof(*wfm_hdr) + wfm_hdr->trc + 1;
> +	cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
> +	if (cksum != mem[cksum_idx]) {
> +		printk(KERN_ERR "Error: bad temperature range table cksum"
> +				" %x != %x\n", cksum, mem[cksum_idx]);
> +		return -EINVAL;
> +	}
> +
> +	/* check waveform mode table address checksum */
> +	wmta = *((int *) wfm_hdr->wmta) & 0x00FFFFFF;
> +	cksum_idx = wmta + m*4 + 3;
> +	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
> +	if (cksum != mem[cksum_idx]) {
> +		printk(KERN_ERR "Error: bad mode table address cksum"
> +				" %x != %x\n", cksum, mem[cksum_idx]);
> +		return -EINVAL;
> +	}
> +
> +	/* check waveform temperature table address checksum */
> +	tta = *((int *) (mem + wmta + m*4)) & 0x00FFFFFF;

Does this code have any unaligned-access issues on non-x86?

> +	cksum_idx = tta + trn*4 + 3;
> +	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
> +	if (cksum != mem[cksum_idx]) {
> +		printk(KERN_ERR "Error: bad temperature table address cksum"
> +			" %x != %x\n", cksum, mem[cksum_idx]);
> +		return -EINVAL;
> +	}
> +
> +	/* here we do the real work of putting the waveform into the
> +	metromem buffer. this does runlength decoding of the waveform */
> +	owfm_idx = wfm_idx = *((int *) (mem + tta + trn*4)) & 0x00FFFFFF;
> +	while (1) {
> +		unsigned char rl;
> +		v = mem[wfm_idx++];
> +		if (v == wfm_hdr->swtb) {
> +			while ((v = mem[wfm_idx++]) != wfm_hdr->swtb)
> +				metromem[mem_idx++] = v;
> +
> +			continue;
> +		}
> +
> +		if (v == wfm_hdr->endb)
> +			break;
> +
> +		rl = mem[wfm_idx++];
> +		for (i = 0; i <= rl; i++)
> +			metromem[mem_idx++] = v;
> +	}
> +
> +	cksum_idx = wfm_idx;
> +	cksum = calc_cksum(owfm_idx, cksum_idx, mem);
> +	if (cksum != mem[cksum_idx]) {
> +		printk(KERN_ERR "Error: bad waveform data cksum"
> +				" %x != %x\n", cksum, mem[cksum_idx]);
> +		return -EINVAL;
> +	}
> +	*frame_count = (mem_idx/64);
> +
> +	return 0;
> +}
>
> ...
>
> +/* this technique copied from pxafb */
> +static void metronome_disable_lcd_controller(struct metronomefb_par *par)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +	add_wait_queue(&par->waitq, &wait);
> +
> +	LCSR = 0xffffffff;	/* Clear LCD Status Register */
> +	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */
> +	LCCR0 |= LCCR0_DIS;	/* Disable LCD Controller */
> +
> +	schedule_timeout(200 * HZ / 1000);
> +	remove_wait_queue(&par->waitq, &wait);
> +}

I assume that if the schedule_timeout() actually times out, we have an
error condition?  Should it be reported?

> +static void metronome_enable_lcd_controller(struct metronomefb_par *par)
> +{
> +	LCSR = 0xffffffff;
> +	FDADR0 = par->metromem_desc_dma;
> +	LCCR0 |= LCCR0_ENB;
> +}
>
> ...
>
> +static int metronome_display_cmd(struct metronomefb_par *par)
> +{
> +	int i;
> +	u16 cs;
> +	u16 opcode;
> +	static u8 borderval;
> +	u8 *ptr;
> +
> +	/* setup display command
> +	we can't immediately set the opcode since the controller
> +	will try parse the command before we've set it all up
> +	so we just set cs here and set the opcode at the end */
> +
> +	ptr = par->metromem;
> +
> +	if (par->metromem_cmd->opcode == 0xCC40)
> +		opcode = cs = 0xCC41;
> +	else
> +		opcode = cs = 0xCC40;
> +
> +	/* set the args ( 2 bytes ) for display */
> +	i = 0;
> +	par->metromem_cmd->args[i] = 	1 << 3 /* border update */
> +					| ((borderval++ % 4) & 0x0F) << 4
> +					| (par->frame_count - 1) << 8;
> +	cs += par->metromem_cmd->args[i++];
> +
> +	/* the rest are 0 */
> +	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
> +
> +	par->metromem_cmd->csum = cs;
> +	par->metromem_cmd->opcode = opcode; /* display cmd */
> +
> +	i = wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
> +	return i;
> +}

wait_event_interruptible_timeout() will return immediately if the calling
task has a signal pending.  Will this ause the driver to malfunction?

> +static int __devinit metronome_powerup_cmd(struct metronomefb_par *par)
> +{
> +	int i;
> +	u16 cs;
> +
> +	/* setup power up command */
> +	par->metromem_cmd->opcode = 0x1234; /* pwr up pseudo cmd */
> +	cs = par->metromem_cmd->opcode;
> +
> +	/* set pwr1,2,3 to 1024 */
> +	for (i = 0; i < 3; i++) {
> +		par->metromem_cmd->args[i] = 1024;
> +		cs += par->metromem_cmd->args[i];
> +	}
> +
> +	/* the rest are 0 */
> +	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
> +
> +	par->metromem_cmd->csum = cs;
> +
> +	msleep(1);
> +	metronome_set_gpio_output(RST_GPIO_PIN, 1);
> +
> +	msleep(1);
> +	metronome_set_gpio_output(STDBY_GPIO_PIN, 1);
> +
> +	i = wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
> +	return i;
> +}

Ditto

> +static int __devinit metronome_config_cmd(struct metronomefb_par *par)
> +{
> +	int i;
> +	u16 cs;
> +
> +	/* setup config command
> +	we can't immediately set the opcode since the controller
> +	will try parse the command before we've set it all up
> +	so we just set cs here and set the opcode at the end */
> +
> +	cs = 0xCC10;
> +
> +	/* set the 12 args ( 8 bytes ) for config. see spec for meanings */
> +	i = 0;
> +	par->metromem_cmd->args[i] = 	15 /* sdlew */
> +					| 2 << 8 /* sdosz */
> +					| 0 << 11 /* sdor */
> +					| 0 << 12 /* sdces */
> +					| 0 << 15; /* sdcer */
> +	cs += par->metromem_cmd->args[i++];
> +
> +	par->metromem_cmd->args[i] = 	42 /* gdspl */
> +					| 1 << 8 /* gdr1 */
> +					| 1 << 9 /* sdshr */
> +					| 0 << 15; /* gdspp */
> +	cs += par->metromem_cmd->args[i++];
> +
> +	par->metromem_cmd->args[i] = 	18 /* gdspw */
> +					| 0 << 15; /* dispc */
> +	cs += par->metromem_cmd->args[i++];
> +
> +	par->metromem_cmd->args[i] = 	599 /* vdlc */
> +					| 0 << 11 /* dsi */
> +					| 0 << 12; /* dsic */
> +	cs += par->metromem_cmd->args[i++];
> +
> +	/* the rest are 0 */
> +	memset((u8 *) (par->metromem_cmd->args + i), 0, (32-i)*2);
> +
> +	par->metromem_cmd->csum = cs;
> +	par->metromem_cmd->opcode = 0xCC10; /* config cmd */
> +
> +	i = wait_event_interruptible_timeout(par->waitq, (GPLR1 & 0x01), HZ);
> +	return i;
> +}

more...

> +/*
> + * this is the slow path from userspace. they can seek and write to
> + * the fb.
> + */
> +static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
> +				size_t count, loff_t *ppos)
> +{
> +	unsigned long p;
> +	int err = -EINVAL;
> +	struct metronomefb_par *par;
> +	unsigned int xres;
> +	unsigned int fbmemlength;
> +
> +	p = *ppos;
> +	par = info->par;
> +	xres = info->var.xres;
> +	fbmemlength = (xres * info->var.yres);
> +
> +	if (p > fbmemlength)
> +		return -ENOSPC;
> +
> +	err = 0;
> +	if ((count + p) > fbmemlength) {
> +		count = fbmemlength - p;
> +		err = -ENOSPC;
> +	}
> +
> +	if (count) {
> +		char *base_addr;
> +
> +		base_addr = (char __force *)info->screen_base;
> +		count -= copy_from_user(base_addr + p, buf, count);
> +		*ppos += count;
> +		err = -EFAULT;
> +	}

This looks odd.  We ignore the return value from copy_from_user(), which
will wreck *ppos.  We also always return -EFAULT.

> +	metronomefb_dpy_update(par);
> +
> +	if (count)
> +		return count;
> +
> +	return err;
> +}
> +

I don't think I'll apply this one yet.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
