From: "Ai Chengshi" <rosemaryai@vip.sina.com>
Subject: Re: When copy, which function the operation system calls
Date: Tue, 20 Jan 2004 11:51:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <001a01c3df08$ae56ea90$d300a8c0@ACS>
References: <Pine.LNX.4.44.0401200021510.2709-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AimvT-0000qO-2V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 19:51:39 -0800
Received: from [202.108.35.178] (helo=vip.sina.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AimvS-0001dq-08
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Jan 2004 19:51:38 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dear James Simmons,

I have read the Linux framebuffer drivers-HOWTO written by you on the web. I
found that the drivers you mentioned were most developed on Linux V2.6.
However, the kernel I used was V2.4. Then how should I do?

Thanks for your help.

Yours sincerely,
Ai Chengshi
----- Original Message -----
From: "James Simmons" <jsimmons@infradead.org>
To: "Ai Chengshi" <rosemaryai@vip.sina.com>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Sent: Tuesday, January 20, 2004 08:23
Subject: Re: [Linux-fbdev-devel] When copy, which function the operation
system calls


>
> > Hi,
> >
> > When I typed cp test.bin /dev/fbdir/0, which function does the Linux
call?
>
> fb_write in fbmem.c.
>
> > And if I want to write the content in the buffer to LCD controller GRAM,
> > where should I add this function?
>
> Which kernel, v2.4 or v2.6? The api is different in each case.
>
>
>
>
>




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
