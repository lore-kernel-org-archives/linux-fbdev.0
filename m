From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Wed, 24 May 2006 14:38:28 +0300
Message-ID: <447445B4.3030105@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <4473DB6B.8090307@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FircH-0008Ih-TH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 04:33:29 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FircG-0003W1-HS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 May 2006 04:33:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id 8612C932C2
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 May 2006 14:33:22 +0300 (EEST)
Received: from zeus.iit.demokritos.gr ([127.0.0.1])
 by localhost (zeus [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10168-07 for <linux-fbdev-devel@lists.sourceforge.net>;
 Wed, 24 May 2006 14:33:19 +0300 (EEST)
Received: from [192.168.3.146] (unknown [192.168.3.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id E037D93278
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 May 2006 14:33:19 +0300 (EEST)
In-Reply-To: <4473DB6B.8090307@t-online.de>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:

>>
> Vassilis,
> 
> Try http://dev.gentoo.org/~spock/projects/vesafb-tng/ for a
> vesafb that supports bios mode switching and dump the regs
> if it works for you.
> 

Knut, thanks for answering...
I can use X to set the mode. X driver uses BIOS unless told
otherwise (UseBios = false) so the two solutions should be
equivalent. If this fails I will try vesafb-tng.

        .bill


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
