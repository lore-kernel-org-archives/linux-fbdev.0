From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 08:19:26 -0700
Message-ID: <376ea3380808180819i3876d3d2x63558d33dc9b931a@mail.gmail.com>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080817200928.15da18c6.krzysztof.h1@poczta.fm>
	<376ea3380808180800h308a5d89v5cd213acfa6b2c0c@mail.gmail.com>
	<Pine.LNX.4.64.0808181708030.3969@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV6W1-0007i4-NO for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:19:29 -0700
Received: from ug-out-1314.google.com ([66.249.92.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV6W0-0002lf-Al
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:19:29 -0700
Received: by ug-out-1314.google.com with SMTP id m2so407156uge.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 08:19:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0808181708030.3969@anakin>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

>> Is accel something crucial that I should be concerned about?
>
> It enables acceleration (rectangle fill and copy, monochrome color
> expansion) for the frame buffer console.
>
> If you disable it, your text console will become slower.

In the end, my plan is to use the framebuffer, through DirectFB, to
play videos. Console speed is of no concern, so it sounds like this
won't matter for now.

My real concern is being able to properly put the framebuffer into the
resolution I want, 720p.

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
