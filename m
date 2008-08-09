From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Set ypanstep to 1
 and enable y-panning on AT91
Date: Sat, 9 Aug 2008 16:41:48 +0200
Message-ID: <20080809164148.09f30452@hskinnemo-gx745.norway.atmel.com>
References: <200808081446.43406.stf_xl@wp.pl>
	<20080808134145.e8b861c6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRpdy-0008I9-3L for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 07:42:10 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KRpdw-0005UT-Go
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 07:42:10 -0700
In-Reply-To: <20080808134145.e8b861c6.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton <akpm@linux-foundation.org> wrote:
> a) Neither of these changelogs communicate the seriousness of the
>    problem which is being fixed, nor the benefit of the change.

The benefit is that the FBIOPAN_DISPLAY ioctl can now be used to pan the
display in the y direction on avr32 and at91. The seriousness is
probably not very bad since I'm sure there's hardware that just doesn't
support this kind of thing at all. But it is necessary for double- and
triple-buffering to work.

The existing patch description does say this (FBIOPAN_DISPLAY doesn't
work since ypanstep is 0, so we set it to 1), though it doesn't explain
what FBIOPAN_DISPLAY does and how serious it is that it isn't working. I
guess I took it for granted that the fbdev people knew this already ;-)

Some chips support x-panning too, so we should probably have a look and
see if that's set up correctly. But that's less important IMO.

>    So when I go through my usual "do we need this in 2.6.27? 
>    2.6.26?  2.6.25?" exercise, I don't have enough information to be
>    able to tell.

I'd say 2.6.27. I've had the patch applied to my "vendor tree" for
about a year, so it's well-tested on avr32, and Stanislaw confirms it
also works on at91. In other words, the risk is not very high, but
since it's a new feature it probably doesn't deserve to be backported.

> b) The second patch was wordwrapped by your email client.  I fixed that.
> 
> c) The authorship/signoff is confusing.  The patch is From:you and
>    signed-off-by:Haavard but is missing your signed-off-by:.
> 
>    Who wrote the patches?  If it was you then all we're missing is
>    your signed-off-by:.
> 
>    If it was Haavard then you should have had his From: line at the
>    start of the chagnelog to indicate this.
> 
>    Either way, it should have had your signed-off-by:, because you
>    were in the delivery path.
> 
>    If Haavard did not participate in the development and was not in
>    the delivery path then his signed-off-by: was inappropriate, and an
>    acked-by: or tested-by: or reviewed-by: would be better.

I wrote the patch, so it's missing from:me and signed-off-by:Stanislaw.

Haavard

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
