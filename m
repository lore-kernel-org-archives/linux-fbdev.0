From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
 style
Date: Thu, 4 Sep 2008 20:58:29 +0200
Message-ID: <20080904205829.024b7bfc.krzysztof.h1@poczta.fm>
References: <20080904123109.65A6C860CE7@f23.poczta.interia.pl>
	<200809041708.51439.juergen127@kreuzholzen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200809041708.51439.juergen127@kreuzholzen.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Juergen Beisert <juergen127@kreuzholzen.de>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Andrew Dyer <amdyer@gmail.com>, "linux-fbdev-users@lists.sourceforge.net" <linux-fbdev-users@lists.sourceforge.net>

On Thu, 4 Sep 2008 17:08:49 +0200
Juergen Beisert <juergen127@kreuzholzen.de> wrote:

> On Donnerstag, 4. September 2008, krzysztof.h1@poczta.fm wrote:
> > > On Mittwoch, 3. September 2008, Krzysztof Helt wrote:
> > > > On Tue,  2 Sep 2008 13:24:51 +0200
> > > >
> > > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > ---
> > > > >  drivers/video/imxfb.c |   70
> > > > > +++++++++++++++++++++++------------------------- 1 files changed, 34
> > > > > insertions(+), 36 deletions(-)
> > > >
> > > > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > >
> > > > One offtopic comment: do you really want the FBINFO_READS_FAST set?
> > > >
> > > > It means that the driver prefer copyarea to imgblit function. It is
> > >
> > > Did you ever get the framework to use the copyarea function the driver
> > > provides? I tried it several times and this function was never called.
> > > Independent from any flags I set or clear.
> > >

The minimum is to set the flag FBINFO_HWACCEL_COPYAREA
into fb_info->flags. If you do not announce the accelerated copyarea
function it is not used (the imageblit is preferred).
If you defined both flags FBINFO_HWACCEL_IMAGEBLIT and
FBINFO_HWACCEL_COPYAREA you have to specify the
FBINFO_READS_FAST to prefer the copyarea. As no of this flag is
set in the imxfb driver the imageblit is used.

> 
> > I did used the copyarea on some other drivers (tridentfb, pm2fb).
> 
> How did you use them?
> 

Simply, the console use them for scrolling. The tridentfb still
uses the copyarea for scrolling on families other then Blade3d. 

> > The tdfxfb driver uses now copyarea function for console scrolling.
> 
> Are you sure, this function will be called? 

Yes. I can recheck if you want, but there is a measurable speed difference 
if you define FBINFO_READS_FAST or not on the 3Dfx hardware.

Please check this threads:
http://marc.info/?l=linux-fbdev-devel&m=117852288316471&w=2
http://marc.info/?l=linux-fbdev-devel&m=117852288316471&w=2

and some threads around. Since then the copyarea is much faster.

> I wrote two drivers for ARM and 
> x86 graphics hardware and provide a copyarea function for both of them. The 
> console framework ignores both. Only the fillrect and imageblit function is 
> used from the frambuffer console code.
> 
The imageblit is preferred over copyarea is it is usually faster. The fillrect 
is always used.

> In driver/video/console/fbcon.c I always fail in function fbcon_scroll(). 
> The "dir" switch/case never reaches one of the "switch (p->scrollmode)" 
> statements.
> 

Please check the constants mentioned above and try again.

Regards,
Krzysztof


----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
