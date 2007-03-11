From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/3] sstfb: fix pixclock setting on
	Voodoo 1/2 cards
Date: Sun, 11 Mar 2007 21:03:00 +0800
Message-ID: <1173618180.5806.0.camel@daplas>
References: <45F3D87F.10805@gmail.com>
	<20070311043638.901c3f42.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HQNg8-0000ca-Fp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 06:01:36 -0700
Received: from wx-out-0506.google.com ([66.249.82.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HQNg7-0002Ky-2W
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 06:01:36 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2034087wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Mar 2007 06:01:34 -0700 (PDT)
In-Reply-To: <20070311043638.901c3f42.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: santiago@mail.cz, linux-fbdev-devel@lists.sourceforge.net

On Sun, 2007-03-11 at 04:36 -0800, Andrew Morton wrote:
> These three patches look 2.6.21ish to me?

They are safe for 2.6.21.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
