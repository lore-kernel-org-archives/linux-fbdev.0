From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 24 Jun 2005 08:26:14 -0400
Message-ID: <9e473391050624052640aa5279@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be>
	 <9e47339105061518346d1df105@mail.gmail.com>
	 <200506161111.27115.adaplas@hotpop.com>
	 <9e4733910506152037193300fa@mail.gmail.com>
	 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
	 <9e473391050620173132ea1ce6@mail.gmail.com>
	 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlnGC-0001fv-On
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 05:26:16 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlnGB-000623-21
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 05:26:16 -0700
Received: by wproxy.gmail.com with SMTP id 58so318172wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jun 2005 05:26:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@www.infradead.org>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 6/23/05, James Simmons <jsimmons@www.infradead.org> wrote:
>         Now I was thinking instead of a massive move of the the software
> cursor we add a flag FBINFO_HWACCEL_CURSOR to tell us if we are using a
> hardware cursor. This way for the sysfs interface you can test to see if
> it is a hardware cursor and only allow userland to access a hardware
> cursor. Here is a patch for that. People please try it out.

Your code will work, but it is conceptually what we want to do?
Software cursors are application specific. The soft cursor implemented
in fbdev really belongs to fbconsole.  If we get another in-kernel
user with a different update pattern (maybe they use the GPU) they
will want a different soft cursor. Shouldn't we just move the current
soft cursor into fbconsole? Given that software cursors are
application specific fbdev should not contain one.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
