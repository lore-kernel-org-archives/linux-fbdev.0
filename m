From: Jim Hague <jim.hague@acm.org>
Subject: Re: pm2 driver
Date: Wed, 5 Oct 2005 13:38:41 +0100
Message-ID: <200510051338.41921.jim.hague@acm.org>
References: <20050927184633.GH4320@codecarver>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EN8Xz-0007KP-VN
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Oct 2005 05:38:59 -0700
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EN8Xy-0001O7-Ex
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Oct 2005 05:39:00 -0700
Received: from hagrid.bear-cave.org.uk ([192.168.1.1])
	by fluffy.bear-cave.org.uk with esmtp (Exim 4.50 #1 (Debian))
	id 1EN8Xj-0000WG-9R
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Oct 2005 13:38:43 +0100
Received: from jim by hagrid.bear-cave.org.uk with local (Exim 3.36 #1 (Debian))
	id 1EN8Xi-0001eR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Oct 2005 13:38:42 +0100
In-Reply-To: <20050927184633.GH4320@codecarver>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 27 September 2005 19:46, Peter 'p2' De Schrijver wrote:
> Attached is a small patch which configures the correct memory clock and
> timings on the Elsa Winner 2000 Office pm2 based card. This is necessary
> when the card is used on a platform which does not support PC style BIOS
> initialization.

Thanks for that, Peter - and sorry for the delay in getting back to you. I've 
been away from home for work purposes, and am just now catching up on back 
emails.

I am curious about one thing. The initial mem control, mem config etc. values 
that you check for - I assume they are what you observe on your hardware. 
Will they be the same on other hardware, do you know? I must check my TVP4020 
docs...

How would you feel if instead I added a driver parameter to force 
initialisation instead of looking for particular initial values?

Out of interest, what have you got the card plugged into?
-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
