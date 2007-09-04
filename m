From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] radeonfb: add PCI Id
	for	RS482/Radeon Xpress 200M
Date: Tue, 04 Sep 2007 15:45:12 +0200
Message-ID: <1188913512.5972.147.camel@localhost.localdomain>
References: <20070904105831.GE7320@devil>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITG7P-00083g-Nj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:05:55 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19jrOmEm54HJzoptjiQ9uR7jUtTsf7th7g=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ITG7O-0001IC-6V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:05:55 -0700
In-Reply-To: <20070904105831.GE7320@devil>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Tue, 2007-09-04 at 12:58 +0200, aherrman@arcor.de wrote:
> .. which can be found in Acer Aspire 5100.
> 
> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/video/aty/ati_ids.h     |    1 +
>  drivers/video/aty/radeon_base.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/aty/ati_ids.h b/drivers/video/aty/ati_ids.h
> index 685a754..648da1e 100644
> --- a/drivers/video/aty/ati_ids.h
> +++ b/drivers/video/aty/ati_ids.h
> @@ -211,3 +211,4 @@
>  #define PCI_CHIP_RS350_7834             0x7834
>  #define PCI_CHIP_RS350_7835             0x7835
>  #define PCI_CHIP_RS480_5955             0x5955
> +#define PCI_CHIP_RS482_5975             0x5975
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index 47ca62f..90a3957 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -102,6 +102,7 @@
>  static struct pci_device_id radeonfb_pci_table[] = {
>          /* Radeon Xpress 200m */
>  	CHIP_DEF(PCI_CHIP_RS480_5955,   RS480,  CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
> +	CHIP_DEF(PCI_CHIP_RS482_5975,   RS480,  CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
>  	/* Mobility M6 */
>  	CHIP_DEF(PCI_CHIP_RADEON_LY, 	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
>  	CHIP_DEF(PCI_CHIP_RADEON_LZ,	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
