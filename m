From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: If no video memory, exit with error [repost]
Date: Wed, 27 Oct 2004 09:50:55 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1098834655.6916.66.camel@gaston>
References: <200410261603.24434.bjorn.helgaas@hp.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMb95-0004Hp-S0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 16:54:31 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CMb94-0006vK-CC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 16:54:31 -0700
In-Reply-To: <200410261603.24434.bjorn.helgaas@hp.com>
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
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Andrew, looks ok.

On Tue, 2004-10-26 at 16:03 -0600, Bjorn Helgaas wrote:
> Posted this last week (10/21) but haven't seen any response.
> Would you consider this for the next -mm?  Also attached in
> case kmail mangles the whitespace.
> 
> 
> [PATCH] radeonfb: If no video memory, exit with error
> 
> Nothing good will happen if we try to ioremap and use a zero-sized
> frame buffer.  I observed this problem on an ia64 sx1000 box, where
> the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
> just gets hopelessly confused because the card isn't initialized
> correctly.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
> --- 1.32/drivers/video/aty/radeon_base.c 2004-10-19 03:40:34 -06:00
> +++ edited/drivers/video/aty/radeon_base.c 2004-10-21 11:50:51 -06:00
> @@ -2186,7 +2186,9 @@
>            rinfo->video_ram = 8192 * 1024;
>            break;
>           default:
> -          break;
> +   printk (KERN_ERR "radeonfb: no video RAM reported\n");
> +   ret = -ENXIO;
> +   goto err_unmap_rom;
>    }
>   }
>  
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
