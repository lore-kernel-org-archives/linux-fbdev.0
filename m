From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH] [RESEND] fbcon: simple text
 blinking implementation
Date: Fri, 08 Aug 2008 10:54:11 +0100
Message-ID: <489C17C3.6060006@eu.citrix.com>
References: <487F4E20.6090802@eu.citrix.com>
	<Pine.LNX.4.64.0807172047340.20605@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KROeX-0001pQ-B9 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 02:52:57 -0700
Received: from smtp.ctxuk.citrix.com ([62.200.22.115] helo=SMTP.EU.CITRIX.COM)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KROeV-0007m9-W4
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 02:52:57 -0700
In-Reply-To: <Pine.LNX.4.64.0807172047340.20605@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

> On Thu, 17 Jul 2008, Stefano Stabellini wrote:
>> at the moment blinking is not supported in fbcon but it is supported in
>> vgacon.
>> Since userspace applications don't distinguish between the two, they just
>> assume that the linux terminal is always capable of blinking text.
>> However implementing blinking in fbcon is not so difficult: this patch
>> provides a very simple (too simple?) implementation of that.
>> I am using the flashcursor function to scan the buffer for blinking text.
>> For the sake of efficiency I added a simple flag mechanism to disable the scan
>> when I am sure that there are no blinking characters on the screen.
> 
> Ehrm, there's already blinking support on some platforms?
> 

are you sure?
fbcon isn't supposed to be a software implementation?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
