From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] neofb patches
Date: Fri, 30 Apr 2004 01:12:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083280337.8281.181.camel@thor.asgaard.local>
References: <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
	 <1083191201.18413.73.camel@thor.asgaard.local>
	 <20040429010725.GD24584@guug.org>
	 <1083243672.18413.148.camel@thor.asgaard.local>
	 <20040429175201.GA26608@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJKhb-0000Xl-VB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 16:12:23 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJKha-00038l-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 16:12:22 -0700
In-Reply-To: <20040429175201.GA26608@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="utf-8"
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-04-29 at 19:52, Otto Solares wrote:
> On Thu, Apr 29, 2004 at 03:01:13PM +0200, Michel Dänzer wrote:
> > On Thu, 2004-04-29 at 03:07, Otto Solares wrote:
> > > On Thu, Apr 29, 2004 at 12:26:41AM +0200, Michel Dänzer wrote:
> > > 
> > > > A small low-level driver could handle this, which both the framebuffer
> > > > device and the DRM use. Linus has proposed this approach, and I must say
> > > > I like it.
> > > 
> > > That should be fbdev without fbcon.
> > 
> > I'm not sure that works: keep in mind that the DRM works on other OSs
> > than Linux, and even on Linux some people may want to use the DRM
> > without a framebuffer device. Neither should be a problem with a minimal
> > base driver which does nothing more than hardware resource management
> > and arbitration.
> 
> Differents OSs have differents sources for DRM kernel side so
> that's not a problem nor will affect others OSs than linux.

Nope. Most of the code in the DRI CVS drm module is shared between OSs.
Most of the shared code is hardware specific though, so if you change
the interface to the hardware, either all the OSs will have to provide
the new interface, or the code can no longer be shared, which would get
us back to the code duplication horrors. I'd very much like to avoid
that.


> Yes, a minimal driver would do the work _NOW_.

Why wouldn't it in the future?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
