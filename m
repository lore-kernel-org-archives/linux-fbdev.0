From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: vesafb probe question
Date: Mon, 10 Jan 2005 05:16:17 +0800
Message-ID: <200501100516.17496.adaplas@hotpop.com>
References: <7A8F92187EF7A249BF847F1BF4903C040AFC32@ausx2kmpc103.aus.amer.dell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnkQQ-0006wL-VN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CnkQP-0001i3-Ue
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 13:16:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BB22613374BF
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  9 Jan 2005 21:16:23 +0000 (UTC)
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C040AFC32@ausx2kmpc103.aus.amer.dell.com>
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
Cc: Stuart_Hayes@Dell.com

On Saturday 08 January 2005 05:03, Stuart_Hayes@Dell.com wrote:
> I'm getting a message in dmesg:  "localhost kernel: vesafb: probe of
> vesafb0 failed with error -6"
>
> I searched the web, and found that a lot of people are getting this, but
> I couldn't find an answer, so I looked into it.
>
> This appears to be because "vesafb" returns -ENXIO ("No such device or
> address") when its probe function fails.  However, driverse/base/bus.c
> spews an error message during device_attach() if a matching driver's
> probe function returns anything but -ENODEV ("No such device").
>
> Would a patch (like the one below) to change vesafb to return ENODEV
> instead of ENXIO be appropriate, or am I missing something?

-ENODEV is fine.

Tony




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
