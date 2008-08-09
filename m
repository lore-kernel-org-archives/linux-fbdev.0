From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Set ypanstep to 1
	and enable y-panning on AT91
Date: Sat, 9 Aug 2008 15:57:09 +0200
Message-ID: <200808091557.09200.stf_xl@wp.pl>
References: <200808081446.43406.stf_xl@wp.pl>
	<20080808134145.e8b861c6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRowP-0003t7-Cu for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 06:57:09 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRowN-0004hx-Ts
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Aug 2008 06:57:09 -0700
In-Reply-To: <20080808134145.e8b861c6.akpm@linux-foundation.org>
Content-Disposition: inline
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

On Friday 08 August 2008, Andrew Morton wrote:
> On Fri, 8 Aug 2008 14:46:43 +0200
>
> Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> > Panning in the y-direction can be done by simply changing the DMA base
> > address. This code is already in place, but FBIOPAN_DISPLAY will
> > currently fail because ypanstep is 0.
> >
> > Set ypanstep to 1 to indicate that we do support y-panning and also
> > set the necessary acceleration flags on AT91 (AVR32 already have
> > them.)
> >
> > Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
>
> problems...
>
> a) Neither of these changelogs communicate the seriousness of the
>    problem which is being fixed, nor the benefit of the change.
>
>    So when I go through my usual "do we need this in 2.6.27?
>    2.6.26?  2.6.25?" exercise, I don't have enough information to be
>    able to tell.
I think this is a new feature, should go to future release i.e. 2.6.27.

> b) The second patch was wordwrapped by your email client.  I fixed that.
I sent a patch average ones a year and never did it correctly, maybe if I will 
be sending patches more frequently, I will learn do it good ;-)

> c) The authorship/signoff is confusing.  The patch is From:you and
>    signed-off-by:Haavard but is missing your signed-off-by:.
>
>    Who wrote the patches?  If it was you then all we're missing is
>    your signed-off-by:.
>
>    If it was Haavard then you should have had his From: line at the
>    start of the chagnelog to indicate this.
Patch is from Haavard, sorry for removing From:

>    Either way, it should have had your signed-off-by:, because you
>    were in the delivery path.
Sorry again, to late but ...
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
