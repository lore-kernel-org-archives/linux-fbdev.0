From: Mark Vojkovich <mvojkovi@XFree86.Org>
Subject: Re: Re: [forum] Re: Announcement: Modification
 to the base XFree86(TM) license.
Date: Sat, 31 Jan 2004 13:48:14 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.21.0401311338520.18986-100000@public.xfree86.org>
References: <20040130222902.GA11885@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1An2yS-0005YK-5z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 13:48:20 -0800
Received: from xf86.isc.org ([204.152.184.208] helo=public.xfree86.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1An2yR-0000Kt-NK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jan 2004 13:48:19 -0800
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
To: devel@xfree86.org
Cc: forum@xfree86.org, linux-fbdev-devel@lists.sourceforge.net



On Fri, 30 Jan 2004, Sven Luther wrote:

> On Fri, Jan 30, 2004 at 08:25:40PM +0100, Egbert Eich wrote:
> > Sven Luther writes:
> >  > 
> >  > Maybe a decision on both parts on this would be ok ? XFree86 could make
> >  > sure the licence of the driver code would not conflict with the GPL,
> >  > keeping the old one for example, and the fbdev driver authors would
> >  > dual-licence the code, both GPL and the old xfree86 licence would do
> >  > just fine. Benjamin, what do you think about this ?
> >  > 
> >  > BTW, CCing this to the linux-fbdev mailing list.
> >  > 
> > 
> > Yes, a personal agreement between driver developers would also work.
> > However they tend to change and other people will make contributions
> > who all would have to agree also. 
> > I don't know if a general dual license agreement in the kernel 
> > file header would be possible. Also it could get removed once 
> > the author changes. Just like the license in the XFree86 driver 
> > could be amended. 
> 
> I guess already some drivers have such a dual licencing.
> 
> > Doing this now for existing fbdev driver would involve to ask
> > anyone who has contributed little more than a typo fix.
> 
> Yeah, that would be rather problematic, but anyway, most of the things
> move from the XFree86 code to fbdev code, and most often, it is not code
> that is copied, but the register information and such. It is always
> easier to get specs if you are working for XFree86 than if you plan to
> do some kernel driver work.
> 

   You can take an XFree86 driver, regardless of what the copyright
says, and completely rewrite it as an fbdev driver (which is what
I believe usually happens) and this is not a violation of the
XFree86 copyright or even of the GPL.  Copyright doesn't apply to 
ideas or algorithms in a work.  It's not a patent.  It only applies
to the reproduction of the code.


			Mark.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
