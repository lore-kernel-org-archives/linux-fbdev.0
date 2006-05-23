From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Wed, 24 May 2006 05:43:05 +0800
Message-ID: <447381E9.4060705@gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fief1-0004LQ-1a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 14:43:27 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fieey-0005qL-6x
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 14:43:27 -0700
Received: by py-out-1112.google.com with SMTP id z59so2001343pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 14:43:22 -0700 (PDT)
In-Reply-To: <447359B8.7020304@iit.demokritos.gr>
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
Cc: vasvir@iit.demokritos.gr

Vassilis Virvilis wrote:
> Vassilis Virvilis wrote:
>> Hi,
> 
>> The problem at hand is savagefb. The specific model is 0x5333:0x8d01
>> (twisterP).
>> I am using a recent enough kernel and I am trying to use fb through SDL.
>>
> [snip]
> 
> Any ideas on how should I proceed to make the S3 savage work with my
> monitors,
> and preferably with any monitor?
> 
> For example since X / Bios combination works is it possible to get into
> the right
> mode and then dump the registers somehow for examination or for later
> feeding?
> 

If you can somehow dump the registers of the working and non-working mode,
we might be able find a pattern.

If you don't know how to dump the register contents, let me know and I'll
send you a userspace utility to do that.

> Is it possible for the kernel driver to use Bios switching?
> 

Currently, no.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
