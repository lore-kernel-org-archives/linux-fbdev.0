From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: no console switching
Date: Tue, 11 Nov 2003 14:53:19 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311111450200.514-100000@waterleaf.sonytel.be>
References: <3FB0E787.6050100@inaccessnetworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJYxb-0003cw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 05:53:35 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJYxb-0000n3-1X
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 Nov 2003 05:53:35 -0800
In-Reply-To: <3FB0E787.6050100@inaccessnetworks.com>
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

On Tue, 11 Nov 2003, Manousaridis Angelos wrote:
> I am trying to implement a framebuffer device without console support. I 
> want to display only graphics, no text at all.
> 
> Is there a way to avoid the console take over?

Disable CONFIG_VT_CONSOLE.

> I don't have the actuall graphics device yet, so I have created an 
> initial version of the driver looking a lot like the vfb device.
> I set the dispsw variable of the display structure to fbcon_dummy.
> When I load the module I see this:
> 
> fbcon_setup: No support for fontwidth 8
> fbcon_setup: type 0 (aux 0, depth 8) not supported

That's harmless, and caused by fbcon_dummy.

> Console: switching to colour frame buffer device 80x30
> fb0: Teralogic 751 frame buffer device
> 
> The module count increases to 63 and I cannot unload the module.

Because the virtual console subsystem uses 63 virtual consoles by default, and
increases the module counter for each of them.

> Also, what do I have to put to the owner variable of the fb_ops 
> structure? The above happens with this variable se to THIS_MODULE.

That's OK.

> If I comment this line causing the owner variable to be undefined, the 
> module count does not increase and the module can be unloaded.
> But It seems that the device is NOT unregistered. When I load the module 

Your module_cleanup() routine must unregister your fb_info.

> again, I see this:
> 
> fb1: Teralogic 751 frame buffer device
> 
> the fb0 is somewhere still defined, and when I try to access it, a page 
> fault occurs. Is it wrong to leave the owner variable undefined?

Yes, that's wrong. The .owner is there to protect you from removing the module
while it's still in use.

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
