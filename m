From: Pete Popov <pete_popov@yahoo.com>
Subject: Re: PATCH
Date: 22 Feb 2004 11:03:53 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077476633.9577.226.camel@localhost.localdomain>
References: <1077410677.9577.4.camel@localhost.localdomain>
	 <20040222160829.GA1522@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuyzW-0001ty-LL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 11:10:14 -0800
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuysL-0000PC-Ue
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 11:02:49 -0800
In-Reply-To: <20040222160829.GA1522@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2004-02-22 at 08:08, Kronos wrote:
> Il Sat, Feb 21, 2004 at 04:44:37PM -0800, Pete Popov ha scritto: 
> > diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/Config.in linux-2.4-dev/drivers/video/Config.in
> > --- linux-2.4-orig/drivers/video/Config.in	2004-01-13 21:51:28.000000000 -0800
> > +++ linux-2.4-dev/drivers/video/Config.in	2004-02-21 16:19:24.000000000 -0800
> > @@ -159,6 +159,7 @@
> >  	    bool '    SIS 300 series support' CONFIG_FB_SIS_300
> >  	    bool '    SIS 315/330 series support' CONFIG_FB_SIS_315
> >  	 fi
> > +	 bool '  SiliconMotion 501 Driver' CONFIG_FB_SMI501
> >  	 tristate '  NeoMagic display support (EXPERIMENTAL)' CONFIG_FB_NEOMAGIC
> >  	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
> >  	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1
> 
> Why bool? It doesn't work as a module?

It hasn't been tested as a module that I know of. If the driver is
otherwise acceptable for inclusion in 2.4, I'll test it as a module if
necessary.

Pete



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
