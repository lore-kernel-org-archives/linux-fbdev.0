From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Mon, 18 Oct 2004 09:18:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410180918.59241.adaplas@hotpop.com>
References: <200410172347.15516.adaplas@hotpop.com> <9e4733910410171525543c1992@mail.gmail.com> <41730519.9040202@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJM6A-0001WB-20
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 18:14:06 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJM65-0005Al-Kn
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 18:14:05 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B48B6907206
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Oct 2004 01:13:54 +0000 (UTC)
In-Reply-To: <41730519.9040202@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Zachary Smith <plinius@comcast.net>

On Monday 18 October 2004 07:49, Zachary Smith wrote:
> Jon Smirl wrote:
>  > How many apps use the user space fbdev interface?
>
> Any app that uses FBUI (my in-kernel GUI) at least opens /dev/fb/0.
> Then it uses my ioctls.

The FBIO_CURSOR is new in 2.6 and the implementation is broken.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
