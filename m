From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Linux Framebuffer Driver
Date: Sun, 20 Feb 2005 22:46:11 +0100
Message-ID: <20050220214611.GM23069@uvt316-2.ruk.cuni.cz>
References: <E1D2Q4W-000GqN-00.kirdevv-mail-ru@f26.mail.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2yya-0007pU-Me
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 13:50:52 -0800
Received: from dec59.ruk.cuni.cz ([195.113.2.17])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D2yyY-0003j9-VZ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 13:50:52 -0800
Content-Disposition: inline
In-Reply-To: <E1D2Q4W-000GqN-00.kirdevv-mail-ru@f26.mail.ru>
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Feb 19, 2005 at 11:34:40AM +0300, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB =D0=98=D0=B2=D0=B0=D0=BD=D0=BE=D0=B2  wrote:
> Hello, my name is Kirill
> I'am not a professional programmer (strongly speaking i am simply user)=
,
> but i try to write Linux framebuffer driver for my Cyberblade/i1 (Tride=
nt)
> videocard.
> So, basic driver I wrote, but one problem occur: when switching to fram=
ebuffer
> console
> information about columns and rows is not updated.
> Although kernel reports: "Console: switching to colour framebuffer devi=
ce
> 100x37",
> console as before have 80x25, because when line exceed 80 characters li=
ne become
> wrapped.
>=20
> What's wrong?
>=20
> I use kernel-2.4.22 on IA-32.

There may be any kind of problem propagating the console resize to the
terminal application in question. Does it go away if you log out and
back in?
ie I was hit by a bug in bash that eats the terminal resizes when bash
is the first thing run in a terminal..

HTH

Michal Suchanek


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
