From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Mon, 1 Jul 2002 09:59:16 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207010957410.21874-100000@www.transvirtual.com>
References: <3D200B7D.7436FF5F@irisa.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17P4WK-0001sS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 09:59:24 -0700
In-Reply-To: <3D200B7D.7436FF5F@irisa.fr>
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
To: Romain Dolbeau <dolbeau@irisa.fr>
Cc: Sven Luther <luther@lambda.u-strasbg.fr>, linux-fbdev-devel@lists.sourceforge.net


> > still is problem with the copying of the text console data at bootup,
> > but apart from that everything is fine.
> >
> > Should i send over a patch for adding it to the Config.xxx files ?
>
> Please send me the patch, I'll submit them for inclusion

Good news. I already included Config.help and Config.in entries for the
PM3 driver. As a note please consider porting it over to the new fbgen
api. I'm going to removal the old fbgen code soon.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
