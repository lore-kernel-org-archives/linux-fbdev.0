From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [patch 0/4] Cell SPE logos
Date: Fri, 13 Jul 2007 12:05:19 +0200
Message-ID: <200707131205.20399.arnd@arndb.de>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070712160621.644d78d2.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9I3n-0001q7-Vr for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 03:07:40 -0700
Received: from moutng.kundenserver.de ([212.227.126.187])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9I3m-0004Nb-CS
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 03:07:39 -0700
In-Reply-To: <Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: cbe-oss-dev@ozlabs.org
Cc: James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

On Friday 13 July 2007, Geert Uytterhoeven wrote:
> > > Summaries:
> > > =A0 [1] fbdev: extract fb_show_logo_line()
> > > =A0 [2] fbdev: Add fb_append_extra_logo()
> > =

> > This one does give additional code and data to all fbdev users while on=
ly
> > being useful to cell machines. =A0Should we fix that?
> =

> I can protect it by #ifdef CONFIG_PPC_CELL (as long as there are no other
> users). Would that be OK?

If you want to have an #ifdef in there, it should probably be
CONFIG_FB_EXTRA_LOGO and have that autoselected by CONFIG_SPU_BASE.

A nicer alternative to the #ifdef might be to mark it __init, so
that it will just go away after boot. Not sure if that's safe
though.

	Arnd <><

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
