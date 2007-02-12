From: Ben Dooks <ben-fbdev@fluff.org>
Subject: Re: [RFC]: s3c2410fb conversion
Date: Mon, 12 Feb 2007 10:06:27 +0000
Message-ID: <20070212100627.GD19392@home.fluff.org>
References: <45b9b69474f01@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HGY5B-0003TT-5h for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 02:06:49 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HGY57-0004Pg-F3
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 02:06:49 -0800
Received: from ben by aeryn.fluff.org.uk with local (Exim 4.63)
	(envelope-from <ben@fluff.org.uk>) id 1HGY4p-00061B-4o
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 10:06:27 +0000
Content-Disposition: inline
In-Reply-To: <45b9b69474f01@wp.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 26, 2007 at 09:06:44AM +0100, Krzysztof Helt wrote:
> Hello,
> 
> The s3c2410fb driver needs register values set for every
> platform. A way of conversion is to move as many values to
> particular fields (e.g. resolution, bit depth, etc.) and
> calculate the register values from them.

I definetly think we should be passing a number of items as
more generic info, such as the pixel clock range, and anything
that can be set from a mode info structure.

This should possibly be the first stage of development, and then
we can see what else can be done.

> I want to ask how far one should move in conversion of the
> driver. Should enumerated values also be moved to separate fields
> or they can be set with "or" operator (I) into existing register
> fields? I mean values (usually bits) like display type (STN/TFT
> bit), etc.
> 
> E.g., the pxafb driver works with the latter approach. Most of
> values are calculated but some of them are set as or-ed values
> into register-like fields (the bits from fields are directly
> copied to register's bits and completed by bits from calculated
> values).

It might be easier to pass lcdcon1 through, and calculate the
rest from a mode info structure.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
