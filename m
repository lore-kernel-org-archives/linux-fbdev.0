From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb_console_init fix.
Date: Sat, 21 Feb 2004 09:56:56 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077317816.9623.20.camel@gaston>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuJlI-0004K1-FU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 15:08:48 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AuJfC-0002GW-JX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 15:02:30 -0800
In-Reply-To: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
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
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2004-02-21 at 08:58, James Simmons wrote:
> Hi!
> 
>   This patch fixes fb_console_init from being called twice. I still need 
> to fix set_con2fb but this helps but this is still important to get in.

I hate those #ifdef MODULE. They are plaguing the drivers too, because
of our crazy initialization scheme...

(Linus: that patch should still go in, doing better is probably a
2.7 target in this case).

If we want the fb stuff to be initialized before other drivers, we
probably want to create an init step before devices and after PCI
probe, but is that really necessary ?

The core fbdev should just need a subsys initcall. fbcon could use
that too and register a notifier. Then we could use the notifier
mecanism to notify fbcon when fbdev's are added (from
register_framebuffer) and get rid of all of the init crap

The only remaining junk is to deal with the setup= stuff, but
then, it could be done by having the drivers provide their
"name" string & setup function in the ops structure passed
on register, and have us call back the driver straight away,
though that's a big change of the way drivers are initialized.

Or we could add an fb_check_setup("name", my_driver_setup) call
to be done by the drivers before register_framebuffer is called


Ben
.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
