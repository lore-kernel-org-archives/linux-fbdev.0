From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Sane behavior of fbset
Date: Sat, 19 Jun 2004 14:13:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406191413.28339.adaplas@hotpop.com>
References: <200406180945.12444.adaplas@hotpop.com> <200406190240.26228.adaplas@hotpop.com> <20040619031650.GC14319@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ6K-0005eg-8x
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:13:16 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ6J-0001aP-Uu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:13:16 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 7E9C670952
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 05:12:10 +0000 (UTC)
In-Reply-To: <20040619031650.GC14319@havoc.gtf.org>
Content-Disposition: inline
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
To: David Eger <eger@havoc.gtf.org>, jsimmons@infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 19 June 2004 11:16, David Eger wrote:
> On Sat, Jun 19, 2004 at 02:40:46AM +0800, Antonino A. Daplas wrote:
> > In 2.6
> >
> > 1. If you use fbset, you will get screen corruption or hang the GPU
> >
> > 2. stty will do the function of fbset.  However, stty will only pass rows
> > and cols (xres and yres respectively).  There is no information for bit
> > depth, timings, virtual resolution, etc.
>
> So *this* is what's going on with my port of the cirrusfb driver--why fbset
> wasn't working... for radeonfb fbset still works in 2.6, so i didn't
> realize there was this problem... What's so wonky with the fbset code path
> that screws things up? and why does stty work?

The flow of fbset is upstream:  fbset->fbdev->fbcon->vc (2.4 code)
The flow of stty is downstream: stty->vc->fbcon->fbdev (2.6 code)

I don't know how radeonfb does it though.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
