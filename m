From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: no console switching
Date: Wed, 12 Nov 2003 13:40:41 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311121338430.885-100000@waterleaf.sonytel.be>
References: <3FB22436.6080605@inaccessnetworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJuJ6-0000vS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 04:41:12 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJuIl-0001qx-GH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Nov 2003 04:40:51 -0800
In-Reply-To: <3FB22436.6080605@inaccessnetworks.com>
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
To: Manousaridis Angelos <amanous@inaccessnetworks.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 12 Nov 2003, Manousaridis Angelos wrote:
> >>I don't have the actuall graphics device yet, so I have created an 
> >>initial version of the driver looking a lot like the vfb device.
> >>I set the dispsw variable of the display structure to fbcon_dummy.
> >>When I load the module I see this:
> >>
> >>fbcon_setup: No support for fontwidth 8
> >>fbcon_setup: type 0 (aux 0, depth 8) not supported
> > 
> > That's harmless, and caused by fbcon_dummy.
> > 
> >>Console: switching to colour frame buffer device 80x30
> >>fb0: Teralogic 751 frame buffer device
> >>
> >>The module count increases to 63 and I cannot unload the module.
> > 
> > Because the virtual console subsystem uses 63 virtual consoles by default, and
> > increases the module counter for each of them.
> 
> In the register_fremabuffer routine, this is called for the first 
> framebuffer that is registered:
> 
>   take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default)
> 
> This is what I don't like. When that happens, I cannot free fb0.
> There is a give_up_console function but it is never called.

The module counters are actually incremented in the code before
take_over_console() is called.

> >>If I comment this line causing the owner variable to be undefined, the 
> >>module count does not increase and the module can be unloaded.
> >>But It seems that the device is NOT unregistered. When I load the module 
> > 
> > 
> > Your module_cleanup() routine must unregister your fb_info.
> > 
> 
> It does call unregister_framebuffer, but it returns "device busy" 
> because fb0 is used as the system console.
> 
> I want either to avoid this :
> "Console: switching to colour frame buffer device 80x30"
> (which means take_over_console will not be called)
> or, if I can't do that, to be able to take back by first framebuffer 
> (fb0) from the console, so that I can unregister it.
> 
> What am I missing here?

Comment out the code to increment the module counters and the code that calls
take_over_console().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
