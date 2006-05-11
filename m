From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 4/12] atyfb: Remove unneeded calls to wait_for_idle
Date: Thu, 11 May 2006 23:11:19 +0300
Message-ID: <20060511201119.GA29907@sci.fi>
References: <4452B422.2080907@gmail.com> <20060501102023.GA9104@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FeHVN-0002Ve-Op
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 May 2006 13:11:25 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FeHVN-0001o1-MD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 May 2006 13:11:25 -0700
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FeHVM-0005t4-71
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 May 2006 13:11:25 -0700
Content-Disposition: inline
In-Reply-To: <20060501102023.GA9104@sci.fi>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>

On Mon, May 01, 2006 at 01:20:23PM +0300, Ville Syrj=E4l=E4 wrote:
> On Sat, Apr 29, 2006 at 08:32:34AM +0800, Antonino A. Daplas wrote:
> > The drawing functions of atyfb is unecessary syncing the GPU which is=
 affecting
> > performance.  Remove the calls, any direct access by fbcon to the fra=
mebuffer
> > will always be preceeded by a call to atyfb_sync().
>=20
> Still works on my Mobility :) I'll try to test with older chips later=20
> this week, but I don't expect any problems. AFAIK the only case when an=
=20
> engine sync is necessary is 3D/scaler <-> 2D transition on pre-Rage Pro=
=20
> chips.

Now also tested with VT2, Rage II+ and IIC. No problems.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
