From: jiangning 39481 <jiangnuts@huawei.com>
Subject: Re: Problem about FB on an iBook G4
Date: Sat, 02 Oct 2004 11:07:18 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3535634202.3420235356@huawei.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDlL3-0006nL-LE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 07:58:21 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDlJw-0002lA-KC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 02 Oct 2004 07:58:21 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i92Ev8Mp015054
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 2 Oct 2004 16:57:08 +0200 (MEST)
Content-language: zh-CN
Content-Disposition: inline
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.61.0410021657060.11545@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>

> The radeonfb in that kernel may be too old for your Radeon. What 
> does `lspci
> -v' say?
> 
Part of 'lspci -v' I think useful are as follows:
00:0b.0 Host bridge:Apple Computer Inc.UniNarth 2 AGP
            Flags:bus master,66Mhz,medium devsel,latency 16
00:10.0 VGA compatible controller:ATI Technologies Inc:Unknown devce 5c63 (rev 01) (prog-if 00 [VGA])
            Subsystem:ATI Technologies Inc:Unknown device 5c63
            Memory at 90000000 (32bit,non-prefetchable)[siu=6k]
            Expansion ROM at 90020000[disabled][size=128k]
            Capabilities:[58] AGP version 2.0
            Capabilities:[50] Power Management version 2


'mplayer -vo cvidix xxx.avi' output:
[radeon] Found chip:RV250 5c63 [Radeon Mobility 9200 M9+]
[radeon] Device is disabled,ignoring
vosub_vidix:Couldn't find working VIDIX driver

'mplayer -vo fbdev xxx.avi' output:
Can't put VSCREENINFO

'fbset -i' output:
...
Frame buffer device information:
Name:OFfb ATY,Via_A
Address:0x9c008000
size:789432
Type:Packed PiXELS
Visual:PSEUDOCOLOR
...
ACCELERATOR:NO

And I tried 'video=offb:off video=radeon:1024x768-32',I only got a frazed screen and I could type 'reboot' just to reboot.
Is this caused by someting in Open Firmware or old kernel as you said?




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
