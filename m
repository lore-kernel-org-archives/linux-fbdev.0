From: Nico Schottelius <schottelius@wdt.de>
Subject: 2.5.60/atyfb
Date: Sat, 15 Feb 2003 16:11:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030215151128.GA478@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.69.232.58] (helo=schottelius.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kieJ-00077t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 02:37:23 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I retried using atyfb with 2.5.60:
Afterloading atyfb the only thing left is the cursor.
i don't see anything else anymore..i see the cursor moving, but that's all.
btw, i am using a laptop (means lcd)...

can somebody tell me whether playing around with fbset could make things
working?

Nico

lspci:
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobilit=
y AGP 2x (rev 64)

dmesg:
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTA=
L, 230 MHz PLL, 50 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI

flapp:~ # fbset -fb /dev/fb/0=20

mode "640x480-60"
    # D: 25.075 MHz, H: 31.343 kHz, V: 59.701 Hz
    geometry 640 480 640 13075 8
    timings 39881 48 16 33 10 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode


flapp:~ # fbset -fb /dev/fb/0 -xres 1024 -yres 768
dmesg:
not enough video RAM

flapp:~ # fbset -fb /dev/fb/0 -xres 800 -yres 600
dmesg:
not enough video RAM

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+TligtnlUggLJsX0RArXmAJ4/RAz5SCpfII1swuELm2gUzDET4gCfTv9r
mbWhCjfwcnwqw4A9N2RgjXQ=
=AnyM
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
