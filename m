From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fbdev changes.
Date: 14 Oct 2002 22:46:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034628378.1143.507.camel@tibook>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181C6Y-000638-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 13:46:22 -0700
In-Reply-To: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Son, 2002-10-13 at 22:27, James Simmons wrote:=20
>=20
>   The final changes to the fbdev layer are at hand. One of the last
> changes I wanted to purpose was to create a console driectory in
> drivers/video and move all console related stuff into that directory.
> The next step was to move the dri stuff into that directory with the agp
> code possible. The questions I have is should we move the agp code over t=
o
> that directory. Should the DRI code move over directly or should we move
> DRI driver specific code into the same directory as the fbdev driver
> directories? For example in aty directory we have all the ati framebuffer
> and ATI dri code. What do you think?

Wouldn't that complicate merges between the kernel and DRI CVS? At any
rate, I think discussion related to the DRI should take place on
dri-devel.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
