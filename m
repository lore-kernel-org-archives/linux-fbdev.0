From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 09:50:39 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040311095039.07a5c857.akpm@osdl.org>
References: <1078454250.6327.47.camel@gaston>
	<Pine.LNX.4.44.0403111715030.5408-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1Uce-0005mD-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:09:32 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1UKu-0001Lh-Cl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 09:51:12 -0800
In-Reply-To: <Pine.LNX.4.44.0403111715030.5408-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: benh@kernel.crashing.org, kronos@kronoz.cjb.net, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons <jsimmons@infradead.org> wrote:
>
> On Fri, 5 Mar 2004, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2004-03-05 at 09:31, James Simmons wrote:
> > > Ug. I applied the fix. I will be pushing the new monitor code as soon as 
> > > ben sends me bugs he found as well.
> > 
> > I don't have anything with the fbmon at this point. The problems I
> > have are local to radeonfb, you can go & push that update
> 
> Okay. Then I will send the patch to andrew. The patch is pretty big.
> You can grab it at 
> 
> http://pheonix.infradead.org/~jsimmons/monitor.diff

         ^^^^^^^  phoenix

> Also you can take a look and comment. Its against 2.6.4.

What's it do?


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
