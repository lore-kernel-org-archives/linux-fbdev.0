From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: fbset and X
Date: 14 May 2002 19:41:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1021398084.11250.1017.camel@tibook>
References: <1021378265.8186.17.camel@zeus>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [193.135.153.233] (helo=tibook)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 177gIC-0006ur-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 May 2002 10:40:56 -0700
In-Reply-To: <1021378265.8186.17.camel@zeus>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Frederick Lefebvre <flefebvre@irg.ca>
Cc: linux-fbdev dev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-05-14 at 14:11, Frederick Lefebvre wrote:

> Does anybody ever had succes switching fbdev resolution while running a
> X server.  I am running Xfbdev (from kdrive) over a fbdev and I get
> screen corruption everytime I switch resolution.=20

Why do you expect changing things behind the X server's back to work?

Can't Xfbdev use several resolutions and switch between them, like the
'real' XFree86 server can?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
