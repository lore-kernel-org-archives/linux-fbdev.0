From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 18:06:00 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403111804410.5794-100000@phoenix.infradead.org>
References: <20040311095039.07a5c857.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1UrF-0008TH-2R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:24:37 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B1U9j-0007PM-Ab
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 09:39:40 -0800
In-Reply-To: <20040311095039.07a5c857.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, kronos@kronoz.cjb.net, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


Various fixes and enhancements to the monitor hardware detection code.
The only driver that uses it is the radeon driver. Give it a try before 
you apply it.


On Thu, 11 Mar 2004, Andrew Morton wrote:

> James Simmons <jsimmons@infradead.org> wrote:
> >
> > On Fri, 5 Mar 2004, Benjamin Herrenschmidt wrote:
> > 
> > > On Fri, 2004-03-05 at 09:31, James Simmons wrote:
> > > > Ug. I applied the fix. I will be pushing the new monitor code as soon as 
> > > > ben sends me bugs he found as well.
> > > 
> > > I don't have anything with the fbmon at this point. The problems I
> > > have are local to radeonfb, you can go & push that update
> > 
> > Okay. Then I will send the patch to andrew. The patch is pretty big.
> > You can grab it at 
> > 
> > http://pheonix.infradead.org/~jsimmons/monitor.diff
> 
>          ^^^^^^^  phoenix
> 
> > Also you can take a look and comment. Its against 2.6.4.
> 
> What's it do?
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
