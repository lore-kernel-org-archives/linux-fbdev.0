From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 16:26:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408091626.31353.adaplas@hotpop.com>
References: <200408090944.01414.adaplas@hotpop.com> <20040808230412.6dc16bf4.akpm@osdl.org> <Pine.GSO.4.58.0408090920511.14159@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu5UX-0005Dg-Sl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:26:49 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu5UX-0000hh-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:26:49 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 932A7780415
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 07:33:19 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0408090920511.14159@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Monday 09 August 2004 15:23, Geert Uytterhoeven wrote:
> On Sun, 8 Aug 2004, Andrew Morton wrote:
> > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > > Most fbdev developers are proposing to bring back the per-display var
> > >  structures to ease the difficulty of video mode handling.  This
> > > proposal is countered by a few (notably James) in that it severely
> > > increases the memory footprint of the kernel.
> >
> > Surprised.
> >
> > By how much does this increase the kernel's memory footprint?
>
> Indeed, you need a full mode database per driver.

Not necessarily.  For drivers which cannot change the videomode, a single
entry is tops. 
 
>
> > And how much simpler would the code be if we were to bring back the
> > per-display var structures?
> >
> > IOW: what's the tradeoff here?
>
>   - per-display var:
>       - increase memory footprint by
>         MAX_NR_CONSOLES.*sizeof(struct var_screen_info)
>       + simpler code
>       + 100% compatible with 2.4
>
>   - private modedb:
>       - increase memory footprint by full mode database per driver.

Note: the private modedb will start with a single entry.  Entries will be added
each time the user does an fbset.  A typical user will probably use less than 10
modelines. I personally use only 3.  In contrast, saving the modeline per display 
already amounts to approximately 64 modelines. 

Also, the private modedb is needed for the resize/stty path.  Without the private
modedb, fbcon will use the default modedb.  And the modedb contain entries
from a mixed hardware.   

>       - more complex (and larger) code

Yes, larger code. But we eliminate the the static mode database and instead of
saving sizeof(struct fb_var_screeninfo) per console, we save only 1/2 of that
per console.

>       - subtle differences with 2.4, because not the whole var is saved

With the patch, the whole var is saved except for xoffset, yoffset and activate.
The timings will be derived from the fb_videomode which  is only a pointer in
the display structure. There should be no difference between 2.4, unless
xoffset, yoffset and activate are critical to the driver's functioning. 
 
>         (BTW, which fields do you want to save, and which not, so I can
> 	 evaluate the impact on some drivers?)

All the fields in var are saved, one way or the other,  except for xoffset, yoffset and
activate.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
