From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Sane behavior of fbset
Date: Thu, 24 Jun 2004 10:17:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406241017.37503.adaplas@hotpop.com>
References: <200406180945.12444.adaplas@hotpop.com> <200406191413.28339.adaplas@hotpop.com> <1088006149.1832.145.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdJrU-0007pV-9k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 19:21:12 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdJrR-0005c3-Pa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 19:21:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 85E946426B8
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Jun 2004 01:40:58 +0000 (UTC)
In-Reply-To: <1088006149.1832.145.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Eger <eger@havoc.gtf.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 23 June 2004 23:55, Benjamin Herrenschmidt wrote:
> > The flow of fbset is upstream:  fbset->fbdev->fbcon->vc (2.4 code)
> > The flow of stty is downstream: stty->vc->fbcon->fbdev (2.6 code)
> >
> > I don't know how radeonfb does it though.
>
> I still think (didn't I repeat it often enough) that the whole idea
> of stty "inventing" modes based on console size is broken. We simply
> can't rely on good enough monitor detection & mode list building to
> be able to pick proper modes. Not only our code is far from ready for
> that, but it will also call all sort of problems to users (remember
> you monitors that need different subtle geometry settings for each
> different mode you use ?)
>
> It may have looked like a nice idea, but I think it's just wrong.
>

It started out like this, during 2.5 development. The discussions were
not very clear cut, as ironing bugs was the main concerned, but basically
it all boils down to the following points:

a. fbset functionality was lost (or removed), so how do we change the
resolution of fbdev?

b. what should be the correct behavior of stty?  

So there were 2 ideas:

1. An stty call will just have to modify the video mode. This will require
that fbdev must be able to handle mode change requests independently.

2. stty will just have to produce a smaller or larger viewport, without
changing the resolution of the video mode. This will involve that fbcon
must be able to do clipping, otherwise it will attempt to write past fb
memory if vc size > fbdev size.

So, I submitted 2 patches.

For 1, I added a hook for con_resize. And for 2,  I added clipping code
for all the accel_* functions, no con_resize hook.

You probably guessed correctly which got merged, 1. And 
because 1 requires fbdev to handle mode changes independently, it's
unavoidable that we need functions to help drivers validate and choose
the correct modelines.  So, EDID parsing,  GTF calculation, and mode
validation were introduced in fbmon.c

(fbset behavior remained undefined until this thread)

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
