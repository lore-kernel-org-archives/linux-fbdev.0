From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 11:23:41 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083201820.20474.119.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
	 <1083191201.18413.73.camel@thor.asgaard.local>
	 <20040429010725.GD24584@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ0Nd-0002Rl-TP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:30:25 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BJ0Nd-0004pp-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:30:25 -0700
In-Reply-To: <20040429010725.GD24584@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1254"
To: Otto Solares <solca@guug.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-04-29 at 11:07, Otto Solares wrote:
> On Thu, Apr 29, 2004 at 12:26:41AM +0200, Michel D=E4nzer wrote:
> > Why? The purpose of the DRM lock is arbitration and state management
> > between DRM clients. It's not necessarily connected to direct hardwar=
e
> > access.
>=20
> Agree, fbdev is too low-level to use the lock.

Yes and No. We _DO_ need an arbitration mecanism between fbdev (or
whoever changes the mode) and other "clients" like DRI and the DRI
lock would be well suited for that too. Right now, you can very easily
lockup the whole box solid by just sending a mode switch down to the
fbdev while DRI is active.

And since the model we are aiming too is just that: sending mode
switches at any time and have all clients adapt properly, we need a
solution for that. One of the reasons is hotplug displays. The hotplug
is equivalent to a mode switch in this regard and will happen whatever
the card is doing.
=20
> > A small low-level driver could handle this, which both the framebuffe=
r
> > device and the DRM use. Linus has proposed this approach, and I must =
say
> > I like it.
>=20
> That should be fbdev without fbcon.

Yes, except that I'd like to see most of the mode list processing moved
to userland. But I agree that the low level driver could/should be fbdev
without the accel hooks. Those are really fbcon specific accel hooks,
I would even like to separate it from the fbdev completely. In that sense=
,
fbcon would just be another "client" of the framebuffer. But in this rega=
rd
too, we need some arbitration.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
