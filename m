From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: 2.5 fbdev & driver initial mode
Date: Thu, 9 Jan 2003 10:30:54 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301091029140.25052-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301090027200.4976-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WZ3q-0001tj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 01:33:14 -0800
In-Reply-To: <Pine.LNX.4.44.0301090027200.4976-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 9 Jan 2003, James Simmons wrote:
> > How is a driver supposed to set the default mode on init lately ?
> > 
> > Looking at rivafb, it fills info->var from fb_find_mode with the mode
> > option if any, but then does nothing with it (and does nothing if
> > no mode option is passed).
> > 
> > On radeonfb, I fill a var  with the default mode obtained
> > from EDID or the option if any. Then, I basically do
> > 
> > 	info->var = var;
> > 	var.activate = FB_ACTIVATE_NOW;
> > 	fb_set_var(&var, info);
> > 
> > before calling register_framebuffer.
> > 
> > What is the right way to do ?
> 
> Sorry about the confusion. The answer depends on the driver. For the 
> rivafb driver because it has a VGA core we have it NOT switch to a 
> graphics state. The reason is 
> 
> 
> 1) If we run a /dev/fb app was can save the hardware text mode state and
>     restore it on closing /dev/fb. You can see this in rivafb_open and
>    rivafb_release. 
> 
> 2) We can test loading it as a module as see debugging info while still
>    having a VGA text mode. Makes life a little easier. The other thing 
>    I like to do is run mdacon and just the fbdev driver by itself. I can 
>    then test the fbdev driver. When I get really brave I test fbcon.c and
>    can debug it.
> 
> Now for graphics hardware built in that has no hardware text mode. It is 
> better to set the video mode right away.

Note: on some platforms graphics chips with VGA cores are _not_ initialized to
VGA mode by the firmware. So great care should be taken when not explicitly
switching to graphics mode on those platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
