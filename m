From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ATI Rage XL with no BIOS support
Date: Fri, 24 Feb 2006 14:52:13 +1100
Message-ID: <1140753133.8264.75.camel@localhost.localdomain>
References: <dc70db7d0602211329j71a441edg5778e91e012d1299@mail.gmail.com>
	 <43FB7BF2.6020506@Sun.COM>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCU0C-0006SQ-2Z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 19:52:20 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FCU0A-0008CB-Qi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 19:52:20 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k1O3glWG021596
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 21:42:48 -0600
In-Reply-To: <43FB7BF2.6020506@Sun.COM>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2006-02-21 at 12:45 -0800, Jay Cotton wrote:
> Basically you are screwed.
> 
> There is a way to fix this, but the code is closed source and ATI will not
> allow it out of there control.  So, unless you can read the bios prom
> into memory and execute the first 1024 bytes in 16bit mode, you will not
> be able to recover.

First 1024 bytes ? hrm... that isn't much... doesn't seem to work much
for me. I have a board with a Rage Mobility, ATI gave us a BIOS image,
I've tried running it in an x86 emulator (it's a ppc machine) to no
avail so far. That BIOS appears to be mucking around with all sort of
things not directly related to the actual video chip, like strange IO
ports all around the legacy space (more than just the timers) etc...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
