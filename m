From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Wed, 16 Mar 2005 01:28:53 +0000
Message-ID: <1110936533.5511.22.camel@africa.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <1110670230.19810.51.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBNLG-0002HJ-R8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:28:58 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBNLF-000397-Do
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:28:58 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id DC5FBE9
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:28:54 -0500 (EST)
Received: from 192.168.1.13 (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CF728F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:28:54 -0500 (EST)
In-Reply-To: <1110670230.19810.51.camel@gaston>
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

On Sun, 2005-03-13 at 10:30 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2005-03-12 at 14:06 +0000, Torgeir Veimo wrote:
> > This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb.
> > A small test application is attached at the end. This patch is against
> > vanilla 2.6.11. 

> The patch definitely needs a lot of cleanups. A few things are wrong
> too, like using test_and_set_* as a mean of locking. This doesn't work
> on relaxed ordering architectures.
> 
> Besides, the entire fbdev subsystem is protected by the console
> semaphore, so you shouldn't need anything else. You need to acquire it
> yourself in the driver ioctl() routine though.
> 
> In order to avoid conflicting with other apps, you should probably
> "abort" the operation if a console switch happens while you are waiting.
> That is, a set_var() and/or a blank(). Return -EINTR or something like
> that.

Do you have any example code I can look at for this? From what I can see
neither the atyfb or matroxfb drivers do this. Not that I'm claiming
they're correct, I guess the current vanilla kernel source is a bit
behind the latest and greatest fb development. 

-- 
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
