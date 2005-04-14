From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Thu, 14 Apr 2005 19:06:23 +0200
Message-ID: <20050414190623.07e18577.khali@linux-fr.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	<20050324203118.345c6004.akpm@osdl.org>
	<200504141351.11605.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DM7nU-0007la-9D
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 10:06:32 -0700
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104] helo=mallaury.noc.nerim.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DM7nS-0005BI-R8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 10:06:32 -0700
In-Reply-To: <200504141351.11605.adaplas@hotpop.com>
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
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>

Hi Tony,

> As for the i2c problem, this is probably due to a misplaced label in
> the failure path, and the reason why I had a difficult time
> reproducing this bug. When nvidiafb failed with the ioremap, it
> skipped deletion of the i2c busses causing the crash whenever the bus
> created by nvidiafb is read.  The fix is also included in this patch.

Exactly what I suspected from the very beginning, but I did not
investigate the error path back then - in fact I can't remember Miles
telling me that the the driver was actually not working for him. Thanks
a lot for confirming and fixing the problem.

> So, can you test this patch and see if it helps?

I can't - I have no compatible hardware - but hopefully Miles will be
able to test.

-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
