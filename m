From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: Framebuffer on modified Radeon 9500
Date: Sun, 11 May 2003 06:54:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030511045436.GB3898@middle.of.nowhere>
References: <E19Eean-0000NG-00@f25.test.onet.pl>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtpzilla3.xs4all.nl ([194.109.127.139])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19EirW-0004Km-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 May 2003 21:55:02 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtpzilla3.xs4all.nl (8.12.9/8.12.9) with ESMTP id h4B4sxQ2056652
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 May 2003 06:54:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E19Eean-0000NG-00@f25.test.onet.pl>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gutko@poczta.onet.pl
Cc: linux-fbdev-devel@lists.sourceforge.net

From: gutko@poczta.onet.pl <gutko@poczta.onet.pl>
Date: Sun, May 11, 2003 at 02:21:29AM +0200
> Hello,
> I'm trying to run (with no effect) radeonfb on X-power Radeon 9500 non pro 128mb, which I modified to 9700 non pro. Some time ago it was loud in internet about this mod. The matter was simple soldering to unlock additional 4 rendering pipes, and a bios change to change hardwane ID's. I took bios from Hercules R9700(non pro). 
> I tried radeonfb 0.1.8  and it always says: "cannot map FB". I tried vesafb and it doesn't print anything at all. I can use this card only in 80x25 mode on console. X works OK in any resolution, same Windows and all Windows games.

[fix your line-length, please. 72 chars is really enough]

How much memory do you have? If you have 1 gigabyte, does booting with
mem=512M help?

HTH,
Jurriaan
-- 
Evil Grin no. 13: <<<<<GRIN>>>>>
Debian (Unstable) GNU/Linux 2.5.69 4112 bogomips load av: 0.30 0.58 0.43


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
