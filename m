From: Philipp Hahn <hahn@univention.de>
Date: Tue, 15 Nov 2016 09:29:45 +0000
Subject: Bug#822575: fb: switching to cirrusdrmfb from simple
Message-Id: <20161115092945.22114.99900.reportbug@ivar.knut.univention.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Source: linux
Version: 4.9~rc5-1~exp1
Followup-For: Bug #822575

Dear Maintainer,

I have the same problem with cirrusfb: After that last message the
screen does not update anymore (but I can login through ssh).

After lots of research I things the problem is related to
CONFIG_X86_SYSFB being enabled in Debian by default:

$ git rev-parse HEAD # git://anonscm.debian.org/kernel/linux.git
6c0c9bcf78dfc886907d006b8cb6c2ea0f075a62
$ git grep -n -F -e CONFIG_X86_SYSFB -e CONFIG_FB_SIMPLE
config/armhf/config:1187:CONFIG_FB_SIMPLE=3Dy
config/kernelarch-x86/config:73:CONFIG_X86_SYSFB=3Dy
config/kernelarch-x86/config:1776:CONFIG_FB_SIMPLE=3Dy

By default the video RAM is claimed by the boot framebbuffer:
> # cat /proc/fb
> 0 simple
> # grep 80000000 /proc/iomem
> 80000000-febfffff : PCI Bus 0000:00
>   80000000-81ffffff : 0000:00:02.0
>     80000000-801d4fff : BOOTFB

When cirrusdrmfb loads, it disabled the bootfb and tries to claim that
region. As it is still held by bootfb, this failes:
> # modprobe cirrus
> # dmesg
> [  263.171744] checking generic (80000000 1d5000) vs hw (80000000 2000000)
> [  263.171753] fb: switching to cirrusdrmfb from simple
> [  263.171838] Console: switching to colour dummy device 80x25
> [  263.177052] [drm:cirrus_device_init [cirrus]] *ERROR* can't reserve VR=
AM
> [  263.177066] cirrus 0000:00:02.0: Fatal error during GPU init: -6
> [  263.177072] Trying to free nonexistent resource <0000000082029000-0000=
000082029fff>
> [  263.177080] Trying to free nonexistent resource <0000000080000000-0000=
000081ffffff>

/proc/fb is empty afterwards, as bootfb remains disabled.

My solution was to remove cirrus.ko and cirrusfb.ko from
/lib/modules/`uname -r`/kernel/ and to re-build the initramfs. That
prevented cirrus from being loaded, leaving the simple-frame-buffer intact.
Loading the module by hand breaks the console again.

I found that SUSE bug
<https://bugzilla.novell.com/show_bug.cgi?id=855821>, where Takashi Iwai
finally disabled those options for OpenSUSE.

Ubuntu disabled the Cirrus drm driver first,
<https://bugs.launchpad.net/ubuntu/+source/grub2/+bug/1038055>
but later changed to only disable X86_SYSFB.

So probably it's best to disable X86_SYSFB:
> config X86_SYSFB
> 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
> 	help
> 	  Firmwares often provide initial graphics framebuffers so the BIOS,
> 	  bootloader or kernel can show basic video-output during boot for
> 	  user-guidance and debugging. Historically, x86 used the VESA BIOS
> 	  Extensions and EFI-framebuffers for this, which are mostly limited
> 	  to x86.
> 	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
> 	  framebuffers so the new generic system-framebuffer drivers can be
> 	  used on x86. If the framebuffer is not compatible with the generic
> 	  modes, it is adverticed as fallback platform framebuffer so legacy
> 	  drivers like efifb, vesafb and uvesafb can pick it up.
> 	  If this option is not selected, all system framebuffers are always
> 	  marked as fallback platform framebuffers as usual.
>=20
> 	  Note: Legacy fbdev drivers, including vesafb, efifb, uvesafb, will
> 	  not be able to pick up generic system framebuffers if this option
> 	  is selected. You are highly encouraged to enable simplefb as
> 	  replacement if you select this option. simplefb can correctly deal
> 	  with generic system framebuffers. But you should still keep vesafb
> 	  and others enabled as fallback if a system framebuffer is
> 	  incompatible with simplefb.
>=20
> 	  If unsure, say Y.

If you read <https://patchwork.kernel.org/patch/3380911/> there was a
patched proposed to change it to 'N' and/or to depend on FB_SIMPLE, but
that patch never made it into linux.

Nor did <https://patchwork.kernel.org/patch/3368351/> or
<https://patchwork.kernel.org/patch/3528991/>.

I tried to contact David Herrmann himself, but never got a reply.

So I think Debian should disable X86_SYSFB for now, too.

Thank you for your work and help
Philipp "also a Debian maintainer" Hahn
-- System Information:
Debian Release: 8.6
  APT prefers stable-updates
  APT policy: (500, 'stable-updates'), (500, 'stable'), (90, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 3.16.0-4-amd64 (SMP w/4 CPU cores)
Locale: LANG=DE_DE.UTF-8, LC_CTYPE=DE_DE.UTF-8 (charmap=3DUTF-8)
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)
