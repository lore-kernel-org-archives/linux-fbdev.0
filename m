From: =?iso-8859-1?q?D=E9cio=20Luiz=20Gazzoni=20Filho?= <decio@revistapcs.com.br>
Subject: Dual Athlon crashing with VESAfb and Rivafb
Date: Tue, 23 Jul 2002 00:14:46 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200207230014.52689.decio@revistapcs.com.br>
Reply-To: decio@revistapcs.com.br
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from karen.sercomtel.com.br ([200.250.19.118])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Wq6c-0005ni-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 20:12:59 -0700
Received: from acidblood (adsl006c180.sercomtel.com.br [200.155.34.182])
	by karen.sercomtel.com.br (8.9.3+Sun/8.9.3) with ESMTP id AAA03375
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Jul 2002 00:12:51 -0300 (EST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have put together a dual Athlon machine (K7D Master mobo with the AMD 7=
60MPX=20
chipset) and GeForce4 Ti4400 video card, and my only grip with it so far =
is=20
the inability to run my display with a framebuffer device. VESAfb locks m=
y=20
machine hard, while Rivafb leaves me staring at a blank screen (though th=
e=20
system keeps loading). That happened on 2.4.19-pre2 with the RML's preemp=
t=20
patch (configured for SMP, preemption enabled, VESAfb and Rivafb built-in=
=20
into the kernel). Now I have updated to 2.4.19-rc3, and VESAfb keeps lock=
ing=20
the machine hard, but I can't load Rivafb any longer, passing the boot-ti=
me=20
parameter video=3Driva:1024x768-32@60 still loads with a plain text conso=
le,=20
and `dmesg | grep riva' doesn't show up anything.

Is this a known problem? Any ideas on how to fix it? If more information =
is=20
needed, let me know and I will provide it.

Thanks

D=E9cio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj08yiwACgkQZ4XkjV48x2dddwCcDWDSL7dvt0aS/OXv5WPCuTtJ
KQIAni61GQ+XO5aBszskX8jAxtLJG9fy
=3DVw/p
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
