From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: about fb_mmap
Date: Fri, 18 Jun 2004 10:28:16 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406181027140.11779@waterleaf.sonytel.be>
References: <PMEKJGJGKKPHMBEGKNMIEEIJCCAA.xuhaoz@neonetech.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEjU-0006Fj-ID
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:28:20 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEjT-0006Up-WC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:28:20 -0700
In-Reply-To: <PMEKJGJGKKPHMBEGKNMIEEIJCCAA.xuhaoz@neonetech.com>
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
To: xuhaoz <xuhaoz@neonetech.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Jun 2004, xuhaoz wrote:
> 	I have a question about fb_mmap in uclinux2.4.

It (should) behave (almost) the same for uClinux and real Linux.

> 	what is the usage of fb_mmap(struct file *file, struct vm_area_struct
> *vma)
> 	my kernel is arm7 no mmu , does the fb_mmap function do some help for my
> framebuffer driver if i use fb_mmap function?

It allows to mmap() the frame buffer memory (and optionally the graphics chip
registers) to a user space application, e.g. an X server.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
