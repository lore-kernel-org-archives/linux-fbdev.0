From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Problem about FB on an iBook G4
Date: Thu, 30 Sep 2004 12:29:25 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0409301227560.9524@waterleaf.sonytel.be>
References: <c854a4.54a4c8@huawei.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCyC6-0006qg-Ro
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Sep 2004 03:29:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CCyBy-0007Zo-0c
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Sep 2004 03:29:50 -0700
In-Reply-To: <c854a4.54a4c8@huawei.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jiangning 39481 <jiangnuts@huawei.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi,

> I bought an Apple iBook G4 with RV280M9+(Mobility Radeon 9200) one month ago.And I installed Yellow Dog Linux 3.01 on it.But I can't set the resolution with "fbset" in console mode and "startx" give me info like "(EE) FBDEV FBIOPUT invalid argument" while depth != 8."dmesg" says something like "Using unsupported 1024x768 Open Firmware FrameBuffer...".The output of "fbset -i" is
> NAME OFfb ATY,Via A

That's offb, the Open Firmware Frame Buffer device, which is used as a fallback
for unsupported graphics cards.

What kernel version does Yellow Dog Linux 3.01 use? Does it include radeonfb?
Recent versions of radeonfb should recognize your Mobility Radeon 9200.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
