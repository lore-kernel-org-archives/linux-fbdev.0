From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] pm_message_t corrections still missing from 2.6.12-rc2
Date: Fri, 8 Apr 2005 14:31:44 +0200
Message-ID: <20050408123144.GB1379@elf.ucw.cz>
References: <1112961860.3757.755.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1112961860.3757.755.camel@desktop.cunningham.myip.net.au>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, FrameBuffer Devel <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> Here, for your consideration, are fixups I still have in my tree after
> updating to rc2.
> 
> (USB & Framebuffer lists copied because a reasonable number apply
> there).
> 
> Regards,
> 
> Nigel
> 
> diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c
> --- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c	2004-12-10 14:26:51.000000000 +1100
> +++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c	2005-04-08 13:41:41.000000000 +1000
> @@ -41,7 +41,7 @@ void dpm_resume(void)
>  		list_add_tail(entry, &dpm_active);
>  
>  		up(&dpm_list_sem);
> -		if (!dev->power.prev_state)
> +		if (!dev->power.prev_state.event)
>  			resume_device(dev);
>  		down(&dpm_list_sem);
>  		put_device(dev);

We do not want these to go anywhere for now. These depend on switching
pm_message_t to struct, and that's 2.6.13 material.

Except that, there are some good fixes (u32->pm_message_t), but they
should be in -mm kernel already.

...except USB. I'm talking with David Brownell about those.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
