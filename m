From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Fri, 04 Feb 2005 22:17:10 +0100
Message-ID: <4203E657.1715D0A0@orpatec.ch>
References: <200502030925.09942.pluto@pld-linux.org>
		 <1107496794.2362.90.camel@gaston>
		 <Pine.LNX.4.56.0502042042120.25309@pentafluge.infradead.org> <9e47339105020413047ada9b2c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxApQ-0000qT-2p
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:17:24 -0800
Received: from mail2.xor.ch ([212.55.210.166])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CxApO-0000cA-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:17:24 -0800
Received: from orpatec.ch (80.218.104.18)
          by mail.xor.ch with MERCUR Mailserver (v4.03.11 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 4 Feb 2005 22:25:14 +0100
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

Jon Smirl wrote:
> 
> > Plus a whole bunch of other drivers. BTW would you consider it time to
> > kill off the old radeon fbdev driver?
> 
> Last time I checked the new radeonfb driver could not set modes on an
> analog LCD panel. Something is mess up in how it computes the closest
> mode to what you ask for. If the mode isn't an exact match it won't
> set the mode. Old driver does not have this problem.
> 
The driver in 2.4.27 (obviously the old one) sets the the mode correct,
either analog or digital (DVI). The driver in 2.6.8 set the mode, at
least fbset returns the correct information, but the actual used mode is
still 640x480.

O. Wyss

-- 
Development of frame buffer drivers: http://linux-fbdev.sf.net
Sample code snippets for wxWidgets: http://wxcode.sf.net
How to build well-designed applications: http://wxguide.sf.net
Desktop with a consistent look and feel: http://wyodesktop.sf.net


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
