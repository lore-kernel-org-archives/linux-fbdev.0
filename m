From: jsimmons@pentafluge.infradead.org
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 21:39:14 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406232130070.27210@pentafluge.infradead.org>
References: <200406180945.12444.adaplas@hotpop.com>  <200406190240.26228.adaplas@hotpop.com>
  <20040619031650.GC14319@havoc.gtf.org>  <200406191413.28339.adaplas@hotpop.com>
 <1088006149.1832.145.camel@gaston> <40D9BDF5.2080603@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdEWf-0006fL-8n
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 13:39:21 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdEWe-0007va-KC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 13:39:21 -0700
In-Reply-To: <40D9BDF5.2080603@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Benjamin Herrenschmidt wrote:
> 
> >It may have looked like a nice idea, but I think it's just wrong.
> >  
> >
> I think that the implementation is wrong, not the whole idea.  Currently 
> the vt_resize ioctl changes the vt size then tries to set the resolution 
> leading to a whole bunch of problems when a suitable resolution can't be 
> found and makes the fbset result ion change code path ugly as well.
> 
> What should happen is that the vt_resize ioctl should be sent to the 
> console driver first and then the console driver calls back the vt layer 
> with the modified  row and column numbers based on the closest 
> resolution found.
> 
> So what we have right now is:
> 
> vt_ioctl (VT_RESIZE) -> vc_resize -> resize_screen -> con_resize ->  
> fb_set_var -> fbcon_event_notify -> vc_resize*

Good catch. We need a flag to determine which layer it came from. Tony 
posted a patch dealing with that.


> 
> * or equivilent code depending on who's patch you use
> 
> Which should be:
> 
> vt_ioctl (VT_RESIZE) -> resize_screen -> con_resize -> fb_set_var & 
> vc_resize
> 
> You'd have to have a per vt var in order to have different console sizes 
> on different vt's this way.  The reason for not using the 
> fbcon_event_notify is that it won't be called when the vt is not in the 
> forground and I don't belive that a we need to resize the console when 
> switching between different vt's.  A vc_resize would the be necessary in 
> the fb_ioctl FBIOPUT_VSCREENINFO code path in this case.
> 
> John
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
