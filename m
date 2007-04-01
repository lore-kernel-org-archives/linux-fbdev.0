From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH] nvidiafb: Fix reversed DDC port
Date: Mon, 2 Apr 2007 09:07:57 +1000
Message-ID: <21d7e9970704011607h3d901car4cdfe466396e7797@mail.gmail.com>
References: <460F7CF4.60006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HY99U-0005P9-9k for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:08:00 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HY99S-00088t-Se
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 16:08:00 -0700
Received: by ug-out-1314.google.com with SMTP id z38so1731885ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2007 16:07:57 -0700 (PDT)
In-Reply-To: <460F7CF4.60006@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>

> After I added some debugging printks I've found that code became a bit
> confused because it believed that primary monitor is 1920x540, but later
> it found in CRTC0's registers that panel size is 1920x1200 (Windows also
> agree that 1920x1200 is primary monitor, and 1920x1080i secondary one).
>
> When I applied attached patch then my monitor became as happy as it was
> before I connected HDMI cable to secondary output.
>

I don't think this will do much except break other peoples cards,
different nvidia cards map the i2c to outputs differently, the correct
way to fix it is to read a table in the BIOS called the DCB table (for
NV4x and above...) guess what? we don't know how to do that properly
because nvidia are very unfriendly...

Dave.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
