From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/1] [Video/Framebuffer]: Hitachi
	TX09D70VM1CDA TFT LCD framebuffer driver
Date: Mon, 12 May 2008 20:18:05 +0900
Message-ID: <20080512111805.GA11299@linux-sh.org>
References: <1210589347-12840-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvW46-0000k9-JU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 04:19:34 -0700
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JvW45-0002Do-Ov
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 May 2008 04:19:34 -0700
Content-Disposition: inline
In-Reply-To: <1210589347-12840-1-git-send-email-cooloney@kernel.org>
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
To: Bryan Wu <cooloney@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Harald Krapfenbauer <harald.krapfenbauer@bluetechnix.at>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, May 12, 2008 at 06:49:07PM +0800, Bryan Wu wrote:
> +config FB_HITACHI_TX09_REFRESHRATE
> +	int "Refresh rate"
> +	depends on FB_HITACHI_TX09
> +	range 25 70
> +	default 52
> +	help
> +	  Refresh rate of the LCD in Hz. According to data sheet, must
> +	  be in the interval [52...68].
> +
25..70 != 52..68, pick one and stick with it. If there's a reason for the
discrepency, then document that, too. ie, "data sheet has no relation to
hardware".

> +static void stop_timers(void)
> +{
> +	unsigned long flags;
> +	long old_value = 0, new_value = 0;
> +
> +	local_irq_save(flags);
> +
[snip]

> +	while (1) {
> +		old_value = new_value;
> +		new_value = BFIN_READ(TIMER_VSYNC, COUNTER) ();
> +		if ((old_value - new_value) > 45000) {

The only way to break out of here is dependent on the timer. You have no
timeout in the case of the timer getting stuck.

> +static int tx09_fb_open(struct fb_info *info, int user)
> +{
> +	unsigned long flags;
> +
> +	pr_debug("%s\n", __FUNCTION__);
> +
> +	spin_lock_irqsave(&tx09_lock, flags);
> +	tx09_open_cnt++;	/* increase counter */
> +	spin_unlock_irqrestore(&tx09_lock, flags);
> +
> +	if (tx09_open_cnt <= 1) {	/* opened the first time */
> +
> +		/* stop PPI */
> +		WRITE_PPI_CONTROL(0);
> +		SSYNC();
> +
> +		/* configure dma stuff */
> +		config_dma();
> +
> +		config_ppi();
> +
> +		/* start dma */
> +		enable_dma(CH_PPI);
> +		SSYNC();
> +
> +		/* start PPI */
> +		WRITE_PPI_CONTROL(READ_PPI_CONTROL() | PORT_EN);
> +		SSYNC();
> +
> +		if (!t_conf_done)
> +			config_timers();
> +
> +		start_timers();
> +	}
> +

Presumably this should be done in the probe path, rather than lazily.
Though you don't bother doing any error checking, so I suppose it doesn't
really matter.

> +static int tx09_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	unsigned long flags;
> +
> +	pr_debug("%s\n", __FUNCTION__);
> +
> +	if (tx09_mmap)
> +		return -1;	/* already mmap'ed */
> +
> +	spin_lock_irqsave(&tx09_lock, flags);
> +	tx09_mmap = 1;
> +	spin_unlock_irqrestore(&tx09_lock, flags);
> +
> +	vma->vm_start = (unsigned long)fb_buffer;
> +	vma->vm_end = vma->vm_start + 320 * 240 * 2;
> +	vma->vm_flags |= VM_MAYSHARE | VM_SHARED;
> +
> +	return 0;
> +}
> +
This is equally bizarre. If you can never support more than one opener of
this device, then have your open() reflect that, rather than trying to do
these lame hacks in every file op.

Beyond that, the size of the VMA is reflected in info->fix.mmio_len,
which the generic fb_mmap() takes care of for you. Other than the
questionable VMA flags, it's not obvious why you rolled your own mmap.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
