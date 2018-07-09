From: Felix Miata <mrmazda@earthlink.net>
Date: Mon, 09 Jul 2018 08:16:03 +0000
Subject: 1920x1080 output on 21:9 as 16:9 display compressed to 4:3 space absent video=1920x1080 on kernel cm
Message-Id: <06b6b2f1-dec4-6cb4-85e9-2fd734cc58a9@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------72C8BBB3CD5224AF09CDC5E7"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------72C8BBB3CD5224AF09CDC5E7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Description: Booted with no video-related cmdline parameters, 1920x1080
framebuffer output on two simultaneously connected displays outputs normal 16:9
1920x1080 on 1920x1080 hardware, but compresses 1920x1080 output into a 4:3
space on 2560x1080 hardware configured as 1920x1080 hardware in the display's
setup menu.

To reproduce:
systemd default = multi-user.target
Kernels: 4.17.3 Fedora, 4.16.12 & 4.12.14 openSUSE, 4.9.x Stretch, 4.16.x
Buster, 4.4.x Kubuntu 16.04 LTS
Gfxchips: (2X) ATI HD5450 Cedar and EVGA GT218 [GeForce 8400 GS Rev. 3]
Grub: 0.97 (openSUSE 13.1, 15.0, TW) or Grub 2.02~beta2-36 (Kubuntu)
Screen A: eisa 0x0063 "XVT323SV" on HDMI cable (ATI) native 1920x1080
Screen B: eisa 0x408b "DELL U2913WM" on DVI cable (ATI) native max 2560x1080;
"native" via monitor" menu setting 1920x1080

Screen B produces expected 16:9 1920x1080 output when screen A is not physically
connected. Screen B only responds when KMS is engaged (off during POST and
kernel/initrd loading).

Intel Kaby Lake G4600 with same displays and cables with Grub2-efi (using
load_video & gfxpayload=keep) works as expected without video=1920x1080 on
cmdline with 4.16.12 openSUSE, 4.16.12 Buster, 4.15.23 Kubuntu. Intel Haswell
G3220 with Grub 0.97 on openSUSE 4.17.3 with same cables and displays also works
as expected.

Should I report this at bugs.freedesktop.org?
-- 
"Wisdom is supreme; therefore get wisdom. Whatever else you
get, get wisdom." Proverbs 4:7 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/


--------------72C8BBB3CD5224AF09CDC5E7
Content-Type: text/plain; charset=UTF-8;
 name="hwinfo-monitor-d2913wm.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hwinfo-monitor-d2913wm.txt"

IyBod2luZm8gLS1tb25pdG9yIChvbiBEVkkpCjI0OiBOb25lIDAwLjA6IDEwMDAyIExDRCBN
b25pdG9yCiAgW0NyZWF0ZWQgYXQgbW9uaXRvci4xMjVdCiAgVW5pcXVlIElEOiByZENSLkwx
amxjZ1JCN2hCCiAgUGFyZW50IElEOiBWQ3UwLlhkODVKQzJJU241CiAgSGFyZHdhcmUgQ2xh
c3M6IG1vbml0b3IKICBNb2RlbDogIkRFTEwgVTI5MTNXTSIKICBWZW5kb3I6IERFTCAiREVM
TCIKICBEZXZpY2U6IGVpc2EgMHg0MDg5ICJERUxMIFUyOTEzV00iCiAgU2VyaWFsIElEOiAi
NVc5Mk42Nk4xMDVMIgogIFJlc29sdXRpb246IDcyMHg0MDBANzBIegogIFJlc29sdXRpb246
IDY0MHg0ODBANjBIegogIFJlc29sdXRpb246IDY0MHg0ODBANzVIegogIFJlc29sdXRpb246
IDgwMHg2MDBANjBIegogIFJlc29sdXRpb246IDgwMHg2MDBANzVIegogIFJlc29sdXRpb246
IDEwMjR4NzY4QDYwSHoKICBSZXNvbHV0aW9uOiAxMDI0eDc2OEA3NUh6CiAgUmVzb2x1dGlv
bjogMTI4MHgxMDI0QDc1SHoKICBSZXNvbHV0aW9uOiAxMTUyeDg2NEA3NUh6CiAgUmVzb2x1
dGlvbjogMTI4MHgxMDI0QDYwSHoKICBSZXNvbHV0aW9uOiAyNTYweDEwODBANjBIegogIFNp
emU6IDY3M3gyODQgbW0KICBZZWFyIG9mIE1hbnVmYWN0dXJlOiAyMDE2CiAgV2VlayBvZiBN
YW51ZmFjdHVyZTogMjUKICBEZXRhaWxlZCBUaW1pbmdzICMwOgogICAgIFJlc29sdXRpb246
IDI1NjB4MTA4MAogICAgIEhvcml6b250YWw6IDI1NjAgMjYyNCAyNjg4IDI3ODQgKCs2NCAr
MTI4ICsyMjQpIC1oc3luYwogICAgICAgVmVydGljYWw6IDEwODAgMTA4MyAxMDkzIDExMTEg
KCszICsxMyArMzEpICt2c3luYwogICAgRnJlcXVlbmNpZXM6IDE4NS41OCBNSHosIDY2LjY2
IGtIeiwgNjAuMDAgSHoKICBEcml2ZXIgSW5mbyAjMDoKICAgIE1heC4gUmVzb2x1dGlvbjog
MjU2MHgxMDgwCiAgICBWZXJ0LiBTeW5jIFJhbmdlOiA0OS04NiBIegogICAgSG9yLiBTeW5j
IFJhbmdlOiAyOS05NCBrSHoKICAgIEJhbmR3aWR0aDogMTg1IE1IegogIENvbmZpZyBTdGF0
dXM6IGNmZz1uZXcsIGF2YWlsPXllcywgbmVlZD1ubywgYWN0aXZlPXVua25vd24KICBBdHRh
Y2hlZCB0bzogIzIzIChWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyKQo=
--------------72C8BBB3CD5224AF09CDC5E7
Content-Type: text/plain; charset=UTF-8;
 name="hwinfo-monitor-viz-xvt323sv.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hwinfo-monitor-viz-xvt323sv.txt"

