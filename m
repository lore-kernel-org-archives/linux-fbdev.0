From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Optimized cfbimgblt.c
Date: Fri, 21 Jan 2005 00:29:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501210025170.14061@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0501201808120.6978@pentafluge.infradead.org>
 <200501210600.06363.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crmfj-0000pG-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:29:07 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Crmfj-0002Vu-AS
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:29:07 -0800
In-Reply-To: <200501210600.06363.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>, "adaplas@hotpop.com" <adaplas@hotpop.com>


> Hi James, how are you doing :-) ?

Bette :-)
 
> The patch looks good, I'll do a few tests.

Great. It needs to be tested on a real big endian machine.

> P.S: Any chance you want to maintain the fb layer again, let me know...

I rather work with you maintaining the fbdev layer. Its alot of work for 
one person.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
