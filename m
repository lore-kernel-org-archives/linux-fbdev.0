From: Zack Smith <fbui@comcast.net>
Subject: Re: fbcon bug?
Date: Mon, 14 Nov 2005 19:21:49 -0500
Message-ID: <43792A1D.50208@comcast.net>
References: <4377F564.6000704@comcast.net> <20051114191340.GA12139@sci.fi> <4378EF3E.8050609@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eboa9-0005Xy-4h
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 16:21:53 -0800
Received: from rwcrmhc13.comcast.net ([216.148.227.118] helo=rwcrmhc12.comcast.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eboa7-0007qZ-S3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 16:21:53 -0800
In-Reply-To: <4378EF3E.8050609@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> Once the console is in KD_GRPHICS mode, all access the to the 
> framebuffer are essentially stopped. 

What I'm seeing is that after a console switch to a KD_GRAPHICS console 
(call it A)
from a KD_TEXT console (console B), B's cursor is seemingly undrawn in A.
Basically, wherever the cursor was B, that's where you will see a black 
box drawn in A,
and there is a delay in its being drawn.

Zack



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
