From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Optimized cfbimgblt.c
Date: Mon, 31 Jan 2005 19:25:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501311918450.17443@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0501201808120.6978@pentafluge.infradead.org>
 <200501210600.06363.adaplas@hotpop.com> <Pine.LNX.4.56.0501210025170.14061@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvhAk-0007uw-Vh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 11:25:18 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CvhAb-0004dj-Iq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 11:25:18 -0800
In-Reply-To: <Pine.LNX.4.56.0501210025170.14061@pentafluge.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@hotpop.com" <adaplas@hotpop.com>


I found the bug for this patch. I problem is that the new cfb_imageblit 
uses the pixmap access_align value. This was not being set in fbdev.c for 
the NVIDIA driver. The original reason for having pixmap in the NVIDIA 
driver was because the hardware needed images to be word padded. Now the 
standard soft accel functions also use word padded images by default.
So I would suggest that we could remove the pixmap code from fbdev.c. What 
do you think? I also noticed a few drivers using it when they don't need 
it. Its due to the lack of documentation. I need to write some.





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
