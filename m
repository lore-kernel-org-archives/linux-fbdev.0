From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbdev: Add FB_EVENT_BLANK to notify listeners of a blanking status change
Date: Tue, 30 Nov 2004 07:29:07 +0800
Message-ID: <200411300729.10877.adaplas@hotpop.com>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411280914.40352.adaplas@hotpop.com> <01f301c4d664$5c950440$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYuxb-0003Xu-GD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 15:29:35 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CYuxZ-0006nx-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Nov 2004 15:29:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 37C77AC3A80
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Nov 2004 23:29:17 +0000 (UTC)
In-Reply-To: <01f301c4d664$5c950440$0f01a8c0@max>
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
To: linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@pol.net, zap@homelink.ru

On Tuesday 30 November 2004 06:36, Richard Purdie wrote:
> Add FB_EVENT_BLANK to notify listeners of a blanking status change. This
> allows backlight drivers to be implemented completely separately from any
> framebuffer driver. The new blanking mode is passed in event.data.

Almost.  Note that my intent is to notify the console of the blank status
_and_ do something about it, so we also need to do
'do_blank_screen/do_unblank_screen' at the fbcon level.

I already have a patch in my tree, and will submit it after 2.6.10 comes
out. But for now and for your own use, this will do just fine.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
