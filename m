From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 18:44:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049215444.593.115.camel@zion.wanadoo.fr>
References: <20030401152209.91116.qmail@web14913.mail.yahoo.com>
	 <1049214320.1174.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147] ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190QMp-0004Kc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 10:20:15 -0800
Received: from amarseille-201-1-6-134.abo.wanadoo.fr ([80.11.137.134]:10070 helo=zion.wanadoo.fr)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 190QMI-0001B8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 10:19:42 -0800
In-Reply-To: <1049214320.1174.68.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Actually, using a combination of functions that will be available in
> fbmon.c, the fbdev driver will become independent from userland, such as
> /etc/fb.modes. User-entered timings are still preferred thoug, and only
> when the timings are invalid that the driver will select the nearest
> mode from the database, or calculate one for it.  A theoretical sequence
> will be like this:
> 
> 1. driver rounds off values in var
> 2. timings in var is validated using fb_validate_mode()
> 3. if timings are valid, driver accepts the new timings
> 4. if timings are invalid, it checks if monitor is GTF capable.
> 5. if monitor is GTF capable, it calls fb_get_mode(). 
> 6. if monitor is not GTF capable, it calls fb_find_mode(), passing the
> database created from fb_create_modedb().
> 
> Fbdev needs this independence from userland in order for stty to work,
> primarily, and to make it easier for the user, secondarily.
> 
> You're correct though that it's a good idea to pass a list of modelines
> to userland.  However, the filtering is best done by the driver because
> it has the best knowledge on the limits/capabilities of the chipset.

How do you fit in this picture using scaled modes ? Typically, LCDs
only really using their "native" mode, but any lower-sized mode can
be obtained using the scaler (I've just fixed bugs in radeonfb for
that btw). In this case, what list do we "propose" to userland ?
A list of 'standard' well known modes in addition to the native one ?

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
