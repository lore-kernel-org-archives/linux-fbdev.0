From: Mike Wolfram <wolfram@microdatec.de>
Subject: Endianess problem in fbcon and cfbimgblt when
	using monochrome fb
Date: Mon, 2 Oct 2006 14:03:32 +0200
Message-ID: <200610021403.33691.wolfram@microdatec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GUMW7-0004Nx-8J for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Oct 2006 05:03:27 -0700
Received: from moutng.kundenserver.de ([212.227.126.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GUMW6-0001iv-IE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Oct 2006 05:03:27 -0700
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


Hi,

I have written a framebuffer driver for an Epson SED1335 based LCD for the ARM 
platform. The LCD is monochrome, so the driver currently only supports 1 bpp. 
The ARM is little-endian.

Everything works fine except when using the fbcon. All text printed to that 
console appears with having each character mirrored on the y axis. So it 
looks like an endian problem.

I found a message from April ("[patch 19/26] fbcon: Fix big-endian bogosity in 
slow_imageblit()") which fixes a problem for big-endian machines. After 
reverting that patch and changing

#define FB_BIT_NR(b)              (b)

to

#define FB_BIT_NR(b)              (7 - (b))

the text appears as expected. So my question is if the patch might be wrong 
and should only change the defines for FB_BIT_NR? Or could the problem be 
somewhere else?

Regards,
Mike Wolfram
-- 
MicroDatec GmbH
Zeulenrodaer Str. 17, 99091 Erfurt, Germany
fon +49-361-77821-0, fax +49-361-77821-30
mobile +49-179-4902190

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
