From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 00/11] ps3av/3fb patches for 2.6.25
Date: Sat, 26 Jan 2008 22:01:39 -0800
Message-ID: <20080126220139.5385f2c7.akpm@linux-foundation.org>
References: <20080125150623.202631389@vixen.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ0aO-00005Q-A7 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:48 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JJ0aN-00048b-VQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:01:44 -0800
In-Reply-To: <20080125150623.202631389@vixen.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, adaplas@gmail.com

> On Fri, 25 Jan 2008 16:06:23 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> Hare are the ps3av/fb patches for 2.6.25:

I would have to say: it's a bit late to be submitting things of this nature
for 2.6.25.  Given the mess everyone has made of everything there's little
chance that I'll be able to do a 2.6.24-mm1 so this stuff basically goes
into mainline without public testing.

I don't think many people care much about ps3 so whatever.  But if it were
core code or a popular driver then I would probably slip this back to
2.6.26.


We haven't heard from Tony in a while so I guess I'm fbdev maintainer
again.  Be afraid.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
