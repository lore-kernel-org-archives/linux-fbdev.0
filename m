From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 09/11] ps3fb: Round up video modes
Date: Sat, 26 Jan 2008 22:01:43 -0800
Message-ID: <20080126220143.16c8f821.akpm@linux-foundation.org>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.478948955@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ0aS-00005S-Uq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:49 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JJ0aS-0001oG-Kt
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:48 -0800
In-Reply-To: <20080125153107.478948955@vixen.sonytel.be>
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
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

> On Fri, 25 Jan 2008 16:06:32 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>  static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
>  			  const struct fb_var_screeninfo *var)
>  {
> -	/* resolution + black border must match a native resolution */
> -	if (vmode->left_margin + vmode->xres + vmode->right_margin !=
> -	    var->left_margin + var->xres + var->right_margin ||
> -	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=
> -	    var->upper_margin + var->yres + var->lower_margin)
> +	long xres, yres, left_margin, right_margin, upper_margin, lower_margin;
> +	long dx, dy;

I don't think these need to be longs?  And they probably don't need to be
signed either.

If a switch to u32 improves the code any, it might be worth doing..

All the typecasting which this patch adds makes me wonder if the choice
of types requires a general revisit...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
