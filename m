From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Tue, 23 May 2006 21:51:36 +0300
Message-ID: <447359B8.7020304@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FibuB-0006Ga-T5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 11:46:55 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FibuC-000658-0p
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 11:46:56 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FibuA-00028z-Ju
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 11:46:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id 4AF5A929F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 21:46:30 +0300 (EEST)
Received: from zeus.iit.demokritos.gr ([127.0.0.1])
 by localhost (zeus [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14169-06 for <linux-fbdev-devel@lists.sourceforge.net>;
 Tue, 23 May 2006 21:46:28 +0300 (EEST)
Received: from [192.168.3.146] (unknown [192.168.3.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by zeus.iit.demokritos.gr (Postfix) with ESMTP id A5BB492642
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 21:46:28 +0300 (EEST)
In-Reply-To: <44698356.80806@iit.demokritos.gr>
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

Vassilis Virvilis wrote:
> Hi,

> The problem at hand is savagefb. The specific model is 0x5333:0x8d01 
> (twisterP).
> I am using a recent enough kernel and I am trying to use fb through SDL.
> 
[snip]

Any ideas on how should I proceed to make the S3 savage work with my monitors,
and preferably with any monitor?

For example since X / Bios combination works is it possible to get into the right
mode and then dump the registers somehow for examination or for later feeding?

Is it possible for the kernel driver to use Bios switching?

Any help / suggestion is greatly appreciated.

     .bill


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
