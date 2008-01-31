From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Thu, 31 Jan 2008 14:07:01 -0800
Message-ID: <20080131140701.b584430e.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKhZP-0002FF-2M for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 14:07:46 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JKhZL-0003YA-Su
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 14:07:41 -0800
In-Reply-To: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
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
To: Thomas Pfaff <tpfaff@pcs.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Mon, 28 Jan 2008 11:03:38 +0100 (CET)
Thomas Pfaff <tpfaff@pcs.com> wrote:

> Patch recreated for 2.6.24.
> 
> The current attr_fgcol_ec / attr_bgcol_ec macros do a simple shift of bits to 
> get the color from vc_video_erase_char. For a monochrome display however the 
> attribute does not contain any color, only attribute bits. Furthermore the 
> reverse bit is lost because it is shifted out, the resulting color is always 0.
> 
> This can bee seen on a monochrome console either directly or by setting it to 
> inverse mode via "setterm -inversescreen on" . Text is written with correct 
> color, fb_fillrects from a bit_clear / bit_clear_margins will get wrong colors.
> 

I'm struggling to understand the seriousness of this bug.  Do you think
this patch needs to be backported to 2.6.24.x?

> +#define mono_col(info)							\
> +	(~(0xfff << (max((info)->var.green.length,			\
> +			 max((info)->var.red.length,			\
> +			     (info)->var.blue.length)))) & 0xff) 

This macro is dangerous because it references its arg more than a single
time.  If someone does mono_col(*foo++) they will get a surprise.

So please follow the general rule here: do not implement in a macro that
which could have been implemented in a C function.

Plus C fundtions have better type checking and for some reason people are
more likely to document C functions.

> +static inline int attr_col_ec(int shift, struct vc_data *vc,
> +			      struct fb_info *info, int is_fg)
> +{
> +	int is_mono01;
> +	int col;
> +	int fg;
> +	int bg;
> +
> +	if (!vc)
> +		return 0;
> +
> +	if (vc->vc_can_do_color)
> +		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
> +			: attr_bgcol(shift,vc->vc_video_erase_char);
> +
> +	if (!info)
> +		return 0;
> +
> +	col = mono_col(info);
> +	is_mono01 = info->fix.visual == FB_VISUAL_MONO01;
> +
> +	if (attr_reverse(vc->vc_video_erase_char)) {
> +		fg = is_mono01 ? col : 0;
> +		bg = is_mono01 ? 0 : col;
> +	}
> +	else {
> +		fg = is_mono01 ? 0 : col;
> +		bg = is_mono01 ? col : 0;
> +	}
> +
> +	return is_fg ? fg : bg;
> +}

This function is vastly too large to be inlined.  Even mono_col() is too
large to be inlined.

Please implement both as regular C functions, then take a look at the
before and after output from size(1).

> +#define attr_bgcol_ec(bgshift,vc,info)		\
> +	attr_col_ec(bgshift,vc,info,0);
> +#define attr_fgcol_ec(fgshift,vc,info)		\
> +	attr_col_ec(fgshift,vc,info,1);
> +

Could be implemented as C functions.

I'll queue the pastch up for testing as-is, but would like a de-macroed,
de-inlined version please.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
