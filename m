From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: color corruption (white becomes pink) in 16 bpp radeonfb
Date: Thu, 17 Jun 2004 07:39:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617053957.GA14087@middle.of.nowhere>
References: <20040617053137.GA14869@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapdQ-0007G2-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:40:24 -0700
Received: from smtp-out2.xs4all.nl ([194.109.24.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BapdP-00068L-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 22:40:24 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out2.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5H5eMOl082627
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 07:40:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20040617053137.GA14869@middle.of.nowhere>
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

From: Jurriaan <thunder7@xs4all.nl>
Date: Thu, Jun 17, 2004 at 07:31:37AM +0200
> when used at 16 bpp, any white in the picture becomes pink when using
> fbi to view some .jpgs on the console.
> This didn't happen with 2.6.7-rc3-mm2.
> 
> It also affects the bootup-penguins: there's a black background, and
> only a pink silhouette inside.
> 
> Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85
> 
Somehow, this seems linked to my other corruption problem. I just
rebooted 2.6.7 with David Eger's corruption-fix patch, and both fbi and
scrolling work fine @ 32 bpp. Perhaps 16 bpp itself is broken in some
way. However, 16bpp was working in 2.6.7-rc3-mm2.

Jurriaan
-- 
I do not want people to be agreeable, as it saves me the trouble of liking them.
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.09


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
