From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Re: [forum] Re: Announcement: Modification to the base XFree86(TM) license.
Date: Sat, 31 Jan 2004 12:37:53 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040131113753.GA19133__32064.5813750618$1075553132@iliana>
References: <20040130222902.GA11885@iliana> <Pine.LNX.4.44.0401310854310.3227-100000@ard.bishopscourt>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmuTQ-0004U9-Jr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 04:43:44 -0800
Received: from smtp5.wanadoo.fr ([193.252.22.26] helo=mwinf0502.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmuTP-0004Yd-SE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 04:43:44 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401310854310.3227-100000@ard.bishopscourt>
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
Content-Transfer-Encoding: 7bit
To: forum@xfree86.org
Cc: devel@xfree86.org, linux-fbdev-devel@lists.sourceforge.net

On Sat, Jan 31, 2004 at 09:10:22AM +0000, Andrew C Aitchison wrote:
> On Fri, 30 Jan 2004, Sven Luther wrote:
> > Yeah, that would be rather problematic, but anyway, most of the things
> > move from the XFree86 code to fbdev code, and most often, it is not code
> > that is copied, but the register information and such. It is always
> > easier to get specs if you are working for XFree86 than if you plan to
> > do some kernel driver work.
> 
> On Sat, 31 Jan 2004, Benjamin Herrenschmidt wrote:
> > The fact that it is mostly a one way is mostly due to the fact that the
> > main problem here is seeking for HW informations.
> 
> For several years the mga fb kernel driver has supported dual head and/or
> dvi on cards which aren't supported by the XFree86 driver (unless you
> use the mga_hal). I've wanted to use kernel code to add this support to 
> XFree86, but been put off by the licence problem.

And, have you asked the mgafb driver author about this ?

You can hardly complain about lack of back traffic if you didn't ask him
about it, and if you did, it would be interesting to this discussion to
know what the problems where.

> As I remember it, the pertinent register information here was reverse 
> engineered, so it is at least arguable that I'd be copying fbdev
> intellectual property here if I'd extracted and reused it.
> Perhaps I was wrong, but my understanding from my days in a software
> house taught me that I'd be breaking copyright not just by lifting
> lines of code, but also by reading the code and copying intellectual
> property, including register information.

Yeah, sure. Which is way you ask for getting a licenced copy you can
use or something. I guess that this will be much more likely to happen
from a kernel fbdev driver author than from a commercial entity, will it
not ?

> Besides there are only a few ways of writing code to twiddle a bit in
> a register - I could easily duplicate a line of code while
> reconstructing it from the register description, and it would be hard
> to prove that I didn't just copy the line directly.

I doubt that this kind of stuff is possible to fall under copyright, or
else the copyright law is more broken than i thought. I know that a
bunch of C header files, with only datastructures and functions
declarations cannot be copyrighted.

> So, for one developer at least, the reason there has been no traffic
> from fbdev to XFree86 is *directly* because of the licence issue.

Yeah, but again, was it so because of a definite will on the fbdev
authors part, or because you didn't ask him ?

Friendly,

Sven Luther


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
