From: Clint Adams <schizo@debian.org>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Tue, 13 Jan 2004 10:40:25 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040113154025.GA12817@scowler.net>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgQeZ-0002ON-Su
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 07:40:27 -0800
Received: from acolyte.scowler.net ([216.254.112.142])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AgQeZ-0002WM-Ce
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 07:40:27 -0800
Content-Disposition: inline
In-Reply-To: <20040113074158.GF4863@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

> Ok, this may be the problem. The first one is initialized by the pm2fb,
> while the second is not. This mean either some initialization problems,
> or the fact that X doesn't initialize some values set by pm2fb.

Sound sreasonable.

> What kernel are you using, maybe it would be best to work on a 2.6
> kernel and try to adapt the pm2fb to the new framework or something.

Currently using Herbert's 2.4.24-1.  I tried various 2.6 kernels prior
to 2.6.1, but xdm couldn't seem to start the server and the USB HID
drivers didn't seem to be functional.

> Can you describe me the symptoms again ? what exactly did you see on the
> second head ?

The second head is currently running WindowMaker with the default Debian
background.  In the upper left corner, there is the 1/Main clip.
Directly to the right of that (I assume by 64 pixels or so) is the exact
same 1/Main clip.  In the border between the two are some flickering
white lines.  The rest of the screen is filled with horizontal
flickering black and whitish lines.  The left edge of the swirl is on
the right hand side of the screen.  It appears 5 times.  The "debian"
only appears as "de", though there are about 5 d's and 3 or 4 e's,
overlapping.  The clips themselves look perfect, but nothing else does.

Thanks.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
