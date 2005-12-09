From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
Date: Sat, 10 Dec 2005 00:38:08 +0800
Message-ID: <4399B2F0.5070505@gmail.com>
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EklGM-0006KH-Ul
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 08:38:26 -0800
Received: from zproxy.gmail.com ([64.233.162.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EklGJ-0000v4-CY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 08:38:26 -0800
Received: by zproxy.gmail.com with SMTP id r28so916666nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 08:38:21 -0800 (PST)
In-Reply-To: <43997037.4020206@t-online.de>
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
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Knut Petersen wrote:

Had time to look at your tracing closely...

>=20
> Framebuffer console is 1 with mode 1280x1024, X console is 7 and has
> been set to 1024x768
> before X was activated.
>=20
> Now I do run "chvt 7;sleep 3;chvt 1" on the vt 1.
>=20
>    [  972.360841]  [<c0282331>] cyblafb_set_par+0x31/0xd80

The set_par call should not happen if the var of vt7 and vt1 are
the same.

>    [  972.360898]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  972.360925]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  972.360951]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.360989]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.361018]  [<c02c8203>] change_console+0x43/0x90
>    [  972.361043]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.361101]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.361143]  [<c012c115>] kthread+0x95/0xd0
>    [  972.361171]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.361212] cyblafb: Switching to new mode: fbset -g 1024 768 102=
4
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.363308] cyblafb: pixclock =3D 64.99 MHz, k/m/n 1 b 6e
>=20
>    [  972.363916]  [<c0282331>] cyblafb_set_par+0x31/0xd80

Okay, this particular set_par() will only be called if the info
mapped to vt1 and info mapped to vt7 are different.  Which means
you have multiple fbdevs loaded in your system.=20

The other reason, of course, is you have a patched fbcon_switch (yours).

>    [  972.363945]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  972.363969]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.363996]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.364023]  [<c02c8203>] change_console+0x43/0x90
>    [  972.364047]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.364093]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.364121]  [<c012c115>] kthread+0x95/0xd0
>    [  972.364143]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.364181] cyblafb: Switching to new mode: fbset -g 1024 768 102=
4
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.366271] cyblafb: pixclock =3D 64.99 MHz, k/m/n 1 b 6e
>    [  972.366325] cyblafb: Switching to KD_GRAPHICS
>=20
> Not so nice. Now let=B4s have a look at the log entries caused switchin=
g
> back to
> the framebuffer console:
>=20
> This call to set_par() is the result of my patch:
>=20
>    [  975.751407]  [<c0282331>] cyblafb_set_par+0x31/0xd80
>    [  975.751437]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  975.751462]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  975.751486]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.751513]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.751540]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.751564]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.751587]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.751613]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.751640]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.751666]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.751702] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.753795] cyblafb: pixclock =3D 135.00 MHz, k/m/n 0 5 3a
>=20
> Without that prior set_par() that=B4s the point where the enhanced cybl=
afb
> would
> have serious problems:
>=20
>    [  975.753839] cyblafb_pan_display: entry
>    [  975.753853]  [<c0281f7c>] cyblafb_pan_display+0x9c/0xb0
>    [  975.753883]  [<c027b911>] fb_pan_display+0x61/0xa0
>    [  975.753925]  [<c027ba4f>] fb_set_var+0xff/0x210
>    [  975.753949]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  975.753973]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.754000]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.754027]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.754051]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.754074]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.754100]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.754127]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.754153]  [<c01029a9>] syscall_call+0x7/0xb

Yes, this is a problem.  Should be easily fixed.

>=20
> Again a call to set_par:
>=20
>    [  975.754744]  [<c0282331>] cyblafb_set_par+0x31/0xd80

This either came from your patch, or you have multiple fbdevs.

>    [  975.754773]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  975.754796]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.754823]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.754850]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.754875]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.754917]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.754943]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.754970]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.754996]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.755032] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.757123] cyblafb: pixclock =3D 135.00 MHz, k/m/n 0 5 3a
>=20
> Now the save_state() function is called:
>=20
>    [  975.757745] cyblafb: Switching to KD_TEXT
>=20
> and again a call to set_par():
>=20
>    [  975.757759]  [<c0282331>] cyblafb_set_par+0x31/0xd80

This set_par is the one that is needed.  This is the point where
the vt is entering KD_TEXT mode fro KD_GRAPHICS.

>    [  975.757789]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  975.757813]  [<c027498a>] fbcon_blank+0x11a/0x1b0
>    [  975.757837]  [<c02cff17>] do_unblank_screen+0x67/0x120
>    [  975.757869]  [<c02c8130>] complete_change_console+0x40/0xd0
>    [  975.757955]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.757979]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.758002]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.758029]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.758055]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.758081]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.758117] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.760205] cyblafb: pixclock =3D 135.00 MHz, k/m/n 0 5 3a
>=20
> And now, the be really shure, again, a call to set_par():
>=20
>    [  975.760827]  [<c0282331>] cyblafb_set_par+0x31/0xd80

Again, this set_par() is either from your patch, or you have multiple
fbdev's.

>    [  975.760856]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  975.760880]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.760923]  [<c02749e6>] fbcon_blank+0x176/0x1b0
>    [  975.760947]  [<c02cff17>] do_unblank_screen+0x67/0x120
>    [  975.760976]  [<c02c8130>] complete_change_console+0x40/0xd0
>    [  975.761002]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.761027]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.761050]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.761076]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.761102]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.761129]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.761164] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.763280] cyblafb: pixclock =3D 135.00 MHz, k/m/n 0 5 3a
>=20
> First of all: set_par is executed too often. With and without my patch.

In the final analysis, the set_par is actually called only once on an
X to console switch in a typical system. The multiple set_par() present
in your trace is due to:

a. different per-display var
b. multiple fbdevs
c. your patch.

In summary.  For a typical system (single fbdev, all vt's with the
same var) switching from X to vt should be like this, with only a
single, necessary call to set_par().

(The set_par call after fbcon_blank is only present when switching
from KD_GRAPHICS.  This will be absent on a KD_TEXT to KD_TEXT switch).

fbcon_blank()
set_par()=20
fbcon_switch()
fb_set_var()

If you have different vars, the sequence will be like this:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()->set_par()

If you have multiple fbdev's, same var:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()
set_par()

And if you have multiple fbdev's, different var's:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()->set_par()
set_par()

So the unnecessary (arguable) set_par calls are only present if
you have multiple fbdevs/multi-head system.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
