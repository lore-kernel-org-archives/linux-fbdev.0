From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: nvidia: how to use overlay
Date: Fri, 21 Jan 2005 06:00:20 +0800
Message-ID: <200501210600.20625.adaplas@hotpop.com>
References: <E1CrbGV-0000Lj-Mi@sc8-pr-web1.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrkLx-0001So-I1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 14:00:33 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CrkLw-0002lv-59
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 14:00:33 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D1CCAD31153
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Jan 2005 22:00:18 +0000 (UTC)
In-Reply-To: <E1CrbGV-0000Lj-Mi@sc8-pr-web1.sourceforge.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, feedback@linux-fbdev.sourceforge.net

On Thursday 20 January 2005 20:18, feedback@linux-fbdev.sourceforge.net wrote:
> gongpu (gongp03@hotmail.com) has submitted this feedback
> for nvidia
>
> In my project which I\'m working on, I want to display two layer. One is
> for some video information. The other is for some symbols. I know how to
> use frame buffer to write directly to the video ram. But how to implement
> these two layers? SDL sdk gives some overlay functions, but I think it was
> implemented in software. How to use hardware overlay? Of course, I\'m sure
> that my video card surpport this kind of overlay. I\'ll be very appreciated
> if you can tell me how to do it or where I can find relative information.
> Thanks for reading. Waiting for your answer.

Try DirectFB (www.directfb.org).  They have an nvidia driver that supports
multiple layers (usually primary + overlay).  You can use SDL on DirectFB by
the way.

Note: I don't know the status of the DirectFB nvidia driver, but it seems
there is a flurry of development recently.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
