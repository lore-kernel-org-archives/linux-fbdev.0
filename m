From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: status
Date: Tue, 26 Nov 2002 00:39:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211260035490.3307-100000@phoenix.infradead.org>
References: <1038260153.1027.26.camel@skalman>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18GTm8-00021w-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Nov 2002 16:40:29 -0800
In-Reply-To: <1038260153.1027.26.camel@skalman>
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
To: Johan Bolmsjo <johan@nocrew.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> For what it's worth, the interleaved modes on atari works like this:
> 
> The bitplanes are interleaved on 16 bit big-endian word basis so if you
> have two bitplanes, bit 0 of the first 16 pixels would be in the first
> 16 bit word in the display memory, bit 1 of the first 16 pixels would be
> in the second word. With bit 0 I mean as masked out by & 0x0001 in C,
> and bit 1 as masked out by 0x0002.
> 
> The Atari ST line support three resolutions by default:
> 320x200 4 bit planes
> 640x200 2 bit planes
> 640x400 1 bit plane

Okay I have been think about the other modes and can't figure out how they 
would work. Could you do a run down to get my hamster running?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
