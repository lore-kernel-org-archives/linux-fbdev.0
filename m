From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] Fix switch from XFree
Date: Tue, 10 Feb 2004 12:06:22 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210110622.GA1913@lambda>
References: <1076409397.873.6.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVij-0002Z8-45
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:06:25 -0800
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0401.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVio-0001xE-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:06:31 -0800
Content-Disposition: inline
In-Reply-To: <1076409397.873.6.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Feb 10, 2004 at 09:36:42PM +1100, Benjamin Herrenschmidt wrote:
> Hi James !
> 
> (This patch includes the one adding the lock around the notifier
> registration so you can drop that previous one)
> 
> Currently, there is a problem when switching from XFree to a console
> that became especially annoying now that we have some accelerations
> in radeonfb 2.6. XFree leaves the accel engine in a state that is
> incorrect for our accel operations. This problem is generic with most
> drivers, we can't expect X to leave the accel engine in the right
> state, that's simply unrealistic.

Mmm, i wonder about this. The X driver is supposed to be responsible for
saving and reseting the engine when leaving/entering. This is usually
done in a separate way when using or not using fbdev.

Now, if we are going to save/restore the contect too, then this would
mean a risk of dual saving the engine state. Or maybe the X server
doesn't really save the context, but just reinitialize it when entering.

I have the feeling that more working together would be helpfull, or
maybe setup a proper policy for X/fbdev to handle this properly.

Maybe the fbdev driver could set a flag or something, which would tell
the X server that it is taking charge of saving/restoring the accel
engine, so the X driver would not try doing this too, at least in the
UseFBDev case (but do we care about the other case ?).

Friendly,

Sven Luther


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
