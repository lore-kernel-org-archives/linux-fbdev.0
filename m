From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Mon, 12 Jun 2006 06:04:05 +0800
Message-ID: <448C9355.5080105@gmail.com>
References: <44893407.4020507@gmail.com> <448B38F8.2000402@gmail.com>	
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	
	<448B61F9.4060507@gmail.com>	
	<9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	
	<448B6ED3.5060408@gmail.com>	
	<9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>	
	<448B8818.1010303@gmail.com>	
	<9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>	
	<448BA03B.6060800@gmail.com>
	<9e4733910606111359o38822782oe0fd9a69659d7d06@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpY2b-0007Nh-SS for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 15:04:17 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpY2Z-00067o-6m
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 15:04:17 -0700
Received: by py-out-1112.google.com with SMTP id x31so1502527pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Jun 2006 15:04:14 -0700 (PDT)
In-Reply-To: <9e4733910606111359o38822782oe0fd9a69659d7d06@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Jon Smirl wrote:
>> > On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> >> My point is: 'Multiple active drivers feature' is a natural
>> consequence
>> >> of the evolution of the code, but the only way to take advantage of it
>> >> is if we provide a means for the user to use it.  And we are not
>> >> providing the means.
>>
>> Maybe you're misunderstanding me. When I say "we are not providing the
>> means", I mean "we are definitely not going to provide the means", NOT,
>> "so we should be providing the means".
> 
> I thought about this for a day. The problem is that in-kernel,
> single-user, multi-head is not on a good development path. That path
> leads to in-kernel, multi-user support which is something I  don't
> think we want to do. The current in-kernel, single-user, multi-head
> feature is also only partially complete, it does not work on the
> majority of VGA hardware in use today.

If you're talking about fbcon, it does work, and not just on the
minority. 

> 
> So the question is, what do you want to do about it? If you leave it
> in place it complicates new work in the VT layer.  One result being the
> complicated sysfs interface that you are building.

The VT subsystem happens to support single user, multi-head, period.
I did not add it, maybe Linus did, who knows. To use it though, besides
hacking the drivers, one needs to provide an interface for it. And I
have emphasized several times that I AM NOT going to provide one.

What I have done is to add a feature to enable us to unload the VT
drivers. If you are planning on replacing the current system with your
own, you will need this feature. So I'm doing you a favor.

> You are forced into
> doing more in-kernel work to support a feature that may not be on the
> long term path.

Look, you're saying that I should only support one driver loaded at
one time.  And I'm doing it by not allowing the users to load more
than one driver at a time. To fully kill this feature, you need to
kill the source which happens to be the VT layer.

If you don't want the VT layer to support more than 1 drivers,
go ahead, rewrite the VT layer.

> 
> Another solution would be to build a small user space console system
> and use it to drive the secondary heads. That would then allow the
> feature to then be removed from the kernel. People would need to
> change their scripts but the user level feature will still be there.

Again, go ahead.

> 
> This is an example of a case where evolutionary design gets into
> trouble. Without knowing the high-level plan for the future of
> multi-user, multi-head graphics support in Linux you don't know the
> right way to solve this problem.
> 

Nobody is stopping you from rewriting the entire graphics subsystem
from scratch.

You can be as revolutionary with your changes as you want, but you have
to respect one very important thing, kernel to userspace compatibility.

Tony
