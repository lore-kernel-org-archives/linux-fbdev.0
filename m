From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] rivafb sync polarity problem?
Date: Fri, 24 Jan 2003 19:39:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301241939270.31541-100000@phoenix.infradead.org>
References: <1042980943.12192.34.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18c9gk-0008WE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 11:40:30 -0800
In-Reply-To: <1042980943.12192.34.camel@h9n1fls20o980.telia.com>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ani Joshi <ajoshi@shell.unixbox.com>


> The patch below tries to set the proper polarity. The mode still doesn't
> work though, since misc_output already is 0xEB by default. I don't know
> if the patch is wrong or which additional problems the rivafb driver
> might have with the mode.

Applied. I'm about to test these new patches.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
