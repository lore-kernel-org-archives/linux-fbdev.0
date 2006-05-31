From: "Prakhar Vig" <prakharv@gmail.com>
Subject: Re: How to use ISRAm as a frame buffer in Linux
Date: Wed, 31 May 2006 10:13:41 +0530
Message-ID: <dbee5b5a0605302143l7b0b4d24kdf0d77685b7ad4d9@mail.gmail.com>
References: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>
	 <447C3BAB.70003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_19788_31686227.1149050621783"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlIYc-0000fL-Dw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:43:46 -0700
Received: from ug-out-1314.google.com ([66.249.92.172])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlIYa-0007p2-6A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:43:46 -0700
Received: by ug-out-1314.google.com with SMTP id j40so1408083ugd
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 21:43:42 -0700 (PDT)
In-Reply-To: <447C3BAB.70003@gmail.com>
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

------=_Part_19788_31686227.1149050621783
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Antonino,

I tried reading the data from framebuffer using cat as u have told, I wrote
the following command:

cat /dev/fb0 > image.txt

Is the command correct or not, as I am getting some corrupted data......
Below is the some part of data, which I am getting:

W<8d>=C3=B5<8c>^U<8d>=C3<8c><8c>c<86>2^D"=C3(c)^Y=C3=AD2=C3*uC[\<9c>d=C3^\m=
^\u]u|}\}}}<9d><85>^?<8^?<85>=C2=BF<8d>=C3<8d>=C3=BE<95>=C3<95>=C3=BD<95>=
=C3=BD<95>=C3=BF<9d>=C3=BF<9d>^_<9e>^_<9e>^_<9e>?<9e>><9e>9d><98>=C2=A5p

And could you please tell me how to get the RGB data from framebuffer.

Thanks And Regards
Prakhar



On 5/30/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>
> Prakhar Vig wrote:
> > Hi All,
> >
> > I would like to read a Image data already present in the framebuffer, a=
s
> > I am new to this , I am finding it difficult to read. I have written on=
e
> > small application where I want to read Image pixels value which are
> > present in Frame buffer.
> >
>
> You can simply open and read /dev/fb0 and it will dump the framebuffer
> in raw format.
>
> cat /dev/fb0 will also do the trick.
>
> Google for a screenshot program for the framebuffer. fbgrab is an example=
.
>
> Tony
>

------=_Part_19788_31686227.1149050621783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Antonino,</div>
<div>&nbsp;</div>
<div>I tried reading the data from framebuffer using cat as u have told, I =
wrote the following command:</div>
<div>&nbsp;</div>
<div>cat /dev/fb0 &gt; image.txt </div>
<div>&nbsp;</div>
<div>Is the command correct or not, as I am getting some corrupted data....=
.. Below is the some part of data, which I am getting:</div>
<div>&nbsp;</div>
<div>W&lt;8d&gt;=C3=B5&lt;8c&gt;^U&lt;8d&gt;=C3&lt;8c&gt;&lt;8c&gt;c&lt;86&=
gt;2^D&quot;=C3&copy;^Y=C3=AD2=C3*uC[\&lt;9c&gt;d=C3^\m^\u]u|}\}}}&lt;9d&gt=
;&lt;85&gt;^?&lt;8^?&lt;85&gt;=C2=BF&lt;8d&gt;=C3&lt;8d&gt;=C3=BE&lt;95&gt;=
=C3&lt;95&gt;=C3=BD&lt;95&gt;=C3=BD&lt;95&gt;=C3=BF&lt;9d&gt;=C3=BF&lt;9d&g=
t;^_&lt;9e&gt;^_&lt;9e&gt;^_&lt;9e&gt;?&lt;9e&gt;&gt;&lt;9e&gt;9d&gt;&lt;98=
&gt;=C2=A5p
</div>
<div>&nbsp;</div>
<div>And could you please tell me how to get the RGB data from framebuffer.=
</div>
<div>&nbsp;</div>
<div>Thanks And Regards</div>
<div>Prakhar</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/30/06, <b class=3D"gmail_sendername">=
Antonino A. Daplas</b> &lt;<a href=3D"mailto:adaplas@gmail.com">adaplas@gma=
il.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Prakhar Vig wrote:<br>&gt; Hi Al=
l,<br>&gt;<br>&gt; I would like to read a Image data already present in the=
 framebuffer, as
<br>&gt; I am new to this , I am finding it difficult to read. I have writt=
en one<br>&gt; small application where I want to read Image pixels value wh=
ich are<br>&gt; present in Frame buffer.<br>&gt;<br><br>You can simply open=
 and read /dev/fb0 and it will dump the framebuffer
<br>in raw format.<br><br>cat /dev/fb0 will also do the trick.<br><br>Googl=
e for a screenshot program for the framebuffer. fbgrab is an example.<br><b=
r>Tony<br></blockquote></div><br>

------=_Part_19788_31686227.1149050621783--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
