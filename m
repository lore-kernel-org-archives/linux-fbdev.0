From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 00:59:30 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404290056050.3125-100000@phoenix.infradead.org>
References: <1083195769.20089.106.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIyxk-0002NZ-Jl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:59:36 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIyxk-0001df-6a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:59:36 -0700
In-Reply-To: <1083195769.20089.106.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>



>  That also means we move all of mode management to
> userland, which I tend to slowly agree with. Remember that in 2.7, we
> may have an initramfs with klibc etc... thus we can have userland code
> shipping along with the kernel.

Wow!!!!! Linux is going to end up a micro kernel after all. We could move the 
tcp stack and even all the filesystems to userland as well. The kernel will
shrink to such a small size. Then bus setup could be done in userland. All 
we need to do is setup the cpu. No more device drivers.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
