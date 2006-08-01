From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Driver for Sharp LH155BA
Date: Tue, 01 Aug 2006 09:18:19 +0800
Message-ID: <44CEABDB.3040702@gmail.com>
References: <170385E48B041543AC99CCD09E325AD1952BB9@mail.rogermanagement.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7itu-0003AW-8b for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 18:18:26 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7its-000837-Vd
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 18:18:26 -0700
Received: by py-out-1112.google.com with SMTP id d42so834011pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 18:18:23 -0700 (PDT)
In-Reply-To: <170385E48B041543AC99CCD09E325AD1952BB9@mail.rogermanagement.com.au>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, Richard Wolf <rwolf@cardaccess.com.au>

Richard Wolf wrote:
> 
> Presumably if I take the shadow buffer route then I could maintain _two_
> shadow buffers.  This would allow me to detect whether the user accessible
> buffer had been changed and update the display only when necessary.  

Yes, that will work too.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
