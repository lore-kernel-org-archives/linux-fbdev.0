From: Alex Thiel <stderr@web.de>
Subject: Re: neofb patches
Date: Mon, 19 Apr 2004 10:33:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <m3ekqkpdt6.fsf@checkov.alex.net>
References: <Pine.GSO.4.58.0404161013040.20787@waterleaf.sonytel.be> <Pine.LNX.4.44.0404162135120.9917-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFUUs-0007LM-7K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 01:51:22 -0700
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFUUr-0005i6-MM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Apr 2004 01:51:21 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1BFUUp-0000iZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Apr 2004 10:51:19 +0200
Received: from p508b3436.dip.t-dialin.net ([80.139.52.54])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Apr 2004 10:51:19 +0200
Received: from stderr by p508b3436.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Apr 2004 10:51:19 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

James Simmons <jsimmons@infradead.org> writes:

> Yes please. I have a newer driver as well. I like to see what fixes you 
> have.
>

BTW, James, I tried that new driver and it fixes the oops that I have
reported a while ago. However, the diff that I got from infradead.org
recently did not apply cleanly to official kernels.

Could you post your new neofb driver as a patch against a vanilla
kernel release, please?

Cheers & thanks,

       Alex

> On Fri, 16 Apr 2004, Geert Uytterhoeven wrote:
>
>> On Thu, 15 Apr 2004, Alex Stewart wrote:
>> > I recently tried using the Neomagic framebuffer driver (from kernel 2.6.5) with
>> > my laptop, and noticed it seemed to have a few ...issues. :)
>> >
>> > So over the past few days I decided to go through and fix a bunch of the
>> > problems I found, and have put together quite a few patches for submission.  Is
>> > this list the right place to send patches for this driver, or is there
>> > somewhere else which would be more appropriate?



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
