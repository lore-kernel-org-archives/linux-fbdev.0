From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: will the new edid functionality allow vesafb to set a frequency?
Date: Fri, 11 Apr 2003 10:09:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030411080948.GA2338@iliana>
References: <24510.212.153.94.193.1049371331.squirrel@webmail.xs4all.nl> <Pine.LNX.4.44.0304102241430.23050-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp5.wanadoo.fr ([193.252.22.29] helo=mwinf0202.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193tbh-00021B-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Apr 2003 01:09:58 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304102241430.23050-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1252"
To: James Simmons <jsimmons@infradead.org>
Cc: Jurriaan Kalkman <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net

On Thu, Apr 10, 2003 at 10:42:30PM +0100, James Simmons wrote:
>=20
> > As the owner of a NVidia card, whose evil proprietary driver won't work
> > with rivafb, but would possibly work with vesafb (I see mixed messages
> > on usenet about this), I have the following question:
> >=20
> > will the new edid-functionality that is currently in heavy development
> > allow linux (somewhere in the future) to set a vertical refresh frequen=
cy
> > with vesafb? I did notice that this Ti500 card has a VESA/VBE 3.0
> > compatible BIOS, so it should be possible.
>=20
> Yes. Also long as your monitor supports EDID correctly. I tested it on my=
=20
> laptop and the data was botched :-(

BTW, what about monitors having a dual input (vga and dvi). I think they
give back the same edid on both entries, yet clearly the dvi entry
cannot do scaling and support less monitor modes, at lest for my Sony
SDM-X52. BTW, get-edid failed to read the entries :

get-edid: get-edid version 1.4.1

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f00 bx=3D0x0 cx=3D0x0
	Function supported
	Call successful

	VBE version 200
	VBE string at 0x11148 " P9"

VBE/DDC service about to be called
	Report DDC capabilities

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x0 cx=3D0x0
	Function supported
	Call successful

	Monitor and video card combination does not support DDC1 transfers
	Monitor and video card combination supports DDC2 transfers
	0 seconds per 128 byte EDID block transfer
	Screen is not blanked during DDC transfer

Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 7 more blocks left


*********** Something special has happened!
Please contact the author, John Fremlin
E-mail: one of vii@altern.org,vii@mailcc.com,vii@mailandnews.com
Please include full output from this program (especially that to stderr)



Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 255 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
Reading next EDID block

VBE/DDC service about to be called
	Read EDID

	Performing real mode VBE call
	Interrupt 0x10 ax=3D0x4f15 bx=3D0x1 cx=3D0x0
	Function supported
	Call failed

The EDID data should not be trusted as the VBE call failed
EDID claims 7 more blocks left
EDID blocks left is wrong.
Your EDID is probably invalid.
=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17x=EA~=A9=A0XN=96%=
=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=01=01d=19=00@A=00&=
0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17x=EA~=A9=A0XN=96%=1EH=
L=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=01=01d=19=00@A=00&0=18=
=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF=FF=FF=FF=FF=FF=FF=FF=00M=D9P =01=01=01=01&=0C=01=03=80=1E=17=
x=EA~=A9=A0XN=96%=1EHL=A1=08=00=01=01=01=01=01=01=01=01=01=01=01=01=01=01=
=01=01d=19=00@A=00&0=18=886=000=E4=10=00=00=18=00=00=00=FD=009?=1C1=07=00
      =00=00=00=FC=00SDM-X52
     =00=00=00=FF=004518830
     =00=07=FF

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
