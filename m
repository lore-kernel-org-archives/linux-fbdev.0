From: James Simmons <jsimmons@infradead.org>
Subject: Re: [patch 11/25] au11oofb: fix to remove
 flickering
Date: Fri, 17 Nov 2006 18:50:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611171850060.32200@pentafluge.infradead.org>
References: <200611020550.kA25oO72002321@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gl8n1-0001Co-LL for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:50:15 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gl8n1-00021C-32
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:50:15 -0800
In-Reply-To: <200611020550.kA25oO72002321@shell0.pdx.osdl.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, freddy@dusktilldawn.nl


Acked-by: James Simmons <jsimmons@infradead.org>

On Wed, 1 Nov 2006, akpm@osdl.org wrote:

> From: Freddy Spierenburg <freddy@dusktilldawn.nl>
> 
> Currently a lot of flickering is seen on the VGA and LCD port when one
> starts a DBAu1100 board, with 'CONFIG_PRINTK=3Dy'.
> 
> This patch removes the flickering and as a result all kernel messages come
> by in a nice steady fashion.
> 
> Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>
> Cc: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/au1100fb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/video/au1100fb.h~au1100fb-fix-to-remove-flickering drivers/video/au1100fb.h
> --- a/drivers/video/au1100fb.h~au1100fb-fix-to-remove-flickering
> +++ a/drivers/video/au1100fb.h
> @@ -274,7 +274,7 @@ static struct au1100fb_panel known_lcd_p
>  		.bpp = 16,
>  		.control_base =	0x0004886A |
>  			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
> -			LCD_CONTROL_BPP_16,
> +			LCD_CONTROL_BPP_16 | LCD_CONTROL_SBB_4,
>  		.clkcontrol_base = 0x00020000,
>  		.horztiming = 0x005aff1f,
>  		.verttiming = 0x16000e57,
> _
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
