From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Advice sought on approach.
Date: Wed, 5 Mar 2003 15:44:12 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051543290.23176-100000@vervain.sonytel.be>
References: <1046875200.10894.216.camel@cambridge.braddahead>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qa8w-0007Xt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:45:19 -0800
In-Reply-To: <1046875200.10894.216.camel@cambridge.braddahead>
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
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 5 Mar 2003, Alex Bennee wrote:
> On Wed, 2003-03-05 at 13:26, Antonino Daplas wrote:
> > On Wed, 2003-03-05 at 20:37, Alex Bennee wrote:
> > > Having read the fb-dev docs on www.linux-fbdev.org I'm a little confused
> > > as to what actually puts data into the framebuffer. Most of the
> > > framebuffer drivers just seem to deal with resolution and colourmap
> > > settings. Is this a case of having to re-implement the fbcon drivers as
> > > well to get what I want?
> > The pixels placed to the framebuffer are all done in the fbcon-cfb*.c
> > modules (if you use the generic functions).  This is for standard
> > character drawing.  The logo is drawn indepently (fbcon_show_logo in
> > fbcon.c).  User applications write directly to the framebuffer via the
> > mmap() function.
> 
> I think I understand now. When the fb_set_disp function is called I fill
> in the display struction with the console display operations. I've got
> two choices now:
> 
> 1. Create a new fbcon_cfb16 file which notes the changed areas before
> calling the generic function.
> 
> 2. Patch the current fbcon_cfb16 (with a CONFIG option) to add the
> change tracking facility in a more generic way.
> 
> I guess the question is is it worth doing 2 as a potential upstream
> patch? Or is this sort of thing so specialised I should just keep it all
> packed in my own fb driver?
> 
> I guess I can't easily implement user access via mmap without uploading
> the entire screen, which I'm not intending to do anyway because all I
> really need is the console support - at least for now.

If all you need is console support, please take a look at
drivers/video/newport_con.c, for the SGI Indy.

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
