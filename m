From: Thomas Pfaff <tpfaff@pcs.com>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Fri, 1 Feb 2008 12:58:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802011128210.5425@lxtpfaff.pcs.ditec.de>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKuY3-0007hF-PV for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 03:59:11 -0800
Received: from mail.pcs.de ([145.253.69.50] helo=mail.pcs.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKuXz-0004h4-GS
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 03:59:11 -0800
In-Reply-To: <20080131140701.b584430e.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Thu, 31 Jan 2008, Andrew Morton wrote:

> On Mon, 28 Jan 2008 11:03:38 +0100 (CET)
> Thomas Pfaff <tpfaff@pcs.com> wrote:
> 
> > Patch recreated for 2.6.24.
> > 
> > The current attr_fgcol_ec / attr_bgcol_ec macros do a simple shift of bits to 
> > get the color from vc_video_erase_char. For a monochrome display however the 
> > attribute does not contain any color, only attribute bits. Furthermore the 
> > reverse bit is lost because it is shifted out, the resulting color is always 0.
> > 
> > This can bee seen on a monochrome console either directly or by setting it to 
> > inverse mode via "setterm -inversescreen on" . Text is written with correct 
> > color, fb_fillrects from a bit_clear / bit_clear_margins will get wrong colors.
> > 
> 
> I'm struggling to understand the seriousness of this bug.  Do you think
> this patch needs to be backported to 2.6.24.x?

I think that only a few people would ever notice it and the bug is far too 
harmless to be in a bugfix release. 

> > +#define mono_col(info)							\
> > +	(~(0xfff << (max((info)->var.green.length,			\
> > +			 max((info)->var.red.length,			\
> > +			     (info)->var.blue.length)))) & 0xff) 
> 
> This macro is dangerous because it references its arg more than a single
> time.  If someone does mono_col(*foo++) they will get a surprise.
> 
> So please follow the general rule here: do not implement in a macro that
> which could have been implemented in a C function.
> 
> Plus C fundtions have better type checking and for some reason people are
> more likely to document C functions.
> 

I agree. This was a quick copy from the fbcon.c source.

> > +static inline int attr_col_ec(int shift, struct vc_data *vc,
> > +			      struct fb_info *info, int is_fg)
> > +{
> > +	int is_mono01;
> > +	int col;
> > +	int fg;
> > +	int bg;
> > +
> > +	if (!vc)
> > +		return 0;
> > +
> > +	if (vc->vc_can_do_color)
> > +		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
> > +			: attr_bgcol(shift,vc->vc_video_erase_char);
> > +
> > +	if (!info)
> > +		return 0;
> > +
> > +	col = mono_col(info);
> > +	is_mono01 = info->fix.visual == FB_VISUAL_MONO01;
> > +
> > +	if (attr_reverse(vc->vc_video_erase_char)) {
> > +		fg = is_mono01 ? col : 0;
> > +		bg = is_mono01 ? 0 : col;
> > +	}
> > +	else {
> > +		fg = is_mono01 ? 0 : col;
> > +		bg = is_mono01 ? col : 0;
> > +	}
> > +
> > +	return is_fg ? fg : bg;
> > +}
> 
> This function is vastly too large to be inlined.  Even mono_col() is too
> large to be inlined.
> 
> Please implement both as regular C functions, then take a look at the
> before and after output from size(1).
> 
> > +#define attr_bgcol_ec(bgshift,vc,info)		\
> > +	attr_col_ec(bgshift,vc,info,0);
> > +#define attr_fgcol_ec(fgshift,vc,info)		\
> > +	attr_col_ec(fgshift,vc,info,1);
> > +
> 
> Could be implemented as C functions.
> 
> I'll queue the pastch up for testing as-is, but would like a de-macroed,
> de-inlined version please.
> 
> 

If the functions should be deinlined someone should decide where to put them. 
Since they must be exported i would avoid to put them into fbcon.c, this would 
lead to cross dependencies.
I would suggest to put the prototype into <linux/fb.h> and the definition into 
fbcmap.c instead, but i am unsure whether they really belong there.

Regarding the checkpatch problem the errors are all coding style related. I have 
decided to keep the coding style that was used in the source file, i think the 
style should be consistent in a source file.

And i forgot a "quell-flowed-text" feature in pine that i did not need in older 
pine versions, therefore the patch was garbled. Sorry.

I will be on vacation next week, answers will take a while.

Greetings,
Thomas

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
