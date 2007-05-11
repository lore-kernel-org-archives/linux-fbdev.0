From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] smart blitter usage for
	scrolling	(cleaned)
Date: Sat, 12 May 2007 03:41:56 +0800
Message-ID: <1178912517.5017.3.camel@daplas>
References: <4644106cacb67@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hmb0F-0006NU-Gj for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 May 2007 12:42:11 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hmb0C-0008Mx-T1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 May 2007 12:42:11 -0700
Received: by py-out-1112.google.com with SMTP id a29so896631pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 11 May 2007 12:42:08 -0700 (PDT)
In-Reply-To: <4644106cacb67@wp.pl>
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

On Fri, 2007-05-11 at 08:42 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch replaces the current SCROLL_MOVE method with smarter
> method using the same logic as the SCROLL_REDRAW method. This
> brings these two methods much closer in performance and benefits
> all framebuffers which uses the SCROLL_MOVE method.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This version does not merge blits and does not uses ifdefs. The
> patch was diffed against linux-2.6.21-git11
> 
> Regards,
> Krzysztof
> 
> diff -urp linux-2.6.21.orig/drivers/video/console/fbcon.c
> linux-2.6.21/drivers/video/console/fbcon.c
> --- linux-2.6.21.orig/drivers/video/console/fbcon.c	2007-05-09
> 16:56:07.936744076 +0200
> +++ linux-2.6.21/drivers/video/console/fbcon.c	2007-05-10
> 21:00:22.685633709 +0200
> @@ -1704,6 +1704,61 @@ static void fbcon_redraw_move(struct vc_
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
> +
> +		do {
> +			c = scr_readw(s);

#####
> +			if (attr != (c & 0xff00)) {
> +				attr = c & 0xff00;
> +				if (s > start) {
> +					ops->bmove(vc, info, line + ycount, x, line, x, 1, s-start);
> +					x += s - start;
> +					start = s;
> +				}
> +			}
#####

The code block above is probably not needed. It just checks if the
attribute of the character (ie the color) has changed.  This is required
for putcs, but is unnecessary for bmove.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
