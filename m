From: David Eger <eger@havoc.gtf.org>
Subject: Re: Sane behavior of fbset
Date: Fri, 18 Jun 2004 13:38:40 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040618173840.GA3989@havoc.gtf.org>
References: <200406180945.12444.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbNKC-0004ks-Rh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 10:38:48 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbNKC-0007tY-IF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 10:38:48 -0700
Content-Disposition: inline
In-Reply-To: <200406180945.12444.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jun 18, 2004 at 09:45:12AM +0800, Antonino A. Daplas wrote:
> Hi,
> 
> Currently, using fbset either corrupts the display, or at worst, hangs the GPU.  I consider
> this a critical bug.  I don't want to discuss the pros/cons of using fbset vs stty to
> change the console size, but we need to make sure that using fbset (or any utility
> that utilizes the fb_set_var ioctl) does not produce undefined behavior.  There are 
> at least 3 possibilities:
> 
> 1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has a notifier 
> support. (I already have working code for this). Of course, stty will still work.

Just for my enlightenment, could you give a synopsis of 2.4 behavior
versus 2.6 behavior?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
