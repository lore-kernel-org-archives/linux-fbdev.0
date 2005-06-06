From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: fbdev hardware cursor support
Date: Mon, 6 Jun 2005 15:33:34 -0400
Message-ID: <9e47339105060612333ed8b98c@mail.gmail.com>
References: <9e473391050524224063df2372@mail.gmail.com>
	 <Pine.LNX.4.56.0506061940550.16950@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfNMW-0004Pv-PD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:34:16 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfNMU-0007FN-8E
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:34:16 -0700
Received: by wproxy.gmail.com with SMTP id 69so1990800wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Jun 2005 12:34:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506061940550.16950@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@www.infradead.org>

On 6/6/05, James Simmons <jsimmons@www.infradead.org> wrote:
> Some time ago we had userland cursor support but it was removed :-( Now
> that we have sysfs it could make a come back. The software cursor code
> doesn't behave proprely from userland. It was design to work with the
> console system only.

I have software cursors going in Xegl now so I am ok for the moment.
At some point we need to resurrect the hardware cursor support in
fbdev.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
