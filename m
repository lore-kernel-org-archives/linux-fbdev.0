From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Fri, 26 Aug 2005 02:09:14 +0800
Message-ID: <430E094A.9030603@gmail.com>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8MAL-0006Y6-0g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 11:09:29 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8MAJ-0006lS-Tn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 11:09:28 -0700
Received: by wproxy.gmail.com with SMTP id i13so382793wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Aug 2005 11:09:20 -0700 (PDT)
In-Reply-To: <430DEAD0.8070403@t-online.de>
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
Cc: Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi Antonino,
>=20
> BTW: Thanks to Jochen Hein for testing cyblafb and reporting the
> very long timeout after switching from X to console!
>=20
>>> I never had expected that upon switching from X to a linux console
>>> drawing functions like fb_imageblit would be called before the
>>> fb_check_var and  fb_set_par functions have been called. But that=B4s
>>> definitely the case.
>>
>> I'm surprised.  That was a problem in earlier versions of the kernel
>> but I think that was fixed.  If you look at fbcon code, all calls to
>> drawing functions:
>=20
> My system is based on SuSE 9.2.
> Kernel 2.6.13-rc7
>=20
> 1. If I do compile cyblafb as a module, there is no problem.
>=20
> 2. If I compile cyblafb into the kernel, there is no problem if
> the first runlevel is 3 and I switch to runlevel 5 after login to
> a console.
>=20
> 3. If I compile cyblafb into the kernel, the problem is 100% reproducib=
le
> if the first runlevel is 5. ps ax -H in that case:
>=20
> 1342 ?        Ss       0:00   /usr/sbin/cron
> 1352 ?        Ss       0:00   /usr/sbin/gpm -m /dev/ttyS0 -t ms
> 1362 ?        S        0:00   /opt/kde3/bin/kdm
> 1385 ?        S        0:20     /usr/X11R6/bin/X -nolisten tcp -br vt7=20
> -auth /var/lib/xdm/authdir/authfiles/A:0-Zgg52m
> 1392 ?        S        0:00     -:0             1681 ?        S       =20
> 0:00       /bin/sh /usr/X11R6/bin/kde
> 1716 ?        S        0:00         gpg-agent --daemon --no-detach=20
> --keep-display /bin/bash /etc/X11/xinit/xinitrc
> 1786 ?        S        0:00         kwrapper ksmserver
> 1648 ?        Ss       0:00   login -- root    1744 tty1    Ss+   =20
> 0:00     -bash
> 1649 tty2    Ss+    0:00   /sbin/mingetty tty2
>=20
> The very first time I switch back from X to a linux console the bug
> is triggered. cyblafb_sync() , called from cyblafb_imageblit(), times
> out because mmio is switched off. Then a number of drawing functions
> is called before the checkvar() and the setpar() are executed.
>=20
> Let=B4s count in /var/log/messages .... exactly 64 calls.
>=20
> 64 (rows) * 16 (font height) =3D 1024 (screen height). I have not verif=
ied=20
> that
> all those calls are imageblits, but  it seems that somebody wants to re=
draw
> the screen.
>=20
> After that the bug never triggers again.
>=20
> I wonder why there should be a difference between kdm executed first
> or login executed first, but that=B4s the case.

I tried to duplicate the problem, but failed.

First, I inserted stub calls, disable_device(info). I inserted it in fbco=
n_blank(),
if blank !=3D 0 and mode_switch !=3D 0. I also inserted another one in fb=
con_switch(),
if vc->vc_mode =3D=3D KD_GRAPHICS. These are the circumstances when the c=
onsole is
about to be acquired by a graphics apps like X.  Then the stub function,
disable_device(), in the fbdev driver, just sets a flag.  This flag is cl=
eared
on a set_par(). This flag is also checked by the sync, imageblit, fillrec=
t and
copyarea functions, which prints something when this flag !=3D 0. I'm not=
 getting
any messages.  Which, if I interpret this correctly, that a set_par will =
always
be called before any of the drawing functions.

The circumstance I can think of that this can happen is when the app fail=
s to
set the VT to KD_GRAPHICS mode, but I'm pretty sure kdm does it properly,=
 in=20
my machine at least (Suse 9.0).

Perhaps, if you have the time, you can instrument it better so we can pin=
point
where this unwanted calls are coming from.  Months were spent trying to f=
ix this
problem, mainly by BenH, and I don't want any stones left unturned.

Tony

PS: I don't know the console subsystem that well, so there may be pathway=
s that
I don't know about.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
