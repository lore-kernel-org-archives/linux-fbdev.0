From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] atyfb: Fix HP OmniBook 500 reboot
	hang
Date: Tue, 26 May 2009 13:49:18 -0700
Message-ID: <20090526134918.096d49c4.akpm@linux-foundation.org>
References: <1243292714-21193-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M93aP-0004mE-VU
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 20:49:25 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M93aO-00080Q-Rm
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 20:49:25 +0000
In-Reply-To: <1243292714-21193-1-git-send-email-syrjala@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: syrjala@sci.fi, linux-fbdev-devel@lists.sourceforge.net

On Tue, 26 May 2009 02:05:14 +0300
Ville Syrjala <syrjala@sci.fi> wrote:

> Apparently HP OmniBook 500's BIOS doesn't like the way atyfb reprograms
> the hardware. The BIOS will simply hang after a reboot. Fix the problem
> by restoring the hardware to it's original state on reboot.
> 
>
> ...
>
> @@ -3502,6 +3503,11 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
>  	par->mmap_map[1].prot_flag = _PAGE_E;
>  #endif /* __sparc__ */
>  
> +	mutex_lock(&reboot_lock);
> +	if (!reboot_info)
> +		reboot_info = info;
> +	mutex_unlock(&reboot_lock);

This looks risky to me.  We save away a pointer to a structure which
was created by framebuffer_alloc().  What guarantee is there that this
memory is still valid when the reboot happens later on?


>  	return 0;
>  
>  err_release_io:
> @@ -3613,9 +3619,14 @@ static void __devexit atyfb_remove(struct fb_info *info)
>  {
>  	struct atyfb_par *par = (struct atyfb_par *) info->par;
>  
> +	mutex_lock(&reboot_lock);
> +	if (reboot_info == info)
> +		reboot_info = NULL;
> +	mutex_unlock(&reboot_lock);
> +
>  	/* restore video mode */
> -	aty_set_crtc(par, &saved_crtc);
> -	par->pll_ops->set_pll(info, &saved_pll);
> +	aty_set_crtc(par, &par->saved_crtc);
> +	par->pll_ops->set_pll(info, &par->saved_pll);
>  
>  	unregister_framebuffer(info);
>  
> @@ -3808,6 +3819,39 @@ static int __init atyfb_setup(char *options)
>  }
>  #endif  /*  MODULE  */
>  
> +static int atyfb_reboot_notify(struct notifier_block *nb,
> +			       unsigned long code, void *unused)
> +{
> +	struct atyfb_par *par;
> +
> +	if (code != SYS_RESTART)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&reboot_lock);
> +
> +	if (!reboot_info)
> +		goto out;
> +
> +	par = reboot_info->par;
> +
> +	/*
> +	 * HP OmniBook 500's BIOS doesn't like the state of the
> +	 * hardware after atyfb has been used. Restore the hardware
> +	 * to the original state to allow succesful reboots.

"successful" ;)

> +	 */
> +	aty_set_crtc(par, &par->saved_crtc);
> +	par->pll_ops->set_pll(reboot_info, &par->saved_pll);
> +
> + out:
> +	mutex_unlock(&reboot_lock);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block atyfb_reboot_notifier = {
> +	.notifier_call = atyfb_reboot_notify,
> +};
> +
>  static int __init atyfb_init(void)
>  {
>      int err1 = 1, err2 = 1;
> @@ -3826,11 +3870,18 @@ static int __init atyfb_init(void)
>      err2 = atyfb_atari_probe();
>  #endif
>  
> -    return (err1 && err2) ? -ENODEV : 0;
> +    if (err1 && err2)
> +	return -ENODEV;
> +
> +    register_reboot_notifier(&atyfb_reboot_notifier);
> +
> +    return 0;
>  }

ick.  Please feel free to repair the indenting in atyfb_init().

>  static void __exit atyfb_exit(void)
>  {
> +	unregister_reboot_notifier(&atyfb_reboot_notifier);
> +
>  #ifdef CONFIG_PCI
>  	pci_unregister_driver(&atyfb_driver);
>  #endif

So we do the restoration for all supported devices on all machines,
even though it's only known to be needed on one card on one machine.

Hopefully that's safe, but a more cautious approach would use a
whitelist of some form.  I don't have enough experience with these
things to be able to judge the risk.

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
