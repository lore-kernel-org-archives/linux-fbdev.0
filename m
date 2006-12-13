From: James Cloos <cloos@jhcloos.com>
Subject: Re: drivers/video/aty/radeon_backlight.c
Date: Wed, 13 Dec 2006 10:32:13 -0500
Message-ID: <m3d56nlskr.fsf@lugabout.jhcloos.org>
References: <m3irgflxh4.fsf@lugabout.jhcloos.org>
	<20061213142930.GA12686@hansmi.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuW6O-0001cZ-48 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 07:33:00 -0800
Received: from ore.jhcloos.com ([64.240.156.239])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GuW6I-0004Dt-NU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 07:32:57 -0800
In-Reply-To: <20061213142930.GA12686@hansmi.ch> (Michael Hanselmann's message
	of "Wed\, 13 Dec 2006 15\:29\:30 +0100")
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
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Hanselmann <linux-kernel@hansmi.ch> writes:

JimC> Are there any dependencies in $subject which would preclude
JimC> changing drivers/video/Kconfig ....

Michael> Yes.

Ok. Thanks.

JimC> is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
JimC> even though the pmac routines are all ifdef'ed?

Michael> Did you actually test wether it works? As far as I know,
Michael> only Apple (PowerPC) hardware uses these registers yet
Michael> and have no use anywhere else.

No, I only noticed the file by coincidence and wanted to find out
about it before testing.

Thanks for the quick reply!

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
