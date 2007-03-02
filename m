From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] fb: sm501fb off-by-1 sysfs store
Date: Fri, 02 Mar 2007 08:34:22 -0600
Message-ID: <45E835EE.2060901@us.ibm.com>
References: <20070301082456.GA3701@linux-sh.org>
	<Pine.LNX.4.62.0703011423060.766@pademelon.sonytel.be>
	<20070301133528.GA6504@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HN8st-0007nT-Du for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 06:37:26 -0800
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HN8sq-0001AO-ML
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 06:37:22 -0800
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l22Eb14M001402
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 2 Mar 2007 09:37:01 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l22EYNZS227810 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 2 Mar 2007 09:34:23 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l22EYNkw000378 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 2 Mar 2007 09:34:23 -0500
In-Reply-To: <20070301133528.GA6504@linux-sh.org>
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

Paul Mundt wrote:
> On Thu, Mar 01, 2007 at 02:25:55PM +0100, Geert Uytterhoeven wrote:
>> On Thu, 1 Mar 2007, Paul Mundt wrote:
>>> @@ -1074,9 +1074,9 @@ static ssize_t sm501fb_crtsrc_store(struct device *dev,
>>>  	if (len < 1)
>>>  		return -EINVAL;
>>>  
>>> -	if (strnicmp(buf, "crt", sizeof("crt")) == 0)
>>> +	if (strnicmp(buf, "crt", 3) == 0)
>>>  		head = HEAD_CRT;
>>> -	else if (strnicmp(buf, "panel", sizeof("panel")) == 0)
>>> +	else if (strnicmp(buf, "panel", 5) == 0)
>>>  		head = HEAD_PANEL;
>>>  	else
>>>  		return -EINVAL;
>> What about using just `strlen("string")' instead? ISTR gcc optimizes this to a
>> constant. Not that it matters that much, as the actual string won't be
>> duplicated.
>>
> I stuck with the constants since they were already referenced in the
> function, and there are enough other places in the kernel where they're
> used for these things. I didn't figure that 5 was a terribly high number
> to count to, but if there's expected difficulty, strlen() is of course an
> option.
> 
> Personally I find it less visually offensive with constants, but as long
> as the end number is the same, I'm not too concerned with how we get
> there. Feel free to change it if you wish.

My personal preference is to use sizeof("string")-1:
- guaranteed to be optimized to a constant (better than strlen)
- less likely to be left alone when "string" becomes "a different string" 
(better than magic numbers)

I also prefer for repeated constants, either preprocessor macros (#define 
OPTION_CRT "crt") or constant char arrays (static const char Option_CRT[] = 
"crt"), or something like that, to ensure one copy of the string in the object. 
  But having the indirection here could add confusion for somebody trying to 
quickly determine what "crt" does.
-- 
Regards,
Paul Clarke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
