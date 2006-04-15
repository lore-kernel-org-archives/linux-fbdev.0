From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb section mismatches
Date: Sun, 16 Apr 2006 06:27:02 +1000
Message-ID: <1145132822.4233.0.camel@localhost.localdomain>
References: <20060414212530.0140b70f.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUrOC-00053s-Kc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Apr 2006 13:29:04 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FUrOC-0007Nw-7F
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 Apr 2006 13:29:04 -0700
In-Reply-To: <20060414212530.0140b70f.rdunlap@xenotime.net>
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
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, akpm <akpm@osdl.org>

On Fri, 2006-04-14 at 21:25 -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Marking radeon_pci_register() as __devinit clears up all section
> mismatch warnings that are caused by radeon_pci_register() calling
> various __devinit function.  Is there some reason not to do this?

Looks ok to me

> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/video/aty/radeon_base.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2617-rc1g8.orig/drivers/video/aty/radeon_base.c
> +++ linux-2617-rc1g8/drivers/video/aty/radeon_base.c
> @@ -2265,7 +2265,7 @@ static struct bin_attribute edid2_attr =
>  };
>  
> 
> -static int radeonfb_pci_register (struct pci_dev *pdev,
> +static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
>  				  const struct pci_device_id *ent)
>  {
>  	struct fb_info *info;
> 
> 
> ---



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
