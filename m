From: Harald Welte <HaraldWelte@viatech.com>
Subject: Re: [PATCH 1/3] viafb: Fix various
	resource	leaks during module_init()
Date: Tue, 19 May 2009 17:21:30 +0800
Message-ID: <20090519092130.GL19746@prithivi.gnumonks.org>
References: <20090519035105.GX19746@prithivi.gnumonks.org>
	<20090519100043.4785c0c0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1M6LeZ-0008Dd-6K
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 09:30:31 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6LeK-0004Ha-LN
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 09:30:31 +0000
Content-Disposition: inline
In-Reply-To: <20090519100043.4785c0c0.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

Hi Krysztof,

thanks for your feedback.

On Tue, May 19, 2009 at 10:00:43AM +0200, Krzysztof Helt wrote:

> I strongly recommend not to duplicate standard fields: fb_info.fix.smem_base and 
> fb_info.fix.smem_len  (and fb_info.screen_base and fb_info.screen_size).

of course.  I have just started to dig into viafb, and there is a long list of
issues that I'd like to improve over time. getting rid of a lot of global
variables, duplicated fields, bringing it more in line with the kernel
infrastructure as well as improving the overall code structure...

> I would like to see conversion:
> viainfo->fbmem => viaifbnfo->screen_base (physical address)
> ? => viafbinfo->screen_size (physical size)
> viaparinfo->fbmem_virt => viafbinfo->fix.smem_start (virtual address)
> viaparinfo->memsize => viafbinfo->fix.smem_len (virtual size)
>
> You may try dropping the global viaparinfo pointer as well (and just get it
> as viafbinfo->par if needed).
> 
> These changes should be sent as a separate patch.

yes, I will do this as a cleanup patch on top of my current work.

> >  	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
> > @@ -2279,7 +2282,7 @@ static int __devinit via_pci_probe(void)
> >  			printk(KERN_ERR
> >  			"allocate the second framebuffer struct error\n");
> >  			framebuffer_release(viafbinfo);
> > -			return -ENOMEM;
> > +			goto out_delete_i2c;
> >  		}
> 
> The framebuffer_release(viafbinfo) will be called twice now.

good catch, fixed in my tree now.

> > +
> > +out_fb_unreg:
> > +	unregister_framebuffer(viafbinfo);
> > +out_fb1_unreg_lcd_cle266:
> > +	if (viafbinfo1 && (viafb_primary_dev == LCD_Device)
> > +            && (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266))
> > +		unregister_framebuffer(viafbinfo1);
> 
> The condition here differs from the condition used during viafbinfo1 register
> (viafb_dual_fb vs. viafbinfo1).

thanks.  This was actually intentional, since it only makes sense to unregister
viafbinfo1 if it actually exists.  But in any case, it doesn't make a practical
difference, so I have altered it to check for viafb_dual_info

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
