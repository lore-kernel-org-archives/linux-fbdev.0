From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 9 Sep 2003 18:18:21 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org>
References: <1062960554.647.34.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wm8R-0005Q3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 10:18:35 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19wm8Q-0008NX-25
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 10:18:34 -0700
In-Reply-To: <1062960554.647.34.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kronos@kronoz.cjb.net, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > Yup, there is much "polish" still needed on the exit/cleanup path,
> > > though I'm waiting to see what you come up with putting class_device
> > > in there :)
> > 
> > edid1  and edid2  will be  attached to  the class_device,  they will  be
> > unregistered before the "release". The problem will go away.
> > 
> > Btw, the class_device stuff won't go in, it's too late. I'll maintain it
> > off tree and submit around 2.6.2.
> 
> I don't think it's too late... on the other hand, James is still sitting
> on a bunch of patches (hey James !) that should get in asap now...

Its not to late. The fbdev layer has bug fixes that need to go in.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
