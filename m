From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 22:25:19 +0800
Message-ID: <438B134F.8080406@gmail.com>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com> <438ABBF3.20104@t-online.de> <438AC4D9.9040603@gmail.com> <438B0A1A.6010409@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgjxH-00028g-Iv
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 06:26:07 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EgjxG-0004Dq-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 06:26:07 -0800
Received: by zproxy.gmail.com with SMTP id r28so469668nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Nov 2005 06:26:03 -0800 (PST)
In-Reply-To: <438B0A1A.6010409@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Tony,
>=20
> thanks for the quick reply.
>=20
>> Try this patch.
>>
>> fb_save_state() will be called when going from KD_GRAPHICS to KD_TEXT.
>> The
>> driver has the opportunity here to save the current state of the hardw=
are
>> before it's touched by fbdev.
>> fb_restore_state() will be called when going from KD_TEXT to KD_GRAPHI=
CS
>> mode.  The driver has the opportunity to set the hardware back to
>> something
>> recognizable by the graphics application.
>> =20
>>
> Are you sure? I added a save_state and restore_state function to
> cyblafb, both
> including nothing but a printk and return. I also added a printk at the
> start of
> both the check_var and set_par functions of cyblafb. The "Scrollmode=3D
> ..." lines
> originate from a printk in updatescrollmode:
>=20
> Loading of cyblafb and switching to it using the following commands:
>=20
>    echo -n "0" > /sys/class/graphics/fb0/con_rotate
>    echo -n "0" > /sys/class/graphics/fb1/con_rotate
>    con2fb /dev/fb0 /dev/tty1
>    rmmod cyblafb
>    sync
>    modprobe cyblafb scalign=3D4
>    con2fb /dev/fb1 /dev/tty1
>    echo -n "0" > /sys/class/graphics/fb0/con_rotate
>    echo -n "0" > /sys/class/graphics/fb1/con_rotate
>    setfont ~/lat9w-16.psfu.gz
>    rcgpm restart
>    echo -e '\033[?2c'
>=20
> dmesg output:
>=20
>    [ 4910.034508] cyblafb: CyblaFB version 0.55 normal exit.
>    [ 4910.086590] cyblafb: CyblaFB version 0.55 initializing
>    [ 4910.088746] cyblafb: Pixmap size =3D 8188, alignement =3D 4
>    [ 4910.090688] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] ->
> GSI 11 (level, low) -> IRQ 11
>    [ 4910.094348] cyblafb: region 0x3c0/0x20 already reserved
>    [ 4910.096321] cyblafb: region 0xe1800000/0x800000 already reserved
>    [ 4910.098374] cyblafb: check_var
>    [ 4910.106050] cyblafb: set_par
>    [ 4910.108224] Scrollmode =3D SCROLL_PAN_MOVE
>    [ 4910.121050] Scrollmode =3D SCROLL_PAN_MOVE
>    [ 4910.138671] Scrollmode =3D SCROLL_PAN_MOVE
>    [ 4910.138763] Scrollmode =3D SCROLL_PAN_MOVE
>    [ 4910.180336] Scrollmode =3D SCROLL_PAN_MOVE
>=20
> now switching to X:
>=20
>    [ 4921.533936] Scrollmode =3D SCROLL_PAN_REDRAW
>=20
> now switching back to framebuffer console:
>=20
>    [ 4929.167382] cyblafb: set_par
>    [ 4929.169506] Scrollmode =3D SCROLL_PAN_MOVE
>    [ 4929.181895] cyblafb: save_state has been called, switching from
> KD_GRAPHICS to KD_TEXT
>    [ 4929.181917] cyblafb: check_var
>    [ 4929.181929] cyblafb: set_par
>    [ 4929.184695] Scrollmode =3D SCROLL_PAN_MOVE
>=20
> no switching to X again:
>=20
>    [ 4933.273261] Scrollmode =3D SCROLL_PAN_REDRAW
>=20
> 1. restore_state is never called
> 2. there is a set_par prior to the call to save_state, but that=B4s
> irrelevant for me as
>    there is a check_var and set_par call after save_state.

Works here.  I inserted printk's before the calls to fb_save|restore_stat=
e
in fbcon.c, switched to X and console several times, and I get this:

fbcon: save state
fbcon: restore state
fbcon: save state
fbcon: restore state
fbcon: save state
fbcon: restore state

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
