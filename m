From: Eric Bambach <eric@cisu.net>
Subject: VesaFB Problems
Date: Sun, 19 Jun 2005 22:36:57 -0500
Message-ID: <200506192236.58009.eric@cisu.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_anjtCcVJRsIWEd7"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkD5B-0003uk-UJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Jun 2005 20:36:21 -0700
Received: from pop-tawny.atl.sa.earthlink.net ([207.69.195.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkD5B-0007MR-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Jun 2005 20:36:21 -0700
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16] helo=mail.cisu.net)
	by pop-tawny.atl.sa.earthlink.net with esmtp (Exim 3.36 #10)
	id 1DkD56-0000Ba-00
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Jun 2005 23:36:16 -0400
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

--Boundary-00=_anjtCcVJRsIWEd7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,
=20
 Please CC me I'm not subscribed.

 If I am not asking on the correct list can someone refer me to a better pl=
ace=20
to ask?

 I am having trouble with vesafb. Here is an excerpt from dmesg, full dmesg=
=20
attached.

vesafb: BUG, returned from vm86 with 0
vesafb: warning, copying modelist from somewhere in RAM!
vesafb: Getting mode info block failed (eax=3D0x4f00)
vesafb: vbe_init failed
vesafb: probe of vesafb0 failed with error -22

#uname -a Linux eric 2.6.11-gentoo-r9 #7 SMP Sun Jun 19 21:57:28 CDT 2005 i=
686=20
AMD Athlon(tm) MP 2600+ AuthenticAMD GNU/Linux

 I am triying to get fbsplash working in Gentoo and I followed the=20
instructions to a T, but I get no output (as in fbsplash doesnt even try to=
=20
load) and I think its related to this message. I am using the nvidia module=
,=20
but its loaded WAY after this message and after fbsplash would try to=20
init...so I doubt theres a conflict. I have 1 AGP GeForce 4ish and a PCI=20
GeForce2 for dual monitors. Could it be related to 2 videocards?

 Any ideas about this message? Can I be of help debugging?

=2D-=20
=2D---------------------------------------
=2D-EB

> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0--Alan Cox LKML-December 08=
,2000=20

=2D---------------------------------------

--Boundary-00=_anjtCcVJRsIWEd7
Content-Type: application/x-gzip;
  name="lspci.dump.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci.dump.gz"

H4sICFk5tkIAA2xzcGNpLmR1bXAA3VfbbuJIEH0OX1GPiQShfcEYpDwQIBlr4sQbNpmREA9tu0la
6wtqG2aYr59qg8HmEi6Z3YdFIYmhqt3n1OlTZUIIaWc/1wS+xEkKruD+G2tDx5/RyGM+2NwTMfTY
jHssgWHH7o0Af9WaBgHbgaF139NrqjOCwTxJWQjdOEpFHARMwKVgM1DJVeXiLqBvSRvcaQIhxTBR
BcOw339VIWQ+n4bgs1nCgioENGWRNwdNrVzYLIzFHGgKvkmyF1xqas3laRUmgo1Z6r1TN2BXxdCx
QUhjfygME/6L3ehfR5ULq/4Ek1ikicxjMmfo80SG+aM8DsO6dEJdHvCUM4QwpATx3zswYyLhcQTq
NalUSM6jgjw6XesTNMq1b7NsuJyI+K3GxyC39hiLkAZIlBf7bHQup7dTTJkIHlIxvyGkCgmuF/nZ
lYJXUzcWPo8wY3HNvNoy/aZQEpe988hfgRzri/LUxo1x9qpcOAXScT+7shhZZrHmMmtNYxNptAad
U2g0Yfg0mSajLC9THmmcwxIpbUMBq9cHHmHimHqn7gRTFzvRr9bFNCkM7WwrMGCeA47gjqznYOom
2RE6+SY7UX4ggpLw/Uz4mdoVY1QCry2FeNqGOl3HWsLWzoclV1nhKmEpbNFEmfTTdyYiloK3Mp42
PNIUzyYelwELuRT41Etjgd4kEHf2HfQcUzNVAgqpKyR7F9Zam9hZ56wK1vNfoBitTa7xoGyaVbNk
VlEc1fYZ1hp3C3EPugMLEkRF0SmK2B/w84f4jXtQR08OXR4ny+uG5ilEIfASpIJqixU6Pp2kuVcT
pVywvUu14SX6J4p/RBI8FhFZ1MgpMmzmHDWbmxyZ2xwZGUeG/jFHijT1ciI5KtH8um3zOtq8E/9A
ZmwaIcUhi9K155dqofxfamE2NmvhbddCP7cW6r9eC4Wc3n1XhiPz8rbxX3dedaPzqtudV9Zlo4FK
2J5soNk/Wdvd05+VvD9rp/RnM+/P4zyr/3NCo4z15ydb1jXfwo7JaW1YSps0sDCv9x08G+EE7Vfe
tHhMolfuc1qy58dXFUtzz+5i4TEd/uago4Cy6cj8OVpUiioblcJbnFUfVTcLdlSQrb45d27Jthie
TzQfz56KatrbGjc+1vjWkdDLU6i2nkLVxTT/MrgttLHTzoLMXZyFZoFhdKvh05eutYfiQ92wpZWo
1YiqH6B2DUg/Qz+K0us9rySkgv0dERDAD+vq4u9SRq76x2UkO38Bq3KajD5+2vmMjNaMGsioPQ1S
LrFQoFOfxyVOu4IhkzMGD9RNAAXRwZC3+e7JbjOYkBbJE5yAzvfMUYcks9WQpNdsYfa9ozHjOB9N
pmneKY/Ba1s9q35PQ5bt4jj427kO5n5qTPf0zyFX4Y4L9g3fcGn1+31QtJZ+tX/rq2gnQ73LA44g
oLTKH3IN4/iTJMMPHLzVo8+uuUM/kt7WvucQCx8cg8yXrsFUG41m3ay3YLiKddCJ0RyWRqSQMqvW
rQ3FUPmQAoOzaNzoa8hL4xCNZfmZq6dEQx9trHXI3NaOtYPkQxr+DY7eDaujEgAA

--Boundary-00=_anjtCcVJRsIWEd7
Content-Type: application/x-gzip;
  name="dmesg.dump.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.dump.gz"

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

--Boundary-00=_anjtCcVJRsIWEd7--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
