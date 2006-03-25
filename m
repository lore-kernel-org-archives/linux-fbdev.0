From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Sat, 25 Mar 2006 01:20:54 +0000 (GMT)
Message-ID: <20060325012054.88967.qmail@web52905.mail.yahoo.com>
References: <4423E396.7070403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMxSf-0007e1-4R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 17:21:01 -0800
Received: from web52905.mail.yahoo.com ([206.190.49.15])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMxSe-0002pv-Fu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 17:21:01 -0800
In-Reply-To: <4423E396.7070403@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Dave Airlie <airlied@gmail.com>

--- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> Chris Rankin wrote:
> > --- Dave Airlie <airlied@gmail.com> wrote:
> >> Just to let you know what I do, I boot up in text mode, ssh in and
> >> modprobe my fb driver then fbcon... I don't touch the console during
> >> that time.. if I vt switch and come back it works fine..
> >=20
> > If vt-switching "fixes" things then that would explain why I can't re=
produce this bug now.
> >=20
>=20
> Can you both try this patch?
>=20
> Tony
>=20
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbco=
n.c
> index eb46629..bf4aeb5 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -1142,6 +1142,7 @@ static void fbcon_init(struct vc_data *v
>  		set_blitting_type(vc, info);
>  	}
> =20
> +	ops->p =3D &fb_display[fg_console];
>  }
> =20
>  static void fbcon_deinit(struct vc_data *vc)

That seems to have worked.

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
