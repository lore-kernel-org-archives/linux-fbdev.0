From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Radeon 2D Acceleration for 2.6
Date: Fri, 23 Jan 2004 13:19:31 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1074824371.976.173.camel@gaston>
References: <Pine.LNX.4.50L0.0401201543490.1525-200000@rosencrantz.pok.ibm.com>
	 <1074638876.793.47.camel@gaston>
	 <Pine.LNX.4.50L0.0401210008080.16594-100000@rosencrantz.pok.ibm.com>
	 <1074820975.367.179.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ajqwk-0008Ao-2b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Jan 2004 18:21:22 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Ajqwj-0006St-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Jan 2004 18:21:21 -0800
In-Reply-To: <1074820975.367.179.camel@thor.asgaard.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: random <eger-temp_addy-1075244930.6ef584@theboonies.us>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-01-23 at 12:22, Michel D=E4nzer wrote:
> On Wed, 2004-01-21 at 00:09, random wrote:=20
> >=20
> > +void radeonfb_prim_fillrect(struct radeonfb_info *rinfo,=20
> > +                       const struct fb_fillrect *region)
> > +{
> > +	radeon_fifo_wait(4); =20
> > + =20
> > +	OUTREG(DP_GUI_MASTER_CNTL, =20
> > +		rinfo->dp_gui_master_cntl  /* contains, like GMC_DST_32BPP */
> > +                | GMC_BRUSH_SOLID_COLOR
> > +                | ROP3_P);
> > +	OUTREG(DP_BRUSH_FRGD_CLR, region->color);
> > +	OUTREG(DP_WRITE_MSK, 0xffffffff);
>=20
> You could probably take this out of the acceleration functions, you
> don't seem to need a different write mask?

Yes, we could factor this one out

> > +	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
> > +
> > +	radeon_fifo_wait(2); =20
> > +	OUTREG(DST_Y_X, (region->dy << 16) | region->dx);
> > +	OUTREG(DST_WIDTH_HEIGHT, (region->width << 16) | region->height);
> > +	radeon_engine_idle ();
>=20
> Why idle the engine in every acceleration function? Doesn't the API
> provide a way to only do it when necessary?

I don't do it in the patch I commited to my tree :) There is an fb_sync
callback that you use for that.

> PS: You lost my last reply to your private mails to your temporary
> address scheme.

And you'll lose mines too, please get rid of this shit and get a real
address :)

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
