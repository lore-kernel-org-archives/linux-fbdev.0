From: James Simmons <jsimmons@infradead.org>
Subject: Re: Negative screen coords in putcs?
Date: Mon, 8 Sep 2003 23:48:34 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309082348200.17059-100000@phoenix.infradead.org>
References: <Law15-F63omP0l0HQFD0000c593@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wZ4q-0006bX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 20:22:00 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19wUoz-0003SR-OI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Sep 2003 15:49:21 -0700
In-Reply-To: <Law15-F63omP0l0HQFD0000c593@hotmail.com>
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
To: Cheshire Cat Fish <cat_fish@hotmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


??? How is that happening?


On Sun, 7 Sep 2003, Cheshire Cat Fish wrote:

> 
> Should putcs get negative Y values?
> 
> I am getting calls with 'yy' less than 0, and I am wondering if I have 
> screwed something up, or if that is correct, how I should handle them?
> 
> Thanks,
> Noel
> --
> A precariously balanced mixture of myopic optimism and rampant paranoia.
> 
> _________________________________________________________________
> Get a FREE computer virus scan online from McAfee. 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
