From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Rotation in 2.4 kernel
Date: Fri, 21 Jan 2005 21:21:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501212121070.30368@pentafluge.infradead.org>
References: <ba2a6a4405012110581bcebd3b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs6Dj-0003R1-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 13:21:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Cs6Di-0002Yu-F2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 13:21:31 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1Cs6Df-0007uT-TR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 21:21:28 +0000
In-Reply-To: <ba2a6a4405012110581bcebd3b@mail.gmail.com>
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


> Hi,
> 
> In 2.4, is there a standard way (API) for drivers to support rotation?
> In 2.6, I think applications use the var info structure to set the
> rotate field. How do applications tell 2.4 framebuffer drivers to
> cause rotation on the fly?  Would be great if someone can shed some
> light.

Nope. Only 2.6 supports that feature.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
