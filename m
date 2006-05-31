From: "Prakhar Vig" <prakharv@gmail.com>
Subject: Re: How to use ISRAm as a frame buffer in Linux
Date: Wed, 31 May 2006 15:10:52 +0530
Message-ID: <dbee5b5a0605310240q3de9582cwccf9d5ee4a012a46@mail.gmail.com>
References: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>
	 <447C3BAB.70003@gmail.com>
	 <dbee5b5a0605302143l7b0b4d24kdf0d77685b7ad4d9@mail.gmail.com>
	 <447D204A.60007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_21153_26348002.1149068452871"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlNCE-00043S-87
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 02:40:58 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlNCA-00013u-MI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 02:40:55 -0700
Received: by ug-out-1314.google.com with SMTP id j40so1433940ugd
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 May 2006 02:40:53 -0700 (PDT)
In-Reply-To: <447D204A.60007@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

------=_Part_21153_26348002.1149068452871
Content-Type: multipart/alternative; 
	boundary="----=_Part_21154_13041220.1149068452871"

------=_Part_21154_13041220.1149068452871
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Antonino,
thanks for ur help.

As u have told I am using an application that reads a data from framebuffer
by opening /dev/fb0. I am attaching the code for ur convineance, I would
like to ask following questions:

1) In this code I am using mmap to allocate memory to frame buffer which ha=
s
one argument
MAP_SHARED or MAP_PRIVATE. Could you please explain for what this meant for
i.e whether it ie related to allocation in SDRAM or ISRAM. MAP_SHARED in
SDRAM and MAP_PRIVATE in ISRAM is it so.

2) If not, Could you please tell me how to allocate framebuffer to ISRAM as
is faster to access from ISRAM than SDRAM.

3) Also, tell me whether I need to use DMA to access data from ISRAM, will
it improve the speed of accessing the data from ISRAM. Is it mandatory to
use DMA if you want to make it work fast.

Once again thanks for yr earnest help.

Thanks And Regards
Prakhar



On 5/31/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>
> Prakhar Vig wrote:
> > Hi Antonino,
> >
> > I tried reading the data from framebuffer using cat as u have told, I
> > wrote the following command:
> >
> > cat /dev/fb0 > image.txt
> >
> > Is the command correct or not, as I am getting some corrupted data.....=
.
> > Below is the some part of data, which I am getting:
> >
> >
> W<8d>=C3=B5<8c>^U<8d>=C3<8c><8c>c<86>2^D"=C3(c)^Y=C3=AD2=C3*uC[\<9c>d=C3^=
\m^\u]u|}\}}}<9d><85>^?<8^?<85>=C2=BF<8d>=C3<8d>=C3=BE<95>=C3<95>=C3=BD<95>=
=C3=BD<95>=C3=BF<9d>=C3=BF<9d>^_<9e>^_<9e>^_<9e>?<9e>><9e>9d><98>=C2=A5p
> >
> >
> > And could you please tell me how to get the RGB data from framebuffer.
> >
>
> What you get is raw framebuffer format.  If you 'cat image.txt >
> /dev/fb0',
> you'll get the same image you dumped previously.
>
> In order for it to be read by an image viewer, you have to convert it
> into a standard format.
>
> Try searching for fbshot or fbgrab and look at the source.
>
> Tony
>

------=_Part_21154_13041220.1149068452871
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Antonino,</div>
<div>thanks for ur help.</div>
<div>&nbsp;</div>
<div>As u have told I&nbsp;am using an application that&nbsp;reads a data&n=
bsp;from framebuffer by opening /dev/fb0. I am attaching the code for ur co=
nvineance, I would like to ask following questions:</div>
<div>&nbsp;</div>
<div>1) In this code I am using mmap to allocate memory to frame buffer whi=
ch has one argument </div>
<div>MAP_SHARED or MAP_PRIVATE. Could you please explain for what this mean=
t for i.e whether it ie related to allocation in SDRAM or ISRAM. MAP_SHARED=
 in SDRAM and MAP_PRIVATE in ISRAM is it so.</div>
<div>&nbsp;</div>
<div>2) If not, Could you please tell me how to allocate framebuffer to ISR=
AM as is faster to access from ISRAM than SDRAM.</div>
<div>&nbsp;</div>
<div>3) Also, tell me whether I need to use DMA to access data from ISRAM, =
will it improve the speed of accessing the data from ISRAM. Is it mandatory=
 to use DMA if you want to make it work fast.</div>
