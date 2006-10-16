From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [Sm5xx-devel]  SM501 framebuffer driver
Date: Mon, 16 Oct 2006 14:48:36 -0500
Message-ID: <4533E214.2010804@billgatliff.com>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
	<45327124.6040301@billgatliff.com>
	<20061016030154.GA6301@linux-sh.org>
	<4533DD5B.4020804@billgatliff.com>
	<4533E012.4060909@applieddata.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZYRG-0000RI-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:47:54 -0700
Received: from smtp2.mtco.com ([207.179.226.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZYRE-00036w-H1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 12:47:54 -0700
In-Reply-To: <4533E012.4060909@applieddata.net>
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
To: Robert Whaley <rwhaley@applieddata.net>
Cc: sm5xx-devel@lists.berlios.de, Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net

Robert Whaley wrote:

> Bill Gatliff wrote:
>
>> Paul:
>>
>> Paul Mundt wrote:
>>
>>> Hi Bill, fancy seeing you in this thread ;-)
>>>  
>>>
>>
>> Heh, you need to talk to the guy at the door.  He'll let anyone in, 
>> I'm proof!  :)
>>
>>> We want the 8051 blob in userspace if anything, there's little 
>>> reason to
>>> tie this in to the module specifically, and it's handy to expose the
>>> interface for people that are specifically interested in loading in
>>> alternate code on the 8051.
>>>
>>> As far as including source for the 8051 code itself, that would be nice
>>> to have, but I doubt it's something the majority of users are going to
>>> care about. I've certainly never seen any.
>>>  
>>>
>>
>> I totally agree on all points.  But I hate blobs.  If the source code 
>> is around, I'd love to have it recorded somewhere even though we all 
>> know that Kbuild and most users won't know what to do with it.  Just 
>> In Case.
>>
>> Do we even know where this blob came from originally?
>>
>>> On that note, do you have a pointer to some of the various ALSA
>>> implementations that are floating around? I've only seen the OSS driver
>>> we had in CVS, and that provides a rather dysmal starting point..
>>>  
>>>
>>
>> Whaley sent me one just last week (hi Robert!).  Given that, I don't 
>> suppose he'd mind my forwarding the patch on.
>
>
> Not at all.  BTW: we use this (moderately buggy) compiler to compile 
> the 8051 code:
>
> http://sourceforge.net/project/showfiles.php?group_id=599
>
> Between the bugs in the compiler and the absence of documentation in 
> the SM501 manual about 8051 interrupts, etc.   It was pretty difficult 
> making this work.
>
> Don't try anything remotely like this with this compiler:
>
> u8 a, b;
> u32 c;
>
>    c |= a << b;
>
>

WTF?!    :)

And here I was thinking that SDCC was probably pretty good...


>+
>+/* There are 2 copies of shared because the shared SRAM is not safe if
>+ * the 8051 is reading/writing to a location while the CPU is
>+ * writing/reading the same location (according to the SM501 manual
>+ * and verified by tests).  So 2 redundant copies are maintained and
>+ * for the contents to be considered valid the same data must be
>+ * present in both copies.
>+ */
>  
>

Classic SM501.  "Here's a feature that works.... but it doesn't!"  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
