From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 6/13] viafb: hw.c, hw.h
Date: Mon, 30 Jun 2008 09:32:38 +0200
Message-ID: <48688C16.5040405@gmail.com>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E77AC@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDDty-0006bJ-HP for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 00:34:18 -0700
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDDtw-0005OD-Mb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 00:34:18 -0700
Received: by ug-out-1314.google.com with SMTP id o29so193361ugd.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Jun 2008 00:34:15 -0700 (PDT)
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E77AC@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 06/30/2008 09:04 AM, JosephChan@via.com.tw wrote:
> Display hw setting and other chips initialization.
> 
> 
> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> diff -Nur a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> --- a/drivers/video/via/hw.c	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/hw.c	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,2865 @@
[...]
> +#include "global.h"
> +
> +static const struct pci_device_id_info pciidlist[] = {
> +	{PCI_VIA_VENDOR_ID, UNICHROME_CLE266_DID, UNICHROME_CLE266},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_PM800_DID, UNICHROME_PM800},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_K400_DID, UNICHROME_K400},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_K800_DID, UNICHROME_K800},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_CN700_DID, UNICHROME_CN700},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_P4M890_DID, UNICHROME_P4M890},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_K8M890_DID, UNICHROME_K8M890},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_CX700_DID, UNICHROME_CX700},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_P4M900_DID, UNICHROME_P4M900},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_CN750_DID, UNICHROME_CN750},
> +	{PCI_VIA_VENDOR_ID, UNICHROME_VX800_DID, UNICHROME_VX800},
> +	{0, 0, 0}
> +};

Why do you need yet another pci_device_id? How do you insure autoloading?

> +
> +struct offset offset_reg = {
> +	/* IGA1 Offset Register */
> +	{IGA1_OFFSET_REG_NUM, {{CR13, 0, 7}, {CR35, 5, 7} } },
> +	/* IGA2 Offset Register */
> +	{IGA2_OFFSET_REG_NUM, {{CR66, 0, 7}, {CR67, 0, 1} } }
> +};
> +
> +struct pll_map pll_value[] = {

May this be static const (and all of these)?

> +	{CLK_25_175M, CLE266_PLL_25_175M, K800_PLL_25_175M, CX700_25_175M},

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
