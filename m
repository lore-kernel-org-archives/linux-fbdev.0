From: James Simmons <jsimmons@infradead.org>
Subject: Re: Radeonfb in 2.5.54bk
Date: Tue, 7 Jan 2003 22:26:09 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072224350.17129-100000@phoenix.infradead.org>
References: <20030107161954.GB15405@kanoe.ludicrus.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W2BH-0001ib-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:26:44 -0800
In-Reply-To: <20030107161954.GB15405@kanoe.ludicrus.net>
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
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Cc: linux-fbdev-devel@lists.sourceforge.net


> My 2.5.54 build instantly switches to the right res, 1024x768. However
> I do see all the initial junk on the screen. Everything else seems to
> work well, however. Does the initial junk show up on other fb devices?
> The same junk would show up in 2.5.54 release but it would switch resolutions
> and kill init.

Hm. I never ran into the intial junk stuff. I have had issues when going 
from vgacon at 80x30 to neofb at 160x48. The resize didn't change the data 
in struct vc_data. The latest patch shoudl fix that.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
