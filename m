From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: FB_EVENT (blank and unblank?)
Date: Sun, 28 Nov 2004 09:14:39 +0800
Message-ID: <200411280914.40352.adaplas@hotpop.com>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411280824.01338.adaplas@hotpop.com> <02cc01c4d4e5$75e4e170$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYDpu-00063A-Uq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 17:26:46 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CYDeR-00073r-N0
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 17:15:06 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F2AB9124314E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 28 Nov 2004 01:14:45 +0000 (UTC)
In-Reply-To: <02cc01c4d4e5$75e4e170$0f01a8c0@max>
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
To: Richard Purdie <rpurdie@rpsys.net>, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Sunday 28 November 2004 08:59, Richard Purdie wrote:
> Antonino A. Daplas:
> >> My Issue: I have a backlight driver that shares no code with the
> >> framebuffer driver - the hardware is totally separate. I have there
> >> written
> >> them as two spate drivers which seems to make sense. The problem is that
> >> there is no method to communicate blanking to the external backlight
> >> driver
> >> (which is all it needs to know about). Obviously I can add links between
> >
> > Of course there is.  Your backlight driver does a
> > register_backlight_controllers().  Then your fb driver does a
> > set_backlight_enable(!blank) in its xxxfb_blank implementation.
>
> Yes, you could do that. I was trying to look for a method than meant no
> specific action by the framebuffer driver was required. It shouldn't have
> to care if a backlight is present or not...

Ah, when you explained it like that, then it does sound very reasonable.
Okay, I think that can be added.  I think we will need only 1 event
FB_EVENT_BLANK, then in fb_event.data, the blanking level.

We can do it similarly with the mode switch event, differentiate if the
request is coming from userspace or the kernel.

Tony





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
