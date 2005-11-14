From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: fbcon bug?
Date: Tue, 15 Nov 2005 04:10:38 +0800
Message-ID: <4378EF3E.8050609@gmail.com>
References: <4377F564.6000704@comcast.net> <20051114191340.GA12139@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbkfN-0003UE-5X
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 12:11:01 -0800
Received: from xproxy.gmail.com ([66.249.82.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbkfL-0000rw-6q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 12:11:00 -0800
Received: by xproxy.gmail.com with SMTP id s6so1604638wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 12:10:54 -0800 (PST)
In-Reply-To: <20051114191340.GA12139@sci.fi>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Ville Syrj=E4l=E4 wrote:
> On Sun, Nov 13, 2005 at 09:24:36PM -0500, Zack Smith wrote:
>> Hi all,
>>
>> I've noticed that 2.6.14, when a console switch occurs going
>> from a console that is KD_TEXT to one that is KD_GRAPHICS,
>> fbcon doesn't seem to immediately shut down the cursor. It appears
>> to draw or undraw the cursor at least once before it disables
>> cursor activity due to graphics mode.
>>
>> Does anybody know if this bug has been corrected in 14.1 or .2,
>> or if anyone would mind if I go in and fix it?
>=20
> I'm not sure if it's related but there is a cursor problem with atyfb.=20
> When doing ioctl(... KD_GRAPHICS) the cursor remains visible in most=20
> cases. Sometimes it does disappear properly but that is quite rare.=20
> However doing a vt switch to another vt and back again seems to fix it=20
> every time so I'm not sure it's the same problem you're seeing. None of=
=20
> the other fb drivers I use implement a hardware cursor which is probabl=
y=20
> the reason I'm only seeing it on atyfb.
>

Once the console is in KD_GRPHICS mode, all access the to the framebuffer
are essentially stopped.  So depending on the state of the cursor (visibl=
e
or not), it will stay that way even if a command to erase or draw the
cursor is given.

You may tell the console to erase the cursor before going to KD_GRAPHICS
mode as a workaround.

Tony



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
