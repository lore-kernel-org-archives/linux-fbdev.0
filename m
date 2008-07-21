From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Mon, 21 Jul 2008 12:11:59 +0100
Message-ID: <20080721111159.GA18909@flint.arm.linux.org.uk>
References: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
	<1216534233-26674-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKtJU-000322-Sq for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 04:12:20 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKtJT-0004yj-UR
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 04:12:20 -0700
Content-Disposition: inline
In-Reply-To: <1216534233-26674-2-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jul 20, 2008 at 02:10:29AM -0400, Jaya Kumar wrote:
>  	if (fbi->map_cpu) {
>  		/* prevent initial garbage on screen */
>  		memset(fbi->map_cpu, 0, fbi->map_size);
> -		fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
> +		fbi->fb.screen_base = (char __force __iomem *) fbi->map_cpu
> +					+ fbi->video_offset;

I'm not sure this has any benefits - the use of __force in drivers is
definitely frowned upon.

It's well known that FB doesn't sit well with all the MMIO sparse checking
so it's probably a good idea not to try and make it work.

> @@ -1357,6 +1379,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
>  		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
>  		if (smemlen > fbi->fb.fix.smem_len)
>  			fbi->fb.fix.smem_len = smemlen;
> +		if (inf->custom_xfer_div)
> +			fbi->fb.fix.smem_len /= inf->custom_xfer_div;

I don't understand this.  If you have a 640x480 display with 8 bits of
memory per pixel, then it's 307200 bytes no matter whether you're only
using the lower 4 bits and the upper 4 are unused.

If, on the other hand, the lower 4 bits contain one pixel and the upper
4 bits contain the other pixel, then you have a 4 bit per pixel
framebuffer, so 'bpp' should be 4.  In which case the original calculation
gives the correct answer.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
