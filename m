From: Richard Smith <rsmith@bitworks.com>
Subject: vga softboot code repository
Date: Mon, 13 Sep 2004 10:54:56 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4145C2D0.1080202@bitworks.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>	 <9e4733910409061402372095b1@mail.gmail.com>	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>	 <9e47339104090707172cdc258d@mail.gmail.com>	 <1094572321.6095.10.camel@admin.tel.thor.asgaard.local> <9e47339104090722437b81b373@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6tAW-0001SO-R1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 08:55:04 -0700
Received: from [69.4.201.55] (helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6tAW-0007sN-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 08:55:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by bitworks.com (Postfix) with ESMTP id 9B2231F53C0
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Sep 2004 10:54:59 -0500 (CDT)
Received: from bitworks.com ([127.0.0.1])
	by localhost (fileserver [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28269-10 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Sep 2004 10:54:56 -0500 (CDT)
Received: from [192.168.1.22] (richard.internal [192.168.1.22])
	by bitworks.com (Postfix) with ESMTP id 458AC1F53A4
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Sep 2004 10:54:56 -0500 (CDT)
In-Reply-To: <9e47339104090722437b81b373@mail.gmail.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Jon,

Reciently theres been a lot of talk on the LinuxBIOS list on the 
softbooting of vga cards and all the various forks there are of the 
x86emu code.  X, LinuxBIOS, DRI and probally a few others.  What works 
with what card, etc.

Its Egbert Eich's wish that we try to unify these things into a 
libsoftboot that all projects could use.  That way fixes and improvments 
will be shared by all rather than just each specific project.

A GNU Arch repository is being created on openbios.org to host 
developement.

You seem the be the man for the DRI x86emu.  Interested in trying to 
merge your stuff into the project?  I know that your ROM map and  setup 
stuff is quite different than X or LB but you still use basically the 
same core right?




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
