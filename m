From: Zachary Smith <plinius@comcast.net>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Sun, 17 Oct 2004 16:49:45 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41730519.9040202@comcast.net>
References: <200410172347.15516.adaplas@hotpop.com>	 <4172A952.4080607@comcast.net> <200410180551.11105.adaplas@hotpop.com> <9e4733910410171525543c1992@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJKiS-0002CA-OR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 16:45:32 -0700
Received: from sccrmhc12.comcast.net ([204.127.202.56])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJKiR-0005Pp-AN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 16:45:32 -0700
In-Reply-To: <9e4733910410171525543c1992@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Jon Smirl wrote:

> Are there cards still out there with no hardware cursor support?

The fallbacks for not having a driver are VESA and VGA, which lack it.

 > How many apps use the user space fbdev interface?

Any app that uses FBUI (my in-kernel GUI) at least opens /dev/fb/0.
Then it uses my ioctls.

Zack


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
