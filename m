From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [FBDEV]: Hardware State
	Notification
Date: Mon, 28 Jun 2004 17:09:38 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088460578.15069.24.camel@gaston>
References: <200406220639.26576.adaplas@hotpop.com>
	 <200406240750.28126.adaplas@hotpop.com> <1088044547.1855.185.camel@gaston>
	 <200406250446.47073.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf4Mj-0006H6-O6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 15:12:41 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1Bf4Mj-0003qF-Bj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Jun 2004 15:12:41 -0700
In-Reply-To: <200406250446.47073.adaplas@hotpop.com>
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


> Include nvidia into the list.  With the nv driver, the whole machine hangs. 
> The i810 has cursor sprite corruption, but has a workaround for it.
> 
> So, I would still like to do the set_par as late as possible such as in 
> fbcon_switch().  (BTW, this fixes the riva driver)

Except that you may not have a switch, if for example an app switch to
KD_GRAPHICS, do stuff with the engine, then back to KD_TEXT on the
same console...

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
