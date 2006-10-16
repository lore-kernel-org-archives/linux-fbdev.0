From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [Sm5xx-devel]  SM501 framebuffer driver
Date: Mon, 16 Oct 2006 12:01:54 +0900
Message-ID: <20061016030154.GA6301@linux-sh.org>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
	<45327124.6040301@billgatliff.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZIk6-0006FV-Sr for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 20:02:19 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZIk3-0001F2-Sw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 20:02:17 -0700
Content-Disposition: inline
In-Reply-To: <45327124.6040301@billgatliff.com>
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
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Robert Whaley <rwhaley@applieddata.net>, sm5xx-devel@lists.berlios.de, linux-fbdev-devel@lists.sourceforge.net

Hi Bill, fancy seeing you in this thread ;-)

On Sun, Oct 15, 2006 at 12:34:28PM -0500, William A. Gatliff wrote:
> One thing that concerns me about all of the ALSA implementations I've
> seen so far is that the source code for the 8051 side is never
> included.  GPL questions aside, for legacy reasons alone we've got to
> make sure that stuff gets in too.
> 
We want the 8051 blob in userspace if anything, there's little reason to
tie this in to the module specifically, and it's handy to expose the
interface for people that are specifically interested in loading in
alternate code on the 8051.

As far as including source for the 8051 code itself, that would be nice
to have, but I doubt it's something the majority of users are going to
care about. I've certainly never seen any.

> But then again, there's the question of where the source code is at all,
> and what toolsystem you use to produce the binary image...
> 
I suspect it's just a simple binary blob and little else, there's
certainly no infrastructure in the loading side for dealing with
anything more elaborate, and it is just a stupid 8051 after all. Taking
and disassembling the thing will likely get you as close as to what the
real source looks like as anything else, but again, most people aren't
going to have a use for this.

Kbuild also doesn't have a simple facility for mapping in multiple cross
compilers depending on target preference, which is one of the things we
hit when trying to figure out how to interface the ARM7 firmware build
for the AICA on the Dreamcast (prior to the request_firmware() interface
being added). This is now handled by pushing everything to userspace,
which seems the obvious choice for the 8051, too.

On that note, do you have a pointer to some of the various ALSA
implementations that are floating around? I've only seen the OSS driver
we had in CVS, and that provides a rather dysmal starting point..

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
