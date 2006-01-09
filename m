From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Sun, 8 Jan 2006 21:43:24 -0800
Message-ID: <20060108214324.0fc93c39.akpm@osdl.org>
References: <1133944427.7168.70.camel@gaston>
	<43989DA3.8070602@gmail.com>
	<1134080257.11760.19.camel@gaston>
	<4398B995.6000903@gmail.com>
	<1134287682.6989.49.camel@gaston>
	<1136773933.30123.100.camel@localhost.localdomain>
	<20060108191311.00ab5dba.akpm@osdl.org>
	<1136780002.12377.1.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvqEy-0006uw-Kf
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 22:10:48 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EvqEx-0005QK-8A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 22:10:48 -0800
In-Reply-To: <1136780002.12377.1.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > Anyway, all of the above patches apply OK to whatever is in git-powerpc so
> > I spose we can just merge git-powerpc and be happy.  Soon, I hope - I have
> > a few things held up by that tree.
> 
> We are working on it.
> 

hm, OK.

You now shrink-dentry-struct-spufs-fix.patch, which I'll resend.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
