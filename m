From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 00:03:18 +0100
Message-ID: <438F8136.5030005@t-online.de>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhxSA-0006Vv-Vu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:03:02 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhxS8-0003GC-L6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:03:03 -0800
In-Reply-To: <438E3D66.8080601@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Geert/Antonino,

YWRAP_MOVE now does work on the cyberblade/i1. The following change
to bitblit.c is necessary:

static int bit_update_start(struct fb_info *info)
{
        struct fbcon_ops *ops =3D info->fbcon_par;
        int err;

-         err =3D fb_pan_display(info, &ops->var);
+        err =3D info->fbops->fb_pan_display(&ops->var,info);;
        ops->var.xoffset =3D info->var.xoffset;
        ops->var.yoffset =3D info->var.yoffset;
        ops->var.vmode =3D info->var.vmode;
        return err;
}

I have to admit that I=B4m not one of those gurus who fully understand th=
e=20
fbcon
console layer in all details ... so please check that this does not=20
break anything else.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
