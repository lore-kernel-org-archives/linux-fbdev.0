From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: /usr/src/linux/Documentation/fb/aty128fb.txt
 (fwd)
Date: Tue, 5 Oct 2004 10:42:26 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410051040510.29639@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0410042119240.19047@waterleaf.sonytel.be>
 <200410051101.01409.adaplas@hotpop.com> <200410042357.20226.eric@pretorious.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEkua-0006KZ-MR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 01:43:08 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEkty-0003fo-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 01:43:08 -0700
In-Reply-To: <200410042357.20226.eric@pretorious.net>
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
To: Eric Pretorious <eric@pretorious.net>
Cc: adaplas@pol.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 4 Oct 2004, Eric Pretorious wrote:
> On Monday 04 October 2004 08:01 pm, Antonino A. Daplas wrote:
> >On Tuesday 05 October 2004 03:19, Geert Uytterhoeven wrote:
> >> passing the value using the "vga=0x317".) The framebuffer.txt file
> >> describes it like this...
> >
> >The option "vga=xxx" is only for drivers that lets the BIOS do the mode
> >setup for them.  Some of these drivers are vesafb and matroxfb.
> 
> I dont' know if it's *supposed*to* but the "vga=xxx" works with aty128fb. 
> (It's the only way that I've gotten it to work so far. I'll retest *without* 
> the <...> and report back later.

That depends on the driver. `vga=' is not handled by the frame buffer device,
but by the early startup code that calls the BIOS to change the video mode.
And it depends on the fbdev driver if it cope with a graphics chip initialized
to something different than VGA text mode. Drivers used on PowerMac usually do,
because Open Firmware gives them graphics mode as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
