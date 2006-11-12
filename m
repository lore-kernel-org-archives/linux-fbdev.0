From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] nvidiafb: Fix nv10 device setup
Date: Sun, 12 Nov 2006 22:18:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611122217430.9472@pentafluge.infradead.org>
References: <20061110083002.178878df.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjNfG-0000by-6o for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 14:18:58 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GjNfF-0000Rf-RW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 14:18:58 -0800
In-Reply-To: <20061110083002.178878df.khali@linux-fr.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 10 Nov 2006, Jean Delvare wrote:

> This "&&" was obviously meant to be a "&".
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> drivers/video/nvidia/nv_setup.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-2.6.19-rc5.orig/drivers/video/nvidia/nv_setup.c	2006-09-21 21:23:53.000000000 +0200
> +++ linux-2.6.19-rc5/drivers/video/nvidia/nv_setup.c	2006-11-10 08:21:53.000000000 +0100
> @@ -262,7 +262,7 @@
> #endif
>
> 	dev = pci_find_slot(0, 1);
> -	if ((par->Chipset && 0xffff) == 0x01a0) {
> +	if ((par->Chipset & 0xffff) == 0x01a0) {
> 		int amt = 0;
>
> 		pci_read_config_dword(dev, 0x7c, &amt);
>
>
>

Acked-by: James Simmons <jsimmons@infradead.org>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
