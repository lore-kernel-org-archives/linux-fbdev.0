From: <kiran.tigadi@wipro.com>
Subject: RE: Smart LCD Linux driver
Date: Fri, 2 Jul 2004 19:16:15 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <DC91351678E31E4FB24B551221F507ECB771EA@blr-itp-msg.wipro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgQ4H-00059Z-5M
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 08:35:13 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BgQ4G-0006Hd-Pg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 08:35:13 -0700
Received: from wiproecmx2.wipro.com ([164.164.31.6])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgVbq-0001uo-1X
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 14:30:18 -0700
Received: from ec-vwall-wd (ec-vwall-wd.wipro.com [10.200.52.125])
	by wiproecmx2.wipro.com (8.12.9-20031013/8.12.9) with SMTP id i62DkHNC013978
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 2 Jul 2004 19:16:17 +0530 (IST)
content-class: urn:content-classes:message
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
To: jbglaw@lug-owl.de
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

Overview Smart LCD panel
=A1=F0262144 colors, 65536 colors, 4096 colors and 8 colors display is =
available by PWM driving.
=A1=F0Direct data display by video data RAM (normally-white LCD)
=A1=F0Partial display function Power saving by pausing display process =
on part of the screen.
=A1=F0Built-in RAM capacity 6=A1=C1540=A1=C1288=3D933120 bit
=A1=F0MPU interface Directly connectable to an 16-bit or 8-bit parallel =
MPU of 80 series
=A1=F0Plenty of command functions
=A1=F0Built-in oscillating circuit

Regards,
Kiran.T

-----Original Message-----
From: linux-fbdev-devel-admin@lists.sourceforge.net =
[mailto:linux-fbdev-devel-admin@lists.sourceforge.net] On Behalf Of =
Jan-Benedict Glaw
Sent: Friday, July 02, 2004 5:13 PM
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Smart LCD Linux driver


On Fri, 2004-07-02 16:50:44 +0530, kiran.tigadi@wipro.com =
<kiran.tigadi@wipro.com> wrote in message =
<DC91351678E31E4FB24B551221F507ECB771E4@blr-itp-msg.wipro.com>:
> Hi,
> =20
> I am working on Smart LCD Linux driver interfaced Asynchronous Display =

> controller. I want info in this regard.

Asynchronous display controller? Attached via a serial link (or by other =
means), but no shared video RAM?

That's one of the more complicated drivers then... You'd need to prepare =
some buffer you can provide to the FB API and poll it for changes, which =
you then need to hammer down to your display controller.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen =
Krieg
    fuer einen Freien Staat voll Freier B=A8=B9rger" | im Internet! |   =
im Irak!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | =
TCPA));


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
