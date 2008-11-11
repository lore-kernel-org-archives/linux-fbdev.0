From: jkimble@one.net
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04on	Coldfire running 2.6.25)
Date: Tue, 11 Nov 2008 10:06:57 -0500 (EST)
Message-ID: <2308.137.237.242.125.1226416017.squirrel@webmail.nuvox.net>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20081111100657_64518"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1Kzupl-00078t-89
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 15:07:13 +0000
Received: from smtp-out3.atlngahp.sys.nuvox.net ([70.43.63.20]
	helo=smtp03.atlngahp.sys.nuvox.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KzupZ-0001G4-1I
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 15:07:13 +0000
In-Reply-To: <43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jkimble@one.net
Cc: linux-fbdev-devel@lists.sourceforge.net

------=_20081111100657_64518
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>> James Kimble wrote:
>>> I've been working on porting the s1d13xxxfb driver from the latest
>>> kernel from Freescale for Coldfire to work with the S1D13A04 chip. I
>>> was
>>> able to get things working to the point that I do get a little TUX logo
>>> up on the screen at boot up. Seemed like a good start but none of my
>>> user space applications will work. I can open the /dev/fb0 device and
>>> the data in the info structure is correct but if I try to write to any
>>> register or area in the frame buffer (or write to the device at all) I
>>> get a seg fault.
>>>
>>> I had an earlier driver working with the 2.6.10 kernel with the same
>>> hardware. The same application space program should work ( I would
>>> think...) but I get the seg fault on the first write to fb0. I tried a
>>> different memory location (ox4400 0000 to 0x7400 0000) for the CS
>>> associated with the video  chip, no  difference. Permissions for
>>> /dev/fb0 are "rw". No other process using fb0. This is really weird.
>>>
>>> Any help or suggestions MUCH appreciated.
>>>
>>
>> You are probably not reserving and/or translating physical memory space
>> to virtual if you get a segfault on every access. Try cat /proc/iomem.
>> Is
>> your device listed?
>>
>> OTOH, a lot of arch specific code has probably changed since 2.6.10 -
>> 2.6.25 that might not even be directly related to fb. Is your arch port
>> up to date?
>>
>> Also you might post your fb driver and someone might spot the fault
>> faster..
>>
>
> /proc/iomem shows:
>
> 74000000-74009000 : s1d13a04fb.0
> 74000000-74009000 : s1d13xxxfb regs
> 74040000-74068000 : s1d13a04fb.0
> 74040000-74068000 : s1d13xxxfb mem
> f000070c-f000070c : spi-int-mask
> f0000740-f000075f : spi-int-level
> f0000a50-f0000a50 : spi-par
> f0008a00-f0008ab8 : spi-module
> f0008f00-f0008f20 : MCF548X-i2c
> f000a000-f000a7ff : mcf548x-flexcan.0
> f000a000-f000a7ff : mcf548x-flexcan
> f000a800-f000afff : mcf548x-flexcan.1
> f000a800-f000afff : mcf548x-flexcan
> f0020000-f0033000 : fsl-sec1
> fc000000-ffffffff : physmap-flash.0
>
> Which looks fine to me. The s1d13 lines match the mapping I set up. I've
> attached the driver. It is the driver for this family of chips that was
> included in the Freescale release of the 2.6.25 kernel for Coldfire. It
> includes my changes.
>

Sorry, wrong devices file. Should have been mcf438x-devices.c. See attached..
------=_20081111100657_64518
Content-Type: application/octet-stream; name="mcf548x-devices.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mcf548x-devices.c"

LyoKICogYXJjaC9tNjhrL2NvbGRmaXJlL21jZjU0NDV4LWRldmljZXMuYwogKgogKiBDb2xkZmly
ZSBNNTQ0NXggUGxhdGZvcm0gRGV2aWNlIENvbmZpZ3VyYXRpb24KICoKICogQmFzZWQgb24gdGhl
IEZyZWVzY2FsZSBNWEMgZGV2aWNlcy5jCiAqCiAqIENvcHlyaWdodCAoYykgMjAwNyBGcmVlc2Nh
bGUgU2VtaWNvbmR1Y3RvciwgSW5jLgogKglLdXJ0IE1haGFuIDxrbWFoYW5AZnJlZXNjYWxlLmNv
bT4KICovCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
PgojaW5jbHVkZSA8bGludXgvaW5pdC5oPgojaW5jbHVkZSA8bGludXgvbXRkL3BoeXNtYXAuaD4K
I2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgojaW5jbHVkZSA8bGludXgvZnNsX2Rl
dmljZXMuaD4KI2luY2x1ZGUgPHZpZGVvL3MxZDEzeHh4ZmIuaD4KCiNpbmNsdWRlIDxhc20vY29s
ZGZpcmUuaD4KI2luY2x1ZGUgPGFzbS9tY2ZzaW0uaD4KCi8qIG1lbW9yeSBzcGFjZSAobGluZSA1
MiBvZiBIUCdzIGRvYykgKi8KI2RlZmluZSBFUFNPTlJFR1NUQVJUICAgMHg3NDAwMDAwMAojZGVm
aW5lIEVQU09OUkVHTEVOICAgICAweDAwMDA5MDAwCiNkZWZpbmUgRVBTT05GQlNUQVJUICAgIDB4
NzQwNDAwMDAKLyogMTYwa0IgZnJhbWVidWZmZXIgKi8KI2RlZmluZSBFUFNPTkZCTEVOICAgICAg
MHgwMDAyODAwMCAKCi8qCiNkZWZpbmUgRVBTT05SRUdTVEFSVCAgIDB4NDQwMDAwMDAKI2RlZmlu
ZSBFUFNPTlJFR0xFTiAgICAgMHgwMDAwOTAwMAojZGVmaW5lIEVQU09ORkJTVEFSVCAgICAweDQ0
MDQwMDAwCi8vIDE2MGtCIGZyYW1lYnVmZmVyCiNkZWZpbmUgRVBTT05GQkxFTiAgICAgIDB4MDAw
MjgwMDAgCiovCgpzdGF0aWMgc3RydWN0IHMxZDEzeHh4ZmJfcmVndmFsIHMxZDEzeHh4ZmJfaW5p
dHJlZ3NbXSA9IAp7CiAgICB7MHgxNCwgMHgwMDAwMDAwMH0sIC8qIFBvd2VyIFNhdmUgQ29uZmln
dXJhdGlvbiBSZWdpc3RlciAgICAgICAgICAgICovIAogICAgezB4NjQsIDB4MDAwMDAwMDB9LCAv
KiBHUElPIFN0YXR1cyBhbmQgQ29udHJvbCBSZWdpc3RlciAgICAgICAgICAgICAqLyAKICAgIHsw
eDA0LCAweDAwMDAwMDAwfSwgLyogTWVtb3J5IENsb2NrIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIg
ICAgICAgICAgKi8gCiAgICB7MHgwOCwgMHgwMDAwMDAzMn0sIC8qIFBpeGVsIENsb2NrIENvbmZp
Z3VyYXRpb24gUmVnaXN0ZXIgICAgICAgICAgICovCiAgICB7MHgwQywgMHgwMDAwMDBEMH0sIC8q
IFBhbmVsIFR5cGUgYW5kIE1PRCBSYXRlIFJlZ2lzdGVyICAgICAgICAgICAgICovCiAgICB7MHgx
MCwgMHgwMDgwMDAwOH0sIC8qIERpc3BsYXkgU2V0dGluZ3MgUmVnaXN0ZXIgICAgICAgICAgICAg
ICAgICAgICovCiAgICB7MHgyMCwgMHgwMDAwMDAyQn0sIC8qIEhvcml6b250YWwgVG90YWwgUmVn
aXN0ZXIgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHgyNCwgMHgwMDAwMDAyN30sIC8qIEhv
cml6IERpc3BsYXkgUGVyaW9kIFJlZ2lzdGVyICAgICAgICAgICAgICAgICovCiAgICB7MHgyOCwg
MHgwMDAwMDAwMH0sIC8qIEhvcml6IERpc3BsYXkgUGVyaW9kIFN0YXJ0IFBvc2l0aW9uIFJlZ2lz
dGVyICovCiAgICB7MHgyQywgMHgwMDg3MDE1Nn0sIC8qIEZQTElORSBSZWdpc3RlciAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHgzMCwgMHgwMDAwMDBGQX0sIC8qIFZlcnQg
VG90YWwgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHgzNCwgMHgw
MDAwMDBFRn0sIC8qIFZlcnQgRGlzcGxheSBQZXJpb2QgUmVnaXN0ZXIgICAgICAgICAgICAgICAg
ICovCiAgICB7MHgzOCwgMHgwMDAwMDAwMH0sIC8qIFZlcnQgRGlzcGxheSBQZXJpb2QgU3RhcnQg
UG9zaXRpb24gUmVnaXN0ZXIgICovCiAgICB7MHgzQywgMHgwMDgwMDAwMH0sIC8qIEZQRlJBTUUg
UmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHg0MCwgMHgwMDAw
MDAwMH0sIC8qIE1haW4gV2luZG93IERpc3BsYXkgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAgICov
CiAgICB7MHg0NCwgMHgwMDAwMDA1MH0sIC8qIE1haW4gV2luZG93IExpbmUgQWRkcmVzcyBPZmZz
ZXQgUmVnaXN0ZXIgICAgICovCiAgICB7MHg1MCwgMHgwMDAwMDAwMH0sIC8qIFBJUCsgV2luZG93
IERpc3BsYXkgU3RhcnQgQWRkcmVzcyBSZWdpc3RlciAgICovCiAgICB7MHg1NCwgMHgwMDAwMDA1
MH0sIC8qIFBJUCsgV2luZG93IExpbmUgQWRkcmVzcyBPZmZzZXQgUmVnaXN0ZXIgICAgICovCiAg
ICB7MHg1OCwgMHgwMDAwMDAwMH0sIC8qIFBJUCsgV2luZG93IFggUG9zaXRpb25zIFJlZ2lzdGVy
ICAgICAgICAgICAgICovCiAgICB7MHg1QywgMHgwMDAwMDAwMH0sIC8qIFBJUCsgV2luZG93IFkg
UG9zaXRpb25zIFJlZ2lzdGVyICAgICAgICAgICAgICovCiAgICB7MHg2MCwgMHgwMDAwMDAwMH0s
IC8qIFNwZWNpYWwgUHVycG9zZSBSZWdpc3RlciAgICAgICAgICAgICAgICAgICAgICovCiAgICB7
MHg3MCwgMHgwMDAwMDAwMH0sIC8qIFBXTSBDbG9jayBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICAg
ICAgICAgICAgICovCiAgICB7MHg3NCwgMHgwMDAwMDAxMH0sIC8qIFBXTU9VVCBEdXR5IEN5Y2xl
IFJlZ2lzdGVyICAgICAgICAgICAgICAgICAgICovCiAgICB7MHg4MCwgMHgwMDAwMDAwMH0sIC8q
IFNjcmF0Y2ggUGFkIEEgUmVnaXN0ZXIgICAgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHg4
NCwgMHgwMDAwMDAwMH0sIC8qIFNjcmF0Y2ggUGFkIEIgUmVnaXN0ZXIgICAgICAgICAgICAgICAg
ICAgICAgICovCiAgICB7MHg4OCwgMHgwMDAwMDAwMH0sIC8qIFNjcmF0Y2ggUGFkIEMgUmVnaXN0
ZXIgICAgICAgICAgICAgICAgICAgICAgICovCiAgICB7MHg2NCwgMHgwODA2MDAwMH0sIC8qIEdQ
SU8gU3RhdHVzIGFuZCBDb250cm9sIFJlZ2lzdGVyICAgICAgICAgICAgICovCiAgICB7MHgxNCwg
MHgwMDAwMDAwMH0sIC8qIFBvd2VyIFNhdmUgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAgICAgICAg
ICAgICovCn07CgpzdGF0aWMgc3RydWN0IHMxZDEzeHh4ZmJfcGRhdGEgczFkMTN4eHhmYl9kYXRh
ID0gewogICAgICAgIC5pbml0cmVncyAgICAgICAgICAgICAgID0gczFkMTN4eHhmYl9pbml0cmVn
cywKICAgICAgICAuaW5pdHJlZ3NzaXplICAgICAgICAgICA9IEFSUkFZX1NJWkUoczFkMTN4eHhm
Yl9pbml0cmVncyksCiAgICAgICAgLnBsYXRmb3JtX2luaXRfdmlkZW8gICAgPSBOVUxMCn07Cgpz
dGF0aWMgc3RydWN0IHJlc291cmNlIHMxZDEzeHh4ZmJfcmVzb3VyY2VzW10gPSB7CiAgICAgICAg
WzBdID0gewogICAgICAgICAgICAgICAgLnN0YXJ0ICA9IEVQU09ORkJTVEFSVCwKICAgICAgICAg
ICAgICAgIC5lbmQgICAgPSBFUFNPTkZCU1RBUlQgKyBFUFNPTkZCTEVOLAogICAgICAgICAgICAg
ICAgLmZsYWdzICA9IElPUkVTT1VSQ0VfTUVNLAogICAgICAgIH0sCiAgICAgICAgWzFdID0gewog
ICAgICAgICAgICAgICAgLnN0YXJ0ICA9IEVQU09OUkVHU1RBUlQsCiAgICAgICAgICAgICAgICAu
ZW5kICAgID0gRVBTT05SRUdTVEFSVCArIEVQU09OUkVHTEVOLAogICAgICAgICAgICAgICAgLmZs
YWdzICA9IElPUkVTT1VSQ0VfTUVNLAogICAgICAgIH0KfTsKCnN0YXRpYyBzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlIHMxZDEzeHh4ZmJfZGV2aWNlID0gewogICAgICAgIC5uYW1lICAgICAgICAgICA9
IFMxRF9ERVZJQ0VOQU1FLAogICAgICAgIC5pZCAgICAgICAgICAgICA9IDAsCiAgICAgICAgLmRl
diAgICAgICAgICAgID0gewogICAgICAgICAgICAgICAgLnBsYXRmb3JtX2RhdGEgID0gJnMxZDEz
eHh4ZmJfZGF0YSwKICAgICAgICB9LAogICAgICAgIC5udW1fcmVzb3VyY2VzICA9IEFSUkFZX1NJ
WkUoczFkMTN4eHhmYl9yZXNvdXJjZXMpLAogICAgICAgIC5yZXNvdXJjZSAgICAgICA9IHMxZDEz
eHh4ZmJfcmVzb3VyY2VzLAp9OwoKCnN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgY29sZGZpcmVfaTJj
X3Jlc291cmNlc1tdID0gewoJWzBdID0gewkJLyogSS9PICovCgkJLnN0YXJ0CQk9IE1DRl9NQkFS
ICsgMHgwMDhGMDAsCgkJLmVuZAkJPSBNQ0ZfTUJBUiArIDB4MDA4RjIwLAoJCS5mbGFncwkJPSBJ
T1JFU09VUkNFX01FTSwKCX0sCglbMl0gPSB7CQkvKiBJUlEgKi8KCQkuc3RhcnQJCT0gNDAsCgkJ
LmVuZAkJPSA0MCwKCQkuZmxhZ3MJCT0gSU9SRVNPVVJDRV9JUlEsCgl9LAp9OwoKc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgY29sZGZpcmVfaTJjX2RldmljZSA9IHsKCS5uYW1lCQkJPSAi
TUNGNTQ4WC1pMmMiLAoJLmlkCQkJPSAtMSwKCS5udW1fcmVzb3VyY2VzCQk9IEFSUkFZX1NJWkUo
Y29sZGZpcmVfaTJjX3Jlc291cmNlcyksCgkucmVzb3VyY2UJCT0gY29sZGZpcmVfaTJjX3Jlc291
cmNlcywKfTsKCnN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgY29sZGZpcmVfc2VjX3Jlc291cmNlc1td
ID0gewoJWzBdID0geyAgICAgICAgIC8qIEkvTyAqLwoJCS5zdGFydCAgICAgICAgICA9IE1DRl9N
QkFSICsgMHgwMDAyMDAwMCwKCQkuZW5kICAgICAgICAgICAgPSBNQ0ZfTUJBUiArIDB4MDAwMzMw
MDAsCgkJLmZsYWdzICAgICAgICAgID0gSU9SRVNPVVJDRV9NRU0sCgl9LAoJWzJdID0geyAgICAg
ICAgIC8qIElSUSAqLwoJCS5zdGFydCAgICAgICAgICA9IElTQ19TRUMsCgkJLmVuZCAgICAgICAg
ICAgID0gSVNDX1NFQywKCQkuZmxhZ3MgICAgICAgICAgPSBJT1JFU09VUkNFX0lSUSwKCX0sCn07
CgpzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBjb2xkZmlyZV9zZWNfZGV2aWNlID0gewoJ
Lm5hbWUgICAgICAgICAgICAgICAgICAgPSAiZnNsLXNlYzEiLAoJLmlkICAgICAgICAgICAgICAg
ICAgICAgPSAtMSwKCS5udW1fcmVzb3VyY2VzICAgICAgICAgID0gQVJSQVlfU0laRShjb2xkZmly
ZV9zZWNfcmVzb3VyY2VzKSwKCS5yZXNvdXJjZSAgICAgICAgICAgICAgID0gY29sZGZpcmVfc2Vj
X3Jlc291cmNlcywKfTsKCiNpZiBkZWZpbmVkKENPTkZJR19NVERfUEhZU01BUCkKc3RhdGljIHN0
cnVjdCBwaHlzbWFwX2ZsYXNoX2RhdGEgbWNmNTQ4NV9mbGFzaF9kYXRhID0gewoJLndpZHRoICAg
ICAgICAgID0gMiwKfTsKCnN0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgbWNmNTQ4NV9mbGFzaF9yZXNv
dXJjZSA9IHsKCS5zdGFydCAgICAgICAgICA9IDB4ZjgwMDAwMDAsCgkuZW5kICAgICAgICAgICAg
PSAweGY4MGZmZmZmLAoJLmZsYWdzICAgICAgICAgID0gSU9SRVNPVVJDRV9NRU0sCn07CgpzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBtY2Y1NDg1X2ZsYXNoX2RldmljZSA9IHsKCS5uYW1l
ICAgICAgICAgICA9ICJwaHlzbWFwLWZsYXNoIiwKCS5pZCAgICAgICAgICAgICA9IDAsCgkuZGV2
ICAgICAgICAgICAgPSB7CgkJLnBsYXRmb3JtX2RhdGEgID0gJm1jZjU0ODVfZmxhc2hfZGF0YSwK
CX0sCgkubnVtX3Jlc291cmNlcyAgPSAxLAoJLnJlc291cmNlICAgICAgID0gJm1jZjU0ODVfZmxh
c2hfcmVzb3VyY2UsCn07CiNlbmRpZgoKc3RhdGljIGludCBfX2luaXQgbWNmNTQ4NV9pbml0X2Rl
dmljZXModm9pZCkKewoJcHJpbnRrKEtFUk5fSU5GTyAiTUNGNTQ4NXggSU5JVF9ERVZJQ0VTXG4i
KTsKCglwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJmNvbGRmaXJlX2kyY19kZXZpY2UpOwoJcGxh
dGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZjb2xkZmlyZV9zZWNfZGV2aWNlKTsKCXBsYXRmb3JtX2Rl
dmljZV9yZWdpc3RlcigmczFkMTN4eHhmYl9kZXZpY2UpOwovKiNpZiBkZWZpbmVkKENPTkZJR19N
VERfUEhZU01BUCkKCXBsYXRmb3JtX2RldmljZV9yZWdpc3RlcigmbWNmNTQ4NV9mbGFzaF9kZXZp
Y2UpOwojZW5kaWYqLwoJcmV0dXJuIDA7Cn0KYXJjaF9pbml0Y2FsbChtY2Y1NDg1X2luaXRfZGV2
aWNlcyk7Cg==
------=_20081111100657_64518
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
------=_20081111100657_64518
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------=_20081111100657_64518--
