From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 20:59:03 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411232057280.6094@waterleaf.sonytel.be>
References: <200411191137.14649.andrew@walrond.org> <200411231801.14328.andrew@walrond.org>
 <200411240226.03203.adaplas@hotpop.com> <200411231923.40572.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWgon-0000ha-BU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:59:17 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CWgom-0005kL-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 11:59:17 -0800
In-Reply-To: <200411231923.40572.andrew@walrond.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Walrond <andrew@walrond.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Tue, 23 Nov 2004, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 18:26, Antonino A. Daplas wrote:
> > Does vesafb work in x86_64?  If it does you can add this in your
> > commandline:
> >
> > vga=0x307
> >
> > 0x306 is the code for 1280x1024, see Documentation/fb/vesafb.txt.
> >
> > Then check your dmesg if the panel size also changed.  If it did, then
> > you can do this:
> >
> > vga=0x307 video=nvidiafb:1280x1024@60.
> 
> And this is just a possible means of tricking the hardware into adjusting the 
> panel size for us?

No, this will use the BIOS to switch to a 1280x1024 mode before starting the
kernel. Remember that Tony told you the panel size is set up by the BIOS. If
that's really the case, it should help.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
