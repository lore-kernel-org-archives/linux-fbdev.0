From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 19:05:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410181905.56602.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <200410181447.44492.adaplas@hotpop.com> <Pine.GSO.4.61.0410181133300.23486@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJVEt-00074E-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 03:59:43 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJVEs-0002Il-5T
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 03:59:43 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 646FC115FD4C
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Oct 2004 10:59:26 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.61.0410181133300.23486@waterleaf.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@gmail.com>

On Monday 18 October 2004 17:35, Geert Uytterhoeven wrote:
> On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > The restore_fb_contents/save_fb_contents cannot be done generically.  Not
> > all framebuffers have a linear format, there are some that are planar
> > such as amifb and vga16fb.  This means that we need to add per-driver
> > hooks just to save and restore the framebuffer contents.
>
> Can't we use fb_imageblit() for restore? 

fb_imageblit() is limited because it uses the pseudo_palette.  Even if
we expand the palette to 256 entries, it won't be able to handle formats >
8bpp. More than 256 is not practical. Plus, fb_imageblit is limited to
1->bpp, and 8->bpp expansion.

> Then al we need to add is a get_image() routine.

I guess if we can add get_image(), it's simple enough to write a
corresponding set_image().  Your amifb is one driver that's going to
be affected, so if you say 'yes' to the above, then let's go for a 
universal cursor implementation.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
