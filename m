From: Javier Marcet <jmarcet@pobox.com>
Subject: Re: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 18:53:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016165300.GA14900@jerry.marcet.dyndns.org>
References: <4C7D0093FFE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 137-123-adsl.red.retevision.es ([80.224.123.137] helo=jerry.marcet.dyndns.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181rPi-0000JH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 09:52:55 -0700
Content-Disposition: inline
In-Reply-To: <4C7D0093FFE@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Petr Vandrovec <VANDROVE@vc.cvut.cz> [021016 18:02]:

>> By more than one head you mean more than one physical card? Or does my
>> G400MAX with its two heads count as more than one?

>It counts as two if you are using /dev/fb1...

OK.

>> One strange thing I've seen though, is that I cannot use 'fbset -depth
>> xx' with xx other than 32 or I'll get:
>>     'ioctl FBIOPUT_VSCREENINFO: Invalid argument'

>16bpp should work too on second head.

I can only use 32 bits. Don't ask me why.

>> >If you'll use 'fbset -fb /dev/ttyX', no oops should occur.
>>=20
>> Whenever I try to pass a tty as argument to the -fb option I get the
>> same error I wrote above.

>16bpp and 32bpp should work. Because of values in default /etc/fb.modes
>are with 8bpp, you must use 'fbset 1024x768-60 -depth 32'. And if
>you are using Debian (maybe it is problem with stock fbset, I did not
>verified it), make sure that videomode 1024x768-72 in /etc/fb.modes
>does not use 10224 as xres/vxres... Most of monitors and videocards does=
=20
>not handle xres=3D10224 properly. You need dozen of megabytes vram to
>use this mode...

I have my custom fb.modes, indeed I'm trying to provide find some nice
default values to include in the package I'm writing for Gentoo, which
is the distribution I use, http://www.gentoo.org
Free and completely open source as Debian, but source based.

>> >> I tried matroxfb-vsync-irq-patch-2.4.19 too, but with it I cannot use=
 at

>> I know it is not a problem of the card itself, since without that patch
>> I don't have problems, but with it whenever a card on the 1st PCI tries
>> to use an IRQ, say a NIC card which is enabled by a 'if eth0 up', the
>> system blocks. No output, no sysrq, nothing, just a solid freeze.

>Maybe that it enables IRQ on card before installing IRQ handler.
>In such case nobody is going to clear IRQ in mga IRQ status register,
>and your system is processing endless stream of interrupts. Buying
>another CPU may give you chance to debug it. Or if you'll send
>me pointer to the patch, I can review it...

You mean the patch that gives the problem or .. what? It's the
vsync-irq-patch on your ftp server.

>Which one? fbset-through-vt? It should not change behavior of
>fbset when using 'fbset -fb /dev/fb*', it just adds possibility
>to use 'fbset -fb /dev/tty*' to set videomode on specific virtual
>terminal. And it should not cause any behavior changes to matroxset.

Oh, I see. That's what I wanted to know exactly, what that patch was
exactly for. Now it's everything more clear :)

>If mga-*-tvout, it adds support for DVI-D and TV outputs available
>on G450/G550.

OK, I don't need that one but it's already included in -ac branch.
Maybe Alan agrees to include the fbset-through-vt one too, even if
Marcelo, or whoever, refused to include it.

>> >set -e

>> What is this for? emacs mode?

>Stop on error... so in your case it will stop just immediately
>after fbset will fail, instead of performing (now useless and
>dangerous) second fbset, matroxset, and chvt.

I'll add it then.

>> I cannot do that, or else I'll get the 'ioctl FBIOPUT_VSCREENINFO:
>> Invalid argument'. The only way I've found is to switch to the desired
>> vt, and run fbset there.

>Do you have 16MB or 32MB device? -vyres 3276 will work only if
>you have 8MB available for second head. With 16MB device maybe
>only 7.9MB is available for second head. And of course, you must have

I have 32MB device. G400MAX DH. The best one IMHO that matrox did of the
G4xx series.

>Yes. With yres=3Dvyres you cannot use hardware panning, hardware must
>always move full screen 16 graphics lines up. Even if MGA core
>can transfer 1GBps, it takes some time to scroll 3MB (for 1024x768/32bpp)
>up - to scroll out all 48 lines it is 144MB read + 144MB written...

I see, then my assumptions were correct.

>> Also, with fastfonts
>> enabled, it's terribly slow, while in the kernel documentation it's
>> stated than fastfonts is faster on Gx00 cards.
>> Has that anything to do with the scrollback you told me before? I have
>> not tried it yet.

>No. fastfont should be used only on G200 (if anywhere...). On G200
>you'll get about 10% speed gain, on older chips about 10% slowdown.
>But (for unknown reason...) on G400 you'll get about 1000% slowdown.
>Maybe I should rerun benchmarks listed in Documentation/fb/matroxfb.txt
>also on newer hardware.

Tell me if you wanna have results from other systems.

>> Anyway, thanks, and I mean a BIG thanks for your detailed quick and
>> prompt response. I wish I got such a nice help with a bttv/DVB cards
>> problem I cannot solve.

>Buy me one... if it is terrestric digital broadcast, maybe I could
>even receive some digital signal here.

Believe me, I would. But being a student with nearly zero income, I just
can't. Indeed, getting a different DVB card might give me some pointer
to where the problem is.

The thing is that without my DVB card installed on the system, I can use
the bttv analog TV card just fine. The kernel recognizes it as a 'WinTV
Go' - it's one of the two bttv cards I have over here -, and it works.
However, once I plug the DVB in a PCI slot, anyone of them, the bttv
card is not even recognized by the kernel.

With both cards inserted I get this out of 'lspci -v':

00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 15
	Memory at de800000 (32-bit, non-prefetchable) [size=3D512]

00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
	Subsystem: Unknown device 0030:13eb
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at e1000000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [04] #06 [0290]

00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
	Subsystem: Unknown device 0030:13eb
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at e0800000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [04] #06 [0290]

Whereas if I remove the DVB card, the output is:

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 15
	Memory at e1000000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 15
	Memory at e0800000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

The most strange thing is that in the past I know they worked under
Windows at the same time, and I believe I once made them work in Linux
at the same time. I've tried kernels from 2.4.18 to latest 2.4.20-pre,
I've come back several revisions of my BIOS, everything. They just
cannot coexist on my system at the same time.
When I try to use the bttv when it's not correctly recognized, I can
load the bttv modules and the card is found, yet If I try to use it, I
can only get sound and lots of SYNC IRQ problems with my SCSI card:

Oct 15 00:51:22 [kernel] bttv0: registered device video0
Oct 15 00:51:33 [kernel] scsi0: PCI error Interrupt at seqaddr =3D 0x9
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=3D12670014
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=3D12670014
Oct 15 00:51:38 [kernel] bttv0: resetting chip
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr =3D 0x8
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=3D12670014
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=3D12670014
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr =3D 0x9
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=3D12670000

This is of course without having loaded any DVB driver.

All right, forgive me for the off-topic. I might make it somewhat
on-topic by saying that the errors above were using 'fbtv' which uses
the framebuffer to show the TV signal.


--=20
Javier Marcet <jmarcet@pobox.com>
Saint Louis University, Madrid Campus

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2tmWwACgkQx/ptJkB7frycjgCeL5EHOLP+Gl6F3v11rMxl074J
wBYAnRHVzyDrYuRorrNuuEQ44//QkrYR
=P7ce
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
