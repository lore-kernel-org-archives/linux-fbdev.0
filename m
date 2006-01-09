From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Mon, 09 Jan 2006 15:13:21 +1100
Message-ID: <1136780002.12377.1.camel@localhost.localdomain>
References: <1133944427.7168.70.camel@gaston> <43989DA3.8070602@gmail.com>
	 <1134080257.11760.19.camel@gaston> <4398B995.6000903@gmail.com>
	 <1134287682.6989.49.camel@gaston>
	 <1136773933.30123.100.camel@localhost.localdomain>
	 <20060108191311.00ab5dba.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvoeT-0003HE-G9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 20:29:01 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EvoeS-0005yF-4s
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Jan 2006 20:29:01 -0800
In-Reply-To: <20060108191311.00ab5dba.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com


> Gad.  It looks like a variant of Ben's patch is in the powerpc tree.  wtf
> is it doing there?

What's going on is that the powerpc tree contains that patch bcs it
contains all the necessary bits to boot a new g5 and that includes it.
However, paulus is currently cooking a merged tree for linus with all of
that stuff, but not the nvidiafb patch since it's not the proper way to
get it in sneaked inside a powerpc merge ;)

> Anyway, all of the above patches apply OK to whatever is in git-powerpc so
> I spose we can just merge git-powerpc and be happy.  Soon, I hope - I have
> a few things held up by that tree.

We are working on it.

> Tell Paul to grovel appropriately to Linus when he sends it though -
> putting non-arch stuff into an arch tree tends to upset him.  

Well, that's why we aren't sending it to Linus ourselves... I'll send it
back to you separately.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
