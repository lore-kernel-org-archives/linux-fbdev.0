From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev upstream
Date: Tue, 6 Jan 2004 00:47:42 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401060042030.7347-100000@phoenix.infradead.org>
References: <3FE9F9C3.20605@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfNr-00083V-QK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:47:47 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdfNr-000471-8H
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:47:47 -0800
In-Reply-To: <3FE9F9C3.20605@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> on the list and myself can try it out.  I'm running fbcon on the radeon 
> machine but I went back to VGA for the nvidia machines as the hardware 
> cursor bug makes it unusable for any kind of text editing work.  I'll 
> switch back on those machines when that bug is squashed.

Endian issue for the nvidia card. I have been tracking that bug down. I 
should have a fix very soon.
 
> Agreed.  Let's get what we have rock solid before we try to break it 
> again.  :)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
