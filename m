From: Jon Smirl <jonsmirl@gmail.com>
Subject: XGL/mesa-solo and fbdev
Date: Mon, 21 Feb 2005 14:48:00 -0500
Message-ID: <9e47339105022111483136bd56@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3JXM-0007rH-4D
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:48:08 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3JXJ-0006UN-Op
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:48:08 -0800
Received: by rproxy.gmail.com with SMTP id z35so605189rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 11:48:04 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

XGL/mesa-solo is a project that has been going on for about a year and
a half now to get X running on top of OpenGL instead of the existing
2D XAA drivers. XGL allows a vastly improved user experience as
demonstrated at the recent X developer's conference. Removing the 2D
drivers from X means that things like mode setting need to come from
someplace else, like fbdev.

To make this project work XGL/mesa-solo needs support for these things
at the minimum:
1) resetting of secondary cards
2) mode setting on all heads, not just the primary one
3) hardware cursor control
4) control of mode setting/cursor etc by users, not just root
5) DRM and fbdev need to not conflict

We are try to get everything in the stack working together before OLS
this summer. I've posted code to implement some of these features and
I'm seeking solutions for making the rest work. Does this look like
something that can get finished in the next month or so? We also need
time to get all of the layers above fbdev using the new support.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
