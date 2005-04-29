From: <kiran.tigadi@wipro.com>
Subject: Epson Smart LCD driver for linux.
Date: Sat, 30 Apr 2005 00:52:59 +0530
Message-ID: <DC91351678E31E4FB24B551221F507ECAE3D68@blr-itp-msg.wipro.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C54CF1.7D391020"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRbEk-0005w4-1f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 12:33:18 -0700
Received: from wip-ec-wd.wipro.com ([203.101.113.39])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRbEi-0000c3-4j
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 12:33:17 -0700
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0FDC020534
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Apr 2005 00:54:55 +0530 (IST)
Received: from blr-ec-bh2.wipro.com (unknown [10.200.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id E357720533
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Apr 2005 00:54:54 +0530 (IST)
Content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C54CF1.7D391020
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am new to frame buffer drivers. I have Epson Dual Mode Display Panel. =
If anybody worked on sismilar panels. please send in their experiance =
and also if u can send template driver I would appriciate.
=20
Thanks & Regards,
Kiran.T
=20

------_=_NextPart_001_01C54CF1.7D391020
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgITAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAIwAAAEVwc29uIFNtYXJ0IExDRCBk
cml2ZXIgZm9yIGxpbnV4LiAA0AsBBYADAA4AAADVBwQAHgAAADQAOwAGAHMBASCAAwAOAAAA1QcE
AB4AAAA5ACAABgBdAQEJgAEAIQAAADcwNEVENDlBMDI1QkE4NEVCODUwQjdGNjEyMkNDMEQ1ADUH
AQOQBgAsDAAAOQAAAAMANgAAAAAAQAA5AMcRrdrwTMUBHgA9AAEAAAABAAAAAAAAAAIBRwABAAAA
MwAAAGM9dXM7YT0gO3A9V2lwcm87bD1CTFItSVRQLU1TRy0wNTA0MjkxOTI3MzJaLTcxMDAyAAAe
AEkAAQAAADkAAABbTGludXgtZmJkZXYtZGV2ZWxdIExDRCBDb250cm9sbGVyIHdpdGggdmVydGlj
YWwgcGFja2luZwAAAABAAE4AgF2HG6hMxQEeAFoAAQAAAC4AAABsaW51eC1mYmRldi1kZXZlbC1h
ZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHkAAAAAAAAAgSsfpL6jEBmdbgDd
AQ9UAgAAAABsaW51eC1mYmRldi1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01U
UABsaW51eC1mYmRldi1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEA
AAAzAAAAU01UUDpMSU5VWC1GQkRFVi1ERVZFTC1BRE1JTkBMSVNUUy5TT1VSQ0VGT1JHRS5ORVQA
AB4AXQABAAAADwAAAGpheWFrdW1hciBsa21sAAACAV4AAQAAAEUAAAAAAAAAgSsfpL6jEBmdbgDd
AQ9UAgAAAABqYXlha3VtYXIgbGttbABTTVRQAGpheWFrdW1hci5sa21sQGdtYWlsLmNvbQAAAAAC
AV8AAQAAAB4AAABTTVRQOkpBWUFLVU1BUi5MS01MQEdNQUlMLkNPTQAAAB4AZgABAAAABQAAAFNN
VFAAAAAAHgBnAAEAAAAuAAAAbGludXgtZmJkZXYtZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9y
Z2UubmV0AAAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABkAAABqYXlha3VtYXIubGttbEBn
bWFpbC5jb20AAAAAHgBwAAEAAAAjAAAARXBzb24gU21hcnQgTENEIGRyaXZlciBmb3IgbGludXgu
IAAAAgFxAAEAAAAbAAAAAcVM8Iu1rTzLX9pwQs2MyvtcmhiASAAAE76qAB4AdAABAAAAKAAAAGxp
bnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAeABoMAQAAACgAAABLaXJhbiBU
aWdhZGkgKFdUMDEgLSBURUxFQ09NIFNPTFVUSU9OUykAHgAdDgEAAAAjAAAARXBzb24gU21hcnQg
TENEIGRyaXZlciBmb3IgbGludXguIAAAAgEJEAEAAABvBAAAawQAAMIOAABMWkZ1/8G9nAMACgBy
Y3BnMTI1gjIDQ2h0bWwxAzA/AQMB9wqAAqQD4wIAY2jBCsBzZXQwIAcTAoD/EAMAUARWCFUHshHV
DlEDAd0Q1zIGAAbDEdUzBEYQ2W8S6xHjCO8J9zsYzw4wNTsR0gxgYwBQCwkBZDM2kxFgC6U0IBAC
KlwOsr0BkGcU8AqjEeMd6DQU8AA8IURPQ1RZUABFIEhUTUwgUABVQkxJQyAiLSAvL1czQyGARFQi
RCCUMy4yIYBFTpwiPh7tHo8jwTE4H/BvIKIjDyQfJpAzHYAlcEV8QUQlzQ7xJu8pbyT0NkEO8DxN
RVRBB7BBMSxgPSJHCfAEkGF0RQWwIhLQT05UItBUEyzwBeFFeBDxbmdlPQZSdhMxL0EAkAIgIDYI
LjUuAcAzMi4zTjki/irPJQM3Nx/wVFBJVExFJc40DvBbgkwLgHV4LWZiAQAEdi01YWVsXSBMnkMi
EAhQAjADYGxsEzFpA/B0aC9ydA3gB0AgqQqwY2sLgGckbjUf8P4vM18xjyZFNKE5cChPJp8FPUQ1
EWA8Qk9EWUc8vRzxPd9nOTYf8ERASVYgaWQ9QjBPEFdBUmULUHlUZUB4dDExMzUzIGToaXI9PWBy
PLA9IwAhPiAAAEPhCrFE0hDwXHH/AyFERRFgP59Ar0G2Q69Ev3NFyjz5NjRJqkX/JPQ0FSVRRi3R
IACQemU9jjJJmwviRdlIaSwkfPo1QcEvT0JJmUmnS+sBwN9JpwqiVAgKgCR8MCgRIeD/QgBTX03f
R09IX0lvSn9UP/9Mn1lfTr9Pz1DcUe9S/1kvBT01OB2AJm5ic3DjAoBdB1wnYQFAXs9VP/9WT1df
WG9nf1qPW59cr12/P2ovX99vT2H/Yw9QzUkguGFtIC0wB+AtcCADULN7IC7wYnUBIBMxZAUQ/S+C
LnrxEQAvQB2cHYBwxHhFcHMCIGffaO9p+kR6dTexTQRxggAEAAtRefd/P4BPafpQAHA10H0Bc3Bl
AHB5BuBkeTbwBbBrzQmAIC/RAJBzbQMQCsE/CrCGIXzxfZ9w4gtQZWE/ETB40Anwh3ALgHuAaGW1
coAgQxBwBnEAcGMu8D8AcIdwB0B/AEIgc3B1IMc3oIehiqJ0ZW0LUY2Q53yFevGHIHVsh3CI33Di
aGFwcAUQYwcwjZAu/2UPZh9UD2sfbC9tP25Pdv//cG9xf3KPc590r3W/ds933/9473n/kR+SL5hf
g4+En54v/5Sfla+Wv6XPmN+Z75r/nA9/nR+pj58/rq+hX6JvUPpUvS6xawQgpw97IKhKJrYI6Qfw
ZWcLEXNR36U/ky//qj+rT6xfrW+2H6+PsJ+xr3+yv7PPtN+177b/uA+5HyDmS8hwAHAuVL3fvu+/
///BD8Ifwy/EP8zvxl/Hb8h//8mPyp/Lr8y/zc/O38/v0W//0n/Yr6dvqH/ef9Tv1f/XD3/mH+Rf
7X/uj9mf8h/zLzX9JVEvPz89j/alMyE8YCWTAn35EAAeADUQAQAAAD8AAAA8REM5MTM1MTY3OEUz
MUU0RkIyNEI1NTEyMjFGNTA3RUNBRTNENjhAYmxyLWl0cC1tc2cud2lwcm8uY29tPgAAHgBHEAEA
AAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAABMAAAARQBwAHMAbwBuACAAUwBt
AGEAcgB0ACAATABDAEQAIABkAHIAaQB2AGUAcgAgAGYAbwByACAAbABpAG4AdQB4AC4ALgBFAE0A
TAAAAAsA9BAAAAAACwD1EAAAAAALAPYQAAAAAEAABzDHEa3a8EzFAUAACDAII0x98UzFAQMA3j+v
bwAAAwDxPwkEAAAeAPg/AQAAADsAAABLaXJhbiBUaWdhZGkgKFdUMDEgLSBURUxFQ09NICYgSU5U
RVItTkVUV09SS0lORyBTT0xVVElPTlMpAAACAfk/AQAAAFsAAAAAAAAA3KdAyMBCEBq0uQgAKy/h
ggEAAAAAAAAAL089V0lQUk8vT1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JPVVAvQ049UkVDSVBJ
RU5UUy9DTj1USUdBREkAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8B
AAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMA
GkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAABwAAAFRJR0FESQAAHgAxQAEAAAAHAAAAVElH
QURJAAAeADJAAQAAAC4AAABsaW51eC1mYmRldi1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQAAAAeADNAAQAAABkAAABqYXlha3VtYXIubGttbEBnbWFpbC5jb20AAAAAHgA4QAEAAAAH
AAAAVElHQURJAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAGEDnc
7pIDAAcQuQAAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABISSxJQU1ORVdUT0ZSQU1FQlVG
RkVSRFJJVkVSU0lIQVZFRVBTT05EVUFMTU9ERURJU1BMQVlQQU5FTElGQU5ZQk9EWVdPUktFRE9O
U0lTTUlMQVJQQU5FTFNQTEVBU0VTRU5EAAAAAAIBfwABAAAAPwAAADxEQzkxMzUxNjc4RTMxRTRG
QjI0QjU1MTIyMUY1MDdFQ0FFM0Q2OEBibHItaXRwLW1zZy53aXByby5jb20+AACkkQ==

------_=_NextPart_001_01C54CF1.7D391020--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
