From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Changing modes with fbset
Date: Tue, 06 Jan 2004 12:38:52 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073389131.25197.30.camel@thor.asgaard.local>
References: <3FDBB97F.4070207@undead.cc>
	 <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
	 <20040106002822.GB442@guug.org>  <1073349349.780.181.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdpY0-0002EN-TC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 03:38:56 -0800
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdpY0-0006zx-BO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 03:38:56 -0800
In-Reply-To: <1073349349.780.181.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Otto Solares <solca@guug.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-01-06 at 01:35, Benjamin Herrenschmidt wrote:
> On Tue, 2004-01-06 at 11:28, Otto Solares wrote:
> >=20
> > Hi James! now that you are back again, i would like to suggest
> > a modification to fbdev core, i am having problems guessing
> > which card is attached to a fb device.  I need this info to
> > solve the 'more than 1 card' situation.  This could be easily
> > fixed if the fbdev api provides the busid of the card, like
> > "pci:0000:01:0.0".  That would solve a lot of things in the
> > HAL detection routines.  Maybe that could be exported via
> > sysfs but i have been waiting for sysfs for a while and don't
> > see it coming to a reality.  Maybe an ioctl is enough.
>=20
> Right, we need that and some way to know which heads are "coupled" for
> dual head drivers. One of the reasons I haven't done dual head support
> in radeonfb yet is that to get it working properly with X, I need to
> update X too, and add a way for X to know which /dev/fb's are actually
> "together" as 2 heads of the same card.
>=20
> Then, we probably want some way to also enable mirroring instead of
> dual head...

Crazy idea: What would break if it defaulted to mirroring? :) You could
achieve true multihead via panning or something...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
