From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] acornfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:05:11 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915220511.F10328@flint.arm.linux.org.uk>
References: <20030915193450.GC16370@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0XQ-0002Mq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:05:36 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19z0XP-0001aj-SM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:05:36 -0700
Content-Disposition: inline
In-Reply-To: <20030915193450.GC16370@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Mon, Sep 15, 2003 at 09:34:50PM +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Mon, Sep 15, 2003 at 09:34:50PM +0200, Kronos wrote:
> Hi,
> this patch convert driver/video/acorn.c to framebuffer_alloc:

This is buggy in places - it looks like you used 'sed' to make many
of these changes, and missed ones which crop up twice on one line.

> @@ -448,7 +448,7 @@
>  	 * 1MB VRAM	32bit
>  	 * 2MB VRAM	64bit
>  	 */
> -	if (current_par.using_vram && current_par.vram_half_sam == 2048) {
> +	if (current_par->using_vram && current_par.vram_half_sam == 2048) {
>  		dat_ctl |= VIDC20_DCTL_BUS_D63_0;
>  	} else 
>  		dat_ctl |= VIDC20_DCTL_BUS_D31_0;
> ...
> Luca
> -- 
> Reply-To: kronos@kronoz.cjb.net
> Home: http://kronoz.cjb.net
> This message will self distruct in 5 seconds.

Your timer appears to be malfunctioning.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
