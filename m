From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: cyblafb in kernel 2.6.16: corrupted display
 in Xfree86
Date: Thu, 23 Mar 2006 09:34:53 +0100
Message-ID: <44225DAD.8080004@t-online.de>
References: <20060322234812.GB2361@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMLPf-0001Et-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 00:43:23 -0800
Received: from mailout05.sul.t-online.com ([194.25.134.82])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMLPd-0006VN-U7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 00:43:23 -0800
In-Reply-To: <20060322234812.GB2361@intevation.de>
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi Thomas!

>/etc/fb.modes:
>mode "1152x864-70"
>    # D: 100.0 MHz, H: 66.138 kHz, V: 69.99 Hz
>    geometry 1152 864 1152 864 8
> =20
>
That is very slow. Use geometry 1152 864 2048 4096 8

>    timings 10000 168 40 57 13 152 11
>    hsync high
>    vsync high
>endmode
>
>To enable this resolution I use:
>
>/etc/rcS.d/S42cyblafb:
>/sbin/modprobe cyblafb bpp=3D16 mode=3D1024x768 ref=3D85 && /usr/sbin/fb=
set -a 1152x864-70
> =20
>

/sbin/modprobe cyblafb && /usr/sbin/fbset -a 1152x864-70 should be=20
sufficient.

>(because the cyblafb driver doesn't understand mode=3D1152x864 as parame=
ter)
>
>XFree86 is standard Debian sarge: 4.3.0.dfsg.1-14sarge1
>
>One further thing to note is that I compiled 2.6.15.6 with gcc
>2.95.4 and 2.6.16 with gcc 3.4.3, can this make a difference?
>
>Any idea what's happening here?
>
>Regards,
>Thomas
>
> =20
>

I cannot test 1152x864 on my system because my monitor does not understan=
d
that resolution. But if it worked previously it should work now ;-)

Are there any problems on the framebuffer console? You wrote that the fb=20
console
comes up fine, but please confirm that scrolling is ok.

Are there any problems left after you reach the state of your third=20
picture? Switching
between the fb console and X works flawlessly then?

Are there any problems if you use the standard resolutions, eg 1024x768=20
or 1280x1024?

Try a fbset -vxres 2048 -vyres 4096  after your first fbset. Does that=20
change anything?

Please send dmesg logs of kernel 2.6.15.6 and 2.6.16 after adding=20
verbosity=3D2
to the modprobe of cyblafb - everything from the point of loading=20
cyblafb to your third
picture. Also include the X server logs. Maybe it=B4s a good idea to send=
=20
those logs to my
private address Knut_Petersen@t-online.de.

cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
