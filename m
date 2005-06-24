From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 24 Jun 2005 13:25:56 -0400
Message-ID: <9e473391050624102559929cd9@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <200506161111.27115.adaplas@hotpop.com>
	 <9e4733910506152037193300fa@mail.gmail.com>
	 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
	 <9e473391050620173132ea1ce6@mail.gmail.com>
	 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
	 <9e473391050624052640aa5279@mail.gmail.com>
	 <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>
	 <9e47339105062409276fcd5223@mail.gmail.com>
	 <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlrwF-0002lK-JQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 10:25:59 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlrwE-00036p-3F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Jun 2005 10:25:59 -0700
Received: by wproxy.gmail.com with SMTP id 69so467457wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jun 2005 10:25:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org>
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Why are you trying to preserve all of the ".fb_cursor =3D soft_cursor,"
assignments in the drivers? What purpose do they serve that can't be
handled by a simple test like this:

Then any in-kernel user does this:
      /* First try the hardware cursor */
      if (info->fbops->fb_cursor)
              err =3D info->fbops->fb_cursor(info, &cursor);
      /* if that doesn't exist or didn't work, use the software one */
      if (err)
              soft_cursor(info, &cursor);

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
