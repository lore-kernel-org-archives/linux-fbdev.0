From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Mon, 28 Mar 2005 17:02:38 -0800
Message-ID: <4248A92E.8080409@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>	 <20050324203118.345c6004.akpm@osdl.org>	 <a44ae5cd050325205012399ccc@mail.gmail.com>	 <42483B11.6010203@osdl.org> <a44ae5cd0503281656592e6177@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DG58A-0000GS-RS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 17:02:54 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DG589-0000SY-BK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 17:02:54 -0800
In-Reply-To: <a44ae5cd0503281656592e6177@mail.gmail.com>
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
> On Mon, 28 Mar 2005 09:12:49 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> 
> By the why, I don't know why Andrew got dropped from my previous message list.
> Also, I thought you were asking these questions of the fbdev and
> vidiafb developers.
> 
> 
>>I guess that there is some chance that the io_remap_pfn* patches
>>are involved with this.  
> 
> 
> I am a tester, so I don't have knowledge about this.

Sure, it wasn't a question.  :)

> 
>>Is there some way to determine exactly which
>>io remap kernel calls are involved in "nvidiafb: cannot ioremap FB
>>base" ?  
> 
> 
> I don't know.  Someone who does, please tell me.  If someone
> will tell me how, I'll be happy to gather the information.
 >
> 
>>Is that in the exposed source code?  
> 
> 
> I have no idea.  How would I find out?
> 
>>If so, where is that source code?  
> 
> 
> I have no clue.

Where did you get the nvidia wrapper?
Where can I find it?

Where did you get the nvidia binary blob?
Where can I get it?

>>If not, can we determine from the binary which calls
>>are being made?  
> 
> 
> Uhhh.  I have delivered the Oops info and a bunch of other
> information.  I have given you whatever I thought might be helpful.  I
> need guidance here.

Sure, but the part that I really need to see is likely partially 
hidden in some binary blob.  We'll see.

> 
>>Or should I just make a io_remap debug patch that
>>prints out lots of debug info so that we can track this down?
> 
> 
> I thought you would determine this with input from developers.
> 
> Your humble tester (remember me from the early USB days?),

Sure I do.  :)
I'll make a patch, probably tonight Pacific time.

-- 
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
