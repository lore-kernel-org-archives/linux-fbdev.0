From: John Zielinski <grim@undead.cc>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 13:29:25 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D9BDF5.2080603@undead.cc>
References: <200406180945.12444.adaplas@hotpop.com>	 <200406190240.26228.adaplas@hotpop.com>	 <20040619031650.GC14319@havoc.gtf.org>	 <200406191413.28339.adaplas@hotpop.com> <1088006149.1832.145.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdBZ4-0004bV-Ma
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 10:29:38 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BdBZ4-0007wk-96
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 10:29:38 -0700
In-Reply-To: <1088006149.1832.145.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: adaplas@pol.net, David Eger <eger@havoc.gtf.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>It may have looked like a nice idea, but I think it's just wrong.
>  
>
I think that the implementation is wrong, not the whole idea.  Currently 
the vt_resize ioctl changes the vt size then tries to set the resolution 
leading to a whole bunch of problems when a suitable resolution can't be 
found and makes the fbset result ion change code path ugly as well.

What should happen is that the vt_resize ioctl should be sent to the 
console driver first and then the console driver calls back the vt layer 
with the modified  row and column numbers based on the closest 
resolution found.

So what we have right now is:

vt_ioctl (VT_RESIZE) -> vc_resize -> resize_screen -> con_resize ->  
fb_set_var -> fbcon_event_notify -> vc_resize*

* or equivilent code depending on who's patch you use

Which should be:

vt_ioctl (VT_RESIZE) -> resize_screen -> con_resize -> fb_set_var & 
vc_resize

You'd have to have a per vt var in order to have different console sizes 
on different vt's this way.  The reason for not using the 
fbcon_event_notify is that it won't be called when the vt is not in the 
forground and I don't belive that a we need to resize the console when 
switching between different vt's.  A vc_resize would the be necessary in 
the fb_ioctl FBIOPUT_VSCREENINFO code path in this case.

John




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
