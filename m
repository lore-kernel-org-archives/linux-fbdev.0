From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] radeonfb: use PCI device Id in
	hex for name string
Date: Tue, 04 Sep 2007 15:48:07 +0200
Message-ID: <1188913688.5972.155.camel@localhost.localdomain>
References: <20070904110050.GH7320@devil>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITG7j-00089I-Ap for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:06:15 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX190MCqFCtIABEmpeX/zg/2YFCYjJo7AeCI=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ITG7i-0005lL-KQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:06:15 -0700
In-Reply-To: <20070904110050.GH7320@devil>
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
To: aherrman@arcor.de
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 2007-09-04 at 13:00 +0200, aherrman@arcor.de wrote:
> .. instead of potentially using nonprintable characters.
> 
> I guess the former (odd) concatenation was used to construct name strings
> that match the  "*_ATI_RADEON_??" macros in include/linux/pci_ids.h
> 
> The PCI Id in hex is much more convenient to use. E.g. it can easily be
> verified against "lspci -nn" output.
> 
> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>

Well... ATI used to have printable characters and those were commonly
used to identify the cards. I'm not sure we want to unilateraly switch
to hex here...

Ben.

> ---
>  drivers/video/aty/radeon_base.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index 71b0c17..e6229b4 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -2184,9 +2184,8 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
>  	rinfo->lvds_timer.function = radeon_lvds_timer_func;
>  	rinfo->lvds_timer.data = (unsigned long)rinfo;
>  
> -	strcpy(rinfo->name, "ATI Radeon XX ");
> -	rinfo->name[11] = ent->device >> 8;
> -	rinfo->name[12] = ent->device & 0xFF;
> +	snprintf(rinfo->name, sizeof(rinfo->name),
> +		 "ATI Radeon %x", ent->device & 0xffff);
>  	rinfo->family = ent->driver_data & CHIP_FAMILY_MASK;
>  	rinfo->chipset = pdev->device;
>  	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
