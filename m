From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev trees
Date: Tue, 18 May 2004 17:06:12 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405181659190.12310-100000@phoenix.infradead.org>
References: <1084859674.15182.28.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ76e-00044K-Vn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 09:06:16 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BQ76e-0001P7-II
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 May 2004 09:06:16 -0700
In-Reply-To: <1084859674.15182.28.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



fbdev-2.6 is the stuff that is know to work with no problems. It's intent 
was to push it to linus. It ended up that patches instead go to Andrew 
Morton which then test them and then passes them to linus. So that tree is 
not really needed. As for the fbdev-2.5 tree, it is the main test bed for 
the latest patches. There was a bug that should now be fixed. I will be 
sending some more important patches to Andrew very soon. The issue with 
resizing via stty is now fixed. 
 

> Hi James !
> 
> I'm trying to follow you tree but I'm lost. It seems you have both an
> fbdev-2.5 and an fbdev-2.6 tree containing completely different code
> bases. I used to sync a local tree with fbdev-2.5 but it stopped working
> completely with one of your latest code drops of last week. Today I
> noticed you had fbdev-2.6 too, but with what seem older version of some
> stuffs (or am I confused ?)
> 
> So which is which ?
> 
> Ben.
> 
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
