From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: Does framebuffer support 24 bit colors?
Date: Sat, 19 Jun 2004 06:51:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040619045156.GA4038@middle.of.nowhere>
References: <40D395B8.4040808@integrated-devices.com>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbXqA-0007VE-PE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 21:52:30 -0700
Received: from smtp-out5.xs4all.nl ([194.109.24.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbXqA-0005Te-8q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 21:52:30 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out5.xs4all.nl (8.12.10/8.12.10) with ESMTP id i5J4qRUY074448
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 06:52:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <40D395B8.4040808@integrated-devices.com>
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
To: Srinivasa Deevi <sdeevi@integrated-devices.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Srinivasa Deevi <sdeevi@integrated-devices.com>
Date: Fri, Jun 18, 2004 at 06:24:08PM -0700
> Hi all
> 
> does frame buffer support 24 bit colors ? What should I do to make it 
> work with 24 colors pixels in LCD ?
> 
Depends on the framebuffer. Matrox does for sure, radeonfb doesn't, for
others, check the source.

Jurriaan
-- 
It is forbidden to kill; therefore all murderers are punished unless they kill
in large numbers and to the sound of trumpets.
        Voltaire - War
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.02


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
