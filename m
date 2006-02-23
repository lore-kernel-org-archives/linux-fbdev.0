From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700
	(M26) and ATOM bios support
Date: Thu, 23 Feb 2006 17:50:58 +1100
Message-ID: <1140677458.8264.24.camel@localhost.localdomain>
References: <20060103204404.GA23313@shaftnet.org>
	 <1139952530.7903.31.camel@localhost.localdomain>
	 <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCAJe-00062c-Mc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 22:51:06 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FCAJd-00016M-GO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Feb 2006 22:51:06 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k1N6fcWG030897
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 00:41:39 -0600
In-Reply-To: <20060223060939.GA27224@shaftnet.org>
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


> And to follow up to myself, here is a third patch.  I've started 
> incorporating bits and pieces from the "oooold" non-working rewrite 
> that you sent me for inspiration.  Changes from last patch:
> 
>  * Naming cleanups
>  * Merge the OpenFirmware PLL detection into the function pointer mess.
>  * Merge the oooold patch's legacy bios connector parsing code, As the 
>    original stuff didn't really do anything anyway, I don't see the harm.  
>  * Merge the ooold patch's atom bios connector parsing code, but it still 
>    doesn't work yet.  It's late and my eyes hurt.
> 
> The good news is that I'm typing this using this patch on my Radeon 
> M26 (mmm.. 1680x1050!), but the bad news is that I don't know if the 
> legacy BIOS code works, especially the connector parsing stuff.
> 
> Let me know if I'm going down the right path.  The RadeonFB driver is 
> pretty complicated, so I'm trying to take baby steps as I figure more 
> of it out.

From your comments, you sound on the right track. I haven't had time to
review the patches yet but I'll do asap, I'm very happy somebody is
tackling those issues :)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
