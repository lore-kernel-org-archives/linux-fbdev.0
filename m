From: "Greg Haerr" <greg@censoft.com>
Subject: Re: [PATCH] FBDev: vga16fb port
Date: Wed, 4 Dec 2002 21:40:37 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <0ad001c29c20$d704fcb0$6401a8c0@gregnewport>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 42dbce0a.leased.aros.net ([66.219.206.10] helo=censoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Jolo-0000mP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Dec 2002 21:41:56 -0800
Received: from [63.206.141.80] (account greg@viewml.com HELO gregnewport)
  by censoft.com (CommuniGate Pro SMTP 3.4.2)
  with ESMTP id 1997744 for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Dec 2002 22:41:03 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net


> I question whether thats something that belongs anywhere near the
> kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
> combines very nicely with the fb driver.

> Out of curiousity where is this library.

BOGL is referenced at http://www.msu.edu/user/pfaffben/projects.html
but I think it's not maintained anymore.  I used BOGL originally,
and used it for a complete rewrite of a VGA16 driver for Microwindows,
with a C version for Linux framebuffer..
See http://microwindows.org Source Code for more details.

Regards,

Greg
Founder & Maintainer, The Microwindows Project



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
