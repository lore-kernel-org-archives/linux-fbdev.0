From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5 vs. aty128fb & radeonfb
Date: Sat, 27 Jul 2002 13:10:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207271308180.17619-100000@www.transvirtual.com>
References: <20020727135953.7916@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17YXtd-0004HM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Jul 2002 13:10:37 -0700
In-Reply-To: <20020727135953.7916@192.168.4.1>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ani Joshi <ajoshi@shell.unixbox.com>


> Hi !
>
> Does somebody plans to update 2.5 with versions of these drivers that
> at least build ? They have been broken for ages now.
>
> If not, then I'll do my own fixing and submit that.

Sorry about that. Pretty soon, next few days, I'm going to be submitting
changes to the fbdev layer which breaks any driver not converted over to
the new fbdev api. It needs to be done.


P.S

   Since the console system can use IRQ/DMA based modes for graphics cards
it would be nice to the ati 128 card converted over to use the CCE engine
:-)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
