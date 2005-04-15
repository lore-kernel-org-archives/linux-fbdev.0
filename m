From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Fri, 15 Apr 2005 11:07:54 +0800
Message-ID: <200504151107.54579.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <200504141351.11605.adaplas@hotpop.com> <20050414190623.07e18577.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMHCE-0001EW-PN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:42 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMHC4-0004zK-Rv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BC4B810657C0
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Apr 2005 03:08:24 +0000 (UTC)
In-Reply-To: <20050414190623.07e18577.khali@linux-fr.org>
Content-Disposition: inline
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
To: Jean Delvare <khali@linux-fr.org>, "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>

On Friday 15 April 2005 01:06, Jean Delvare wrote:
> Hi Tony,
>
> > As for the i2c problem, this is probably due to a misplaced label in
> > the failure path, and the reason why I had a difficult time
> > reproducing this bug. When nvidiafb failed with the ioremap, it
> > skipped deletion of the i2c busses causing the crash whenever the bus
> > created by nvidiafb is read.  The fix is also included in this patch.
>
> Exactly what I suspected from the very beginning, but I did not
> investigate the error path back then - in fact I can't remember Miles
> telling me that the the driver was actually not working for him. Thanks

He didn't.  I just assumed that it did because he also reported that nvidiafb
failed to load due to an ioremap problem (too much video RAM).

> a lot for confirming and fixing the problem.

Well, not yet confirmed, I'll wait for Miles to do so.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
