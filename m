From: Kronos <kronos@people.it>
Subject: Re: [PATCH] radeonfb: fix init/exit section usage
Date: Fri, 7 Jan 2005 22:54:51 +0100
Message-ID: <20050107215451.GA16507@dreamland.darkstar.lan>
References: <41DEE2C7.4030200@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cn24C-0002he-7u
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 13:54:44 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cn24A-0002IT-9s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 13:54:43 -0800
Content-Disposition: inline
In-Reply-To: <41DEE2C7.4030200@osdl.org>
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
Content-Transfer-Encoding: 7bit
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, benh@dreamland.darkstar.lan

Il Fri, Jan 07, 2005 at 11:28:07AM -0800, Randy.Dunlap ha scritto: 
> 
> Fix 3 instances of calling exit section function from text or init:
> Error: ./drivers/video/aty/radeon_base.o .text refers to 000029e5 
> R_386_PC32        .exit.text
> Error: ./drivers/video/aty/radeon_base.o .text refers to 00002a60 
> R_386_PC32        .exit.text
> Error: ./drivers/video/aty/radeon_base.o .init.text refers to 00000192 
> R_386_PC32        .exit.text
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> 
> diffstat:=
>  drivers/video/aty/radeon_base.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> ---

> 
> diff -Naurp ./drivers/video/aty/radeon_base.c~radeonfb_initexit ./drivers/video/aty/radeon_base.c
> --- ./drivers/video/aty/radeon_base.c~radeonfb_initexit	2005-01-06 21:18:20.920585008 -0800
> +++ ./drivers/video/aty/radeon_base.c	2005-01-07 10:30:16.661094480 -0800
> @@ -261,7 +261,7 @@ static struct backlight_controller radeo
>  
>  #endif /* CONFIG_PPC_OF */
>  
> -static void __devexit radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
> +static void radeon_unmap_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
>  {
>  	if (!rinfo->bios_seg)
>  		return;

I see that radeon_unmap_ROM is called in radeonfb_pci_register (error
path). Is this the problem?

Oh btw, the maintainer of the new radeonfb is Ben Herrenschmidt, not Ani
Joshi.

Luca
-- 
Home: http://kronoz.cjb.net
Carpe diem, quam minimum credula postero. (Q. Horatius Flaccus)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
