From: Stefan Reinauer <stepan@suse.de>
Subject: Re: Rage128 as secondary adapter
Date: Thu, 9 Jan 2003 19:39:21 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030109183921.GB21501@suse.de>
References: <20030109174706.1471.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.suse.de ([213.95.15.193] helo=Cantor.suse.de)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WhaO-0007Kk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 10:39:24 -0800
Content-Disposition: inline
In-Reply-To: <20030109174706.1471.qmail@web14907.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

* Jon Smirl <jonsmirl@yahoo.com> [030109 18:47]:
> Can someone with access to the Rage128 documentation
> tell me how to do this from protected mode? I have the
> ROM mapped so the code can get to constants stored in
> the ROM. What I need is a piece of C code equal to
> what the ROM initialization does minus the part about
> Int10 vector setup.
 
I'm almost certain that the information you need is only
available when signing an NDA and thus could not be used
in open source drivers. Also a big problem for open source
firmware implementations such as openbios

> The programmers at ATI probably have a piece of code
> available to do this since ATI's Windows driver can do
> it.  I've tried emailing and signing up as a developer
> without response.
 
This is a pretty common experience.

Stefan.

-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
