From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Mon, 28 Mar 2005 19:01:09 -0800
Message-ID: <4248C4F5.8090705@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>	 <20050324203118.345c6004.akpm@osdl.org>	 <a44ae5cd050325205012399ccc@mail.gmail.com>	 <42483B11.6010203@osdl.org>	 <a44ae5cd0503281656592e6177@mail.gmail.com>	 <4248A92E.8080409@osdl.org> <a44ae5cd05032817125e99b868@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DG6z9-0007lN-Vi
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 19:01:43 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DG6z5-0005Qb-Vb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 19:01:43 -0800
In-Reply-To: <a44ae5cd05032817125e99b868@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, khali@linux-fr.org

Miles Lane wrote:
> On Mon, 28 Mar 2005 17:02:38 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> 
>>Miles Lane wrote:
>>
>>>On Mon, 28 Mar 2005 09:12:49 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
>>>
>>>By the why, I don't know why Andrew got dropped from my previous message list.
>>>Also, I thought you were asking these questions of the fbdev and
>>>vidiafb developers.
>>>
>>>
>>>
>>>>I guess that there is some chance that the io_remap_pfn* patches
>>>>are involved with this.
>>>
>>>
>>>I am a tester, so I don't have knowledge about this.
>>
>>Sure, it wasn't a question.  :)
>>
>>
>>>>Is there some way to determine exactly which
>>>>io remap kernel calls are involved in "nvidiafb: cannot ioremap FB
>>>>base" ?
>>>
>>>
>>>I don't know.  Someone who does, please tell me.  If someone
>>>will tell me how, I'll be happy to gather the information.
>>
>> >
>>
>>>>Is that in the exposed source code?
>>>
>>>
>>>I have no idea.  How would I find out?
>>>
>>>
>>>>If so, where is that source code?
>>>
>>>
>>>I have no clue.
>>
>>Where did you get the nvidia wrapper?
>>Where can I find it?
> 
> 
> Perhaps you are thinking I am using the NVidia binary driver?
> This is not the case.  nvidiafb is a recently added framebuffer
> driver (IIRC, first showing up in 2.6.12-rc1-mm2).  I believe
> khali@linux-fr.org is the author.  I have reproduced this 
> problem with both mm2 and mm3.
> 
> Do you need my .config file?

I'll let you know.
I wondered while driving home if you were using the
(new) in-kernel nv driver.  Thanks for you and Andrew
confirming that.  Looks like I didn't go back far enough
in the thread history.

> 
>>Where did you get the nvidia binary blob?
> 
> 
> If you had my .config file, couldn't you build the driver into
> the kernel, as I have?  I don't know what a driver blob is.
> I haven't built the driver as a module.
> 
> 
>>Where can I get it?
> 
> 
> Build it?
> 
> 
>>>>If not, can we determine from the binary which calls
>>>>are being made?
>>>
>>>
>>>Uhhh.  I have delivered the Oops info and a bunch of other
>>>information.  I have given you whatever I thought might be helpful.  I
>>>need guidance here.
>>
>>Sure, but the part that I really need to see is likely partially
>>hidden in some binary blob.  We'll see.
> 
> 
> Blob? Well, I have some i2c built as modules.
> 
> 
>>>Your humble tester (remember me from the early USB days?),
>>
>>Sure I do.  :)
>>I'll make a patch, probably tonight Pacific time.

I send you something later tonight.

-- 
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
