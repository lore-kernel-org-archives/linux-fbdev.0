From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Problem about FB on an iBook G4
Date: Sat, 2 Oct 2004 16:59:54 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410021657100.11545@waterleaf.sonytel.be>
References: <3535634202.3420235356@huawei.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDlNn-0007Xp-2P
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 08:01:11 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CDlMj-0003yR-Ea
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 08:01:10 -0700
In-Reply-To: <3535634202.3420235356@huawei.com>
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

On Sat, 2 Oct 2004, jiangning 39481 wrote:
> > The radeonfb in that kernel may be too old for your Radeon. What 
> > does `lspci
> > -v' say?
> > 
> Part of 'lspci -v' I think useful are as follows:
> 00:0b.0 Host bridge:Apple Computer Inc.UniNarth 2 AGP
>             Flags:bus master,66Mhz,medium devsel,latency 16
> 00:10.0 VGA compatible controller:ATI Technologies Inc:Unknown devce 5c63 (rev 01) (prog-if 00 [VGA])

This Radeon chip is not even recognized by the latest radeonfb in 2.6.9-rc3.

Gr{oetje,eeting}s,

						Geert

P.S. Please don't remove linux-fbdev-devel@lists.sourceforge.net from the CC
     list.
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
