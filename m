From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Calling fb_blank() in an interrupt?
Date: Sat, 22 Jan 2005 18:22:02 -0000
Message-ID: <059101c500af$493d5440$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsPtf-0003zX-61
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Jan 2005 10:22:07 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CsPtd-0006IZ-E7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Jan 2005 10:22:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id j0MIM2rT024037
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Jan 2005 18:22:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 23566-10 for <linux-fbdev-devel@lists.sourceforge.net>;
 Sat, 22 Jan 2005 18:22:01 +0000 (GMT)
Received: from max (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.1/8.12.10) with ESMTP id j0MILwtD024029
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Jan 2005 18:21:58 GMT
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-fbdev-devel@lists.sourceforge.net

Do fb_blank() and other framebuffer functions need to be interrupt safe?

I can't find any documentation on whether this should be the case or not...

-- 
Richard 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
