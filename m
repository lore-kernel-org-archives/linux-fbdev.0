From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Fri, 4 Feb 2005 16:04:20 -0500
Message-ID: <9e47339105020413047ada9b2c@mail.gmail.com>
References: <200502030925.09942.pluto@pld-linux.org>
	 <1107496794.2362.90.camel@gaston>
	 <Pine.LNX.4.56.0502042042120.25309@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxAcp-0008SY-Th
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:04:23 -0800
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CxAco-0007Pt-IP
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 13:04:23 -0800
Received: by rproxy.gmail.com with SMTP id j1so568961rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Feb 2005 13:04:20 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502042042120.25309@pentafluge.infradead.org>
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

On Fri, 4 Feb 2005 20:42:48 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > > plain text document attachment (.config)
> >
> > You seem to have built both the old and new radeonfb's ... can you
> > remove the old one ?
> 
> Plus a whole bunch of other drivers. BTW would you consider it time to
> kill off the old radeon fbdev driver?

Last time I checked the new radeonfb driver could not set modes on an
analog LCD panel. Something is mess up in how it computes the closest
mode to what you ask for. If the mode isn't an exact match it won't
set the mode. Old driver does not have this problem.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
