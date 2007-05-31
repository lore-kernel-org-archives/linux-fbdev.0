From: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 3/9] cfag12864bfb: Use sys_ instead
	of cfb_ framebuffer accessors
Date: Thu, 31 May 2007 15:10:51 +0200
Message-ID: <653402b90705310610n2d66717ap890605adeb0a2033@mail.gmail.com>
References: <4658D547.8020707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkQa-0001Jg-Cj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:56 -0700
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkQX-0005R6-HU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:56 -0700
Received: by nz-out-0506.google.com with SMTP id 18so316474nzp
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:52 -0700 (PDT)
In-Reply-To: <4658D547.8020707@gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Avuton Olrich <avuton@gmail.com>

On 5/27/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> From: Avuton Olrich <avuton@gmail.com>
>
> Because the framebuffer memory is allocated system RAM, use the sys_ drawing
> libraries. It also fixes the following compile error:
>
>   LD      .tmp_vmlinux1
> drivers/built-in.o:(.data+0x8b48): undefined reference to `cfb_fillrect'
> drivers/built-in.o:(.data+0x8b50): undefined reference to `cfb_copyarea'
> drivers/built-in.o:(.data+0x8b58): undefined reference to `cfb_imageblit'
>
> [adaplas]
> Use fb_sys_read/write for the same reasons as above.
>
> Signed-off-by: Avuton Olrich <avuton@gmail.com>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
>
>  drivers/auxdisplay/Kconfig        |    4 ++++
>  drivers/auxdisplay/cfag12864bfb.c |    8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 7c2ef5c..0e09376 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -72,6 +72,10 @@ config CFAG12864B
>  	depends on X86
>  	depends on FB
>  	depends on KS0108
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
>  	default n
>  	---help---
>  	  If you have a Crystalfontz 128x64 2-color LCD, cfag12864b Series,
> diff --git a/drivers/auxdisplay/cfag12864bfb.c
> b/drivers/auxdisplay/cfag12864bfb.c
> index 66fafbb..307c190 100644
> --- a/drivers/auxdisplay/cfag12864bfb.c
> +++ b/drivers/auxdisplay/cfag12864bfb.c
> @@ -73,9 +73,11 @@ static int cfag12864bfb_mmap(struct fb_i
>
>  static struct fb_ops cfag12864bfb_ops = {
>  	.owner = THIS_MODULE,
> -	.fb_fillrect = cfb_fillrect,
> -	.fb_copyarea = cfb_copyarea,
> -	.fb_imageblit = cfb_imageblit,
> +	.fb_read = fb_sys_read,
> +	.fb_write = fb_sys_write,
> +	.fb_fillrect = sys_fillrect,
> +	.fb_copyarea = sys_copyarea,
> +	.fb_imageblit = sys_imageblit,
>  	.fb_mmap = cfag12864bfb_mmap,
>  };
>
>
>

ACK, I will test it asap.

Thanks for the fix, I'm a bit outdated, as I'm taking exams this weeks.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
