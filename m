From: "irene7" <irene7@mail2000.com.tw>
Subject: Re: how to rotate 90 the LCD image
Date: Mon, 10 Mar 2003 12:43:22 +0800 (CST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047271402.34395.irene7@mail2000.com.tw>
Reply-To: irene7@mail2000.com.tw
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ms3.mail2000.com.tw ([211.72.252.187])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sF8O-0006FD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 20:43:32 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net


=20Thank=20your=20for=20your=20comprehensive=20explanation=20.
=20And=20i=20also=20get=20the=20information,that=20the=20embedded=20GUI=20sy=
stem=20can=20support=20it's=20GUI=20rotate=2090.
=20Is=20that=20true=20?
=20and=20if=20it=20is=20true,=20maybe=20it's=20efficiency=20would=20be=20a=20=
probelm?

-----Original=20message-----
From:Antonino=20Daplas=20<adaplas@pol.net>
To:irene7@mail2000.com.tw
Cc:Linux=20Fbdev=20development=20list=20<linux-fbdev-devel@lists.sourceforge=
.net>
Date:10=20Mar=202003=2010:06:45=20+0800
Subject:Re:=20[Linux-fbdev-devel]=20how=20to=20rotate=2090=20the=20LCD=20ima=
ge

On=20Sun,=202003-03-09=20at=2017:37,=20irene7=20wrote:
>=20
>=20=20HI~=20
>=20
>=20=20=20=20=20i=20am=20an=20newbie.=20and=20i=20have=20a=20trouble=20:
>=20=20=20=20=20my=20LCD=20driver=20is=20working=20fine=20,=20but=20the=20on=
ly=20problem=20is=20the=20LCD=20image=20is=20rotate=2090.
>=20=20=20=20=20what=20should=20i=20modified=20the=20driver=20to=20rotate=20=
it=20back?=20

Hmm,=20a=20lot=20of=20LCD=20hardware=20have=20this=20sort=20of=20problem.=20=
=20If=20you=20do=20not
have=20a=20hardware=20option=20to=20change=20how=20the=20data=20is=20to=20be=
=20displayed=20(such
as=20rotate=2090=20degrees=20the=20other=20way),=20you=20can=20do=20at=20lea=
st=20two=20things:

1.=20=20have=20your=20own=20fbcon-cfb*.c=20functions=20that=20draws,=20clear=
s=20and=20moves
pixels=20from=20top->bottom,=20right->left=20(90=20degrees=20CW)=20or=20bott=
om->top,
left->right=20(90=20degrees=20CCW).=20=20You=20may=20also=20want=20to=20pre-=
rotate
display->fontdata=20in=20your=20xxxfb_setup=20routine,=20so=20you=20don't=20=
degrade
performance.=20You=20also=20need=20to=20modify=20the=20fbcon_show_logo=20in=20=
fbcon.c=20to
do=20the=20same=20thing.=20=20The=20advantage=20of=20this=20method=20is=20yo=
u're=20going=20to=20have
a=20fairly=20efficient=20framebuffer=20console,=20the=20disadvantage=20is=20=
user
applications=20will=20not=20work.

2.=20=20The=20second=20method=20is=20to=20allocate=20a=20virtual=20framebuff=
er.=20=20Then=20on=20a
periodic=20basis,=20you=20transfer=20the=20data=20in=20the=20virtual=20frame=
buffer=20to=20the
actual=20framebuffer,=20doing=20the=20rotating=20on=20the=20fly.=20=20The=20=
advantage=20of
this=20method=20is=20user=20applications=20should=20work,=20the=20disadvanta=
ge=20is=20it=20is
not=20the=20most=20efficient=20method.

You=20can=20look=20at:=20

ftp://ssv-embedded.de/ssv/products/trm916/sample/x86/linux/fbdev

(authored=20by=20Henry)

for=20a=20template=20on=20how=20to=20implement=20#2.=20=20You=20still=20have=
=20to=20implement=20the
rotation=20yourself.=20=20If=20you=20have=20questions=20rotating=20the=20dat=
a,=20let=20me
know.


Tony





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
