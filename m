From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] rivafb sync polarity problem?
Date: 20 Jan 2003 00:49:50 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042994847.976.3.camel@localhost.localdomain>
References: <1042980943.12192.34.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aInf-00048l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 08:59:59 -0800
In-Reply-To: <1042980943.12192.34.camel@h9n1fls20o980.telia.com>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ani Joshi <ajoshi@shell.unixbox.com>

On Sun, 2003-01-19 at 20:55, Fredrik Noring wrote:
> Hi,
> 
> It seems the mode below doesn't work with rivafb in Linux 2.4.21-pre2,
> the RGB (TV) screen fail to sync properly. (The equivalent modeline in
> XFree86 4.2 works.)
> 
>     mode "768x288"
>         geometry   768 288   768 288   32
>         timings    62500   120 80   20 2   54 2
>         hsync low
>         vsync low
>     endmode
> 

Ooops :-)  Sorry, I did not notice you were using 288 for your yres, so
62500 is just right.

How bad is the sync problem?  It's possible that your horizontal timings
is not divisible by 8?  Ie., your hsync_len is 54, but when it's written
to the register, it's just 48.  You might want to recalculate the
numbers so you use 54 or 56.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
