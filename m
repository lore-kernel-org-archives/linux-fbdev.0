From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Mon, 20 Jun 2005 20:31:15 -0400
Message-ID: <9e473391050620173132ea1ce6@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be>
	 <9e47339105061518346d1df105@mail.gmail.com>
	 <200506161111.27115.adaplas@hotpop.com>
	 <9e4733910506152037193300fa@mail.gmail.com>
	 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkWff-0005KA-3w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 17:31:19 -0700
Received: from wproxy.gmail.com ([64.233.184.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkWfc-0004ba-DA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 17:31:18 -0700
Received: by wproxy.gmail.com with SMTP id 69so197105wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jun 2005 17:31:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
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
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>

On 6/20/05, James Simmons <jsimmons@www.infradead.org> wrote:
> I agree we should not fall back to the software cursor when the hardware
> cursor fails. Do we really want to eliminate the cursor from the device
> interface if it is not a hardware cursor? Shouldn't the cursor always
> work? That is the question.

I don't think there really is a choice here. Fbdev has to implement
the hardware cursor. The software one is application specific.
fbconsole and X implement it completely differently. I don't think
there is a way to implement a general software cursor.

fbdev provides hardware or nothing
if no hardware cursor, cursor is up to app
fbconsole and X then provide two different fallback schemes.

For example I don't think we have enough info to implement X's
software cursor in the fbdev driver. We would need some way to know
when X is updating the screen via paint or buffer swaps. Wouldn't that
be a total mess for fbdev to track and a new API would be needed.

We just never noticed the problem before since only one client
(fbconsole) was using the cursor. Current X is programming the
hardware cursor from user space.

After this change it would probably be cleaner to just eliminate the
softcursor module and compile softcursor into fbconsole. softcursor.c
would be moved to the fbconsole subdir if you can figure out how to
tell git to do a mv. But we can always save these changes for later.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
