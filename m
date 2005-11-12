From: Jurij Smakov <jurij@wooyd.org>
Subject: Image defects with 2.6.14/atyfb/Sunblade 100
Date: Fri, 11 Nov 2005 21:51:23 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0511112134500.3900@bobcat>
Reply-To: jurij@wooyd.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463804416-2026778518-1131774683=:3900"
Return-path: <bounce-debian-sparc=debian-sparc=m.gmane.org@lists.debian.org>
Resent-Message-ID: <DH0RwB.A.EfF.ELYdDB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-sparc@lists.debian.org>
List-Help: <mailto:debian-sparc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-sparc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-sparc-request@lists.debian.org?subject=unsubscribe>
To: Linux-fbdev-devel@lists.sourceforge.net
Cc: debian-sparc@lists.debian.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804416-2026778518-1131774683=:3900
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

[Forwarding information to linux-fbdev-devel]

Hello,

Recently Luigi Gangitano has pointed out a linux-fbdev-devel thread [0]
in which progress was achieved in fixing the atyfb bug resulting in 
console and X display corruption on SunBlade 100, filed as #321200 in the 
Debian bug tracking system [1]. The patch mentioned in the thread (which 
we plan to include in the next Debian kernel package release) is attached. 
While the situation with this patch is greatly improved, users testing the 
new 2.6.14 kernel packages have reported [2,3] that there is still some 
minor screen corruption in a form of red dots or lines. A screenshot 
(provided by Andrey Chernomyrdin) can be viewed at [4]. We'd appreciate 
any ideas which could lead to the resolution of this problem.

Please CC the responses to me (and, optionally to the 
debian-sparc@lists.debian.org), as I'm not subscribed to this list.

[0] http://marc.theaimsgroup.com/?t=111088248100003&r=1&w=2
[1] http://bugs.debian.org/321200
[2] http://lists.debian.org/debian-sparc/2005/11/msg00076.html
[3] http://lists.debian.org/debian-sparc/2005/11/msg00087.html
[4] http://www.wooyd.org/debian/tmp/sunblade.png

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Debian kernel team
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
---1463804416-2026778518-1131774683=:3900
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sparc-atyfb-xl-gr.patch
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=sparc-atyfb-xl-gr.patch

ZGlmZiAtYXVyIGEvZHJpdmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jIGIv
ZHJpdmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jDQotLS0gYS9kcml2ZXJz
L3ZpZGVvL2F0eS9hdHlmYl9iYXNlLmMJMjAwNS0xMC0yNyAxNzowMjowOC4w
MDAwMDAwMDAgLTA3MDANCisrKyBiL2RyaXZlcnMvdmlkZW8vYXR5L2F0eWZi
X2Jhc2UuYwkyMDA1LTExLTA5IDE5OjU2OjE4LjAwMDAwMDAwMCAtMDgwMA0K
QEAgLTQwNCw3ICs0MDQsNyBAQA0KIAl7IFBDSV9DSElQX01BQ0g2NEdNLCAi
M0QgUkFHRSBYTCAoTWFjaDY0IEdNLCBBR1ApIiwgMjMwLCA4MywgNjMsIEFU
SV9DSElQXzI2NFhMIH0sDQogCXsgUENJX0NISVBfTUFDSDY0R04sICIzRCBS
QUdFIFhMIChNYWNoNjQgR04sIEFHUCkiLCAyMzAsIDgzLCA2MywgQVRJX0NI
SVBfMjY0WEwgfSwNCiAJeyBQQ0lfQ0hJUF9NQUNINjRHTywgIjNEIFJBR0Ug
WEwgKE1hY2g2NCBHTywgUENJLTY2L0JHQSkiLCAyMzAsIDgzLCA2MywgQVRJ
X0NISVBfMjY0WEwgfSwNCi0JeyBQQ0lfQ0hJUF9NQUNINjRHUiwgIjNEIFJB
R0UgWEwgKE1hY2g2NCBHUiwgUENJLTMzTUh6KSIsIDIzMCwgODMsIDYzLCBB
VElfQ0hJUF8yNjRYTCB9LA0KKwl7IFBDSV9DSElQX01BQ0g2NEdSLCAiM0Qg
UkFHRSBYTCAoTWFjaDY0IEdSLCBQQ0ktMzNNSHopIiwgMjMwLCA4MywgNjMs
IEFUSV9DSElQXzI2NFhMIHwgTTY0Rl9TRFJBTV9NQUdJQ19QTEwgfSwNCiAJ
eyBQQ0lfQ0hJUF9NQUNINjRHTCwgIjNEIFJBR0UgWEwgKE1hY2g2NCBHTCwg
UENJKSIsIDIzMCwgODMsIDYzLCBBVElfQ0hJUF8yNjRYTCB9LA0KIAl7IFBD
SV9DSElQX01BQ0g2NEdTLCAiM0QgUkFHRSBYTCAoTWFjaDY0IEdTLCBQQ0kp
IiwgMjMwLCA4MywgNjMsIEFUSV9DSElQXzI2NFhMIH0sDQogDQo=

---1463804416-2026778518-1131774683=:3900--
