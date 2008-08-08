From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Set ypanstep to 1
 and enable y-panning on AT91
Date: Fri, 8 Aug 2008 13:41:45 -0700
Message-ID: <20080808134145.e8b861c6.akpm@linux-foundation.org>
References: <200808081446.43406.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRYn7-0006Ag-Ha for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 13:42:29 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRYn6-0005Do-7c
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 13:42:29 -0700
In-Reply-To: <200808081446.43406.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 8 Aug 2008 14:46:43 +0200
Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> Panning in the y-direction can be done by simply changing the DMA base
> address. This code is already in place, but FBIOPAN_DISPLAY will
> currently fail because ypanstep is 0.
> 
> Set ypanstep to 1 to indicate that we do support y-panning and also
> set the necessary acceleration flags on AT91 (AVR32 already have
> them.)
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

problems...

a) Neither of these changelogs communicate the seriousness of the
   problem which is being fixed, nor the benefit of the change.

   So when I go through my usual "do we need this in 2.6.27? 
   2.6.26?  2.6.25?" exercise, I don't have enough information to be
   able to tell.

b) The second patch was wordwrapped by your email client.  I fixed that.

c) The authorship/signoff is confusing.  The patch is From:you and
   signed-off-by:Haavard but is missing your signed-off-by:.

   Who wrote the patches?  If it was you then all we're missing is
   your signed-off-by:.

   If it was Haavard then you should have had his From: line at the
   start of the chagnelog to indicate this.

   Either way, it should have had your signed-off-by:, because you
   were in the delivery path.

   If Haavard did not participate in the development and was not in
   the delivery path then his signed-off-by: was inappropriate, and an
   acked-by: or tested-by: or reviewed-by: would be better.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
