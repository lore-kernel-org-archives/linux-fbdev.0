From: "Abhilash" <abhilash@avenir.net>
Subject: Frame buffer Reading fails!!
Date: Fri, 3 Jan 2003 21:18:51 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <00df01c2b33f$a1354690$bd00000a@abhilash>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00DC_01C2B36D.B6843500"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UlC3-0001AL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 02:06:16 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA07513
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 4 Jan 2003 11:05:36 +0100 (MET)
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.21.0301041105330.10242@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: inux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>



This is a multi-part message in MIME format.

------=_NextPart_000_00DC_01C2B36D.B6843500
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

As u suggested I tried following code in RedHat7.1.
But it shows

 "The framebuffer device was opened successfully."
 "Error reading fixed information."

What could be the problem?
I am new to this.

Thank you,
Abhilash.


#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>

int main()
{
    int fbfd =3D 0;
    struct fb_var_screeninfo vinfo;
    struct fb_fix_screeninfo finfo;
    long int screensize =3D 0;
    char *fbp =3D 0;
    int x =3D 0, y =3D 0;
    long int location =3D 0;

    // Open the file for reading and writing
    fbfd =3D open("/dev/fb0", O_RDWR);
    if (!fbfd) {
        printf("Error: cannot open framebuffer device.\n");
        exit(1);
    }
    printf("The framebuffer device was opened successfully.\n");

    // Get fixed screen information
    if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo)) {
        printf("Error reading fixed information.\n");
        exit(2);
    }
}

----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "Abhilash" <abhilash@avenir.net>
Cc: "Linux Frame Buffer Device Development"
<linux-fbdev-devel@lists.sourceforge.net>
Sent: Friday, December 27, 2002 5:03 PM
Subject: Re: [Linux-fbdev-devel] Screen Capturing


> On Fri, 27 Dec 2002, Abhilash wrote:
> > I need to capture the screen .For that I use mirror driver in
Windows
for
> > capturing screen.
> > ie, its basically overloading the driver functions.
> >
> > So in case of Linux, is there any method like this or which is the
best
> > method?
> > In Xlib there are some functions to capture screen and also heard
abt
VESA
> > which is better?
>
> If you are using a frame buffer device, you can capture the contents
of
> /dev/fb*. Either read from /dev/fb*, or mmap() it. The data you
receive
are in
> the native format of the graphics chip. For CLUT modes, you have to
use an
> ioctl() to get the colormap.
>
> Gr{oetje,eeting}s,
>
> Geert




------=_NextPart_000_00DC_01C2B36D.B6843500
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3502.5390" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hello,<BR><BR>As u suggested I tried =
following code=20
in RedHat7.1.<BR>But it shows<BR><BR>&nbsp;"The framebuffer device was =
opened=20
successfully."<BR>&nbsp;"Error reading fixed information."<BR><BR>What =
could be=20
the problem?<BR>I am new to this.<BR><BR>Thank=20
you,<BR>Abhilash.<BR><BR><BR>#include &lt;unistd.h&gt;<BR>#include=20
&lt;stdio.h&gt;<BR>#include &lt;fcntl.h&gt;<BR>#include=20
&lt;linux/fb.h&gt;<BR>#include &lt;sys/mman.h&gt;<BR><BR>int=20
main()<BR>{<BR>&nbsp;&nbsp;&nbsp; int fbfd =3D 0;<BR>&nbsp;&nbsp;&nbsp; =
struct=20
fb_var_screeninfo vinfo;<BR>&nbsp;&nbsp;&nbsp; struct fb_fix_screeninfo=20
finfo;<BR>&nbsp;&nbsp;&nbsp; long int screensize =3D =
0;<BR>&nbsp;&nbsp;&nbsp; char=20
*fbp =3D 0;<BR>&nbsp;&nbsp;&nbsp; int x =3D 0, y =3D =
0;<BR>&nbsp;&nbsp;&nbsp; long int=20
location =3D 0;<BR><BR>&nbsp;&nbsp;&nbsp; // Open the file for reading =
and=20
writing<BR>&nbsp;&nbsp;&nbsp; fbfd =3D open("/dev/fb0",=20
O_RDWR);<BR>&nbsp;&nbsp;&nbsp; if (!fbfd)=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("Error: cannot =
open=20
framebuffer device.\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
exit(1);<BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp; printf("The =
framebuffer=20
device was opened successfully.\n");<BR><BR>&nbsp;&nbsp;&nbsp; // Get =
fixed=20
screen information<BR>&nbsp;&nbsp;&nbsp; if (ioctl(fbfd, =
FBIOGET_FSCREENINFO,=20
&amp;finfo)) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("Error=20
reading fixed =
information.\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
exit(2);<BR>&nbsp;&nbsp;&nbsp; }<BR>}<BR><BR>----- Original Message=20
-----<BR>From: "Geert Uytterhoeven" &lt;<A=20
href=3D"mailto:geert@linux-m68k.org">geert@linux-m68k.org</A>&gt;<BR>To: =

"Abhilash" &lt;<A=20
href=3D"mailto:abhilash@avenir.net">abhilash@avenir.net</A>&gt;<BR>Cc: =
"Linux=20
Frame Buffer Device Development"<BR>&lt;<A=20
href=3D"mailto:linux-fbdev-devel@lists.sourceforge.net">linux-fbdev-devel=
@lists.sourceforge.net</A>&gt;<BR>Sent:=20
Friday, December 27, 2002 5:03 PM<BR>Subject: Re: [Linux-fbdev-devel] =
Screen=20
Capturing<BR><BR><BR>&gt; On Fri, 27 Dec 2002, Abhilash wrote:<BR>&gt; =
&gt; I=20
need to capture the screen .For that I use mirror driver=20
in<BR>Windows<BR>for<BR>&gt; &gt; capturing screen.<BR>&gt; &gt; ie, its =

basically overloading the driver functions.<BR>&gt; &gt;<BR>&gt; &gt; So =
in case=20
of Linux, is there any method like this or which is the<BR>best<BR>&gt; =
&gt;=20
method?<BR>&gt; &gt; In Xlib there are some functions to capture screen =
and also=20
heard<BR>abt<BR>VESA<BR>&gt; &gt; which is better?<BR>&gt;<BR>&gt; If =
you are=20
using a frame buffer device, you can capture the contents<BR>of<BR>&gt;=20
/dev/fb*. Either read from /dev/fb*, or mmap() it. The data=20
you<BR>receive<BR>are in<BR>&gt; the native format of the graphics chip. =
For=20
CLUT modes, you have to<BR>use an<BR>&gt; ioctl() to get the=20
colormap.<BR>&gt;<BR>&gt; Gr{oetje,eeting}s,<BR>&gt;<BR>&gt;=20
Geert<BR><BR><BR></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_00DC_01C2B36D.B6843500--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
