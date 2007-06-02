From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/24] controlfb: The	pseudo_palette
	is only 16 elements long
Date: Sun, 03 Jun 2007 09:22:24 +1000
Message-ID: <1180826544.14025.13.camel@localhost.localdomain>
References: <46613ED7.80602@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HucvX-0002s0-GC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 16:22:31 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/V46O8O5eUvIJzgfKcINQnsjJqR71bugs=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HucvW-0007hx-0o
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 16:22:31 -0700
In-Reply-To: <46613ED7.80602@gmail.com>
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
Cc: Andrew Morton <akpm@osdl.org>

On Sat, 2007-06-02 at 17:56 +0800, Antonino A. Daplas wrote:
> The pseudo_palette is only 16 elements long.
> 
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  drivers/video/controlfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
> index 8b76273..b0be7ea 100644
> --- a/drivers/video/controlfb.c
> +++ b/drivers/video/controlfb.c
> @@ -94,7 +94,7 @@ static inline int VAR_MATCH(struct fb_va
>  struct fb_info_control {
>  	struct fb_info		info;
>  	struct fb_par_control	par;
> -	u32			pseudo_palette[17];
> +	u32			pseudo_palette[16];
>  		
>  	struct cmap_regs	__iomem *cmap_regs;
>  	unsigned long		cmap_regs_phys;
> 
> 
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