IyBod2luZm8gLS1tb25pdG9yIChvbiBIRE1JKQoyNTogTm9uZSAwMS4wOiAxMDAwMiBMQ0Qg
TW9uaXRvcgogIFtDcmVhdGVkIGF0IG1vbml0b3IuMTI1XQogIFVuaXF1ZSBJRDogd2tGdi5m
VlhEd0c1UVl1NAogIFBhcmVudCBJRDogVkN1MC5YZDg1SkMySVNuNQogIEhhcmR3YXJlIENs
YXNzOiBtb25pdG9yCiAgTW9kZWw6ICJYVlQzMjNTViIKICBWZW5kb3I6IFZJWiAKICBEZXZp
Y2U6IGVpc2EgMHgwMDYzICJYVlQzMjNTViIKICBTZXJpYWwgSUQ6ICJTS0dIQUwwMTAwMDAx
IgogIFJlc29sdXRpb246IDcyMHg0MDBANzBIegogIFJlc29sdXRpb246IDY0MHg0ODBANjBI
egogIFJlc29sdXRpb246IDY0MHg0ODBANzVIegogIFJlc29sdXRpb246IDgwMHg2MDBANjBI
egogIFJlc29sdXRpb246IDgwMHg2MDBANzJIegogIFJlc29sdXRpb246IDgwMHg2MDBANzVI
egogIFJlc29sdXRpb246IDEwMjR4NzY4QDYwSHoKICBSZXNvbHV0aW9uOiAxMDI0eDc2OEA3
MEh6CiAgUmVzb2x1dGlvbjogMTAyNHg3NjhANzVIegogIFJlc29sdXRpb246IDE5MjB4MTA4
MEA2MEh6CiAgU2l6ZTogNjk4eDM5MyBtbQogIFllYXIgb2YgTWFudWZhY3R1cmU6IDIwMTAK
ICBXZWVrIG9mIE1hbnVmYWN0dXJlOiAyCiAgRGV0YWlsZWQgVGltaW5ncyAjMDoKICAgICBS
ZXNvbHV0aW9uOiAxOTIweDEwODAKICAgICBIb3Jpem9udGFsOiAxOTIwIDIwMDggMjA1MiAy
MjAwICgrODggKzEzMiArMjgwKSAraHN5bmMKICAgICAgIFZlcnRpY2FsOiAxMDgwIDEwODQg
MTA4OSAxMTI1ICgrNCArOSArNDUpICt2c3luYwogICAgRnJlcXVlbmNpZXM6IDE0OC41MCBN
SHosIDY3LjUwIGtIeiwgNjAuMDAgSHoKICBEcml2ZXIgSW5mbyAjMDoKICAgIE1heC4gUmVz
b2x1dGlvbjogMTkyMHgxMDgwCiAgICBWZXJ0LiBTeW5jIFJhbmdlOiA1MC03NyBIegogICAg
SG9yLiBTeW5jIFJhbmdlOiAzMS03MCBrSHoKICAgIEJhbmR3aWR0aDogMTQ4IE1IegogIENv
bmZpZyBTdGF0dXM6IGNmZz1uZXcsIGF2YWlsPXllcywgbmVlZD1ubywgYWN0aXZlPXVua25v
d24KICBBdHRhY2hlZCB0bzogIzIzIChWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyKQo=
--------------72C8BBB3CD5224AF09CDC5E7--
