From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Thu, 25 Aug 2005 17:59:12 +0200
Message-ID: <430DEAD0.8070403@t-online.de>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8K5o-00082V-6b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 08:56:40 -0700
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8K5k-0004PD-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 08:56:40 -0700
In-Reply-To: <430DD026.2070303@gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Hi Antonino,

BTW: Thanks to Jochen Hein for testing cyblafb and reporting the
very long timeout after switching from X to console!

>> I never had expected that upon switching from X to a linux console
>> drawing functions like fb_imageblit would be called before the
>> fb_check_var and  fb_set_par functions have been called. But that=B4s
>> definitely the case.
>
> I'm surprised.  That was a problem in earlier versions of the kernel
> but I think that was fixed.  If you look at fbcon code, all calls to
> drawing functions:

My system is based on SuSE 9.2.
Kernel 2.6.13-rc7

1. If I do compile cyblafb as a module, there is no problem.

2. If I compile cyblafb into the kernel, there is no problem if
the first runlevel is 3 and I switch to runlevel 5 after login to
a console.

3. If I compile cyblafb into the kernel, the problem is 100% reproducible
if the first runlevel is 5. ps ax -H in that case:

1342 ?        Ss       0:00   /usr/sbin/cron
1352 ?        Ss       0:00   /usr/sbin/gpm -m /dev/ttyS0 -t ms
1362 ?        S        0:00   /opt/kde3/bin/kdm
1385 ?        S        0:20     /usr/X11R6/bin/X -nolisten tcp -br vt7=20
-auth /var/lib/xdm/authdir/authfiles/A:0-Zgg52m
1392 ?        S        0:00     -:0            =20
1681 ?        S        0:00       /bin/sh /usr/X11R6/bin/kde
1716 ?        S        0:00         gpg-agent --daemon --no-detach=20
--keep-display /bin/bash /etc/X11/xinit/xinitrc
1786 ?        S        0:00         kwrapper ksmserver
1648 ?        Ss       0:00   login -- root   =20
1744 tty1    Ss+    0:00     -bash
1649 tty2    Ss+    0:00   /sbin/mingetty tty2

The very first time I switch back from X to a linux console the bug
is triggered. cyblafb_sync() , called from cyblafb_imageblit(), times
out because mmio is switched off. Then a number of drawing functions
is called before the checkvar() and the setpar() are executed.

Let=B4s count in /var/log/messages .... exactly 64 calls.

64 (rows) * 16 (font height) =3D 1024 (screen height). I have not verifie=
d=20
that
all those calls are imageblits, but  it seems that somebody wants to redr=
aw
the screen.

After that the bug never triggers again.

I wonder why there should be a difference between kdm executed first
or login executed first, but that=B4s the case.

Feel free to send patches.

cu,
 Knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
