From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 v4] Add DIU platform code for
	MPC8610HPCD
Date: Fri, 28 Mar 2008 12:19:25 -0500
Message-ID: <47ED289D.3020607@freescale.com>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<1206672058321-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfIEl-0003cI-Dt for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 10:19:32 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JfIEj-0007ax-1S
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 10:19:31 -0700
In-Reply-To: <1206672058321-git-send-email-yorksun@freescale.com>
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
To: York Sun <yorksun@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, Timur Tabi <timur@freescale.com>

York Sun wrote:
> +	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
> +	if (np) {
> +		of_address_to_resource(np, 0, &r);
> +		of_node_put(np);
> +		pixis_bdcfg0 = ioremap(r.start + 0x00000008, sizeof(u8));
> +		if (!pixis_bdcfg0) {
> +			printk(KERN_ERR "Err: can't map FPGA cfg register!\n");
> +			return;
> +		}
> +		pixis_arch = ioremap(r.start + 0x00000001, sizeof(u8));
> +		if (!pixis_arch) {
> +			printk(KERN_ERR "Err: can't map FPGA arch register!\n");
> +			return;
> +		}

Just of_iomap() the whole resource, rather than doing it a byte at a time.

> +int __init preallocate_diu_videomemory(void)
> +{
> +	pr_debug("diu_size=%lu\n", diu_ops.diu_size);
> +
> +	diu_ops.diu_mem = __alloc_bootmem(diu_ops.diu_size, 8, 0);
> +	if (!diu_ops.diu_mem) {
> +		printk(KERN_ERR "fsl-diu: cannot allocate %lu bytes\n",
> +			diu_ops.diu_size);
> +		return -ENOMEM;
> +	}
> +
> +	printk(KERN_INFO "%s: diu_mem=%p\n", __func__, diu_ops.diu_mem);

The pr_debug line is more useful information than the KERN_INFO line...

-Scott

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
