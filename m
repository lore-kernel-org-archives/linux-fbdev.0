From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Twister savagefb doesn't sync
Date: Wed, 24 May 2006 06:04:59 +0200
Message-ID: <4473DB6B.8090307@t-online.de>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fikbu-0007PX-0j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 21:04:38 -0700
Received: from mailout04.sul.t-online.com ([194.25.134.18])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fikbr-0006K4-IN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 21:04:38 -0700
In-Reply-To: <447381E9.4060705@gmail.com>
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
Cc: vasvir@iit.demokritos.gr


>If you can somehow dump the registers of the working and non-working mode,
>we might be able find a pattern.
>
>If you don't know how to dump the register contents, let me know and I'll
>send you a userspace utility to do that.
>
>  
>
>>Is it possible for the kernel driver to use Bios switching?
>>
>>    
>>
>
>Currently, no.
>
>  
>
Vassilis,

Try http://dev.gentoo.org/~spock/projects/vesafb-tng/ for a
vesafb that supports bios mode switching and dump the regs
if it works for you.

cu,
 Knut


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
