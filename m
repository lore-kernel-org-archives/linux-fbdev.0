From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 10:30:30 +1100
Message-ID: <1110670230.19810.51.camel@gaston>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAG4Y-0000vg-R8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:31:06 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAG4X-0002LY-9u
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:31:06 -0800
In-Reply-To: <1110636406.5997.86.camel@atlantis.netenviron.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Torgeir Veimo <torgeir@pobox.com>

On Sat, 2005-03-12 at 14:06 +0000, Torgeir Veimo wrote:
> This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb.
> A small test application is attached at the end. This patch is against
> vanilla 2.6.11.
> 
> Signed-off-by: Torgeir Veimo <torgeir@pobox.com>

Please, put patches inline in the mail, not as attachment, it makes
dealing with them simpler and possible to quote them with any mailer.

The patch definitely needs a lot of cleanups. A few things are wrong
too, like using test_and_set_* as a mean of locking. This doesn't work
on relaxed ordering architectures.

Besides, the entire fbdev subsystem is protected by the console
semaphore, so you shouldn't need anything else. You need to acquire it
yourself in the driver ioctl() routine though.

In order to avoid conflicting with other apps, you should probably
"abort" the operation if a console switch happens while you are waiting.
That is, a set_var() and/or a blank(). Return -EINTR or something like
that.

Ben.






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
