From: John Zielinski <grim@undead.cc>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 17:44:02 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D9F9A2.2080708@undead.cc>
References: <200406180945.12444.adaplas@hotpop.com>  <200406190240.26228.adaplas@hotpop.com>  <20040619031650.GC14319@havoc.gtf.org>  <200406191413.28339.adaplas@hotpop.com> <1088006149.1832.145.camel@gaston> <40D9BDF5.2080603@undead.cc> <Pine.LNX.4.56.0406232130070.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdFXR-0004QR-CO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 14:44:13 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BdFXQ-0002Ss-TU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 14:44:13 -0700
In-Reply-To: <Pine.LNX.4.56.0406232130070.27210@pentafluge.infradead.org>
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
To: jsimmons@pentafluge.infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

jsimmons@pentafluge.infradead.org wrote:

>Good catch. We need a flag to determine which layer it came from. Tony 
>posted a patch dealing with that.
>  
>
I took a look and I'm going to merge that into my kernel and trace 
trough the ioctl call paths again.  The VT_RESIZE path looks good with 
his patch but I think that the FBIOPUT_VSCREENINFO may loop through a 
few functions a second time.  I'll know for sure when I trace things out 
later.

But my thinking was that vc_resize (or part of it split of into a 
seperate function) should be the final terminus of the code path.  That 
way you wouldn't need flags or anything else to break out of the 
circular code path we have now.  The code would be easier to follow and 
be less prone to mistakes.

I'll see if I can whip up a patch that works with our current single var 
to show you what I mean.

John




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
