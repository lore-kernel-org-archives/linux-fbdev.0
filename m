From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Fri, 30 Apr 2004 18:40:59 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040501004059.GD30285@guug.org>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJiYf-0001za-ST
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 17:40:45 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJiYf-0005cN-Ja
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 17:40:45 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Apr 30, 2004 at 05:50:07PM +0100, James Simmons wrote:
> 2) Several of the above libraries depend on mode changing being avaliable 
>    in fbdev. Take that away and alot of companies will be very upset. I 
>    tell you if I owned/worked for a company that wrote embedded software 
>    that changed the video mode via fbdev (which BTW I do) and that was 
>    taken away I would be very upset!!!! The only we use the fbdev interface
>    is because it is easy to port our software from one box to another and 
>    second it does mode switching for us. We don't need to write the mode 
>    switching for each box. You take that away and the reality is companies
>    will have no real reason to use the fbdev api anymore. We will just come 
>    up with our own thing. Do you really want that to happen?

I agree.  Mode switching is a core function for a low-level graphics layer.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
