From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer overflow halts network (fwd)
Date: Wed, 12 Feb 2003 20:01:44 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122001240.31435-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301281033390.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j35H-0006By-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:02:19 -0800
In-Reply-To: <Pine.GSO.4.21.0301281033390.9269-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Leif Neland <leif@neland.dk>


> Sorry to bother you "privately", but I can't find much info of the use of
> framebuffer after it is installed.
> 
> I have set up my primary work machine (i.e. it is mostly used as a terminal
> to connect to other servers) with framebuffer and have 64 lines*160 chars in
> a pretty font.
> 
> I ssh to other servers from this machine.
> 
> If I do something which create a lot of output, eg. ls -lR /, the remote
> machine sends more data than the framebuffer-terminal can handle. This
> blocks the network on the terminal machine, which also is nameserver,
> internal webserver and upsd server.
> 
> Is it possible to set up some sort of flow control, so the remote machine
> stops when the terminal is overloaded?
> 
> Both servers are 100Mb, on different switches, which are connected at 100Mb
> The terminal is on a Cisco, the other on a cheaper 24ports switch.
> 
> If you can't help me, can you direct me in the proper direction?

Which kernel are you using and whcih video card?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