<div>&nbsp;</div>
<div>Once again thanks for yr earnest help.</div>
<div>&nbsp;</div>
<div>Thanks And Regards</div>
<div>Prakhar</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/31/06, <b class=3D"gmail_sendername">=
Antonino A. Daplas</b> &lt;<a href=3D"mailto:adaplas@gmail.com">adaplas@gma=
il.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Prakhar Vig wrote:<br>&gt; Hi An=
tonino,<br>&gt;<br>&gt; I tried reading the data from framebuffer using cat=
 as u have told, I
<br>&gt; wrote the following command:<br>&gt;<br>&gt; cat /dev/fb0 &gt; ima=
ge.txt<br>&gt;<br>&gt; Is the command correct or not, as I am getting some =
corrupted data......<br>&gt; Below is the some part of data, which I am get=
ting:
<br>&gt;<br>&gt; W&lt;8d&gt;=C3=B5&lt;8c&gt;^U&lt;8d&gt;=C3&lt;8c&gt;&lt;8c=
&gt;c&lt;86&gt;2^D&quot;=C3&copy;^Y=C3=AD2=C3*uC[\&lt;9c&gt;d=C3^\m^\u]u|}\=
}}}&lt;9d&gt;&lt;85&gt;^?&lt;8^?&lt;85&gt;=C2=BF&lt;8d&gt;=C3&lt;8d&gt;=C3=
=BE&lt;95&gt;=C3&lt;95&gt;=C3=BD&lt;95&gt;=C3=BD&lt;95&gt;=C3=BF&lt;9d&gt;=
=C3=BF&lt;9d&gt;^_&lt;9e&gt;^_&lt;9e&gt;^_&lt;9e&gt;?&lt;9e&gt;&gt;&lt;9e&g=
t;9d&gt;&lt;98&gt;=C2=A5p
<br>&gt;<br>&gt;<br>&gt; And could you please tell me how to get the RGB da=
ta from framebuffer.<br>&gt;<br><br>What you get is raw framebuffer format.=
&nbsp;&nbsp;If you 'cat image.txt &gt; /dev/fb0',<br>you'll get the same im=
age you dumped previously.
<br><br>In order for it to be read by an image viewer, you have to convert =
it<br>into a standard format.<br><br>Try searching for fbshot or fbgrab and=
 look at the source.<br><br>Tony<br></blockquote></div><br>

------=_Part_21154_13041220.1149068452871--

------=_Part_21153_26348002.1149068452871
Content-Type: text/plain; name="testfb.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="testfb.c"
X-Attachment-Id: f_envhp5fm

