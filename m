From: Dr Andrew C Aitchison <A.C.Aitchison@dpmms.cam.ac.uk>
Subject: Re: Re: [forum] Re: Announcement: Modification
 to the base XFree86(TM) license.
Date: Mon, 2 Feb 2004 13:59:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402021326140.3485-100000@harrier.dpmms.cam.ac.uk>
References: <20040202114141.GA15340@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnecP-0007FZ-VJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 06:00:05 -0800
Received: from smtp.dpmms.cam.ac.uk ([131.111.24.3] ident=[exim])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AnecP-0008NX-DM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 06:00:05 -0800
In-Reply-To: <20040202114141.GA15340@iliana>
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

On Sat, 31 Jan 2004, Sven Luther wrote:
> > > And, have you asked the mgafb driver author about this ?
> > > 
> > > You can hardly complain about lack of back traffic if you didn't ask him
> > > about it, and if you did, it would be interesting to this discussion to
> > > know what the problems where.

On Sat, Jan 31, 2004 at 01:06:23PM +0000, Andrew C Aitchison wrote:
> "The Author" ?
> This is open source code; there may be 27 authors of the relevant file.
> In XFree86 code I wouldn't know how to find the author of a file without
> looking at that file. My {limited ,mis}understanding of clean room coding 
> makes me wary of reading any source unless I know that its licence will 
> allow me to do what I wish.
 
On Mon, 2 Feb 2004, Sven Luther wrote:
> This is not acceptable. You are making wild accusations, and didn't even
> try to contact the relevant people. To my knowledge, Petr is the sole
> author of matroxfb, and there should not have been any problem in at
> least asking him about this.

I didn't intend to make *any* accusations, and don't understand what
accusations I'm supposed to have made.
I clearly have to explain my starting position more clearly;
it is probably wrong, and almost certainly the cause of most of the 
confusion, however it is how I came into this arguement, and maybe seeing 
how I'm thinking will let you see that I wasn't making accusations.

My understanding of copyright/patents/plagarism (I'm vague and confused 
about which this covers) is that merely by reading your document,
I am allowing the possibility that I may use that information in something
which I later write.
 This is the principle behind "cleanroom" development, see
	http://en.wikipedia.org/wiki/Cleanroom, 
meaning 2.

If my licence to use your document doesn't allow me to do what I wish,
it is therefore better for me not to read your document.

My understanding about fbdev was that it was GPL-licenced, and that
it is *not* OK to incorporate GPL-ed code into XFree86.
Since I can't read the source code, I can't see who owns the bit I'm 
interested in and can't therefore ask permission to use it under a 
different licence.

I merely wished to point out that the GPL-licence *had* affected my
decision not to copy anything from fdbdev into XFree86.
Call me lazy, mis-informed, confused and paranoid, but I resent the
suggestion that I've been making accusations, wild or tame.

> > OK. So I've probably been paranoid and lazy, but if the fbdev licence 
> > had been compatible with the XFree86 one, I would have done the work.
> > As it is the bar was raised high enough to stop me.
> 
> Yeah, whatever, but with you asking that the fbdev drivers change their
> licence, it is the same thing as the GPL zealots not liking the new
> XFree86 licence. 
> 
> The way to solve this is by cooperation, not by staying aloft and
> pointing the finger to the opposite side.

I didn't intend to ask that fbdev change their licence (although I wish
they would). I merely intended to point out that, however much the fault
was mine, the perception of the licence conflict had blocked transfer
from fbdev to XFree86.
Since Sven and Benjamin both suggested that transfer from fbdev to
XFree86 wasn't important, I thought it reasonable to relate my
experience showing that transfer in that direction was desirable and
that the GPL-licence was a hinderance.

I also realize that I have a habit of using complex and precise English.
As many people in this discussion are not native English speakers,
that is not smart, and may be why some of my intended meaning has
not got through. I apologize for this.

-- 
Dr. Andrew C. Aitchison		Computer Officer, DPMMS, Cambridge
A.C.Aitchison@dpmms.cam.ac.uk	http://www.dpmms.cam.ac.uk/~werdna



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
