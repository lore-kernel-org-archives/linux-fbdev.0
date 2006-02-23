From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Fri, 24 Feb 2006 10:15:21 +1100
Message-ID: <1140736521.8264.49.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
	 <1139952530.7903.31.camel@localhost.localdomain>
	 <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org>
	 <1140677458.8264.24.camel@localhost.localdomain>
	 <20060223223619.GA14458@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCPgF-000867-My
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 15:15:27 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FCPgE-000098-8R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 15:15:27 -0800
In-Reply-To: <20060223223619.GA14458@shaftnet.org>
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
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> And of course, OpenFirmware integration, and doing something with the 
> TMDS PLL information. 

Yeah. Also, I need to create some kind of table of known OpenFirmware
cards and their associated connector maping since unfortunately, the
firmware driver doesn't provide the information... But I'll do that
afterward.

> I'm unsure how to best to proceed from here, so this patch is it until 
> I get some more directed feedback.  

I'll review properly next week.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
