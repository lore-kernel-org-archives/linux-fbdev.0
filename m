From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Mirrored and shiftet fonts and logos
Date: 15 Dec 2002 05:30:10 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039911145.1008.41.camel@localhost.localdomain>
References: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NJwn-0002HL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 13:35:45 -0800
In-Reply-To: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
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
To: =?ISO-8859-1?Q?Andr=E9?= Stierenberg <stierenberg@gmx.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2002-12-15 at 00:53, Andr=C3=A9 Stierenberg wrote:
> Now the characters are printed correctly. And in the linux logo, the
> pinguin, something is also wrong. It seems the some pixels are mirrored t=
oo
> whereas other pixels are correct.
>=20
> What could this be and in what way can i fix the problem?
>=20
The logo is drawn directly to the framebuffer by fbcon_show_logo() in
linux/drivers/video/fbcon.c.

In your case, (is this cfb4?), the code segment is enclosed by this
conditional:

#if defined(CONFIG_FBCON_CFB4)
...
#endif

You can apply the same reversal techniques to correct your problem.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
