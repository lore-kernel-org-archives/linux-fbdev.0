From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: problems with radeonfb in linux-2.6.11-rc3
Date: Fri, 04 Feb 2005 23:21:11 -0500
Message-ID: <1107577271.5958.90.camel@thor.asgaard.local>
References: <200502040029.43885.warcomp@web.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxHRi-0001mu-D9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 20:21:22 -0800
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CxHRg-00011K-Ra
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 20:21:22 -0800
In-Reply-To: <200502040029.43885.warcomp@web.de>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: dri-devel@lists.sf.net

On Fri, 2005-02-04 at 00:29 +0000, Armin Krieg wrote:
>=20
> I'm using a Radeon 9600XT and there are no error-messages in syslog....
>=20
> and i hope i can give also another bug-report, although I think its a pro=
blem
> with the new dri-code...
> I'm using a cvs-snapshot of x.org and with the newer kernels 2.6.11-XXX o=
r
> a cvs-snapshot of drm my screen is completely "distorted", but i can see =
the
> edges of windows...so it seems to be a problem with a correct order of th=
e
> horizontal lines...

Sounds like it could be related to the recently added colour buffer
tiling... CC'ing dri-devel, please follow up there only about this
problem. Does your X server log contain 'Color tiling enabled by
default'? If so, does Option "ColorTiling" "off" fix the problem?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
