From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] fbdev: add new TMIO framebuffer
 driver
Date: Wed, 8 Oct 2008 11:16:53 -0700
Message-ID: <20081008111653.67c55f12.akpm@linux-foundation.org>
References: <1223463303-32700-1-git-send-email-dbaryshkov@gmail.com>
	<20081008171546.GA4766@localdomain> <gcisol$ico$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1Kndan-0002zh-Od
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:17:01 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kndaj-0002az-Bi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:17:01 +0000
In-Reply-To: <gcisol$ico$1@ger.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


Please never change the Cc: list.  Just do reply-to-all all the time.

On Wed, 8 Oct 2008 18:05:09 +0000 (UTC) Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:

> Samuel Ortiz wrote:
> 
> > On Wed, Oct 08, 2008 at 02:55:03PM +0400, Dmitry Baryshkov wrote:
> >> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
> >> chips.
> >> 
> >> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com> Cc: Ian Molton
> >> <spyro@f2s.com>
> >> Cc: Samuel Ortiz <sameo@openedhand.com>
> > Acked-by: Samuel Ortiz <sameo@openedhand.com>
> 
> Thanks. And as Kristoffer acked one of previous revisions of this driver,
> I hope he will also ack this one. Now the question is: via which tree should
> this driver be merged? Is there any specific FB tree? Or should I send pull
> request directly to Linus when the window will open :) ?

fbdev patches are meged via the -mm tree.  I have this email thread
saved away for review-and-merge.  It might take me a few days - I like
to leave things, to let the dust settle.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
