From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: Re: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Wed, 1 Mar 2006 17:56:34 +0100
Message-ID: <20060301165633.GG17561@boogie.lpds.sztaki.hu>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain> <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org> <1140677458.8264.24.camel@localhost.localdomain> <20060223223619.GA14458@shaftnet.org> <1140736521.8264.49.camel@localhost.localdomain> <20060301033338.GA20460@shaftnet.org> <1141184789.4157.30.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEUcz-0005bQ-V0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 08:56:42 -0800
Received: from boogie.lpds.sztaki.hu ([193.225.12.226])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FEUcy-0008FQ-FF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 08:56:42 -0800
Content-Disposition: inline
In-Reply-To: <1141184789.4157.30.camel@localhost.localdomain>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Stuffed Crust <pizza@shaftnet.org>

On Wed, Mar 01, 2006 at 02:46:29PM +1100, Benjamin Herrenschmidt wrote:

> In fact, a mix of both might do the trick... module/kernel argument for
> a default override and sysfs for "live" override ?

Nowadays you can use sysfs to both display and modify module parameters,
so making use of that would be the best.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
