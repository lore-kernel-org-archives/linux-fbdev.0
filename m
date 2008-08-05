From: "alois.klingler@chello.at" <alois.klingler@chello.at>
Subject: Re: kernel oops with framebuffer device vt8623fb
Date: Tue, 05 Aug 2008 13:17:39 +0200
Message-ID: <489836D3.2050008@chello.at>
References: <487E2911.5090701@gmx.net>	<20080717013917.GA1695@localhost.localdomain>
	<20080728204817.ebaa621b.akpm@linux-foundation.org>
Reply-To: alois.klingler@chello.at
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQKZc-0002zR-Ve for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 04:19:29 -0700
Received: from viefep18-int.chello.at ([213.46.255.22]
	helo=viefep21-int.chello.at)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQKZZ-0002k8-Ro
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 04:19:28 -0700
Received: from edge05.upc.biz ([192.168.13.212]) by viefep20-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP
	id <20080805111755.WFQL14987.viefep20-int.chello.at@edge05.upc.biz>
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 5 Aug 2008 13:17:55 +0200
In-Reply-To: <20080728204817.ebaa621b.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: MadLoisae@gmx.net, linux-fbdev-devel@lists.sourceforge.net, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org

Hi!

This issue is still not fixed in 2.6.26.1 - may be there a way to commit 
it in 2.6.26.2?

Still, the provided patch I got on 07/17/2008 works great ...

Thanks, anyway!

kind regards, Alois


Andrew Morton wrote:
> On Thu, 17 Jul 2008 03:39:18 +0200 Ondrej Zajicek <santiago@crfreenet.org> wrote:
>
>   
>> On Wed, Jul 16, 2008 at 07:00:02PM +0200, MadLoisae@gmx.net wrote:
>>     
>>> Hi!
>>>
>>> I've updated my machine from 2.6.25.11 to 2.6.26 and I think I've found 
>>> a problem.
>>>
>>> If I load the module vt8623fb i get a kernel oops, if the VIA 8623 
>>> display framebuffer driver is compiled direct into kernel the system 
>>> hangs up very early at booting the kernel.
>>>       
>> I am sorry for mistake, here is a patch for 2.6.26 fixing the bug:
>>
>> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
>>     
>
> I went back through the email thread and wrote your changelog for you. 
> Not a very good one though.
>
> It would be better were you to write your changelogs, please.
>
>
>   


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
