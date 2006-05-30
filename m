From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [directfb-dev] printk on framebuffer console
Date: Tue, 30 May 2006 20:17:57 +0800
Message-ID: <447C37F5.8000008@gmail.com>
References: <447C03C6.3000805@singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fl3As-0007z9-LZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 05:18:14 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fl3As-0002OC-J3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 05:18:14 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fl3Ap-0001lr-PW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 05:18:14 -0700
Received: by py-out-1112.google.com with SMTP id b29so386140pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 05:18:06 -0700 (PDT)
In-Reply-To: <447C03C6.3000805@singnet.com.sg>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Terence Soh <gopher@singnet.com.sg>
Cc: directfb-dev@directfb.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Terence Soh wrote:
> Hi,
> 
> I'm seeking advise on getting printk displayed on the framebuffer console.

You're better off sending this to linux-fbdev-devel, so I'm adding
this to the CC list.

> 
> My display is RGB555 VGA resolution and I using the mainline kernel 
> font_8x8 for fonts and I've disabled the serial console and tile 
> blitting support. At the moment, the printk are printing black lines on 
> the screen instead of the printk statements.
> 
> In bitblit.c bit_putcs(),the image.depth = 1. Is this correct for my 
> application?
> 
> Also is font_8x8 suitable for 16 bit screens? It seems  like it's meant 
> for monochrome display.

Yes, the monochrome bitmap are expanded to the current foreground and
background colors of the console.

First, make sure that writing directly to the framebuffer memory displays
something properly on your monitor.

Then make sure that your driver has a working xxxfb_setcolreg function()
and that info->pseudo_palette is properly filled up.

Make sure also that info->var and info->fix are correctly set.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
