From: James Simmons <jsimmons@infradead.org>
Subject: Re: Mirrored Display?
Date: Tue, 7 Jan 2003 21:18:12 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072117130.17129-100000@phoenix.infradead.org>
References: <1041175846.1210.10.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W17d-0005xE-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 13:18:53 -0800
In-Reply-To: <1041175846.1210.10.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Michael Kaufmann <kaufmann@sohard.de>, Linux-fbdev-devel@lists.sourceforge.net


> > I'm know a litte bit amazed about a rotation feature in next versions. Does 
> > this mean, that the buffer where user apps (or also the console) are writing 
> > there picture data is not directly the videobuffer anymore? Or how does this 
> > rotation feature works?
> I think the rotation hooks are console specific.  

Actually the low level drivers can use the hooks.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
