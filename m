From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 22:01:00 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com>
References: <9e473391050301215019081bce@mail.gmail.com> 
 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>  <1109806955.5610.129.camel@gaston>
  <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com> <1109816602.5610.153.camel@gaston>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <1109816602.5610.153.camel@gaston>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>



On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:

> On Wed, 2005-03-02 at 20:03 -0500, Vladimir Dergachev wrote:
>>
>> On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:
>>
>>>
>>>>
>>>>     What about isolating interrupt-handling code into a small driver ?
>>>> Something simple to respond to interrupts and call all handlers with a
>>>> certain mask.
>>>>
>>>>     This would be useful not only for drm and fbdev but also for km
>>>> (v4l capture module) and stereo-glasses code.
>>>>
>>>
>>> Nope, I don't agree.
>>
>> With which part ? ;)
>
> On having a small stub module that does just IRQs ... I think the base
> module should be the fbdev (mode setting etc...)

Oh, but I was not suggesting that. I just meant that interrupt handling 
code is self-contained and can easily serve several consumers.

Which driver claims the pci id I don't care about..

                    best

                      Vladimir Dergachev

>
> Ben.
>
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
