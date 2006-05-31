From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: How to use ISRAm as a frame buffer in Linux
Date: Wed, 31 May 2006 12:49:14 +0800
Message-ID: <447D204A.60007@gmail.com>
References: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>	 <447C3BAB.70003@gmail.com> <dbee5b5a0605302143l7b0b4d24kdf0d77685b7ad4d9@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlIe7-0001Q5-M4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:49:27 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlIe7-0000ax-QJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:49:27 -0700
Received: from wx-out-0102.google.com ([66.249.82.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlIe7-0005qg-Ho
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:49:27 -0700
Received: by wx-out-0102.google.com with SMTP id t14so421557wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 21:49:25 -0700 (PDT)
In-Reply-To: <dbee5b5a0605302143l7b0b4d24kdf0d77685b7ad4d9@mail.gmail.com>
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
To: Prakhar Vig <prakharv@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Prakhar Vig wrote:
> Hi Antonino,
> =20
> I tried reading the data from framebuffer using cat as u have told, I
> wrote the following command:
> =20
> cat /dev/fb0 > image.txt
> =20
> Is the command correct or not, as I am getting some corrupted data.....=
.
> Below is the some part of data, which I am getting:
> =20
> W<8d>=C3=B5<8c>^U<8d>=C3<8c><8c>c<86>2^D"=C3=A9^Y=C3=AD2=C3*uC[\<9c>d=C3=
^\m^\u]u|}\}}}<9d><85>^?<8^?<85>=C2=BF<8d>=C3<8d>=C3=BE<95>=C3<95>=C3=BD<=
95>=C3=BD<95>=C3=BF<9d>=C3=BF<9d>^_<9e>^_<9e>^_<9e>?<9e>><9e>9d><98>=C2=A5=
p
>=20
> =20
> And could you please tell me how to get the RGB data from framebuffer.
> =20

What you get is raw framebuffer format.  If you 'cat image.txt > /dev/fb0=
',
you'll get the same image you dumped previously.=20

In order for it to be read by an image viewer, you have to convert it
into a standard format.

Try searching for fbshot or fbgrab and look at the source.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications i=
n
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D107521&bid=3D248729&dat=3D=
121642
