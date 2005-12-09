From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
Date: Fri, 09 Dec 2005 22:33:04 +0800
Message-ID: <439995A0.7070505@gmail.com>
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751083AbVLIOda@vger.kernel.org>
In-Reply-To: <43997037.4020206@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Knut Petersen wrote:
> Hi Tony!
>=20
>> Sorry, NAK for now.  Unless other people agree that it is okay for t=
hem
>> to have an unconditional call to set_par() for every console switch.=
 Note
>> that the set_par() in some drivers is terribly slow (several seconds
>> at least).
>>
>> Let's wait a few days, if nobody disagrees with you, so be it.
>>
>> =20
>>
> Which hardware needs several seconds?

savagefb does it in 3 seconds. I do remember a few nvidia cards that ta=
kes
longer. i810fb is okay, it's also in the millisecond range.

 I do run relatively slow hardware,
> but a complete
> set_par() needs less than 0.003 seconds with cyblafb.

Good for you.

>=20
> If there really is hardware that needs _several_ seconds for _one_
> set_par(), then we should
> really be more carefull when to call that function.

People accept that when switching from X to console and vice versa, it
will be slow. It's when switching from a text console to another that
needs to be very fast. Inserting a set_par that can take a few to sever=
al
seconds will eventually become frustrating for people who predominantly
work in console mode.

>=20
> Let=B4s have a look at a switch from the framebuffer console to X and=
 back.
>=20
> Kernel is a 2.6.15-rc4-git1 with my current cyblafb + your patches
> needed for cyblafb
> + the patch we are talking about.
>=20
> Framebuffer console is 1 with mode 1280x1024, X console is 7 and has
> been set to 1024x768
> before X was activated.
>=20
> Now I do run "chvt 7;sleep 3;chvt 1" on the vt 1.
>=20
>    [  972.360841]  [<c0282331>] cyblafb_set_par+0x31/0xd80
>    [  972.360898]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  972.360925]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  972.360951]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.360989]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.361018]  [<c02c8203>] change_console+0x43/0x90
>    [  972.361043]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.361101]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.361143]  [<c012c115>] kthread+0x95/0xd0
>    [  972.361171]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.361212] cyblafb: Switching to new mode: fbset -g 1024 768 1=
024
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.363308] cyblafb: pixclock =3D 64.99 MHz, k/m/n 1 b 6e
>=20
>    [  972.363916]  [<c0282331>] cyblafb_set_par+0x31/0xd80
>    [  972.363945]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  972.363969]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.363996]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.364023]  [<c02c8203>] change_console+0x43/0x90
>    [  972.364047]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.364093]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.364121]  [<c012c115>] kthread+0x95/0xd0
>    [  972.364143]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.364181] cyblafb: Switching to new mode: fbset -g 1024 768 1=
024
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.366271] cyblafb: pixclock =3D 64.99 MHz, k/m/n 1 b 6e
>    [  972.366325] cyblafb: Switching to KD_GRAPHICS
>=20
> Not so nice. Now let=B4s have a look at the log entries caused switch=
ing
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
> Without that prior set_par() that=B4s the point where the enhanced cy=
blafb
> would
> have serious problems:

As I've mentioned above, this can be easily fixed.

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
>=20
> Again a call to set_par:
>=20
>    [  975.754744]  [<c0282331>] cyblafb_set_par+0x31/0xd80
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
> First of all: set_par is executed too often. With and without my patc=
h.
>=20
> If we would know that vt x is nothing but the vt used for X, we could
> introduce a policy
> to completely ignore all framebuffer operations for that console. Tha=
t
> also would result
> in a much nicer look of the modeswitch. Do we need a new kernel
> parameter or should
> this be implemented by detected which vt is switched to KD_GRAPHICS?

I've tried this before, it is ugly.

>=20
> Switching from X to the console could be optimized a lot, I=B4m shure=
 that
> you do agree.
> We do need _one_ call to set_par() etc, but this must be at the right
> place. And the right
> place is somewhere before any other driver operation is called, with =
the
> exception of
> check_var() and init functions obviously.

The problem is that the console code has so many pathways that it is
difficult to find the correct moment to call a set_par.  Especially sin=
ce
there are so many cases where it's illegal for the console to write to
the framebuffer. Think KD_GRAPHICS, hardware/software suspend, hardware
initialization, etc. Think also that the hardware can be change by
the kernel (via stty) and by the user (via fbset, etc).

Yes, we can optimize the code pathways so we minimize calls to set_par
and set_var, but remember that just a few kernel versions ago, fbcon/
fbdev was plagued with bugs, so bug fixing was the priority, not
code optimization. Nowadays, core fbdev and fbcon looks pretty stable s=
o
we can redirect our effort towards this goal.

>=20
> Think about your NAK carefully. I might submit a patch to skeletonfb.=
c
> that inserts
> a warning at all places that might be unexpectedly called with a
> hardware state different
> to that set by set_par(). ;-))))

Go ahead.  Only pan_display, I believe, currently has this problem. And
again, the fix is simple.

>=20
> And please don=B4t argue that X or certain releases are broken. That =
is
> true, but ordinary
> users will use those broken versions for years.

I'm not arguing that.  However, we can always work around this buggy
implementation.  For example, one can do an

echo 1 > /sys/class/graphics/fb0/state

before kdm (the buggy one that forgets to set KD_GRAPHICS) is called.

Tony
