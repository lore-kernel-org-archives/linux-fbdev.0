From: Fredrik Noring <noring@nocrew.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 19 Jan 2003 17:42:25 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042994545.1071.9.camel@localhost.localdomain>
References: <1042975785.1296.31.camel@h9n1fls20o980.telia.com> 
	<1042990791.1058.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from maild.telia.com ([194.22.190.101])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aIVm-0001lI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 08:41:30 -0800
In-Reply-To: <1042990791.1058.12.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

s=F6n 2003-01-19 klockan 16.41 skrev Antonino Daplas:
> The other patch (in reply to Jak) should hopefully fix the initial=20
> screen corruption on insmod and the kobject trace message.

It did - thanks!

> Can you try running an fbdev-based application, such as X, at 8bpp, just
> to find out if the hardware is incorrectly initialized from the very
> start or if this is more fbcon-related?

I've tried two things. This:

   modprobe rivafb     <-- loads OK, no visual side effects
   modprobe fbcon      <-- garbage graphics, complete hang

And this:

   modprobe rivafb     <-- loads OK, no visual side effects
   fbset 640x480-60    <-- screen turns black, complete hang

The mode looks like this:

   mode "640x480-60"
       # D: 25.175 MHz, H: 31.469 kHz, V: 59.94 Hz
       geometry 640 480 640 480 8
       timings 39722 48 16 33 10 96 2
    endmode

I haven't found any crash reports or similar in /var/log/messages. The
system simply freezes completely.

	Fredrik




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
