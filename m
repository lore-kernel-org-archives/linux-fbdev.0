From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: 2 more fbcon rotation bugs
Date: Tue, 22 Nov 2005 09:01:36 +0100
Message-ID: <4382D060.9040206@t-online.de>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <4382BBE3.9020002@t-online.de> <4382CD40.8000507@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeT5t-0007AC-EA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Nov 2005 00:01:37 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EeT5s-0003rY-7d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Nov 2005 00:01:37 -0800
In-Reply-To: <4382CD40.8000507@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas schrieb:

>Shouldn't the accelerator be intelligent enough to handle bitmaps with
>variable widths?  Will something like the one attached work?
>
>  
>

Well, the accelerator can handle it, but it needs some precautions. Also 
xres != vxres
is possible, although it is currently disabled as I was too lazy to put 
work in an
unused feature. But now there is the rotation code that can benefit from 
x-panning,
and so it will be included soon.

cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
