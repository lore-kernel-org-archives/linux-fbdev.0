From: "=?iso-8859-1?Q?p.gilardetti@libero.it?=" <p.gilardetti@libero.it>
Subject: (no subject)
Date: Thu,  6 Feb 2003 16:27:23 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <H9W89N$BB99264CDD033C15A1E92A4E2F5E0F29@libero.it>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp2.libero.it ([193.70.192.52])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gnvx-0002ei-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Feb 2003 07:27:25 -0800
Received: from libero.it (193.70.192.47) by smtp2.libero.it (6.7.015)
        id 3E0D86610029A4FB for linux-fbdev-devel@lists.sourceforge.net; Thu, 6 Feb 2003 16:27:23 +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: =?iso-8859-1?Q?linux-fbdev-devel?= <linux-fbdev-devel@lists.sourceforge.net>

Hi,=0D=0AI have a problem when I change the bpp value, here is the code:=0D=
=0A=0D=0Aif( ioctl(fbd, FBIOGET_VSCREENINFO, &var_info) =3D=3D -1){=0D=0A=
	perror("\nError IOCTL 1");=0D=0A	exit(0);=0D=0A}           =0D=0Aprintf(=
"\n bpp: %d", var_info.bits_per_pixel);   // output is  bpp: 16=0D=0Avar_=
info.bits_per_pixel =3D 24;=0D=0Aif( ioctl(fbd, FBIOPUT_VSCREENINFO, &var=
_info) =3D=3D -1){=0D=0A	perror("\nError IOCTL 2");=0D=0A	exit(0);=0D=0A}=
           =0D=0AThe program exit with the following message error: =0D=0A=
Error IOCTL 2: Invalid argument=0D=0A=0D=0AHow can I set the bpp value? S=
hould I modify the file /etc/X11/XF86Config?=0D=0A=0D=0AI have another pr=
oblem, I try to write a simple program that reads frame from framebuffer =
and then creates a Divx file of a few seconds.=0D=0AI map the framebuffer=
 to a buffer, but the program crash with a segmentation fault:=0D=0A     =
                                            =0D=0A    screen_buffer =3D (=
char *)malloc(DIM_BUFFER * sizeof(char));=0D=0A    screen_buffer =3D (voi=
d *)mmap(0, DIM_BUFFER, PROT_READ, MAP_SHARED, fbd, 0);                 =0D=
=0A	=0D=0A    encFrame.image =3D (void *)screen_buffer;  <--- causes seg =
fault=0D=0A=0D=0AWhat's wrong?  =0D=0A=0D=0AThanks,=0D=0APaolo Gilardetti=
=0D=0A	 =0D=0A



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
