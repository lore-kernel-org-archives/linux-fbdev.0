From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Does fbdev need a cursor API for
 userland?
Date: Mon, 18 Oct 2004 11:35:15 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410181133300.23486@waterleaf.sonytel.be>
References: <200410172347.15516.adaplas@hotpop.com> <200410180920.39170.adaplas@hotpop.com>
 <9e47339104101719462ea5b2dd@mail.gmail.com> <200410181447.44492.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJTvH-0003a9-MU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 02:35:23 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJTvG-00065x-QT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 02:35:23 -0700
In-Reply-To: <200410181447.44492.adaplas@hotpop.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, Antonino Daplas <adaplas@hotpop.com>

On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> The restore_fb_contents/save_fb_contents cannot be done generically.  Not
> all framebuffers have a linear format, there are some that are planar such
> as amifb and vga16fb.  This means that we need to add per-driver hooks just
> to save and restore the framebuffer contents.

Can't we use fb_imageblit() for restore? Then al we need to add is a
get_image() routine.

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
