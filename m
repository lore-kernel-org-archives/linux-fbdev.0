From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Tue, 19 Oct 2004 16:55:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410191655.59426.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <200410190534.26894.adaplas@hotpop.com> <Pine.GSO.4.61.0410190958340.13789@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJpgl-00055N-Am
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 01:49:51 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJpgk-0007wX-Dt
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 01:49:51 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E17B211266BF
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 19 Oct 2004 08:49:28 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.61.0410190958340.13789@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

On Tuesday 19 October 2004 16:01, Geert Uytterhoeven wrote:
> On Tue, 19 Oct 2004, Antonino A. Daplas wrote:
> > On Tuesday 19 October 2004 05:00, Geert Uytterhoeven wrote:
> > > On Tue, 19 Oct 2004, Antonino A. Daplas wrote:
> > > > On Monday 18 October 2004 20:01, Geert Uytterhoeven wrote:
> > > > > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > > > > > On Monday 18 October 2004 17:35, Geert Uytterhoeven wrote:
> > > > > > > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > >
> > > I didn't intend it to do conversions. 32-bit ARGB would be used for
> > > truecolor visuals only.
> > >
> > > > Isn't it much simpler to just have a set_image() where the source
> > > > block is in the same format as the framebuffer so it doesn't have to
> > > > do format conversions?
> > >
> > > Yes it is.
> > >
> > > The fb_imageblit() approach is just more generic, and could (in theory)
> > > be used from user space as well, allowing applications to not have to
> > > care about the actual frame buffer format anymore. All they have to
> > > handle is 1-bit monochrome, 8-bit pseudocolor and 32-bit ARGB
> > > truecolor.
> >
> > We still have to do conversions, say from 32-bit ARGB to RGB565.  And
> > this is just for truecolor.
>
> Indeed.
>
> > How about directcolor?
>
> You're right. And currently directcolor is treated like pseudocolor w.r.t.
> the console and the penguin logo.
>
> Hmm, bad idea, at least for saving/restore for the cursor.

Well, your proposal sounds useful though. We can still expand imageblit so it has
these additional functions:

32-bit ARGB truecolor ->any truecolor format
32-bit ARGB directcolor-> any directcolor format
8-bit pseudocolor -> all formats <= 8 bpp && !directcolor && !truecolor 

(First and second is easy to add. The third may be a bit tricky because
it conflicts with already existing code for the penguin, but I think it's
fixable. The logo code in fbmem.c and color_imageblit need to be rewritten.)

I think with the above we cover everything for packed-pixel formats.

Then for the cursor (if people still want it), we just add get_image_raw()
and set_image_raw() hooks which gets/sets the contents in native framebuffer
format.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
