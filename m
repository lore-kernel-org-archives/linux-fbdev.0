From: <feedback@linux-fbdev.sourceforge.net>
Subject: nvidia: how to use overlay
Date: Thu, 20 Jan 2005 04:18:19 -0800
Message-ID: <E1CrbGV-0000Lj-Mi@sc8-pr-web1.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrbGW-0002az-4O
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 04:18:20 -0800
Received: from mx-outbound.sourceforge.net ([66.35.250.223] helo=sc8-sf-sshgate.sourceforge.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CrbGV-0000f8-SN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 04:18:20 -0800
Received: from sc8-pr-web1-b.sourceforge.net ([10.5.1.111] helo=sc8-pr-web1.sourceforge.net)
	by sc8-sf-sshgate.sourceforge.net with esmtp (Exim 3.36 #1 (Debian))
	id 1CrbGV-0007kG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Jan 2005 04:18:19 -0800
Received: from nfsnobody by sc8-pr-web1.sourceforge.net with local (Exim 4.43)
	id 1CrbGV-0000Lj-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 04:18:19 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


gongpu (gongp03@hotmail.com) has submitted this feedback
for nvidia

In my project which I\'m working on, I want to display two layer. One is for some video information. The other is for some symbols. I know how to use frame buffer to write directly to the video ram. But how to implement these two layers? 
SDL sdk gives some overlay functions, but I think it was implemented in software. How to use hardware overlay?
Of course, I\'m sure that my video card surpport this kind of overlay. 
I\'ll be very appreciated if you can tell me how to do it or where I can find relative information. Thanks for reading. Waiting for your answer.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
