From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Wed, 01 Mar 2006 14:46:29 +1100
Message-ID: <1141184789.4157.30.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
	 <1139952530.7903.31.camel@localhost.localdomain>
	 <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org>
	 <1140677458.8264.24.camel@localhost.localdomain>
	 <20060223223619.GA14458@shaftnet.org>
	 <1140736521.8264.49.camel@localhost.localdomain>
	 <20060301033338.GA20460@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEIIN-0008B7-Ng
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Feb 2006 19:46:35 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FEIIN-0004JF-Ff
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Feb 2006 19:46:35 -0800
In-Reply-To: <20060301033338.GA20460@shaftnet.org>
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


> I basically have two chunks of remaining code to write:
> 
> 1) The OpenFirmware stuff, which basically requires some re-jiggering of 
>    arguments passed in and return codes.  

Or just write a small howto and I will do the job :) I've been very busy
lately mostly due to my newborn child, thus I didn't help more than
that, but I'm really interested in your work. I also want to bring along
a bunch of fixes like the memory mapping fixes I've been doing on X.org
radeon driver recently.

> 2) User-specified layout code isn't smart enough to try the secondary 
>    connectors if the primary connectors don't have anything connected.
>    (This could be lessened by extending the syntax to explicitly state 
>     CRT,CRT2,DFP,DFP2,etc..)

Agreed. (And X too btw ...)

In fact, we need a way to provide the driver with the full connector
mapping I think, in case it can't be obtained from the firmware.

> Then there's the big open question of how we should allow the user
> to override the connector table, in case we mis-detect or don't have a
> table to begin with.  If we have DDC enabled we can build a 
> connector table by probing all DDC ports, using the existing logic. 

module option is the easy/cheap way but sucks in some ways... sysfs per
device instance is nice but a bit "too late" unless we have a way for
the driver to re-probe... which is a good thing to have anyway since we
might finally deal with screen hotplug :)

In fact, a mix of both might do the trick... module/kernel argument for
a default override and sysfs for "live" override ?

I would however not bother too much at the moment with that. Let's get
the rest working first

> Thoughts?
> 
> (This work builds on the radeon-atom-4 patch, and is definately in the 
>  "heavily experimental" stage.  I'll post a patch once I have time to 
>  clean it up and fix the first two points)

Thanks.

I'll look at your stuff in more detail asap and will then let it simmer
in -mm if I'm happy enough for at least a kernel version...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
