From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Logo crash
Date: Sun, 5 Jan 2003 20:39:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301052039040.24903-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301051744260.10559-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0301051744260.10559-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>


> The local variable palette_cmap.transp is not initialized, so it can contain
> garbage, causing a crash during logo drawing.
> 
> --- linux-2.5.54/drivers/video/fbmem.c	Thu Jan  2 12:54:58 2003
> +++ linux-m68k-2.5.54/drivers/video/fbmem.c	Sun Jan  5 17:22:57 2003
> @@ -386,6 +386,7 @@
>  	palette_cmap.red = palette_red;
>  	palette_cmap.green = palette_green;
>  	palette_cmap.blue = palette_blue;
> +	palette_cmap.transp = 0;
>  
>  	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
>  		n = LINUX_LOGO_COLORS - i;

Applied.
