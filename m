From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State
	Notification
Date: Mon, 28 Jun 2004 19:55:09 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088470508.13870.31.camel@gaston>
References: <200406220639.26576.adaplas@hotpop.com>
	 <200406250446.47073.adaplas@hotpop.com> <1088460578.15069.24.camel@gaston>
	 <200406290645.11510.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf6x1-0000sO-Jr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 17:58:19 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1Bf6x1-0001qd-5p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 17:58:19 -0700
In-Reply-To: <200406290645.11510.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> fbcon_switch() will be called when there is a request to redraw the screen 
> of the same vc, such as in the above, or when switching to a different vc. 
> 
> I think the name 'con_switch' is misleading.  The better term, IMO, is
> 'con_redraw'.

Hrm... ok, I missed that one then. It would still be useful to figure
out what's wrong with X, it may not be a driver problem, but rather
an X core problem calling the driver "restore" callbacks at the wrong
time, and thus more easily fixable

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
