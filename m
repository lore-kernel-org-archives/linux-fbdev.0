From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: fbdev hardware cursor support
Date: Wed, 25 May 2005 09:16:28 +0300
Message-ID: <20050525061628.GA5396@sci.fi>
References: <9e473391050524224063df2372@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DapBz-0007gv-BD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 May 2005 23:16:35 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DapBx-0003aC-Rq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 May 2005 23:16:35 -0700
Content-Disposition: inline
In-Reply-To: <9e473391050524224063df2372@mail.gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Wed, May 25, 2005 at 01:40:57AM -0400, Jon Smirl wrote:
> What is the status of fbdev hardware cursor support? I see the ioctl
> is disabled in the driver.
>=20
> If a driver is using the softcursor support would the ioctl control tha=
t cursor?
> Does softcursor work in a bitmap graphics mode?
>=20
> The EGL based X server is going to need fbdev hardware cursors working.

Why doesn't it draw the cursor using OpenGL? On many cards the hardware=20
cursor is too limited to allow nice looking cursors.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
