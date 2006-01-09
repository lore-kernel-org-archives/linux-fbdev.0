From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Mon, 09 Jan 2006 17:38:56 +1100
Message-ID: <1136788737.20511.3.camel@localhost.localdomain>
References: <1133944427.7168.70.camel@gaston> <43989DA3.8070602@gmail.com>
	 <1134080257.11760.19.camel@gaston> <4398B995.6000903@gmail.com>
	 <1134287682.6989.49.camel@gaston>
	 <1136773933.30123.100.camel@localhost.localdomain>
	 <20060108191311.00ab5dba.akpm@osdl.org>
	 <1136780002.12377.1.camel@localhost.localdomain>
	 <20060108214324.0fc93c39.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvqfO-0007uL-HQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 22:38:06 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EvqfN-0007pd-1C
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 22:38:06 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k096VoWG026285
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Jan 2006 00:31:52 -0600
In-Reply-To: <20060108214324.0fc93c39.akpm@osdl.org>
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

On Sun, 2006-01-08 at 21:43 -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > Anyway, all of the above patches apply OK to whatever is in git-powerpc so
> > > I spose we can just merge git-powerpc and be happy.  Soon, I hope - I have
> > > a few things held up by that tree.
> > 
> > We are working on it.
> > 
> 
> hm, OK.
> 
> You now shrink-dentry-struct-spufs-fix.patch, which I'll resend.

Ok. Paulus is just only back from vacation, so we have a big backlog of
stuffs. Hopefully he'll have something for Linus to pull tonight or
tomorrow.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