ICAgICNpbmNsdWRlIDxsaW51eC9mYi5oPgoKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxz
dGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dGltZS5oPgojIGluY2x1ZGU8
c3lzL2lvY3RsLmg+CiMgaW5jbHVkZTxzeXMvdGltZS5oPgojIGluY2x1ZGUgPGZjbnRsLmg+CiMg
aW5jbHVkZTx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlPHN5cy9tbWFu
Lmg+CgkKCQoKCgoKICAgIGludCBtYWluKCkKICAgIHsKICAgICAgICBpbnQgZmJmZCA9IDA7CiAg
ICAgICAgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvIHZpbmZvOwogICAgICAgIHN0cnVjdCBmYl9m
aXhfc2NyZWVuaW5mbyBmaW5mbzsKICAgICAgICBsb25nIGludCBzY3JlZW5zaXplID0gMDsKICAg
ICAgICBjaGFyICpmYnAgPSAwOwogICAgICAgIGludCB4ID0gMCwgeSA9IDA7CiAgICAgICAgbG9u
ZyBpbnQgbG9jYXRpb24gPSAwOwogICAgICAgIGludCBpOwoJdW5zaWduZWQgc2hvcnQgaW50IHQ7
CgkKCgoKCiAgICAgICAgLy8gT3BlbiB0aGUgZmlsZSBmb3IgcmVhZGluZyBhbmQgd3JpdGluZwog
ICAgICAgIGZiZmQgPSBvcGVuKCIvZGV2L2ZiMCIsIE9fUkRXUik7CiAgICAgICAgaWYgKCFmYmZk
KSB7CiAgICAgICAgICAgIHByaW50ZigiRXJyb3I6IGNhbm5vdCBvcGVuIGZyYW1lYnVmZmVyIGRl
dmljZS5cbiIpOwogICAgICAgICAgICBleGl0KDEpOwogICAgICAgIH0KICAgICAgICBwcmludGYo
IlRoZSBmcmFtZWJ1ZmZlciBkZXZpY2Ugd2FzIG9wZW5lZCBzdWNjZXNzZnVsbHkuXG4iKTsKCiAg
ICAgICAgLy8gR2V0IGZpeGVkIHNjcmVlbiBpbmZvcm1hdGlvbgogICAgICAgIGlmIChpb2N0bChm
YmZkLCBGQklPR0VUX0ZTQ1JFRU5JTkZPLCAmZmluZm8pKSB7CiAgICAgICAgICAgIHByaW50Zigi
RXJyb3IgcmVhZGluZyBmaXhlZCBpbmZvcm1hdGlvbi5cbiIpOwogICAgICAgICAgICBleGl0KDIp
OwogICAgICAgIH0KCiAgICAgICAgLy8gR2V0IHZhcmlhYmxlIHNjcmVlbiBpbmZvcm1hdGlvbgog
ICAgICAgIGlmIChpb2N0bChmYmZkLCBGQklPR0VUX1ZTQ1JFRU5JTkZPLCAmdmluZm8pKSB7CiAg
ICAgICAgICAgIHByaW50ZigiRXJyb3IgcmVhZGluZyB2YXJpYWJsZSBpbmZvcm1hdGlvbi5cbiIp
OwogICAgICAgICAgICBleGl0KDMpOwogICAgICAgIH0KCiAgICAgICAgcHJpbnRmKCIlZHglZCwg
JWRicHBcbiIsIHZpbmZvLnhyZXMsIHZpbmZvLnlyZXMsIHZpbmZvLmJpdHNfcGVyX3BpeGVsKTsK
CiAgICAgICAgLy8gRmlndXJlIG91dCB0aGUgc2l6ZSBvZiB0aGUgc2NyZWVuIGluIGJ5dGVzCiAg
ICAgICAgc2NyZWVuc2l6ZSA9IHZpbmZvLnhyZXMgKiB2aW5mby55cmVzICogdmluZm8uYml0c19w
ZXJfcGl4ZWwgLyA4OwoJcHJpbnRmKCJcbiBzY3JlZW4gc2l6ZSBpcyAlbGQiLHNjcmVlbnNpemUp
OwkKCQogICAgICAgIC8vIE1hcCB0aGUgZGV2aWNlIHRvIG1lbW9yeQogICAgICAgIGZicCA9IChj
aGFyICopbW1hcCgwLCBzY3JlZW5zaXplLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBfU0hB
UkVELAogICAgICAgICAgICAgICAgICAgICAgICAgICBmYmZkLCAwKTsKICAgICAgICBpZiAoKGlu
dClmYnAgPT0gLTEpIHsKICAgICAgICAgICAgcHJpbnRmKCJFcnJvcjogZmFpbGVkIHRvIG1hcCBm
cmFtZWJ1ZmZlciBkZXZpY2UgdG8gbWVtb3J5LlxuIik7CiAgICAgICAgICAgIGV4aXQoNCk7CiAg
ICAgICAgfQogICAgICAgIHByaW50ZigiVGhlIGZyYW1lYnVmZmVyIGRldmljZSB3YXMgbWFwcGVk
IHRvIG1lbW9yeSBzdWNjZXNzZnVsbHkuXG4iKTsKCiAKCQkKCWk9MDsKCSBmb3IgKHkgPSAwOyB5
IDwgMTsgeSsrKQogICAgICAgICAgICBmb3IgKHggPSAwOyB4IDwgODsgeCsrKQoJCXsKCQkgIHQ9
KigodW5zaWduZWQgc2hvcnQgaW50KikoZmJwICtpKSkgOwoJCSBpKys7CQoJCX0KCglwcmludGYo
IlxuIGFmdGVyIGxvb3AiKTsKICAgICAgICBtdW5tYXAoZmJwLCBzY3JlZW5zaXplKTsKICAgICAg
ICBjbG9zZShmYmZkKTsKICAgICAgICByZXR1cm4gMDsKICAgIH0K
------=_Part_21153_26348002.1149068452871--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
