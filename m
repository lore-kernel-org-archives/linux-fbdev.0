From: Michel Danzer <mdanzer@ati.com>
Subject: Re: EGL_MESA_screen_surface proposal
Date: Tue, 15 Mar 2005 11:36:53 -0500
Message-ID: <1110904613.9080.62.camel@lnx-1cv4-4-110>
References: <4236F0A8.4000004@tungstengraphics.com>
	 <9e47339105031507064a68630f@mail.gmail.com>
	 <4236FC79.5000909@tungstengraphics.com>
	 <9e4733910503150828ecf5a1b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBFPh-0003HG-1I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 09:01:01 -0800
Received: from mail-red.bigfish.com ([216.148.222.61] helo=mail76-R-red.bigfish.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DBFPf-0000vD-L8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 09:01:00 -0800
In-Reply-To: <9e4733910503150828ecf5a1b@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Brian Paul <brian.paul@tungstengraphics.com>, Xserver development <xorg@freedesktop.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI-EGL <dri-egl@lists.freedesktop.org>

On Tue, 2005-03-15 at 11:28 -0500, Jon Smirl wrote:
> 
> On Tue, 15 Mar 2005 08:17:13 -0700, Brian Paul
> <brian.paul@tungstengraphics.com> wrote:
> > Perhaps the eglShowSurface() and eglScreenMode() functions should be
> > combined so the new surface and new display mode can be validated
> > together.  That way, the undefined state between setting the new
> > surface and new mode can be avoided.

Makes sense to me.

> In one of the other threads (on x.org&fbdev) people are arguing that
> mode setting and surface selection should not be combined.

Actually, I was arguing that mode setting and _memory management_
shouldn't be tied together, see my other post to dri-egl in this thread.
The approach Brian is proposing is much more flexible, which I applaud.


-- 
Michel Danzer, Linux Software Engineering       \   Tel: +1 905-882-2600
ATI Technologies Inc., Markham, Ontario, Canada  \       Extension: 3550



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
