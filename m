From: Zack <plinius@comcast.net>
Subject: fbui 0.4e ready (formerly fbdraw)
Date: Fri, 17 Sep 2004 12:51:16 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <414B4034.2060006@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8Ojh-0002Fp-CF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 12:49:37 -0700
Received: from sccrmhc13.comcast.net ([204.127.202.64])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C8Oje-0003Fz-Qt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 12:49:37 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hello all,

I've renamed fbdraw to fbui. It's located here:
http://home.comcast.net/~plinius

Changes include:

1. added routines such as draw string, copy area, put RGB pixels
2. the library libfbui buffers commands for increased speed
3. >1 programs can share each virtual console
4. VC switching works
5. the library includes my PCF font reader

Current size is 10kB.

Enjoy,
Zack


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
