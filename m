From: Ian Campbell <icampbell@arcom.com>
Subject: Re: Re: [PATCH] PXA255 LCD Driver
Date: Sat, 20 Mar 2004 11:24:45 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079781564.3076.30.camel@localhost>
References: <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4eaz-0003kc-KQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 03:24:53 -0800
Received: from mta08-svc.ntlworld.com ([62.253.162.48])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4eay-00008Q-Lk
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Mar 2004 03:24:52 -0800
Received: from cthulhu.hellion.org.uk ([80.6.127.103])
          by mta08-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20040320112447.DFYJ5004.mta08-svc.ntlworld.com@cthulhu.hellion.org.uk>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sat, 20 Mar 2004 11:24:47 +0000
In-Reply-To: <Pine.LNX.4.44.0403192352580.14905-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

> Is this the case for your setup or is this something true in general.

I'm not entirely sure -- I know it's true in my case, I have a feeling
it's true in general (apart from things like the CPLDs that Russell
mentioned).

> I like to add data fields that could be used by everyone.

I totally agree -- as I said in my reply to Russell I don't want to come
up with a solution which is only useful to me!

> Are these the fields you need in general?

I believe so -- although as I said I'm not 100% about it. I really need
input from people who have experience with lcd controllers on other
architectures than StrongArm and XScale.

> We can have it so that we can pass in a monitor string that can be used to 
> select the proper LCD panel in the database. How does that sound?

It sounds great, if we can work out which extra settings are needed

Ian.
-- 
Ian Campbell



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
