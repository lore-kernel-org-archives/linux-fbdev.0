From: Timothy Miller <miller@techsource.com>
Subject: Re: accelerated radeonfb produces artifacts on
 scrolling in 2.6.7
Date: Thu, 17 Jun 2004 09:51:07 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D1A1CB.7090301@techsource.com>
References: <20040616182415.GA8286@middle.of.nowhere> <20040616184145.GA12673@havoc.gtf.org> <40D0A5B4.7060007@techsource.com> <20040616195210.GA26935@middle.of.nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bax1W-0000ss-JG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 06:33:46 -0700
Received: from kinesis.swishmail.com ([209.10.110.86] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Bax1W-0008Fg-8U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 06:33:46 -0700
In-Reply-To: <20040616195210.GA26935@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org



Jurriaan wrote:

>>Is this the case even with the off-by-one error in the bitblt code 
>>fixed?  In the 2.4 kernel, I got rid of all artifacts by fixing the 
>>off-by-one error.

> You mean this code? I see (w-1) and (h-1) in there.


> 
> 	if ( xdir < 0 ) { sx += w-1; dx += w-1; }
> 	if ( ydir < 0 ) { sy += h-1; dy += h-1; }


Yes, that's the code, and it's correct.



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
