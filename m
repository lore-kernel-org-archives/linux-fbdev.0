From: David Eger <eger@havoc.gtf.org>
Subject: Re: Sane behavior of fbset
Date: Fri, 18 Jun 2004 23:16:50 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040619031650.GC14319@havoc.gtf.org>
References: <200406180945.12444.adaplas@hotpop.com> <20040618173840.GA3989@havoc.gtf.org> <200406190240.26228.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbWO2-000883-Q5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 20:19:22 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbWO2-0007Zr-Ej
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 20:19:22 -0700
Content-Disposition: inline
In-Reply-To: <200406190240.26228.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net, jsimmons@infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Jun 19, 2004 at 02:40:46AM +0800, Antonino A. Daplas wrote:
> 
> In 2.6
> 
> 1. If you use fbset, you will get screen corruption or hang the GPU
> 
> 2. stty will do the function of fbset.  However, stty will only pass rows and 
> cols (xres and yres respectively).  There is no information for bit depth, 
> timings, virtual resolution, etc.
> 

So *this* is what's going on with my port of the cirrusfb driver--why fbset 
wasn't working... for radeonfb fbset still works in 2.6, so i didn't realize 
there was this problem... What's so wonky with the fbset code path that 
screws things up? and why does stty work?

heck, in this case, I'm of the mind to just send the cirrusfb update 
upstream...  James?  you ever test the patch on your hardware?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
