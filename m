From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 15:06:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410181506.09713.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <200410180920.39170.adaplas@hotpop.com> <9e47339104101719462ea5b2dd@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJRV8-0006ft-4i
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 00:00:14 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJRV5-0001MR-DM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 00:00:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2C30790C60D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Oct 2004 07:00:01 +0000 (UTC)
In-Reply-To: <9e47339104101719462ea5b2dd@mail.gmail.com>
Content-Disposition: inline
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Monday 18 October 2004 10:46, Jon Smirl wrote:
> On Mon, 18 Oct 2004 09:20:39 +0800, Antonino A. Daplas
>
> <adaplas@hotpop.com> wrote:
> head in this environment has exposed some design problems in the
> fb_info structures. The structure doesn't sort out things that there
> are only one of vs multiple ones.

I don't think you can expect a single fb_info structure to represent more
than 1 display. If the card happens to support multihead, then the driver must
be able to register the driver more than once so it creates /dev/fb0,
/dev/fb1, etc, one for each head.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
