From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Radeon support (Was: Re: (no subject))
Date: Tue, 6 Aug 2002 17:22:13 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10208061718580.9820-100000@sorrow.ashke.com>
References: <Pine.LNX.4.33.0208061601110.17601-100000@softpixel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pcp103897pcs.glstrt01.nj.comcast.net ([68.45.109.175] helo=sorrow.ashke.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cBmb-0007Hb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 14:22:25 -0700
In-Reply-To: <Pine.LNX.4.33.0208061601110.17601-100000@softpixel.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Christopher P Wright <softpixel.com>" <cwright@softpixel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


I thought that might be a possibility, too, except that the same monitor
works with the same applications when connected to the DVI output on the
7500 with the adapter.  So apparently the application isn't switching to
an unsupported frequency.

I might try to get the app to dump the registers anyway, though.

Thanks for the response.

Oh, and sorry for sending an e-mail without a subject to the list.

Adam

On Tue, 6 Aug 2002, Christopher P Wright <softpixel.com> wrote:

> i dont develop many fb drivers, but it sounds like the video out dfb sets
> your card to is out of sync range (causing the monitor to ignore it rather
> than toast itself).  perhaps see what the clocks are being set to, and
> maybe check configuration of dfb (i havnt used that in a while now, so i
> dont know too much about it)
> 
> if possible, get some app to dump your card's registers while the screen
> is blanked.  then send this to dfb developers, amybe they will be able to
> see what is getting done improperly.
> 
> best of wishes on getting this fixed,
> chris
> 
> ---
> if you got the will
> and you got the skill
> then you take a step.
> - Master Phung
> 
> 
> 
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
