From: Fredrik Noring <noring@nocrew.org>
Subject: Re: [PATCH] rivafb sync polarity problem?
Date: 19 Jan 2003 18:38:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042997937.1303.22.camel@h9n1fls20o980.telia.com>
References: <1042980943.12192.34.camel@h9n1fls20o980.telia.com> 
	<1042994847.976.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailf.telia.com ([194.22.194.25])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aJOT-0001oI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 09:38:01 -0800
In-Reply-To: <1042994847.976.3.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> How bad is the sync problem?  

Well, I must say it's pretty bad. It's a digital kind of TV - so
either you'll get a stable nice looking image, or you'll get the
blue "no-signal" screen. I get the blue screen.

But there is a strange mode in the TV where I can see the RGB signal
from the computer using the sync from the RF-input. Using this, at
least it seems the frequencies are reasonably correct.

> It's possible that your horizontal timings is not divisible by 8?  
> Ie., your hsync_len is 54, but when it's written to the register, 
> it's just 48.  You might want to recalculate the numbers so you 
> use 54 or 56.

I've tried the two variants below but neither work unfortunately.

    mode "768x288"
        geometry   768 288   768 288   32
    #   timings    62500   126 80   20 2   48 2
        timings    62500   118 80   20 2   56 2
        hsync low
        vsync low
    endmode

Thanks,

	Fredrik




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
