From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [PATCH] Sysfs for framebuffer
Date: 22 Mar 2004 18:41:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <87ekrk93u0.fsf@bytesex.org>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320213030.GA3950@kroah.com> <20040320215219.GA20277@dreamland.darkstar.lan> <20040320215909.GA26277@kroah.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5TPK-0001ME-KB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 09:40:14 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B5TPI-0007V7-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 09:40:13 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with ESMTP id i2MHe1bV022070
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Mar 2004 18:40:01 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with UUCP id i2MHZDKN021663
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 18:35:13 +0100
Received: from bytesex.org (news@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i2MHfhZm000673
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Mar 2004 18:41:43 +0100
Received: (from news@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id i2MHfhib000672
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 18:41:43 +0100
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Greg KH <greg@kroah.com> writes:

> Well, /sys/class/video is already taken by the V4L core code,

Uhm, no, v4l actually uses "video4linux".

  Gerd



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
