From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: PROBLEM: System hangs off when logging off
	KDE
Date: Sat, 08 Nov 2003 02:10:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1068253832.1773.41.camel@thor.asgaard.local>
References: <BAY9-F39KrQRIiDLRaP000174a8@hotmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIHcd-0002IL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Nov 2003 17:10:39 -0800
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AIHca-0006Jg-F0
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Nov 2003 17:10:36 -0800
In-Reply-To: <BAY9-F39KrQRIiDLRaP000174a8@hotmail.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: David Guiraud <david_guiraud@hotmail.com>
Cc: davej@codemonkey.org.uk, linux-fbdev-devel@lists.sourceforge.net

On Sat, 2003-11-08 at 01:00, David Guiraud wrote:
> [1]System hangs off when logging off KDE
> [2] Compiled Kernel with agpgart and radeon modular; both loaded; (Sorry =
for=20
> my bad english!) The KDE Login manager starts as common; i log in, as=20
> common; when i try to symply log off (Shutdown or Reboot chosen with KDE =

> works fine), the monitor turns off (as usual), but does not turn on again=
;=20
> the systems seems to hang off (dont know if this is called hanging off?=20
> translated it from german, but i think you know what i mean); cant get th=
e=20
> terminals with CTRL-ALT-F?; only reset helps... Perhaps this is a problem=
=20
> with the KDE-Code (ver 3.1.4), i can only say that 2.4.22 does not hang o=
ff.=20

What XFree86 version? See http://bugs.xfree86.org/show_bug.cgi?id=3D94 .


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
