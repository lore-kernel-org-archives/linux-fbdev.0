From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Fri, 4 Feb 2005 21:59:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502042158250.26459@pentafluge.infradead.org>
References: <200502030925.09942.pluto@pld-linux.org>  <1107496794.2362.90.camel@gaston>
  <Pine.LNX.4.56.0502042042120.25309@pentafluge.infradead.org>
 <9e47339105020413047ada9b2c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxBTz-0003Dk-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:59:19 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CxBTz-0006wX-1u
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:59:19 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1CxBTw-0006uZ-8J
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 21:59:17 +0000
In-Reply-To: <9e47339105020413047ada9b2c@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


> > > You seem to have built both the old and new radeonfb's ... can you
> > > remove the old one ?
> > 
> > Plus a whole bunch of other drivers. BTW would you consider it time to
> > kill off the old radeon fbdev driver?
> 
> Last time I checked the new radeonfb driver could not set modes on an
> analog LCD panel. Something is mess up in how it computes the closest
> mode to what you ask for. If the mode isn't an exact match it won't
> set the mode. Old driver does not have this problem.

Could you set CONFIG_FB_RADEON_DEBUG and post the results to this list and 
CC ben?



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
