From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb doesn't work with an ati X800	pcie
	card
Date: Thu, 12 Apr 2007 08:11:54 +1000
Message-ID: <1176329514.8061.106.camel@localhost.localdomain>
References: <46093D22.3090401@gmx.net> <461BD18E.5020706@gmx.net>
	<461CD1F7.40004@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hbl3P-0006xA-H6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 15:12:39 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+HxvmjfJiwU10IQGmSkqBPQsyhGAdtwao=])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hbl3O-00084X-1C
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 15:12:39 -0700
In-Reply-To: <461CD1F7.40004@gmx.net>
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
To: Jimmy.Jazz@gmx.net
Cc: kofboy@163.com, kronos.it@gmail.com, linux-fbdev-devel@lists.sourceforge.net, pizza@shaftnet.org

On Wed, 2007-04-11 at 14:17 +0200, Jimmy Jazz wrote:
> Hello,
> 
> i sent it without care and i forgot to add some diff files you will have 
> to apply to radeonfb.h, ati_ids.h and radeon_base.c with both 
> radeon_accel.c and radeon_monitor.c patches. Otherwise, you won't be 
> able to compile the kernel anymore. Sorry for the inconvenient.
> 
> Thank you all of you who contributed to these patches, the initiator of 
> the radeonfb driver and of course the Xorg team who made ATI cards 
> compatible with the xorg server.

There are already patches from Solomon for Atom BIOSes.

I admit that I never found the time to fully cleanup, split, test,
etc... those along with other fixes I have in my queue. I could use a
co-maintainer for radeonfb...

Ben.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
