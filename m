From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Subject: Re: dirty artefacts on bootup
Date: Thu, 08 Dec 2005 23:12:27 +0100
Message-ID: <1134079947.5549.6.camel@home.sweethome>
References: <1133871927.5595.8.camel@noti> <1133903112.7168.50.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkTzu-0004Y0-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:12:18 -0800
Received: from mail3.netbeat.de ([193.254.185.27])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EkTzs-0003Tw-QU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:12:18 -0800
In-Reply-To: <1133903112.7168.50.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: linux-fbdev-devel@lists.sourceforge.net

I'm not familiar with the code of the driver, but if you had any hints,
i would like to try them out.
I have the suspicion, that there is something written to the registers
which shouldn't.
Is there any initialising function, that is called, when X starts ?
We then could try to call it earlier during boot up.

Dirk


Am Mittwoch, den 07.12.2005, 08:05 +1100 schrieb Benjamin Herrenschmidt:
> On Tue, 2005-12-06 at 13:25 +0100, Dirk Henning Gerdes wrote:
> > Hi Benjamin,
> >=20
> > I'm using the radeon framebuffer driver on a sony-notebook with a rad=
eon
> > 9200 mobile.
> >=20
> > During bootup I get dirty artefacts on the screen.=20
> > It's hard to explain. The text first is clear on the screen, but then
> > there come so many dirty lines on top of it, that you cannot read
> > anything.
> > When the xserver is started, the problem is away. switching to a cons=
ole
> > with [Alt][CTRL][F1] works perfectly. And then you can read the text
> > normally.
> >=20
> > I have compiled the driver with the debug-option, which brought the
> > following output.
> > I'm not quite sur, if this can help, because I got it, when the conso=
le
> > worked after starting X.
> >=20
> > [  148.839846] hStart =3D 1040, hEnd =3D 1176, hTotal =3D 1344
> > [  148.839851] vStart =3D 770, vEnd =3D 776, vTotal =3D 806
> > [  148.839855] h_total_disp =3D 0x7f00ync_strt_wid =3D 0x11040a
> > [  148.839858] v_total_disp =3D 0x2ff0325noti login: [  148.839846] h=
Start
> > =3D 1040, hEnd =3D 1176, hTotal =3D 1344
> > [  148.839851] vStart =3D 770, vEnd =3D 776, vTotal =3D 806
> > [  148.839855] h_total_disp =3D 0x7f00a7ync_strt_wid =3D 0x60301
> > [  148.839860] pixclock =3D 15384
> > [  148.839862] freq =3D 6500
> >=20
> > Is there anything I can do to get this dirty lines away?
>=20
> Not sure yet. It seems to only happen on machine I have no access to, s=
o
> I haven't been able to properly figure it out at this point.
>=20
> Ben.
>=20
>=20
>=20
--=20
Dirk Henning Gerdes
B=F6nnersdyk 47
47803 Krefeld

Tel:  02151-755745
      0174-7776640
Mail: mail@dirk-gerdes.de



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
