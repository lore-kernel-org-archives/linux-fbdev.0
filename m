From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Changing modes with fbset
Date: Tue, 06 Jan 2004 12:09:44 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073351384.781.202.camel@gaston>
References: <3FDBB97F.4070207@undead.cc>
	 <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
	 <20040106002822.GB442@guug.org> <1073349349.780.181.camel@gaston>
	 <20040106010852.GC442@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfkS-0003rJ-4Y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:11:08 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfkR-0001EE-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:11:07 -0800
In-Reply-To: <20040106010852.GC442@guug.org>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 
> Finding "coupled" cards could be as easy as checking if the fbdev
> api returns the same busid for both fbdev's.

That would work as long as you don't have a single PCI chip providing
2 separate independant sets of heads but I agree this is very unlikely :)

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
