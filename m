From: Jurriaan <thunder7@xs4all.nl>
Subject: color corruption (white becomes pink) in 16 bpp radeonfb
Date: Thu, 17 Jun 2004 07:31:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617053137.GA14869@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapV9-0005ei-PL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:31:51 -0700
Received: from smtp-out5.xs4all.nl ([194.109.24.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BapV9-0005yk-7x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:31:51 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out5.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5H5VoUY028495
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 07:31:50 +0200 (CEST)
Content-Disposition: inline
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
Cc: linux-kernel@vger.kernel.org

when used at 16 bpp, any white in the picture becomes pink when using
fbi to view some .jpgs on the console.
This didn't happen with 2.6.7-rc3-mm2.

It also affects the bootup-penguins: there's a black background, and
only a pink silhouette inside.

Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85

Jurriaan
-- 
8)  "Marketing Statistics":  How to claim 99% of the people sent your
spam LIKED it because only 10 people out of 1000 complained, (even
though you hijacked a server and made it near impossible to trace or
reply to).
	'Top ten seminars at an upcoming DMA conference' as seen in nanae
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.32


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
