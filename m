From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Thu, 17 Jun 2004 11:34:18 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1087490056.8697.253.camel@gaston>
References: <200406160406.07060.adaplas@hotpop.com>
	 <200406161353.51195.adaplas@hotpop.com>
	 <20040616173429.GA8601@havoc.gtf.org>
	 <200406170629.09691.adaplas@hotpop.com>
	 <20040617001634.GA6013@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaztD-0004dp-9d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 09:37:23 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BaztB-0002XM-CW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 09:37:21 -0700
In-Reply-To: <20040617001634.GA6013@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-06-16 at 19:16, David Eger wrote:

> > Yeah, even with XOrg/Free86 nv driver, it hangs.  Don't really know the
> > exact solution, probably a complete re-initialization of the hardware
> > when switching from X.  But this will require that fbcon recognizes
> > a switch from X itself which it currently doesn't (unless I'm mistaken).
> 
> Back in February, BenH said he was going to work on a patch for this:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.2/0247.html
> 
> Hey Ben, what ever became of this?  Are there now hooks for this or 
> something?

Last time I played with nv & rivafb (a loooong time ago), I found out
the hangs were caused by some weirdness with the manipulation of the
endian flip register and got that working. The problem I've been working
on for restoring console is different, and has to do with forcing a
call to set-par when coming back from KD_GRAPHICS mode. That is already
upstream (though I noticed some X driver still mess with the HW after
the switch back, like the radeon one)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
