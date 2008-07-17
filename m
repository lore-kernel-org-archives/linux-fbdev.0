From: "MadLoisae@gmx.net" <MadLoisae@gmx.net>
Subject: Re: kernel oops with framebuffer device vt8623fb
Date: Thu, 17 Jul 2008 13:23:46 +0200
Message-ID: <487F2BC2.8020000@gmx.net>
References: <487E2911.5090701@gmx.net> <20080717013917.GA1695@localhost.localdomain>
Reply-To: MadLoisae@gmx.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757537AbYGQLYA@vger.kernel.org>
In-Reply-To: <20080717013917.GA1695@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

this patch fixed my problem completly.

thanks a lot!

kind regards, Alois

Ondrej Zajicek wrote:
> On Wed, Jul 16, 2008 at 07:00:02PM +0200, MadLoisae@gmx.net wrote:
>   
>> Hi!
>>
>> I've updated my machine from 2.6.25.11 to 2.6.26 and I think I've found 
>> a problem.
>>
>> If I load the module vt8623fb i get a kernel oops, if the VIA 8623 
>> display framebuffer driver is compiled direct into kernel the system 
>> hangs up very early at booting the kernel.
>>     
>
> I am sorry for mistake, here is a patch for 2.6.26 fixing the bug:
>
> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
>
> diff -uprN -X linux-2.6.26-orig/Documentation/dontdiff linux-2.6.26-orig/drivers/video/arkfb.c linux-2.6.26/drivers/video/arkfb.c
> --- linux-2.6.26-orig/drivers/video/arkfb.c	2008-07-13 23:51:29.000000000 +0200
> +++ linux-2.6.26/drivers/video/arkfb.c	2008-07-16 22:56:34.000000000 +0200
> @@ -958,20 +958,20 @@ static int __devinit ark_pci_probe(struc
>  	/* Prepare PCI device */
>  	rc = pci_enable_device(dev);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot enable PCI device\n");
> +		dev_err(info->device, "cannot enable PCI device\n");
>  		goto err_enable_device;
>  	}
>  
>  	rc = pci_request_regions(dev, "arkfb");
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot reserve framebuffer region\n");
> +		dev_err(info->device, "cannot reserve framebuffer region\n");
>  		goto err_request_regions;
>  	}
>  
>  	par->dac = ics5342_init(ark_dac_read_regs, ark_dac_write_regs, info);
>  	if (! par->dac) {
>  		rc = -ENOMEM;
> -		dev_err(info->dev, "RAMDAC initialization failed\n");
> +		dev_err(info->device, "RAMDAC initialization failed\n");
>  		goto err_dac;
>  	}
>  
> @@ -982,7 +982,7 @@ static int __devinit ark_pci_probe(struc
>  	info->screen_base = pci_iomap(dev, 0, 0);
>  	if (! info->screen_base) {
>  		rc = -ENOMEM;
> -		dev_err(info->dev, "iomap for framebuffer failed\n");
> +		dev_err(info->device, "iomap for framebuffer failed\n");
>  		goto err_iomap;
>  	}
>  
> @@ -1004,19 +1004,19 @@ static int __devinit ark_pci_probe(struc
>  	rc = fb_find_mode(&(info->var), info, mode_option, NULL, 0, NULL, 8);
>  	if (! ((rc == 1) || (rc == 2))) {
>  		rc = -EINVAL;
> -		dev_err(info->dev, "mode %s not found\n", mode_option);
> +		dev_err(info->device, "mode %s not found\n", mode_option);
>  		goto err_find_mode;
>  	}
>  
>  	rc = fb_alloc_cmap(&info->cmap, 256, 0);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot allocate colormap\n");
> +		dev_err(info->device, "cannot allocate colormap\n");
>  		goto err_alloc_cmap;
>  	}
>  
>  	rc = register_framebuffer(info);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot register framebugger\n");
> +		dev_err(info->device, "cannot register framebugger\n");
>  		goto err_reg_fb;
>  	}
>  
> @@ -1090,7 +1090,7 @@ static int ark_pci_suspend (struct pci_d
>  	struct fb_info *info = pci_get_drvdata(dev);
>  	struct arkfb_info *par = info->par;
>  
> -	dev_info(info->dev, "suspend\n");
> +	dev_info(info->device, "suspend\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
> @@ -1121,7 +1121,7 @@ static int ark_pci_resume (struct pci_de
>  	struct fb_info *info = pci_get_drvdata(dev);
>  	struct arkfb_info *par = info->par;
>  
> -	dev_info(info->dev, "resume\n");
> +	dev_info(info->device, "resume\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
> diff -uprN -X linux-2.6.26-orig/Documentation/dontdiff linux-2.6.26-orig/drivers/video/s3fb.c linux-2.6.26/drivers/video/s3fb.c
> --- linux-2.6.26-orig/drivers/video/s3fb.c	2008-07-13 23:51:29.000000000 +0200
> +++ linux-2.6.26/drivers/video/s3fb.c	2008-07-16 22:44:19.000000000 +0200
> @@ -903,13 +903,13 @@ static int __devinit s3_pci_probe(struct
>  	/* Prepare PCI device */
>  	rc = pci_enable_device(dev);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot enable PCI device\n");
> +		dev_err(info->device, "cannot enable PCI device\n");
>  		goto err_enable_device;
>  	}
>  
>  	rc = pci_request_regions(dev, "s3fb");
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot reserve framebuffer region\n");
> +		dev_err(info->device, "cannot reserve framebuffer region\n");
>  		goto err_request_regions;
>  	}
>  
> @@ -921,7 +921,7 @@ static int __devinit s3_pci_probe(struct
>  	info->screen_base = pci_iomap(dev, 0, 0);
>  	if (! info->screen_base) {
>  		rc = -ENOMEM;
> -		dev_err(info->dev, "iomap for framebuffer failed\n");
> +		dev_err(info->device, "iomap for framebuffer failed\n");
>  		goto err_iomap;
>  	}
>  
> @@ -965,19 +965,19 @@ static int __devinit s3_pci_probe(struct
>  	rc = fb_find_mode(&(info->var), info, mode_option, NULL, 0, NULL, 8);
>  	if (! ((rc == 1) || (rc == 2))) {
>  		rc = -EINVAL;
> -		dev_err(info->dev, "mode %s not found\n", mode_option);
> +		dev_err(info->device, "mode %s not found\n", mode_option);
>  		goto err_find_mode;
>  	}
>  
>  	rc = fb_alloc_cmap(&info->cmap, 256, 0);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot allocate colormap\n");
> +		dev_err(info->device, "cannot allocate colormap\n");
>  		goto err_alloc_cmap;
>  	}
>  
>  	rc = register_framebuffer(info);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot register framebuffer\n");
> +		dev_err(info->device, "cannot register framebuffer\n");
>  		goto err_reg_fb;
>  	}
>  
> @@ -1053,7 +1053,7 @@ static int s3_pci_suspend(struct pci_dev
>  	struct fb_info *info = pci_get_drvdata(dev);
>  	struct s3fb_info *par = info->par;
>  
> -	dev_info(info->dev, "suspend\n");
> +	dev_info(info->device, "suspend\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
> @@ -1085,7 +1085,7 @@ static int s3_pci_resume(struct pci_dev*
>  	struct s3fb_info *par = info->par;
>  	int err;
>  
> -	dev_info(info->dev, "resume\n");
> +	dev_info(info->device, "resume\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
> @@ -1102,7 +1102,7 @@ static int s3_pci_resume(struct pci_dev*
>  	if (err) {
>  		mutex_unlock(&(par->open_lock));
>  		release_console_sem();
> -		dev_err(info->dev, "error %d enabling device for resume\n", err);
> +		dev_err(info->device, "error %d enabling device for resume\n", err);
>  		return err;
>  	}
>  	pci_set_master(dev);
> diff -uprN -X linux-2.6.26-orig/Documentation/dontdiff linux-2.6.26-orig/drivers/video/vt8623fb.c linux-2.6.26/drivers/video/vt8623fb.c
> --- linux-2.6.26-orig/drivers/video/vt8623fb.c	2008-07-13 23:51:29.000000000 +0200
> +++ linux-2.6.26/drivers/video/vt8623fb.c	2008-07-16 22:57:05.000000000 +0200
> @@ -677,13 +677,13 @@ static int __devinit vt8623_pci_probe(st
>  
>  	rc = pci_enable_device(dev);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot enable PCI device\n");
> +		dev_err(info->device, "cannot enable PCI device\n");
>  		goto err_enable_device;
>  	}
>  
>  	rc = pci_request_regions(dev, "vt8623fb");
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot reserve framebuffer region\n");
> +		dev_err(info->device, "cannot reserve framebuffer region\n");
>  		goto err_request_regions;
>  	}
>  
> @@ -696,14 +696,14 @@ static int __devinit vt8623_pci_probe(st
>  	info->screen_base = pci_iomap(dev, 0, 0);
>  	if (! info->screen_base) {
>  		rc = -ENOMEM;
> -		dev_err(info->dev, "iomap for framebuffer failed\n");
> +		dev_err(info->device, "iomap for framebuffer failed\n");
>  		goto err_iomap_1;
>  	}
>  
>  	par->mmio_base = pci_iomap(dev, 1, 0);
>  	if (! par->mmio_base) {
>  		rc = -ENOMEM;
> -		dev_err(info->dev, "iomap for MMIO failed\n");
> +		dev_err(info->device, "iomap for MMIO failed\n");
>  		goto err_iomap_2;
>  	}
>  
> @@ -714,7 +714,7 @@ static int __devinit vt8623_pci_probe(st
>  	if ((16 <= memsize1) && (memsize1 <= 64) && (memsize1 == memsize2))
>  		info->screen_size = memsize1 << 20;
>  	else {
> -		dev_err(info->dev, "memory size detection failed (%x %x), suppose 16 MB\n", memsize1, memsize2);
> +		dev_err(info->device, "memory size detection failed (%x %x), suppose 16 MB\n", memsize1, memsize2);
>  		info->screen_size = 16 << 20;
>  	}
>  
> @@ -731,19 +731,19 @@ static int __devinit vt8623_pci_probe(st
>  	rc = fb_find_mode(&(info->var), info, mode_option, NULL, 0, NULL, 8);
>  	if (! ((rc == 1) || (rc == 2))) {
>  		rc = -EINVAL;
> -		dev_err(info->dev, "mode %s not found\n", mode_option);
> +		dev_err(info->device, "mode %s not found\n", mode_option);
>  		goto err_find_mode;
>  	}
>  
>  	rc = fb_alloc_cmap(&info->cmap, 256, 0);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot allocate colormap\n");
> +		dev_err(info->device, "cannot allocate colormap\n");
>  		goto err_alloc_cmap;
>  	}
>  
>  	rc = register_framebuffer(info);
>  	if (rc < 0) {
> -		dev_err(info->dev, "cannot register framebugger\n");
> +		dev_err(info->device, "cannot register framebugger\n");
>  		goto err_reg_fb;
>  	}
>  
> @@ -817,7 +817,7 @@ static int vt8623_pci_suspend(struct pci
>  	struct fb_info *info = pci_get_drvdata(dev);
>  	struct vt8623fb_info *par = info->par;
>  
> -	dev_info(info->dev, "suspend\n");
> +	dev_info(info->device, "suspend\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
> @@ -848,7 +848,7 @@ static int vt8623_pci_resume(struct pci_
>  	struct fb_info *info = pci_get_drvdata(dev);
>  	struct vt8623fb_info *par = info->par;
>  
> -	dev_info(info->dev, "resume\n");
> +	dev_info(info->device, "resume\n");
>  
>  	acquire_console_sem();
>  	mutex_lock(&(par->open_lock));
>
>
>
>
>   
