From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 10:36:06 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083112565.20473.10.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BId9J-0006lS-JN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:42:05 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BId9H-0001EG-HX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:42:03 -0700
In-Reply-To: <20040428002037.GE22495@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-28 at 10:20, Otto Solares wrote:
> On Wed, Apr 28, 2004 at 09:10:55AM +1000, Benjamin Herrenschmidt wrote:
> > Jon Smirl has been working on embedded mesa & moving DRI outside of
> > X. Unfortunately, last I heard, he was still on his trip of re-inventing
> > everything including replacing the fbdev's with his own stuff instead
> > of moving from what we have ...
> 
> Ooops! that will break my software that relies on fbdev and                                                                                                                       
> mesa-solo!

Well, I'm sure there is some good in what he is doing too, I don't 
have time to deal with that at the moment, it would be interesting
to synchronise properly though.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
