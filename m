From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 16:40:58 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051638000.23176-100000@vervain.sonytel.be>
References: <1046877920.1228.190.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qb1p-0002Mp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:41:58 -0800
In-Reply-To: <1046877920.1228.190.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 5 Mar 2003, Antonino Daplas wrote:
> On Wed, 2003-03-05 at 22:06, Thomas Winischhofer wrote:
> > > Yes, that's the Real Thing :-)  fbcon_resize has a "fuzzy mode" too --
> > > it won't do an fb_set_var() if the change in dimensions is only a
> > > fraction of a character's dimension.
> > 
> > Ack. Is 16 fuzzy enough, what do you think?
> 
> I think you should only accept modes where the difference is a fraction
> of a character width or height.  A difference more than that and
> clear_margins() will not work correctly.  

Indeed, accel_clear_margins() calculates the margins as

    unsigned int cw = vc->vc_font.width;
    unsigned int ch = vc->vc_font.height;
    unsigned int rw = info->var.xres % cw;
    unsigned int bh = info->var.yres % ch;

However, if it would use

    unsigned int rw = info->var.xres - (vc->vc_cols*cw);
    unsigned int bh = info->var.yres - (vc->vc_rows*ch);

it would work with higher differences, too. And it would be a bit faster
(multiply and subtract vs. modulo).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
