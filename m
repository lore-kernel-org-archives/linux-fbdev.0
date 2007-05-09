From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] smart blitter usage for scrolling
Date: Wed, 09 May 2007 22:19:18 +0800
Message-ID: <1178720358.4861.27.camel@daplas>
References: <464172cc491d5@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hln0s-0007zN-Ch for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 07:19:30 -0700
Received: from wx-out-0506.google.com ([66.249.82.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hln0r-0004rY-PC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 07:19:30 -0700
Received: by wx-out-0506.google.com with SMTP id i30so335430wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 09 May 2007 07:19:29 -0700 (PDT)
In-Reply-To: <464172cc491d5@wp.pl>
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

On Wed, 2007-05-09 at 09:05 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds option to uses blitter only to move characters
> which have to be moved instead of current brute force approach
> (move whole screen).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This patch uses the same logic as the fbcon_redraw() but uses
> bmove() instead of putcs(). On my system (dual P3 866MHz and
> Permedia 2 with 83MHz clock) this gives the SCROLL_MOVE up to 5%
> slower than non accelerated SCROLL_REDRAW. Previously, the
> SCROLL_MOVE was few times (up to 10) slower. I tested it with
> "time dmesg" at 1024x768 and 1600x1200 resolutions.

This sounds quite logical to me.  However, I would rather that you
create a new scrolling mode (ie SCROLL_MOVE_REDRAW and
SCROLL_WRAP_REDRAW). Then create a new FBINFO_HWACCEL flag that will
enable SCROLL_PAN/WRAP_MOVE_REDRAW and perhaps another one that will
enable MERGE_BLIT.

To illustrate, see further comments below.


> 
> I think that this new approach can completely replace the brute
> force SCROLL_MOVE method used currently. It should help all
> drivers which uses SCROLL_MOVE method (probably not many), reduce
> difference between SCROLL_REDRAW and SCROLL_MOVE and do nothing
> to drivers useng SCROLL_REDRAW method.
> 
> There is additional possibility to improve performance by
> enabling MERGE_BLIT definition. In this case, the first matching
> character to scroll (in source and destination location) is
> ignored. This produces about half of blits requests (in my test
> case - around 100 instead of around 200) but blits are larger
> (each one is one character larger). This may help on cards where
> the blitter is fast but slow to start (any known card?). If it is
> not a case it can be dropped completely (to simplify the code).
> In my case it has not produced any speed improvement (and even
> slower scrolling by 1-2%).
> 
> This patch is indented for your review and tests on different
> hardware. I will also test it on hardware I have (I can borrow
> slower machine and I have few other GFX cards to tests).
> 
> Kind regards,
> Krzysztof
> 
> diff -urp linux-2.6.21/drivers/video/Kconfig
> linux-2.6.21.mod/drivers/video/Kconfig
> --- linux-2.6.21/drivers/video/Kconfig	2007-05-08
> 23:38:34.055228990 +0200
> +++ linux-2.6.21.mod/drivers/video/Kconfig	2007-05-09
> 00:13:34.910949935 +0200
> @@ -139,6 +139,23 @@ config FB_TILEBLITTING
>  	 This is particularly important to one driver, matroxfb.  If
>  	 unsure, say N.
>  
> +config FB_SMALL_BLITS
> +       bool "Enable Enhanced Blitting Support (EXPERIMENTAL)"
> +       depends on FB && EXPERIMENTAL
> +       default n
> +       ---help---
> +         This enables smart usage of blitter to sroll screen. A
> standard
> +	 way is to use blitter to move almost whole screen. The enhanced
> +	 blitting moves only characters which have to be moved. The same
> +	 logic is used for redrawing characters during scroll if the
> +	 blitting is not used to scroll.
> +	 It may or may not speed up scrolling of your framebuffer. It
> +	 depends on relative speed of your CPU and GPU. If you have
> +	 fast CPU and slow GPU this option may slow down scrolling.
> +	 If the opposite is true this may speed up scrolling for you.
> +
> +	 If unsure, say N.
> +
>  comment "Frame buffer hardware drivers"
>  	depends on FB
>  
> diff -urp linux-2.6.21/drivers/video/console/fbcon.c
> linux-2.6.21.mod/drivers/video/console/fbcon.c
> --- linux-2.6.21/drivers/video/console/fbcon.c	2007-04-26
> 05:08:32.000000000 +0200
> +++ linux-2.6.21.mod/drivers/video/console/fbcon.c	2007-05-09
> 00:15:37.501935997 +0200
> @@ -1663,6 +1663,81 @@ static void fbcon_redraw_move(struct vc_
>  	}
>  }
>  
> +static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info
> *info,
> +			struct display *p, int line, int count, int ycount)
> +{
> +	int offset = ycount * vc->vc_cols;
> +	unsigned short *d = (unsigned short *)
> +	    (vc->vc_origin + vc->vc_size_row * line);
> +	unsigned short *s = d + offset;
> +	struct fbcon_ops *ops = info->fbcon_par;
> +
> +	while (count--) {
> +		unsigned short *start = s;
> +		unsigned short *le = advance_row(s, 1);
> +		unsigned short c;
> +		int x = 0;
> +		unsigned short attr = 1;
> +#ifdef MERGE_BLITS
> +		int was_blit = 1;
> +#endif
> +
> +		do {
> +			c = scr_readw(s);
> +			if (attr != (c & 0xff00)) {
> +				attr = c & 0xff00;
> +				if (s > start) {
> +					ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
> +#ifdef MERGE_BLITS
> +					was_blit = 1;
> +#endif

You can remove those #ifdef's (they're ugly anyway if used within a
function).

So something like:

if (info->flags & FBINFO_HWACCEL_MERGEBLIT)
	was_blit = 1;
> +					x += s - start;
> +					start = s;
> +				}
> +			}
> +			if (c == scr_readw(d)) {
> +				if (s > start) {
> +#ifdef MERGE_BLITS
> +					if (!was_blit) {
> +#endif

and,

if (info->flags & FBINFO_HWACCEL_MERGEBLIT || !was_blit) 

or something to that effect.


> +						ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
> +						x += s - start + 1;
> +						start = s + 1;
> +#ifdef MERGE_BLITS
> +					}
> +					was_blit = !was_blit;
> +#endif
> +				} else {
> +#ifdef MERGE_BLITS
> +					if (was_blit) {
> +#endif
> +						x++;
> +						start++;
> +#ifdef MERGE_BLITS
> +					}
> +#endif
> +				}
> +			}
> +			scr_writew(c, d);
> +			console_conditional_schedule();
> +			s++;
> +			d++;
> +		} while (s < le);
> +		if (s > start) {
> +			ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
> +		}
> +		console_conditional_schedule();
> +		if (ycount > 0)
> +			line++;
> +		else {
> +			line--;
> +			/* NOTE: We subtract two lines from these pointers */
> +			s -= vc->vc_size_row;
> +			d -= vc->vc_size_row;
> +		}
> +	}
> +}
> +
>  static void fbcon_redraw(struct vc_data *vc, struct display *p,
>  			 int line, int count, int offset)
>  {
> @@ -1748,7 +1823,9 @@ static int fbcon_scroll(struct vc_data *
>  {
>  	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
>  	struct display *p = &fb_display[vc->vc_num];
> +#ifndef CONFIG_FB_SMALL_BLITS
>  	struct fbcon_ops *ops = info->fbcon_par;
> +#endif
>  	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
>  
>  	if (fbcon_is_inactive(vc, info))
> @@ -1772,10 +1849,22 @@ static int fbcon_scroll(struct vc_data *
>  			goto redraw_up;
>  		switch (p->scrollmode) {
>  		case SCROLL_MOVE:
> +#ifndef CONFIG_FB_SMALL_BLITS
>  			ops->bmove(vc, info, t + count, 0, t, 0,
>  				    b - t - count, vc->vc_cols);
>  			ops->clear(vc, info, b - count, 0, count,
>  				  vc->vc_cols);
> +#else

Again, you can remove the #ifdef and just do:
	
		case SCROLL_MOVE_REDRAW:	
> +			fbcon_redraw_blit(vc, info, p, t, b - t - count,
> +				     count);
> +			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
> +			scr_memsetw((unsigned short *) (vc->vc_origin +
> +							vc->vc_size_row *
> +							(b - count)),
> +				    vc->vc_video_erase_char,
> +				    vc->vc_size_row * count);
> +			return 1;
> +#endif
>  			break;
>  
>  		case SCROLL_WRAP_MOVE:
> @@ -1858,9 +1947,21 @@ static int fbcon_scroll(struct vc_data *
>  			goto redraw_down;
>  		switch (p->scrollmode) {
>  		case SCROLL_MOVE:
> +#ifndef CONFIG_FB_SMALL_BLITS
>  			ops->bmove(vc, info, t, 0, t + count, 0,
>  				    b - t - count, vc->vc_cols);
>  			ops->clear(vc, info, t, 0, count, vc->vc_cols);
> +#else

Same here.

> +			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
> +				     -count);
> +			fbcon_clear(vc, t, 0, count, vc->vc_cols);
> +			scr_memsetw((unsigned short *) (vc->vc_origin +
> +							vc->vc_size_row *
> +							t),
> +				    vc->vc_video_erase_char,
> +				    vc->vc_size_row * count);
> +			return 1;
> +#endif
>  			break;
>  
>  		case SCROLL_WRAP_MOVE:

And all those selection magic  you can do in update_scrollmode().

Hopefully, you get what I'm trying to illustrate. Choose the most
effective method you want (not necessarily my example), but let's
eliminate the ugly #ifdefs and make this a new scrolling mode selectable
by the driver by setting certain bits in info->flags. 

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
