From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 02 Apr 2003 00:25:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049214320.1174.68.camel@localhost.localdomain>
References: <20030401152209.91116.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190Ods-0000iE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 08:29:44 -0800
In-Reply-To: <20030401152209.91116.qmail@web14913.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 23:22, Jon Smirl wrote:
> > 
> > 5. fb_get_mode(int flags, int val, struct
> > fb_var_screeninfo *var, struct
> > fb_info *info)
> > 
> > - compute mode timings using GTF (refresh driven,
> > hsync driven, pixclock
> > driven, or maximized refresh) and place result in
> > var
> > 
> > #4 and #5 are already in fbmon.c
> >
> 
> Wouldn't it be better to make fb_get_mode only return
> the list of valid modes based on the hardware and
> monitor (if available) combination rather than letting
> the app sort it out?

Actually, using a combination of functions that will be available in
fbmon.c, the fbdev driver will become independent from userland, such as
/etc/fb.modes. User-entered timings are still preferred thoug, and only
when the timings are invalid that the driver will select the nearest
mode from the database, or calculate one for it.  A theoretical sequence
will be like this:

1. driver rounds off values in var
2. timings in var is validated using fb_validate_mode()
3. if timings are valid, driver accepts the new timings
4. if timings are invalid, it checks if monitor is GTF capable.
5. if monitor is GTF capable, it calls fb_get_mode(). 
6. if monitor is not GTF capable, it calls fb_find_mode(), passing the
database created from fb_create_modedb().

Fbdev needs this independence from userland in order for stty to work,
primarily, and to make it easier for the user, secondarily.

You're correct though that it's a good idea to pass a list of modelines
to userland.  However, the filtering is best done by the driver because
it has the best knowledge on the limits/capabilities of the chipset.

BTW:  fb_get_mode() will only compute a single modeline (using GTF). 
It's fb_create_modedb() that will make a list of video modes.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
