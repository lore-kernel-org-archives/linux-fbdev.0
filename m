From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: multiple outputs
Date: Fri, 22 Aug 2008 11:50:24 -0700
Message-ID: <376ea3380808221150t2484cdd5ne17087bf2fe2201c@mail.gmail.com>
References: <a728f9f90808220735h498e0b37wd7f9f5d84e346041@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739403CD45C746@dbde02.ent.ti.com>
	<a728f9f90808220757p766c5a4aw57307ca503366f05@mail.gmail.com>
	<376ea3380808220802g7edffbd8g54c28fc2b09abd81@mail.gmail.com>
	<a728f9f90808220817q48a466ccu78279ea5d5dee13d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWbiN-0000JC-Ue for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 11:50:28 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWbiM-0000lq-Jb
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 11:50:27 -0700
Received: by ug-out-1314.google.com with SMTP id m2so279438uge.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Aug 2008 11:50:25 -0700 (PDT)
In-Reply-To: <a728f9f90808220817q48a466ccu78279ea5d5dee13d@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

> yes.  It provides a legacy kernel fb interface.  Although directfb has
> their own set of accel code which in this case could mess with the
> hardware behind the driver's back as the drm handles more than just
> modesetting depending on the driver.

So, in that case, is the old, fb drivers such as intelfb, radeonfb,
etc deprecated. And the new way forward is with these drm drivers that
mimic the old fb drivers?

This still seems like it is still in development so it may not be
ready, but it is good to have an idea in my mind about where the
drivers are going.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
