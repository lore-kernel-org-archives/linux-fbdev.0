From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 13:16:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066389397.662.228.camel@gaston>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston>
	 <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston>
	 <20031017111032.GB1639@casa.fluido.as>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AASg9-0006vm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 04:21:58 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AASet-0005GO-8f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 04:20:39 -0700
In-Reply-To: <20031017111032.GB1639@casa.fluido.as>
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Aha... So, from what you know, is there any possibility (fb, X, X with
> ATI drivers, anything else) to use the video output (or the second
> head) of radeon cards under Linux? And have you tried your drivers
> with 2 cards (one PCI and one AGP)?

I haven't tried with 2 cards, no. It's possible to do dual head
with XFree.

> And in all cases, why is parameter "mode" not working? If I could set
> 1280x1024-32@60 from Lilo, most of my problems would be solved...

I'll check that out. The new module parameter thing isn't that good,
I think I'll revive the old stuff for a while.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
