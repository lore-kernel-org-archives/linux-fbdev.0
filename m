From: Andrew C Aitchison <a.c.aitchison@ntlworld.com>
Subject: Re: Re: [forum] Re: Announcement: Modification
 to the base XFree86(TM) license.
Date: Sat, 31 Jan 2004 09:10:22 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401310854310.3227-100000@ard.bishopscourt>
References: <20040130222902.GA11885@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Amr94-0001XA-L6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 01:10:30 -0800
Received: from mta06-svc.ntlworld.com ([62.253.162.46])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Amr94-000777-94
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 01:10:30 -0800
In-Reply-To: <20040130222902.GA11885@iliana>
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
To: forum@xfree86.org
Cc: devel@xfree86.org, linux-fbdev-devel@lists.sourceforge.net


On Fri, 30 Jan 2004, Sven Luther wrote:
> Yeah, that would be rather problematic, but anyway, most of the things
> move from the XFree86 code to fbdev code, and most often, it is not code
> that is copied, but the register information and such. It is always
> easier to get specs if you are working for XFree86 than if you plan to
> do some kernel driver work.

On Sat, 31 Jan 2004, Benjamin Herrenschmidt wrote:
> The fact that it is mostly a one way is mostly due to the fact that the
> main problem here is seeking for HW informations.

For several years the mga fb kernel driver has supported dual head and/or
dvi on cards which aren't supported by the XFree86 driver (unless you
use the mga_hal). I've wanted to use kernel code to add this support to 
XFree86, but been put off by the licence problem.

As I remember it, the pertinent register information here was reverse 
engineered, so it is at least arguable that I'd be copying fbdev
intellectual property here if I'd extracted and reused it.
Perhaps I was wrong, but my understanding from my days in a software
house taught me that I'd be breaking copyright not just by lifting
lines of code, but also by reading the code and copying intellectual
property, including register information.

Besides there are only a few ways of writing code to twiddle a bit in
a register - I could easily duplicate a line of code while
reconstructing it from the register description, and it would be hard
to prove that I didn't just copy the line directly.

So, for one developer at least, the reason there has been no traffic
from fbdev to XFree86 is *directly* because of the licence issue.

-- 
Andrew C. Aitchison					Cambridge
			A.C.Aitchison@ntlworld.com



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
